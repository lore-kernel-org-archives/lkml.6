Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293482-1527035238-2-14354651422251424927
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527035237; b=ZUu+3ZSxqwVNQ6kuQGWHYvKl4A9IAieiv8XHis3A1pyxu4Wo4O
    n0/tnxHOqgroiYA/GRODkm56ixcWJNBs210r0Z1bSu8RtLr7u/zMM943K5KybSCK
    joDI0Ye/+kygtlJJZJ+CdYxA1OomojJyfKBTVouw3uyb/fufhVN2Th67iB6nvoUx
    io8JviD/SrXJRThduAI4gzksiAKBlVY25pOCQx721cW13ARFB/RvZHjzk+sQHbN1
    5qMU2Rk157TYJwdqVhQplIoaMxaLurWckLJX7bg5OjAxxazW9+7rm9RXmnK8Jey5
    nFuV3hmnh8pusnBB3I+mhBfHwEIRfw1X/FpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1527035237; bh=P
    UgX1fGby7/8mnALdul8EET86vGuzfx90mbHWm2PKxU=; b=GaJ757hNEvn2UM7Qf
    P/f9grTRxmxYOg2jE+SZe7e3aBrMue8NjLdP5b1iSoQBFqcdSjtzTLDH1Jgckkl/
    A804qZ+WNsgxh5xAB/LRiXVKW2j6ovzsifNE6hUPfkA2mfNSPZk0w4blT4R48kVJ
    ATM0X7IbnEY5p9qX7Hif1oqegG9QJmGX5PTmDeTI5OdvHoP4nSGbPyNF/TB/5Dnf
    sV6qN9wP+a5BX55Xcmt3VdRsePjO0cy/Z5NXWyXKCStmy2S0LVxfxeFjO/1WtFCU
    fyYvLlFZwwI6cqQGHnEiz0/XwLtDW8lNiAeKBrsUiRaCUrbl0wpMS1W4E9eIsxje
    8Y37A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCgJJ0Kpbe3ugvZhdLdkpuNDlqPF1jIR4E4qjDlnC0a24POgVDqysKPguQePEPoLZhs9pDWfILKuEHEr1LaIyyfF8z8lmCisZpTE9qHzobA/bTvoWED2
    luIne80TzhjTUp6FnMzfiVx29a5WDBR7hsaaksGZv6zl0CgHf4UNJDxQyllLMMq78eSIiyjhC+PzF4iHnKnlwBXEKN+CfLmGQ1eOizp0m/4efIhuRdQ45ve+
    8SfECOMQnd+2l44tjO1qTg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VnNF1IyMAAAA:8
    a=VwQbUJbxAAAA:8 a=dUYqpe9WOuBEtok2xBMA:9 a=kas67cv5UFq9e37m:21
    a=-LfwMX1bhVgRieC4:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753856AbeEWA1N (ORCPT <rfc822;linux@kroah.com>);
        Tue, 22 May 2018 20:27:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753859AbeEWA1I (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 May 2018 20:27:08 -0400
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v7 14/14] ima: Store the measurement again when appraising a modsig
Date: Tue, 22 May 2018 21:12:53 -0300
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180523001253.15247-1-bauerman@linux.ibm.com>
References: <20180523001253.15247-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052300-8235-0000-0000-00000D8D5A92
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009068; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036241; UDB=6.00530093; IPR=6.00815370;
 MB=3.00021248; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-23 00:27:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052300-8236-0000-0000-000041177066
Message-Id: <20180523001253.15247-15-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805230002
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If the IMA template contains the 'sig' field, then the modsig should be
added to the measurement list when the file is appraised, and that is what
normally happens.

But If a measurement rule caused a file containing a modsig to be measured
before a different rule causes it to be appraised, the resulting
measurement entry will not contain the modsig because it is only fetched
during appraisal. When the appraisal rule triggers, it won't store a new
measurement containing the modsig because the file was already measured.

We need to detect that situation and store an additional measurement with
the modsig. This is done by defining the appraise subaction flag
IMA_READ_MEASURE and testing for it in process_measurement().

Suggested-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 security/integrity/ima/ima.h          |  1 +
 security/integrity/ima/ima_api.c      |  8 ++++-
 security/integrity/ima/ima_main.c     | 16 +++++++++-
 security/integrity/ima/ima_policy.c   | 59 ++++++++++++++++++++++++++++++++---
 security/integrity/ima/ima_template.c | 27 ++++++++++++++++
 security/integrity/integrity.h        |  9 ++++--
 6 files changed, 110 insertions(+), 10 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 33120c10a173..081e2b87cf9d 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -147,6 +147,7 @@ int ima_init_crypto(void);
 void ima_putc(struct seq_file *m, void *data, int datalen);
 void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
 struct ima_template_desc *ima_template_desc_current(void);
+bool ima_current_template_has_sig(void);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index bf88236b7a0b..73f6d4df66a7 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -288,7 +288,13 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 					    xattr_len, NULL};
 	int violation = 0;
 
-	if (iint->measured_pcrs & (0x1 << pcr))
+	/*
+	 * We still need to store the measurement in the case of MODSIG because
+	 * we only have its contents to put in the list at the time of
+	 * appraisal. See comment in store_measurement_again() for more details.
+	 */
+	if (iint->measured_pcrs & (0x1 << pcr) &&
+	    (!xattr_value || xattr_value->type != IMA_MODSIG))
 		return;
 
 	result = ima_alloc_init_template(&event_data, &entry);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9d32ce6c3df3..90e336a2b5c4 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -169,6 +169,20 @@ void ima_file_free(struct file *file)
 	ima_check_last_writer(iint, inode, file);
 }
 
+/*
+ * A file measurement might already exist in the measurement list. Based on
+ * policy, include an additional file measurement containing the appended
+ * signature and file hash, without the appended signature (i.e., the 'd-sig'
+ * field).
+ */
+static bool store_measurement_again(struct integrity_iint_cache *iint,
+				    struct evm_ima_xattr_data *xattr_value)
+{
+	return iint->flags & IMA_READ_MEASURE && xattr_value &&
+		xattr_value->type == IMA_MODSIG &&
+		ima_current_template_has_sig();
+}
+
 static int process_measurement(struct file *file, const struct cred *cred,
 			       u32 secid, char *buf, loff_t size, int mask,
 			       enum ima_hooks func, int opened)
@@ -302,7 +316,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
-	if (action & IMA_MEASURE)
+	if (action & IMA_MEASURE || store_measurement_again(iint, xattr_value))
 		ima_store_measurement(iint, file, pathname,
 				      xattr_value, xattr_len, pcr);
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 66d0d3bcf1b2..5ad5ced3b352 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -10,6 +10,9 @@
  *	- initialize default measure policy rules
  *
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/list.h>
 #include <linux/fs.h>
@@ -341,7 +344,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
  * In addition to knowing that we need to appraise the file in general,
  * we need to differentiate between calling hooks, for hook specific rules.
  */
-static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
+static int get_appraise_subaction(struct ima_rule_entry *rule,
+				  enum ima_hooks func)
 {
 	if (!(rule->flags & IMA_FUNC))
 		return IMA_FILE_APPRAISE;
@@ -362,6 +366,15 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
 	}
 }
 
+static int get_measure_subaction(struct ima_rule_entry *rule,
+				 enum ima_hooks func)
+{
+	if (rule->flags & IMA_FUNC && ima_hook_supports_modsig(func))
+		return IMA_READ_MEASURE;
+	else
+		return 0;
+}
+
 /**
  * ima_match_policy - decision based on LSM and other conditions
  * @inode: pointer to an inode for which the policy decision is being made
@@ -398,11 +411,12 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 
 		action |= entry->action & IMA_DO_MASK;
 		if (entry->action & IMA_APPRAISE) {
-			action |= get_subaction(entry, func);
+			action |= get_appraise_subaction(entry, func);
 			action &= ~IMA_HASH;
 			if (ima_fail_unverifiable_sigs)
 				action |= IMA_FAIL_UNVERIFIABLE_SIGS;
-		}
+		} else if (entry->action & IMA_MEASURE)
+			action |= get_measure_subaction(entry, func);
 
 		if (entry->action & IMA_DO_MASK)
 			actmask &= ~(entry->action | entry->action << 1);
@@ -642,6 +656,40 @@ static void ima_log_string(struct audit_buffer *ab, char *key, char *value)
 	ima_log_string_op(ab, key, value, NULL);
 }
 
+/*
+ * To validate the appended signature included in the measurement list requires
+ * the file hash, without the appended signature (i.e., the 'd-sig' field).
+ * Therefore, notify the user if they have the 'sig' field but not the 'd-sig'
+ * field in the template.
+ */
+static void check_current_template_modsig(void)
+{
+#define MSG "template with 'sig' field also needs 'd-sig' field when modsig is allowed\n"
+	struct ima_template_desc *template;
+	bool has_sig, has_dsig;
+	static bool checked;
+	int i;
+
+	/* We only need to notify the user once. */
+	if (checked)
+		return;
+
+	has_sig = has_dsig = false;
+	template = ima_template_desc_current();
+	for (i = 0; i < template->num_fields; i++) {
+		if (!strcmp(template->fields[i]->field_id, "sig"))
+			has_sig = true;
+		else if (!strcmp(template->fields[i]->field_id, "d-sig"))
+			has_dsig = true;
+	}
+
+	if (has_sig && !has_dsig)
+		pr_notice(MSG);
+
+	checked = true;
+#undef MSG
+}
+
 static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 {
 	struct audit_buffer *ab;
@@ -920,10 +968,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			if ((strcmp(args[0].from, "imasig")) == 0)
 				entry->flags |= IMA_DIGSIG_REQUIRED;
 			else if (ima_hook_supports_modsig(entry->func) &&
-				 strcmp(args[0].from, "imasig|modsig") == 0)
+				 strcmp(args[0].from, "imasig|modsig") == 0) {
 				entry->flags |= IMA_DIGSIG_REQUIRED
 						| IMA_MODSIG_ALLOWED;
-			else
+				check_current_template_modsig();
+			} else
 				result = -EINVAL;
 			break;
 		case Opt_permit_directio:
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 36fc32f538b5..967c287dcdfb 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -230,6 +230,33 @@ struct ima_template_desc *ima_template_desc_current(void)
 	return ima_template;
 }
 
+/*
+ * Tells whether the current template has fields which reference a file's
+ * signature.
+ */
+bool ima_current_template_has_sig(void)
+{
+	static int ima_template_has_sig = -1;
+
+	if (ima_template_has_sig < 0) {
+		struct ima_template_desc *template;
+		int i;
+
+		template = ima_template_desc_current();
+		for (i = 0; i < template->num_fields; i++)
+			if (!strcmp(template->fields[i]->field_id, "sig") ||
+			    !strcmp(template->fields[i]->field_id, "d-sig")) {
+				ima_template_has_sig = 1;
+				break;
+			}
+
+		if (ima_template_has_sig < 0)
+			ima_template_has_sig = 0;
+	}
+
+	return ima_template_has_sig;
+}
+
 int __init ima_init_template(void)
 {
 	struct ima_template_desc *template = ima_template_desc_current();
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index b38339c02541..a85b83519fc8 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -38,12 +38,13 @@
 #define IMA_MODSIG_ALLOWED	0x20000000
 
 #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
-				 IMA_HASH | IMA_APPRAISE_SUBMASK)
+				 IMA_HASH | IMA_APPRAISE_SUBMASK | \
+				 IMA_READ_MEASURE)
 #define IMA_DONE_MASK		(IMA_MEASURED | IMA_APPRAISED | IMA_AUDITED | \
 				 IMA_HASHED | IMA_COLLECTED | \
-				 IMA_APPRAISED_SUBMASK)
+				 IMA_APPRAISED_SUBMASK | IMA_READ_MEASURED)
 
-/* iint subaction appraise cache flags */
+/* iint subaction appraise and measure cache flags */
 #define IMA_FILE_APPRAISE	0x00001000
 #define IMA_FILE_APPRAISED	0x00002000
 #define IMA_MMAP_APPRAISE	0x00004000
@@ -54,6 +55,8 @@
 #define IMA_READ_APPRAISED	0x00080000
 #define IMA_CREDS_APPRAISE	0x00100000
 #define IMA_CREDS_APPRAISED	0x00200000
+#define IMA_READ_MEASURE	0x00400000
+#define IMA_READ_MEASURED	0x00800000
 #define IMA_APPRAISE_SUBMASK	(IMA_FILE_APPRAISE | IMA_MMAP_APPRAISE | \
 				 IMA_BPRM_APPRAISE | IMA_READ_APPRAISE | \
 				 IMA_CREDS_APPRAISE)

