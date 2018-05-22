Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2904459-1527011913-2-39472770015780753
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527011912; b=GTeDimDg8wPBoNb+NgSFfIsNxIChX85qT4xIPknueeYay5Wb4e
    dson+eZuZI44VcEn4dcSw1masSHUN2aLmhHmG3hHkx/aMiRKIgEVSuMeaLrR1TT5
    T3+Ju/CToBqDzfOQFUeuGt4yA0Ch0YKZOGPpqH4Otva3dkgZklUeuoFEuSvoJaNg
    cDAJTtRj2+6TnzDBQwm5RArwGEy/B5DBZHytcvyiNo5jDLWQlpkLVjFoKEdgNQ7h
    J2ch+LIH+kobUvDRnEvlQOwD6PhI0wlNsJA6Jt91t9iCzR/B/+cFGhcr6C+sdjZ9
    W12uYF2lSHOv9kMX4IZWXxguPuxPg7QJxWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-transfer-encoding:sender:list-id; s=fm2;
    t=1527011912; bh=719B5pWUAEnYcWN9O3VJploJwyrIXp/WLc9PkvnItnI=; b=
    JdDXskdBNz4sXJwBB8brhpKzWotMhozcPfaziNT07w2Tc+iRxIokU9DWtGXHRMmK
    CIf6RsZ0Ne8mLyZfPriE/h3yxHrH4vPtdvaY2OeFzHjR81Hjjotg1rDD/JZt/KqG
    orvlHxR0UjUYVGOKpSBtuVnQOZnLlF0MucVueYqTg7y9U2LFIOEn0O/aZ15StG1U
    HrKfPgx2TW2OJN0jbM4TWdbqaGF9I3eZBFj/PGI4EdSFPgZigWyTT6opPDXaw0Y/
    IsYp4XD3oETb1m8n0E5saVX7qbk5pBnUWn5JlEsRyF734b4+R+ODvQC90ymPw81s
    IyHEXR9uM/hMIQ3zF4ZBJQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org
    header.i=@codeaurora.org header.b=fS4158Ga x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org
    header.i=@codeaurora.org header.b=nymtImTk x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=codeaurora.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org
      header.i=@codeaurora.org header.b=fS4158Ga x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org
      header.i=@codeaurora.org header.b=nymtImTk x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=codeaurora.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG89cakjcvMzlVjHqwtsWHqf6wEkJPxqvpB+CnXnc9EK/3ytHZTyCSVVBNv/1f7HCgZduhvevnlHfGRS6QQ7Kg97VoAO1RljqZQjzVel49O/+H9Q6WQQ
    mT2zMzuCrxcPYWFJUp/oMPllwpcZC4RDVxH+3AUQYguzrASKupheArG/OWarCp5MtnJv7G+M4JU8aiRbC2Fqp0c+HHpIZDxQN6WbTjjD1z1JT1+g/h1KKZ86
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=LpQP-O61AAAA:8
    a=VwQbUJbxAAAA:8 a=zVRjdazwAAAA:8 a=UvkM4mIKH019wfpsRTYA:9
    a=pioyyrs4ZptJ924tMmac:22 a=AjGcO6oz07-iQ99wixmX:22 a=000VuuKJPBW3DWPeRJJA:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbeEVR63 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 13:58:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54652 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbeEVR62 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 May 2018 13:58:28 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 74E4760314
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: ryan@finnie.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, stable@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI/portdrv: do not disable device on remove()
Date: Tue, 22 May 2018 13:58:00 -0400
Message-Id: <1527011883-21320-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

'Commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during
shutdown")' has been added to kernel to shutdown pending PCIe port
service interrupts during reboot so that a newly started kexec kernel
wouldn't observe pending interrupts.

pcie_port_device_remove() is disabling the root port and switches by
calling pci_disable_device() after all PCIe service drivers are shutdown.

pci_disable_device() has a much wider impact then port service itself and
it prevents all inbound transactions to reach to the system and impacts
the entire PCI traffic behind the bridge.

Issue is that pcie_port_device_remove() doesn't maintain any coordination
with the rest of the PCI device drivers in the system before clearing the
bus master bit.

This has been found to cause crashes on HP DL360 Gen9 machines during
reboot. Besides, kexec is already clearing the bus master bit in
pci_device_shutdown() after all PCI drivers are removed.

Just remove the extra clear here.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=199779
Fixes: cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during shutdown")
Cc: stable@vger.kernel.org
Reported-by: Ryan Finnie <ryan@finnie.org>
---
 drivers/pci/pcie/portdrv_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index c9c0663..d22a95d 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -409,7 +409,6 @@ void pcie_port_device_remove(struct pci_dev *dev)
 {
 	device_for_each_child(&dev->dev, NULL, remove_iter);
 	pci_free_irq_vectors(dev);
-	pci_disable_device(dev);
 }
 
 /**
-- 
2.7.4
