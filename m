Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B26C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A21B218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfAYMhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:37:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726878AbfAYMhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:37:31 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0PCYJn8051258
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 07:37:29 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q7yknhdbq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 07:37:29 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 25 Jan 2019 12:37:27 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 25 Jan 2019 12:37:24 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0PCbNb559768958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Jan 2019 12:37:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0D11AE051;
        Fri, 25 Jan 2019 12:37:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 368B6AE045;
        Fri, 25 Jan 2019 12:37:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.107.54])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Jan 2019 12:37:22 +0000 (GMT)
Subject: Re: [PATCH] security: mark expected switch fall-throughs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Matthew Garrett <mjg59@google.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Date:   Fri, 25 Jan 2019 07:37:11 -0500
In-Reply-To: <20190125025639.GA13946@embeddedor>
References: <20190125025639.GA13946@embeddedor>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012512-0012-0000-0000-000002ECE912
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012512-0013-0000-0000-000021242109
Message-Id: <1548419831.3971.117.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-25_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901250103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-24 at 20:56 -0600, Gustavo A. R. Silva wrote:
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

Other than the one question in ima_appraise.c, the rest of the IMA
changes are fine.

Mimi

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

Matthew, is this right?

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

