Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C530EC282C5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E38218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sweZFUxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfAYDOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 22:14:05 -0500
Received: from sonic312-28.consmr.mail.bf2.yahoo.com ([74.6.128.90]:41050 "EHLO
        sonic312-28.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728339AbfAYDOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 22:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1548386042; bh=w8ta0RrtTEnHTNvflMGm2gLEJJUhaEuuAVTXf9p/XFk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=sweZFUxy1MilKcOQ3wr551PC40XtOk7gmb8oTOo12P5C7GN22IDJ4ucdeUbPkQYl7Zoqsm/pA96lDjSAp7s8IAPTKXvaunrwy/ps2vgNVyJGaIKDnR2oEg91u4UOH92QmmelD/FTVbiyHv6fxwwx6dGueqMZsGQSWJPqyVL+QUrHb6BU7il2VWlrjRZSLnk7e6f7OKQ4PHgS131pq7ieRIDPRTQzWdNT7kIn8FVUe9Cv0FHqwjuIacGaPA2eiL0vZLcAGSFoJV9JF22pqz/9t5Y1FkEXG51FT9w7wPXQmX5OAj2Wuv3DXscnnJYCYHLBVo/Qqqmy7HEnDNwRWrgirQ==
X-YMail-OSG: mhXClJgVM1n4WLvaUG7axCwoOZUklJgYhB0fnJy2wZKcqDfICXkMhquab6emxlo
 ipeGRnOKApJ9uRCj15L1nj0PqnPgXPXOWccoDZfQRGRyo_.meOJrYO1ZTkEPkkJ.g4kczH9w3NEX
 89.X2G2uux3vRGc3nHTAsQ8w7o4fWrOjlwT9TH2odRhcgxc8.XsH_mV.sae8nDDwGoZ3i23fb6NE
 Woi1dWFo3frdHHKLI5sdo7GuDrsbkTnTw6jz3U.YiUjqyJ3TevrRGhe0jMgs0bSbeGE5Ywaayq76
 wORwotWBU..QgmAWGaNqh1ENBGkF73UDSiWo8tj6FqeTPNzblkPuQbkqF9RfmL7Sm.F8bV5sEfSX
 EPgMvSNO.9xlwU2cHMg7_7DiZCxSNF5tNCr54AhGTgAfB7.wrAvDAVqBufvAAYesWS4fgY88.CKz
 ctkf.vxdIc_4bTIgs8mSezgX7M3ietcIT0ltSLatdwv9_MaBlsHHFNgAr9.t1dP6AIWHEUmVOXuw
 p8ozghsynmOMMDltrhq4Gf.An4qv0nP.y7ypWVgKvh5LMbdDru5fcmhrr66SbrebFkbmoFofpgxX
 OtJxiNRWdIdYz.P.8YeZkLgqxyXwYvm0vFRpfhMzv80uOWuQqKfwsPn3.WsjGW0_R9Bcqhkcgf8i
 Fr5GLs7fIuL7JU.P79szoSrMXbcMfXaGULplXa86MEZvppwBEzuF956ztqdAvl.XQIcjHSkmaTQJ
 ZFLxs.dxcpDYz3WuTGt1KdHDJ1oZuLTRAbxGmtEDkKYmFu0ToeATnS7uJzVwOxP7QbTu6CKa_IMj
 retjVKxuNZQ6fg_czxTvzBjUacLGAfsoOrc2Q_5p9yIVbfYCqbF8yjkCA098Irp.P3.KtcSqjWCD
 Vy0pur54SW6PmBAHfzFX8KeZs4bbbqcBmE7PSF3iAM5pV3QvEQPY3_YarWQGcDKCP28odDmZMM3G
 zZeOaC3slIP.7Xqdgz0KbJsImCXQWU8f8eWdt3UdMTBopkIeClucCcXMqeaSGM1a6My53.1RwVLx
 xFPPBb18w4QSYOlbH9UTXmpEYplgRI10HQdQHkPQY5HLUoDMtJrzGQXC142KJsKqqgkKJeiDDsjx
 ZFM.W9xBEdwPDk_kt7lznbWn85tILOlc0nv.AqZYF
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Fri, 25 Jan 2019 03:14:02 +0000
Received: from 202.36.179.100 (EHLO [10.193.2.218]) ([202.36.179.100])
          by smtp417.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID fbf0cee7abaadf9895f2ada916badca5;
          Fri, 25 Jan 2019 03:14:01 +0000 (UTC)
Subject: Re: [PATCH] security: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20190125025639.GA13946@embeddedor>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <d30c9427-29bb-4b98-ec71-0663d0f9fa7f@schaufler-ca.com>
Date:   Thu, 24 Jan 2019 19:13:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125025639.GA13946@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/2019 6:56 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> This patch fixes the following warnings:
>
> security/integrity/ima/ima_appraise.c:116:26: warning: this statement may fall through [-Wimplicit-fallthrough=]
> security/integrity/ima/ima_template_lib.c:85:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
> security/integrity/ima/ima_policy.c:940:18: warning: this statement may fall through [-Wimplicit-fallthrough=]
> security/integrity/ima/ima_policy.c:943:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> security/integrity/ima/ima_policy.c:972:21: warning: this statement may fall through [-Wimplicit-fallthrough=]
> security/integrity/ima/ima_policy.c:974:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> security/smack/smack_lsm.c:3391:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
> security/apparmor/domain.c:569:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>
> Warning level 3 was used: -Wimplicit-fallthrough=3
>
> This patch is part of the ongoing efforts to enabling -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Ug. It can't be part of a greater comment? Grumble.

> ---
>  security/apparmor/domain.c                | 2 +-
>  security/integrity/ima/ima_appraise.c     | 1 +
>  security/integrity/ima/ima_policy.c       | 4 ++++
>  security/integrity/ima/ima_template_lib.c | 1 +
>  security/smack/smack_lsm.c                | 3 +--
>  5 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
> index 726910bba84b..c7c619578095 100644
> --- a/security/apparmor/domain.c
> +++ b/security/apparmor/domain.c
> @@ -572,7 +572,7 @@ static struct aa_label *x_to_label(struct aa_profile *profile,
>  			stack = NULL;
>  			break;
>  		}
> -		/* fall through to X_NAME */
> +		/* fall through - to X_NAME */
>  	case AA_X_NAME:
>  		if (xindex & AA_X_CHILD)
>  			/* released by caller */
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index a2baa85ea2f5..57daf30fb7d4 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -114,6 +114,7 @@ static void ima_set_cache_status(struct integrity_iint_cache *iint,
>  		break;
>  	case CREDS_CHECK:
>  		iint->ima_creds_status = status;
> +		/* fall through */
>  	case FILE_CHECK:
>  	case POST_SETATTR:
>  		iint->ima_file_status = status;
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 8bc8a1c8cb3f..122797023bdb 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -938,10 +938,12 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  		case Opt_uid_gt:
>  		case Opt_euid_gt:
>  			entry->uid_op = &uid_gt;
> +			/* fall through */
>  		case Opt_uid_lt:
>  		case Opt_euid_lt:
>  			if ((token == Opt_uid_lt) || (token == Opt_euid_lt))
>  				entry->uid_op = &uid_lt;
> +			/* fall through */
>  		case Opt_uid_eq:
>  		case Opt_euid_eq:
>  			uid_token = (token == Opt_uid_eq) ||
> @@ -970,9 +972,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  			break;
>  		case Opt_fowner_gt:
>  			entry->fowner_op = &uid_gt;
> +			/* fall through */
>  		case Opt_fowner_lt:
>  			if (token == Opt_fowner_lt)
>  				entry->fowner_op = &uid_lt;
> +			/* fall through */
>  		case Opt_fowner_eq:
>  			ima_log_string_op(ab, "fowner", args[0].from,
>  					  entry->fowner_op);
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> index 43752002c222..513b457ae900 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -83,6 +83,7 @@ static void ima_show_template_data_ascii(struct seq_file *m,
>  		/* skip ':' and '\0' */
>  		buf_ptr += 2;
>  		buflen -= buf_ptr - field_data->data;
> +		/* fall through */
>  	case DATA_FMT_DIGEST:
>  	case DATA_FMT_HEX:
>  		if (!buflen)
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index fa98394a40d0..127aa6c58e34 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3391,13 +3391,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>  		 */
>  		final = &smack_known_star;
>  		/*
> -		 * Fall through.
> -		 *
>  		 * If a smack value has been set we want to use it,
>  		 * but since tmpfs isn't giving us the opportunity
>  		 * to set mount options simulate setting the
>  		 * superblock default.
>  		 */
> +		/* Fall through */
>  	default:
>  		/*
>  		 * This isn't an understood special case.
