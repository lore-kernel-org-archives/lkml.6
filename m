Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835134-2-7489272006778962563
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835133; b=fMt2dZmomjrZGKSDc7577k5/AguMr+zOq7kP3i6s3XksA9n
    DRRJ3PUfBq53ut6BE5cVw8cJenlFFyChpN/7Paonn8axTLvWiC+TM9H037JChXTm
    vLC046/HEngfW1Xg/X9u3IwQcSDvHw526+NyDdYB991ULV44RrYt8o0ox8tHlr8m
    i+SRUuCfZCoeFiBtrdHj2nJaQi6U/iI5phV474CrlfhX/oEn5Uj7cnzv95DQbal7
    p2x5wqU095WrvvouBL9PJwCwMcXRLH75tsy9yl6dnADDYQ3wmNwVI4u2+O4OIVEY
    wEeeZTMbDvgGok932BG3U4QlrYR8FqbjrAR+gLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835133; bh=J7KiIdM2io/aqi05fmC
    6eWF/QbgnhCRPQP/INt+TbUI=; b=PhIvmkwJwhq2BUMSDKVINZYGz+RUG6o5laQ
    16VkANW0RzUdQEKriUx1XoQKkPDV04bxHCUfeqnLEW36ON5HQs0tBSvIlviaZ6+Y
    GbDDnSmGnyiEBFUDZux83lUMBsnSoAFmJzlfw+q3cuvP23YumBfDK/mILc+kOgCn
    JgLm3UbDFS1VFDbSO9zCmDa73kbA46iJ2ra8Uc6bNCDNTxBSUnwcMopgbL8kbvUQ
    phC0wyhhmHjKLTgiXe5E2/B0ceiu7FvA9YSES0B8oW60AaBiR7txSJu+bNniaWf6
    TQ3SOuW2W9NWQ6NLaLFyvKR3GvAd7xtPq/HIHFTlwLRPb00FbFA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933432AbeB1QZa (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:25:30 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35346 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935089AbeB1QUZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:20:25 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Linux PCI" <linux-pci@vger.kernel.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.329460370@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 059/254] x86/PCI: Make broadcom_postcore_init() check
 acpi_disabled
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

commit ddec3bdee05b06f1dda20ded003c3e10e4184cab upstream.

acpi_os_get_root_pointer() may return a valid address even if acpi_disabled
is set, but the host bridge information from the ACPI tables is not going
to be used in that case and the Broadcom host bridge initialization should
not be skipped then, So make broadcom_postcore_init() check acpi_disabled
too to avoid this issue.

Fixes: 6361d72b04d1 (x86/PCI: read Broadcom CNB20LE host bridge info before PCI scan)
Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>
Link: https://lkml.kernel.org/r/3186627.pxZj1QbYNg@aspire.rjw.lan
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/pci/broadcom_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/pci/broadcom_bus.c
+++ b/arch/x86/pci/broadcom_bus.c
@@ -97,7 +97,7 @@ static int __init broadcom_postcore_init
 	 * We should get host bridge information from ACPI unless the BIOS
 	 * doesn't support it.
 	 */
-	if (acpi_os_get_root_pointer())
+	if (!acpi_disabled && acpi_os_get_root_pointer())
 		return 0;
 #endif
 
