Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE54FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB26E20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfBVRxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:53:30 -0500
Received: from namei.org ([65.99.196.166]:53628 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbfBVRxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:53:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x1MHr0FO014358;
        Fri, 22 Feb 2019 17:53:00 GMT
Date:   Sat, 23 Feb 2019 04:53:00 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
cc:     Mimi Zohar <zohar@linux.ibm.com>,
        John Johansen <john.johansen@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] security: mark expected switch fall-throughs and add
 a missing break
In-Reply-To: <4be79a11-bda8-b0c5-a966-d9793e47d915@embeddedor.com>
Message-ID: <alpine.LRH.2.21.1902230452380.27514@namei.org>
References: <20190208205453.GA3232@embeddedor> <1549660417.12743.18.camel@linux.ibm.com> <26221503-3755-1ee1-2265-f4e0a7e1304c@embeddedor.com> <4be79a11-bda8-b0c5-a966-d9793e47d915@embeddedor.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019, Gustavo A. R. Silva wrote:

> Hi James,
> 
> I wonder if you can take this, please.

Ok -- I had thought you were sending all of these upstream across the 
board.


> 
> Thanks
> --
> Gustavo
> 
> On 2/18/19 8:53 PM, Gustavo A. R. Silva wrote:
> > 
> > 
> > On 2/8/19 3:13 PM, Mimi Zohar wrote:
> >> On Fri, 2019-02-08 at 14:54 -0600, Gustavo A. R. Silva wrote:
> >>> In preparation to enabling -Wimplicit-fallthrough, mark switch
> >>> cases where we are expecting to fall through.
> >>>
> >>> This patch fixes the following warnings:
> >>>
> >>> security/integrity/ima/ima_template_lib.c:85:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >>> security/integrity/ima/ima_policy.c:940:18: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >>> security/integrity/ima/ima_policy.c:943:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >>> security/integrity/ima/ima_policy.c:972:21: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >>> security/integrity/ima/ima_policy.c:974:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >>> security/smack/smack_lsm.c:3391:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >>> security/apparmor/domain.c:569:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >>>
> >>> Warning level 3 was used: -Wimplicit-fallthrough=3
> >>>
> >>> Also, add a missing break statement to fix the following warning:
> >>>
> >>> security/integrity/ima/ima_appraise.c:116:26: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >>>
> >>> Acked-by: John Johansen <john.johansen@canonical.com>
> >>> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> >>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >>
> >> Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> >>
> > 
> > Thanks, Mimi.
> > 
> > --
> > Gustavo
> > 
> >>> ---
> >>> Changes in v2:
> >>>  - Update Subject.
> >>>  - Integrate a missing break in switch fix by Mimi Zohar.
> >>>
> >>>  security/apparmor/domain.c                | 2 +-
> >>>  security/integrity/ima/ima_appraise.c     | 1 +
> >>>  security/integrity/ima/ima_policy.c       | 4 ++++
> >>>  security/integrity/ima/ima_template_lib.c | 1 +
> >>>  security/smack/smack_lsm.c                | 3 +--
> >>>  5 files changed, 8 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
> >>> index 3b266a438776..ca2dccf5b445 100644
> >>> --- a/security/apparmor/domain.c
> >>> +++ b/security/apparmor/domain.c
> >>> @@ -572,7 +572,7 @@ static struct aa_label *x_to_label(struct aa_profile *profile,
> >>>  			stack = NULL;
> >>>  			break;
> >>>  		}
> >>> -		/* fall through to X_NAME */
> >>> +		/* fall through - to X_NAME */
> >>>  	case AA_X_NAME:
> >>>  		if (xindex & AA_X_CHILD)
> >>>  			/* released by caller */
> >>> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> >>> index a2baa85ea2f5..5fb7127bbe68 100644
> >>> --- a/security/integrity/ima/ima_appraise.c
> >>> +++ b/security/integrity/ima/ima_appraise.c
> >>> @@ -114,6 +114,7 @@ static void ima_set_cache_status(struct integrity_iint_cache *iint,
> >>>  		break;
> >>>  	case CREDS_CHECK:
> >>>  		iint->ima_creds_status = status;
> >>> +		break;
> >>>  	case FILE_CHECK:
> >>>  	case POST_SETATTR:
> >>>  		iint->ima_file_status = status;
> >>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> >>> index 26fa9d9723f6..e0cc323f948f 100644
> >>> --- a/security/integrity/ima/ima_policy.c
> >>> +++ b/security/integrity/ima/ima_policy.c
> >>> @@ -936,10 +936,12 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
> >>>  		case Opt_uid_gt:
> >>>  		case Opt_euid_gt:
> >>>  			entry->uid_op = &uid_gt;
> >>> +			/* fall through */
> >>>  		case Opt_uid_lt:
> >>>  		case Opt_euid_lt:
> >>>  			if ((token == Opt_uid_lt) || (token == Opt_euid_lt))
> >>>  				entry->uid_op = &uid_lt;
> >>> +			/* fall through */
> >>>  		case Opt_uid_eq:
> >>>  		case Opt_euid_eq:
> >>>  			uid_token = (token == Opt_uid_eq) ||
> >>> @@ -968,9 +970,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
> >>>  			break;
> >>>  		case Opt_fowner_gt:
> >>>  			entry->fowner_op = &uid_gt;
> >>> +			/* fall through */
> >>>  		case Opt_fowner_lt:
> >>>  			if (token == Opt_fowner_lt)
> >>>  				entry->fowner_op = &uid_lt;
> >>> +			/* fall through */
> >>>  		case Opt_fowner_eq:
> >>>  			ima_log_string_op(ab, "fowner", args[0].from,
> >>>  					  entry->fowner_op);
> >>> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> >>> index 43752002c222..513b457ae900 100644
> >>> --- a/security/integrity/ima/ima_template_lib.c
> >>> +++ b/security/integrity/ima/ima_template_lib.c
> >>> @@ -83,6 +83,7 @@ static void ima_show_template_data_ascii(struct seq_file *m,
> >>>  		/* skip ':' and '\0' */
> >>>  		buf_ptr += 2;
> >>>  		buflen -= buf_ptr - field_data->data;
> >>> +		/* fall through */
> >>>  	case DATA_FMT_DIGEST:
> >>>  	case DATA_FMT_HEX:
> >>>  		if (!buflen)
> >>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> >>> index 587dc06eba33..5c1613519d5a 100644
> >>> --- a/security/smack/smack_lsm.c
> >>> +++ b/security/smack/smack_lsm.c
> >>> @@ -3380,13 +3380,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
> >>>  		 */
> >>>  		final = &smack_known_star;
> >>>  		/*
> >>> -		 * Fall through.
> >>> -		 *
> >>>  		 * If a smack value has been set we want to use it,
> >>>  		 * but since tmpfs isn't giving us the opportunity
> >>>  		 * to set mount options simulate setting the
> >>>  		 * superblock default.
> >>>  		 */
> >>> +		/* Fall through */
> >>>  	default:
> >>>  		/*
> >>>  		 * This isn't an understood special case.
> >>
> 

-- 
James Morris
<jmorris@namei.org>

