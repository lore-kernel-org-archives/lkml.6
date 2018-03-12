Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443661-1520826534-2-7997291587378893792
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520826533; b=HO2glwmfPVazW/D6Hgy+weLp414knJna8ZQVGIh8qs4xuWM
    OS3t58F2PNhjZXk2C2Nm+fUpplKYzVwTLSKRu/EssJN09F8tcu0E+9iPiJs4X4gc
    P7WHHj3hNwV7VxTQ3jM/linj8vikFqmB1ZVDh3xDO/scBUWbUgi5YUCK5bhGVPga
    nzG+AfJQwfEUlr/lawAaJDe9Gkt54XTQazPsam77v8ZBCpx+svhXSJyMp4hJRwcE
    foDygrGq4R/2JuXHnndKZM/3rvV+lHzpNQGC51PEsHsflybBxE7oPciEqMYTUhY+
    mCeKCG0mKyjwKeRwWdUE/usAUrn1y0WYMwwcCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826533; bh=4sah/5JX/kqXoxqalBa
    3zerkJsil3DyJOlrocCcisnw=; b=kgSdOGWE6DCAQ8LW+RA1lYbkSLM5Kof2kRP
    0Ia11nnlMsvbpxR5CgmaAK44IWGqBAhFvf9DRo7PWpge+Lxco2OTm73gxIlLR5U8
    gvp4D3KcAJ5OhaK0f0074mUXvHsNRi7oz51VLwTbXXY8Ub/mcriWpuXgWIfoOfnv
    qtR9yAiqgs9S243PPx8SiByUa/bKSTfNB84TAkKKKNkIFUQTf+VyROCKPehXb0wK
    vxOmbQaptLL8QzjWYNVjL5ftWhbU7V4ON1AsBrmicHsN0f8bcN0TDcx/1TNJdLVZ
    d0J4KGiIladsOX6f9SC4xC3NzBJpGeF0ylOO18asSYfW07JtldA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S932764AbeCLDsu (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:48:50 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41088 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932621AbeCLDHl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:41 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Borislav Petkov" <bp@alien8.de>, "Andi Kleen" <ak@linux.intel.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.867341874@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 080/104] x86/cpu/bugs: Make retpoline module warning
 conditional
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

From: Thomas Gleixner <tglx@linutronix.de>

commit e383095c7fe8d218e00ec0f83e4b95ed4e627b02 upstream.

If sysfs is disabled and RETPOLINE not defined:

arch/x86/kernel/cpu/bugs.c:97:13: warning: ‘spectre_v2_bad_module’ defined but not used
[-Wunused-variable]
 static bool spectre_v2_bad_module;

Hide it.

Fixes: caf7501a1b4e ("module/retpoline: Warn about missing retpoline in module")
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/bugs.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -236,9 +236,10 @@ static const char *spectre_v2_strings[]
 #define pr_fmt(fmt)     "Spectre V2 : " fmt
 
 static enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
-static bool spectre_v2_bad_module;
 
 #ifdef RETPOLINE
+static bool spectre_v2_bad_module;
+
 bool retpoline_module_ok(bool has_retpoline)
 {
 	if (spectre_v2_enabled == SPECTRE_V2_NONE || has_retpoline)
@@ -248,6 +249,13 @@ bool retpoline_module_ok(bool has_retpol
 	spectre_v2_bad_module = true;
 	return false;
 }
+
+static inline const char *spectre_v2_module_string(void)
+{
+	return spectre_v2_bad_module ? " - vulnerable module loaded" : "";
+}
+#else
+static inline const char *spectre_v2_module_string(void) { return ""; }
 #endif
 
 static void __init spec2_print_if_insecure(const char *reason)
@@ -435,6 +443,6 @@ ssize_t cpu_show_spectre_v2(struct sysde
 		return sprintf(buf, "Not affected\n");
 
 	return sprintf(buf, "%s%s\n", spectre_v2_strings[spectre_v2_enabled],
-		       spectre_v2_bad_module ? " - vulnerable module loaded" : "");
+		       spectre_v2_module_string());
 }
 #endif
