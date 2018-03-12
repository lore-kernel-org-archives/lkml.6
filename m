Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3369064-1520825199-2-16544489280095819545
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520825199; b=rHB1ooCxPkzMjkEya1ixfLxpNIjdZXk0V+IrD1VAKdHBYJ1
    igcioCDXzwi7mVJXM6yFLrvx8l3Zt7bzNxTAG8zoP8sJ0CLdzyfpa0b1VbWR6c02
    HZ2mytB3e4CHP1pHRAXRdJqRq0R4NoCV6kOqqx7ltJwE60r5Z5Dykp4Z5zkd5pa0
    GaV5+OtKNPkOmGsZckuhKnWbpPA0mSdt67Y9moupJUDRlPiRzlsqsLzRa6DrqVco
    PvSDA5mti9OejLpf5i1+3LEMjHAIK4YTWLHANgVZlzGGy6VKGlpbaINVLvS9H2Da
    0EIilVdpHFZAKttidp1X4wPseKRtGcEtVSmMEXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520825199; bh=4EKWMda5DlZK9K5a3g1
    8sED7qh951shyiSlqKiRXuWw=; b=AcrYTTgCw6Ct/n3vYKtHPfk2q/Q9bYoMMPS
    Yk9paP7JK+VE2c4BEVro4kduysjHd5gY2xomY/6NWvljThh4tSNs6eiJHVNOI3Ys
    YGxDZY00mMfm+MOpuVCGPheVcZTBrnXni8QzWgY/9lCMvmEIi2CIvwM20KHeIPrC
    3kckP0Rzn2ACNDBqQ+GgAyd/XWpwIXIfFd4dJEFVyUTEe1CkbykUTlJayoAwd3bl
    Qv9Rro4FD/ZEA+tLZ4Q7rtxqvNtVsQ5JX9X29n1S2oEvGJFRde6CBM+DM3Ser8Sh
    /e+ZjJutYSrbpUQVxdB9ZTbPHEhTl1LfqoYIui19Ipr0bTBhrrA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932686AbeCLDZ3 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:25:29 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41211 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932676AbeCLDHn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:43 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Rusty Russell" <rusty@rustcorp.com.au>,
        "Paul Gortmaker" <paul.gortmaker@windriver.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.84415621@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 021/104] modpost: don't emit section mismatch warnings
 for compiler optimizations
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Gortmaker <paul.gortmaker@windriver.com>

commit 4a3893d069b788f3570c19c12d9e986e8e15870f upstream.

Currently an allyesconfig build [gcc-4.9.1] can generate the following:

   WARNING: vmlinux.o(.text.unlikely+0x3864): Section mismatch in
   reference from the function cpumask_empty.constprop.3() to the
   variable .init.data:nmi_ipi_mask

which comes from the cpumask_empty usage in arch/x86/kernel/nmi_selftest.c.

Normally we would not see a symbol entry for cpumask_empty since it is:

	static inline bool cpumask_empty(const struct cpumask *srcp)

however in this case, the variant of the symbol gets emitted when GCC does
constant propagation optimization.

Fix things up so that any locally optimized constprop variants don't warn
when accessing variables that live in the __init sections.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
[bwh: Backported to 3.2: Add definitions of {OTHER,ALL}_TEXT_SECTIONS]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -876,6 +876,8 @@ static void check_section(const char *mo
 
 #define DATA_SECTIONS ".data$", ".data.rel$"
 #define TEXT_SECTIONS ".text$"
+#define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
+		".fixup", ".entry.text"
 
 #define INIT_SECTIONS      ".init.*"
 #define DEV_INIT_SECTIONS  ".devinit.*"
@@ -887,6 +889,9 @@ static void check_section(const char *mo
 #define CPU_EXIT_SECTIONS  ".cpuexit.*"
 #define MEM_EXIT_SECTIONS  ".memexit.*"
 
+#define ALL_TEXT_SECTIONS  ALL_INIT_TEXT_SECTIONS, ALL_EXIT_TEXT_SECTIONS, \
+		TEXT_SECTIONS, OTHER_TEXT_SECTIONS
+
 /* init data sections */
 static const char *const init_data_sections[] =
 	{ ALL_INIT_DATA_SECTIONS, NULL };
@@ -898,6 +903,9 @@ static const char *const init_sections[]
 static const char *const init_exit_sections[] =
 	{ALL_INIT_SECTIONS, ALL_EXIT_SECTIONS, NULL };
 
+/* all text sections */
+static const char *const text_sections[] = { ALL_TEXT_SECTIONS, NULL };
+
 /* data section */
 static const char *const data_sections[] = { DATA_SECTIONS, NULL };
 
@@ -916,6 +924,7 @@ static const char *const data_sections[]
 static const char *const head_sections[] = { ".head.text*", NULL };
 static const char *const linker_symbols[] =
 	{ "__init_begin", "_sinittext", "_einittext", NULL };
+static const char *const optim_symbols[] = { "*.constprop.*", NULL };
 
 enum mismatch {
 	TEXT_TO_ANY_INIT,
@@ -1097,6 +1106,17 @@ static const struct sectioncheck *sectio
  *   This pattern is identified by
  *   refsymname = __init_begin, _sinittext, _einittext
  *
+ * Pattern 5:
+ *   GCC may optimize static inlines when fed constant arg(s) resulting
+ *   in functions like cpumask_empty() -- generating an associated symbol
+ *   cpumask_empty.constprop.3 that appears in the audit.  If the const that
+ *   is passed in comes from __init, like say nmi_ipi_mask, we get a
+ *   meaningless section warning.  May need to add isra symbols too...
+ *   This pattern is identified by
+ *   tosec   = init section
+ *   fromsec = text section
+ *   refsymname = *.constprop.*
+ *
  **/
 static int secref_whitelist(const struct sectioncheck *mismatch,
 			    const char *fromsec, const char *fromsym,
@@ -1129,6 +1149,12 @@ static int secref_whitelist(const struct
 	if (match(tosym, linker_symbols))
 		return 0;
 
+	/* Check for pattern 5 */
+	if (match(fromsec, text_sections) &&
+	    match(tosec, init_sections) &&
+	    match(fromsym, optim_symbols))
+		return 0;
+
 	return 1;
 }
 
