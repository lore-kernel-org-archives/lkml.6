Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C09C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBDE218FF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfBHUy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 15:54:57 -0500
Received: from gateway30.websitewelcome.com ([50.116.127.1]:15591 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726978AbfBHUy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 15:54:57 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id C41325125
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 14:54:55 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sDAlgcldpdnCesDAlgcf7f; Fri, 08 Feb 2019 14:54:55 -0600
X-Authority-Reason: nr=8
Received: from [189.250.49.191] (port=34656 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gsDAk-001tFR-R9; Fri, 08 Feb 2019 14:54:55 -0600
Date:   Fri, 8 Feb 2019 14:54:53 -0600
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
Subject: [PATCH v2] security: mark expected switch fall-throughs and add a
 missing break
Message-ID: <20190208205453.GA3232@embeddedor>
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
X-Source-IP: 189.250.49.191
X-Source-L: No
X-Exim-ID: 1gsDAk-001tFR-R9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.49.191]:34656
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

security/integrity/ima/ima_template_lib.c:85:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
security/integrity/ima/ima_policy.c:940:18: warning: this statement may fall through [-Wimplicit-fallthrough=]
security/integrity/ima/ima_policy.c:943:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
security/integrity/ima/ima_policy.c:972:21: warning: this statement may fall through [-Wimplicit-fallthrough=]
security/integrity/ima/ima_policy.c:974:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
security/smack/smack_lsm.c:3391:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
security/apparmor/domain.c:569:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Warning level 3 was used: -Wimplicit-fallthrough=3

Also, add a missing break statement to fix the following warning:

security/integrity/ima/ima_appraise.c:116:26: warning: this statement may fall through [-Wimplicit-fallthrough=]

Acked-by: John Johansen <john.johansen@canonical.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Update Subject.
 - Integrate a missing break in switch fix by Mimi Zohar.

 security/apparmor/domain.c                | 2 +-
 security/integrity/ima/ima_appraise.c     | 1 +
 security/integrity/ima/ima_policy.c       | 4 ++++
 security/integrity/ima/ima_template_lib.c | 1 +
 security/smack/smack_lsm.c                | 3 +--
 5 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 3b266a438776..ca2dccf5b445 100644
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
index a2baa85ea2f5..5fb7127bbe68 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -114,6 +114,7 @@ static void ima_set_cache_status(struct integrity_iint_cache *iint,
 		break;
 	case CREDS_CHECK:
 		iint->ima_creds_status = status;
+		break;
 	case FILE_CHECK:
 	case POST_SETATTR:
 		iint->ima_file_status = status;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 26fa9d9723f6..e0cc323f948f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -936,10 +936,12 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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
@@ -968,9 +970,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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
index 587dc06eba33..5c1613519d5a 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3380,13 +3380,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
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

