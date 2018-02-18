Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-717636-1518944932-2-6450580859368769762
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518944931; b=f2eIg32k66iDHguysLF/b2WqkxwjQPdpozX/yaH6w8CWMna
    Pq2BKuneexOG+ufg3ZuVJrAEkef+O/6h3lLCsb90rEB6HniggWDSVsipUOL0MQi0
    c6nWgVhkD76aDa410KQRO5AB7y+Q2OJQa7PB49WetoBInQvkpw/rUnlLHULR6Afh
    Jl6jqZ3T3H+H7UbXFuA1xPd3oE1p5t7W+hLQQFL6YPwZlk31e0L3f++HnQG9RHlh
    Ne3qQEE0pRouHD0u6qynAe2VwszFo7nBC6Nb59cB9JEHiEALDpqO33VXj6o+apvu
    rWTHkpB/7Z/5im7pvvzoQXSi2v9aTbCuEGC6iXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518944931; bh=1q3hIAqbjegE4PLr6DxdGopCvI
    /XPZcFxu6zx4plzFg=; b=WKX6jJ2INhcFVZPjVoOavAvJvvzcYKyOmdNvLEWQtV
    cVg//UwJjjxxKkMCIW/6qsoepuX5ktmzUOBODImT89Twbl+r/Pnmd+EFvFaR9GxB
    msL4+R9exh3OS20j6BeHtW34dGQoqrRcWss5L8MIrabWMJDZP3HfBhD/SyhtcBTt
    p0+cJdAF5epkaACTNWhTTzgGQpF0Pynk4IBmZVmpyYXch2mT8P0O3n35M7WQ1G+3
    2kqNIat76pyEqBmcaF1jVe83NIuiMkn5EXuRLLgvsn7Sy4J5Ip+Myg966yVGghN/
    a7c7296SGJfLS0a+P8NQWcLlIQgl1puxdfWGDlXSGeZg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbeBRJI1 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Feb 2018 04:08:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:12868 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751155AbeBRJIZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 18 Feb 2018 04:08:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,529,1511856000";
   d="scan'208";a="28919125"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc 1/2] mei: me: add cannon point device ids
Date: Sun, 18 Feb 2018 11:05:15 +0200
Message-Id: <20180218090516.21077-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexander Usyskin <alexander.usyskin@intel.com>

Add CNP LP and CNP H device ids for cannon lake
and coffee lake platforms.

Cc: <stable@vger.kernel.org> 4.14+
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw-me-regs.h | 3 +++
 drivers/misc/mei/pci-me.c     | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index 0ccccbaf530d..bda3bd8f3141 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -132,6 +132,9 @@
 #define MEI_DEV_ID_KBP        0xA2BA  /* Kaby Point */
 #define MEI_DEV_ID_KBP_2      0xA2BB  /* Kaby Point 2 */
 
+#define MEI_DEV_ID_CNP_LP     0x9DE0  /* Cannon Point LP */
+#define MEI_DEV_ID_CNP_H      0xA360  /* Cannon Point H */
+
 /*
  * MEI HW Section
  */
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 4a0ccda4d04b..f915000e5bf9 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -98,6 +98,9 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{MEI_PCI_DEVICE(MEI_DEV_ID_KBP, MEI_ME_PCH8_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_KBP_2, MEI_ME_PCH8_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_LP, MEI_ME_PCH8_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_H, MEI_ME_PCH8_CFG)},
+
 	/* required last entry */
 	{0, }
 };
-- 
2.14.3
