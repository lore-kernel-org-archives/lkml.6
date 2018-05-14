Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-402196-1526281486-2-11931190570268727047
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526281485; b=AxqnJ+udIN+j4MoeRpx8D4rswTG9lbvLb17iFmBm7qYlQBTHam
    KDNIr3gt9/2PLMhR2gX0K7b0P+kR39df5ziLVkeWcTukXLPmcWQ3jO/C+cgA5lU1
    eNPkxazt/tNUmveGTDxxRRLhaOYDTHOJYxuXCbM1zyo1rnJoyQxyTbgZrvPWxk0J
    /zh30QsDIm6PDn5UqCYWLQRxVjNmYFc0N85T5X5JaW0+n3CRz5uK7ZPHxsqA/AXD
    MmNXvtznqDVufVse3aV41TxqLJRGmyDR+4rvPpfBdWAAGaotRTWQvGPXQ4MXgQqA
    RXULzNZQ98WwOX1R1ubuB6/XwfR03R+mutcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526281485; bh=SdXfadypTXpTBr1mPXOzQhWqAgN6hN
    dHQS8a6fS8MGU=; b=hpf+BAis4sDH/ycBE2AQp/GSxeX6subny+AoYwUke4mjnO
    JGF+4j4lUsgkm7pRth69c1wnczHnNZm+lWb/KPsB7r1iBzvOljfQfudFWe5UhEec
    sDtQCS6mcgUKKJkpOXXpLESPbQ08h2ruatIeKh00ZPrIdI53xDPHJlnMfz/+ib/D
    HHfd22kjizZMmJuq4Ow3enBZmBzFQ2SxepOqRTlDb9FZT5dZUKhcxzsKEX+j6fxk
    FxYXXcEBeu1lKLqfGtalj+1woX+c+Q8OnTwAbZZil+lj6iLCM4yiyZUQhptcF0i3
    ugSddIdUG8ihLyudXzifhICe+/Mvz7Bl5xr7TBcQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=pM3LRjTa x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=pM3LRjTa x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCtSsPbzNCQbirS3MI9rfjSy5RGushP3VqTEyqqLg+2qgI5xMoLQWh9ijixMAiR7ydKQz80Hik6Yh7lGMa5HsZ+M/eZR5IuHYX/2FsmBfIBALNO7g5j1
    Ft+AM7U52uHFx+YL9ZCDYIrkoF0nNS6NUk+WTgn30M2/7odFiC9f/jjsgdDAdphxOYsXI9MkBe9WjXpLK4u0btxWjXhlNG7ubyTHoIs+AuG75LXaKn8CapVw
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=QyXUC8HyAAAA:8
    a=ag1SF4gXAAAA:8 a=YQl0GWw6Zf5YOcMYI_UA:9 a=QEXdDO2ut3YA:10
    a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754113AbeENG77 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 02:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932099AbeENG75 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 02:59:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.16 52/72] PCI / PM: Always check PME wakeup capability for runtime wakeup support
Date: Mon, 14 May 2018 08:49:09 +0200
Message-Id: <20180514064825.714164841@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai Heng Feng <kai.heng.feng@canonical.com>

commit 8feaec33b9868582654cd3d5355225dcb79aeca6 upstream.

USB controller ASM1042 stops working after commit de3ef1eb1cd0 (PM /
core: Drop run_wake flag from struct dev_pm_info).

The device in question is not power managed by platform firmware,
furthermore, it only supports PME# from D3cold:
Capabilities: [78] Power Management version 3
       Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
       Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

Before commit de3ef1eb1cd0, the device never gets runtime suspended.
After that commit, the device gets runtime suspended to D3hot, which can
not generate any PME#.

usb_hcd_pci_probe() unconditionally calls device_wakeup_enable(), hence
device_can_wakeup() in pci_dev_run_wake() always returns true.

So pci_dev_run_wake() needs to check PME wakeup capability as its first
condition.

In addition, change wakeup flag passed to pci_target_state() from false
to true, because we want to find the deepest state different from D3cold
that the device can still generate PME#. In this case, it's D0 for the
device in question.

Fixes: de3ef1eb1cd0 (PM / core: Drop run_wake flag from struct dev_pm_info)
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: 4.13+ <stable@vger.kernel.org> # 4.13+
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pci.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2125,16 +2125,16 @@ bool pci_dev_run_wake(struct pci_dev *de
 {
 	struct pci_bus *bus = dev->bus;
 
-	if (device_can_wakeup(&dev->dev))
-		return true;
-
 	if (!dev->pme_support)
 		return false;
 
 	/* PME-capable in principle, but not from the target power state */
-	if (!pci_pme_capable(dev, pci_target_state(dev, false)))
+	if (!pci_pme_capable(dev, pci_target_state(dev, true)))
 		return false;
 
+	if (device_can_wakeup(&dev->dev))
+		return true;
+
 	while (bus->parent) {
 		struct pci_dev *bridge = bus->self;
 
