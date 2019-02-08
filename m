Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4D4C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE3720855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfBHVNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:13:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726565AbfBHVNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:13:47 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x18LDcI4118583
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 16:13:46 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qhe1w8kn1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 16:13:45 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 8 Feb 2019 21:13:43 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Feb 2019 21:13:39 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x18LDcqp10486098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Feb 2019 21:13:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B102942045;
        Fri,  8 Feb 2019 21:13:38 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B12014203F;
        Fri,  8 Feb 2019 21:13:37 +0000 (GMT)
Received: from dhcp-9-31-103-153.watson.ibm.com (unknown [9.31.103.153])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Feb 2019 21:13:37 +0000 (GMT)
Subject: Re: [PATCH v2] security: mark expected switch fall-throughs and add
 a missing break
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Date:   Fri, 08 Feb 2019 16:13:37 -0500
In-Reply-To: <20190208205453.GA3232@embeddedor>
References: <20190208205453.GA3232@embeddedor>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19020821-0020-0000-0000-0000031494E3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020821-0021-0000-0000-00002165A64D
Message-Id: <1549660417.12743.18.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-08_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-08 at 14:54 -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
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
> Also, add a missing break statement to fix the following warning:
> 
> security/integrity/ima/ima_appraise.c:116:26: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Acked-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
> Changes in v2:
>  - Update Subject.
>  - Integrate a missing break in switch fix by Mimi Zohar.
> 
>  security/apparmor/domain.c                | 2 +-
>  security/integrity/ima/ima_appraise.c     | 1 +
>  security/integrity/ima/ima_policy.c       | 4 ++++
>  security/integrity/ima/ima_template_lib.c | 1 +
>  security/smack/smack_lsm.c                | 3 +--
>  5 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
> index 3b266a438776..ca2dccf5b445 100644
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
> index a2baa85ea2f5..5fb7127bbe68 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -114,6 +114,7 @@ static void ima_set_cache_status(struct integrity_iint_cache *iint,
>  		break;
>  	case CREDS_CHECK:
>  		iint->ima_creds_status = status;
> +		break;
>  	case FILE_CHECK:
>  	case POST_SETATTR:
>  		iint->ima_file_status = status;
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 26fa9d9723f6..e0cc323f948f 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -936,10 +936,12 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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
> @@ -968,9 +970,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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
> index 587dc06eba33..5c1613519d5a 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3380,13 +3380,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
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

