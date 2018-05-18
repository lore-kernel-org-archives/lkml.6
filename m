Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3608381-1526632702-2-12368221004989394416
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES ro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526632701; b=kzz0oni6qz9ZZpdv5AWog1Hrf1uTbxu408LgqW8BGXs3rdnDL0
    jwHcLPLpjmMLHqWtViwar4uixO5hLfAxRakSLYmZENAjZVHli/Di5iXVjQIF2pRh
    pTMoxv+uzRHPFuVm1HNtqi3DtH1S8EdOF7Zu2MQNlegtwXTgLa0Qo7ps5GRbrrCd
    o6WCnQReEiGmZSDaLPMUa3thc3lJsWcTP6ARsfj1C4ysMAaV28HV+T2FeG2CKuv9
    Dx+r5LXOIuJZMeMv61KsmnYnRCTLApiNWYxwPvWDuabZDHAv7ebZYCCYcw2vNBhv
    J3BvMuuW4Aq/asNkezWW6fLvrkJRAS1EMMAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526632701; bh=THG1zZphd/LXQkEHpFjp0+gFL76Vrh
    uUEeDVNxMQ+0k=; b=CEyxvXPf+jKsVvR/DOkvNqO/gW1Wzede76HP9lqUk193q7
    bXEd55VWIK3JHIYug6rIaj4aaDooT1Zl0MtLHo8e37L0AEYDyHB0YgFP/ciPII61
    lqm2FM451A6YlfMNBrbMVIFLBt171mNKKuJQfIZpR1YyrCGc4jXw4D2WQiq3+xRg
    SayoggHJdXKXwsdvOFLjuHIdPk8VDo/zlTLDfk1P1aki29IIiR1yW4IOKb8nZfRE
    yvNNARWHxVfRMWSqhM6DSzWt0nRmdZ29hbK8Gi37w6ETuaTptpWSdc7B+2/TvHX3
    /8c6NiUESSQyIF2up9s8ufxVtiNm633fmPFdlbow==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF+QHvaNh9dCj+Fg59B2UZhA88lFsQX6/1vsFRe+E6P/iPMBKOSPPaRiCI2PC26WmoszcTcdJczPuzoFpQBRTLVrka7yKaYAtk/FlVXxskCzLVZoBmed
    eqsfHNQthBH9cCDgAbo/Yi+hKXpNu0ykpDtzNM8GCIAqwPcQaiQCOy55oLWc9YgZUSAnHcnlWUTGQ9wSXUink1h/1XtseL29Iz4qOBB4f5VEd4+aXBriv5Zd
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=EqdPLkY1AAAA:8 a=QyXUC8HyAAAA:8 a=TzkOFMPegL3h_FD9u8YA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=dfeKg4RqpEhWThG6bP4-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753825AbeERIiR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 04:38:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:46326 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752373AbeERIiO (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 18 May 2018 04:38:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,413,1520924400";
   d="scan'208";a="200438768"
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-input@vger.kernel.org,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH] mfd: intel-lpss: Fix Intel Cannon Lake LPSS I2C input clock
Date: Fri, 18 May 2018 11:38:27 +0300
Message-Id: <20180518083827.20626-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Intel Cannon Lake PCH has much higher 216 MHz input clock to LPSS I2C
than Sunrisepoint which uses 120 MHz. Preliminary information was that
both share the same clock rate but actual silicon implements elevated
rate for better support for 3.4 MHz high-speed I2C.

This incorrect input clock rate results too high I2C bus clock in case
ACPI doesn't provide tuned I2C timing parameters since I2C host
controller driver calculates them from input clock rate.

Fix this by using the correct rate. We still share the same 230 ns SDA
hold time value than Sunrisepoint.

Cc: stable@vger.kernel.org
Fixes: b418bbff36dd ("mfd: intel-lpss: Add Intel Cannonlake PCI IDs")
Reported-by: Jian-Hong Pan <jian-hong@endlessm.com>
Reported-by: Chris Chiu <chiu@endlessm.com>
Reported-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
Hi Jian-Hong, Chris and Daniel. Could you test does this fix your
touchpad issue?
---
 drivers/mfd/intel-lpss-pci.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index d1c46de89eb4..d9ae983095c5 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -124,6 +124,11 @@ static const struct intel_lpss_platform_info apl_i2c_info = {
 	.properties = apl_i2c_properties,
 };
 
+static const struct intel_lpss_platform_info cnl_i2c_info = {
+	.clk_rate = 216000000,
+	.properties = spt_i2c_properties,
+};
+
 static const struct pci_device_id intel_lpss_pci_ids[] = {
 	/* BXT A-Step */
 	{ PCI_VDEVICE(INTEL, 0x0aac), (kernel_ulong_t)&bxt_i2c_info },
@@ -207,13 +212,13 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x9daa), (kernel_ulong_t)&spt_info },
 	{ PCI_VDEVICE(INTEL, 0x9dab), (kernel_ulong_t)&spt_info },
 	{ PCI_VDEVICE(INTEL, 0x9dfb), (kernel_ulong_t)&spt_info },
-	{ PCI_VDEVICE(INTEL, 0x9dc5), (kernel_ulong_t)&spt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x9dc6), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x9dc5), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x9dc6), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x9dc7), (kernel_ulong_t)&spt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x9de8), (kernel_ulong_t)&spt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x9de9), (kernel_ulong_t)&spt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x9dea), (kernel_ulong_t)&spt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x9deb), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x9de8), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x9de9), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x9dea), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x9deb), (kernel_ulong_t)&cnl_i2c_info },
 	/* SPT-H */
 	{ PCI_VDEVICE(INTEL, 0xa127), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0xa128), (kernel_ulong_t)&spt_uart_info },
@@ -240,10 +245,10 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0xa32b), (kernel_ulong_t)&spt_info },
 	{ PCI_VDEVICE(INTEL, 0xa37b), (kernel_ulong_t)&spt_info },
 	{ PCI_VDEVICE(INTEL, 0xa347), (kernel_ulong_t)&spt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0xa368), (kernel_ulong_t)&spt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0xa369), (kernel_ulong_t)&spt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0xa36a), (kernel_ulong_t)&spt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0xa36b), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa368), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa369), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa36a), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa36b), (kernel_ulong_t)&cnl_i2c_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, intel_lpss_pci_ids);
-- 
2.17.0
