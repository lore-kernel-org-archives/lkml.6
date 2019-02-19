Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EDAC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D70217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbfBSCxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:53:43 -0500
Received: from gateway20.websitewelcome.com ([192.185.46.107]:47682 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbfBSCxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 21:53:42 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id E7D93400CF183
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 20:53:40 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id vvXQgEVaa2qH7vvXQglPav; Mon, 18 Feb 2019 20:53:40 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=51688 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gvvXQ-000941-1A; Mon, 18 Feb 2019 20:53:40 -0600
Subject: Re: [PATCH v2] security: mark expected switch fall-throughs and add a
 missing break
To:     Mimi Zohar <zohar@linux.ibm.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20190208205453.GA3232@embeddedor>
 <1549660417.12743.18.camel@linux.ibm.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Message-ID: <26221503-3755-1ee1-2265-f4e0a7e1304c@embeddedor.com>
Date:   Mon, 18 Feb 2019 20:53:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549660417.12743.18.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.20
X-Source-L: No
X-Exim-ID: 1gvvXQ-000941-1A
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.119.20]:51688
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/8/19 3:13 PM, Mimi Zohar wrote:
> On Fri, 2019-02-08 at 14:54 -0600, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch
>> cases where we are expecting to fall through.
>>
>> This patch fixes the following warnings:
>>
>> security/integrity/ima/ima_template_lib.c:85:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> security/integrity/ima/ima_policy.c:940:18: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> security/integrity/ima/ima_policy.c:943:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> security/integrity/ima/ima_policy.c:972:21: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> security/integrity/ima/ima_policy.c:974:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> security/smack/smack_lsm.c:3391:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> security/apparmor/domain.c:569:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> Also, add a missing break statement to fix the following warning:
>>
>> security/integrity/ima/ima_appraise.c:116:26: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>
>> Acked-by: John Johansen <john.johansen@canonical.com>
>> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> 

Thanks, Mimi.

--
Gustavo

>> ---
>> Changes in v2:
>>  - Update Subject.
>>  - Integrate a missing break in switch fix by Mimi Zohar.
>>
>>  security/apparmor/domain.c                | 2 +-
>>  security/integrity/ima/ima_appraise.c     | 1 +
>>  security/integrity/ima/ima_policy.c       | 4 ++++
>>  security/integrity/ima/ima_template_lib.c | 1 +
>>  security/smack/smack_lsm.c                | 3 +--
>>  5 files changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
>> index 3b266a438776..ca2dccf5b445 100644
>> --- a/security/apparmor/domain.c
>> +++ b/security/apparmor/domain.c
>> @@ -572,7 +572,7 @@ static struct aa_label *x_to_label(struct aa_profile *profile,
>>  			stack = NULL;
>>  			break;
>>  		}
>> -		/* fall through to X_NAME */
>> +		/* fall through - to X_NAME */
>>  	case AA_X_NAME:
>>  		if (xindex & AA_X_CHILD)
>>  			/* released by caller */
>> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
>> index a2baa85ea2f5..5fb7127bbe68 100644
>> --- a/security/integrity/ima/ima_appraise.c
>> +++ b/security/integrity/ima/ima_appraise.c
>> @@ -114,6 +114,7 @@ static void ima_set_cache_status(struct integrity_iint_cache *iint,
>>  		break;
>>  	case CREDS_CHECK:
>>  		iint->ima_creds_status = status;
>> +		break;
>>  	case FILE_CHECK:
>>  	case POST_SETATTR:
>>  		iint->ima_file_status = status;
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index 26fa9d9723f6..e0cc323f948f 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -936,10 +936,12 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>>  		case Opt_uid_gt:
>>  		case Opt_euid_gt:
>>  			entry->uid_op = &uid_gt;
>> +			/* fall through */
>>  		case Opt_uid_lt:
>>  		case Opt_euid_lt:
>>  			if ((token == Opt_uid_lt) || (token == Opt_euid_lt))
>>  				entry->uid_op = &uid_lt;
>> +			/* fall through */
>>  		case Opt_uid_eq:
>>  		case Opt_euid_eq:
>>  			uid_token = (token == Opt_uid_eq) ||
>> @@ -968,9 +970,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>>  			break;
>>  		case Opt_fowner_gt:
>>  			entry->fowner_op = &uid_gt;
>> +			/* fall through */
>>  		case Opt_fowner_lt:
>>  			if (token == Opt_fowner_lt)
>>  				entry->fowner_op = &uid_lt;
>> +			/* fall through */
>>  		case Opt_fowner_eq:
>>  			ima_log_string_op(ab, "fowner", args[0].from,
>>  					  entry->fowner_op);
>> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
>> index 43752002c222..513b457ae900 100644
>> --- a/security/integrity/ima/ima_template_lib.c
>> +++ b/security/integrity/ima/ima_template_lib.c
>> @@ -83,6 +83,7 @@ static void ima_show_template_data_ascii(struct seq_file *m,
>>  		/* skip ':' and '\0' */
>>  		buf_ptr += 2;
>>  		buflen -= buf_ptr - field_data->data;
>> +		/* fall through */
>>  	case DATA_FMT_DIGEST:
>>  	case DATA_FMT_HEX:
>>  		if (!buflen)
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index 587dc06eba33..5c1613519d5a 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -3380,13 +3380,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>>  		 */
>>  		final = &smack_known_star;
>>  		/*
>> -		 * Fall through.
>> -		 *
>>  		 * If a smack value has been set we want to use it,
>>  		 * but since tmpfs isn't giving us the opportunity
>>  		 * to set mount options simulate setting the
>>  		 * superblock default.
>>  		 */
>> +		/* Fall through */
>>  	default:
>>  		/*
>>  		 * This isn't an understood special case.
> 
