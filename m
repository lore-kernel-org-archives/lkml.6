Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB91C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CF5217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfAYC4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:56:42 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.222]:36567 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbfAYC4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:56:42 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 096B750F973
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 20:56:41 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id mrfcgkrg890onmrfdgBtHy; Thu, 24 Jan 2019 20:56:41 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=33912 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gmrfc-000vHu-2W; Thu, 24 Jan 2019 20:56:40 -0600
Date:   Thu, 24 Jan 2019 20:56:39 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] security: mark expected switch fall-throughs
Message-ID: <20190125025639.GA13946@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gmrfc-000vHu-2W
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:33912
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

security/integrity/ima/ima_appraise.c:116:26: warning: this statement may fall through [-Wimplicit-fallthrough=]
security/integrity/ima/ima_template_lib.c:85:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
security/integrity/ima/ima_policy.c:940:18: warning: this statement may fall through [-Wimplicit-fallthrough=]
security/integrity/ima/ima_policy.c:943:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
security/integrity/ima/ima_policy.c:972:21: warning: this statement may fall through [-Wimplicit-fallthrough=]
security/integrity/ima/ima_policy.c:974:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
security/smack/smack_lsm.c:3391:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
security/apparmor/domain.c:569:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling -Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 security/apparmor/domain.c                | 2 +-
 security/integrity/ima/ima_appraise.c     | 1 +
 security/integrity/ima/ima_policy.c       | 4 ++++
 security/integrity/ima/ima_template_lib.c | 1 +
 security/smack/smack_lsm.c                | 3 +--
 5 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 726910bba84b..c7c619578095 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -572,7 +572,7 @@ static struct aa_label *x_to_label(struct aa_profile *profile,
 			stack = NULL;
 			break;
 		}
-		/* fall through to X_NAME */
+		/* fall through - to X_NAME */
 	case AA_X_NAME:
 		if (xindex & AA_X_CHILD)
 			/* released by caller */
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index a2baa85ea2f5..57daf30fb7d4 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -114,6 +114,7 @@ static void ima_set_cache_status(struct integrity_iint_cache *iint,
 		break;
 	case CREDS_CHECK:
 		iint->ima_creds_status = status;
+		/* fall through */
 	case FILE_CHECK:
 	case POST_SETATTR:
 		iint->ima_file_status = status;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8bc8a1c8cb3f..122797023bdb 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -938,10 +938,12 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 		case Opt_uid_gt:
 		case Opt_euid_gt:
 			entry->uid_op = &uid_gt;
+			/* fall through */
 		case Opt_uid_lt:
 		case Opt_euid_lt:
 			if ((token == Opt_uid_lt) || (token == Opt_euid_lt))
 				entry->uid_op = &uid_lt;
+			/* fall through */
 		case Opt_uid_eq:
 		case Opt_euid_eq:
 			uid_token = (token == Opt_uid_eq) ||
@@ -970,9 +972,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			break;
 		case Opt_fowner_gt:
 			entry->fowner_op = &uid_gt;
+			/* fall through */
 		case Opt_fowner_lt:
 			if (token == Opt_fowner_lt)
 				entry->fowner_op = &uid_lt;
+			/* fall through */
 		case Opt_fowner_eq:
 			ima_log_string_op(ab, "fowner", args[0].from,
 					  entry->fowner_op);
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 43752002c222..513b457ae900 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -83,6 +83,7 @@ static void ima_show_template_data_ascii(struct seq_file *m,
 		/* skip ':' and '\0' */
 		buf_ptr += 2;
 		buflen -= buf_ptr - field_data->data;
+		/* fall through */
 	case DATA_FMT_DIGEST:
 	case DATA_FMT_HEX:
 		if (!buflen)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index fa98394a40d0..127aa6c58e34 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3391,13 +3391,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 		 */
 		final = &smack_known_star;
 		/*
-		 * Fall through.
-		 *
 		 * If a smack value has been set we want to use it,
 		 * but since tmpfs isn't giving us the opportunity
 		 * to set mount options simulate setting the
 		 * superblock default.
 		 */
+		/* Fall through */
 	default:
 		/*
 		 * This isn't an understood special case.
-- 
2.20.1

