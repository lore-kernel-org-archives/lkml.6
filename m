Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3075552-1525602677-2-2240411810306854552
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525602676; b=b38RrXEFohd3JHtkJ0tZQ/gjOCSDFk/WXFwR4SA+ziRZuOAepT
    5y6KDZ2l2SbQK9M7zjEERra6wRaYU1mHsJKCDnQKlaxiNJisMkgaVZFIIO1RF/WR
    ixsfgEn5dYj1SJ00A4BJD8iTbqFSkNVapYJbjGdvGcthloV+0PwrCYLXJQn87GlX
    RtHV2kZgyAAbmOLeMC/N18719p9UzSGfl61gdOShPP1vNjRrUz4OOVlMOTNL3sMV
    Z8SovlnkU1uT/QS9pLinvLOTWGLUA5ZBMYiLBgaMzZmQ7GFHgB0YPTBbGulSGyjR
    6QUVdTdSM/4AbmeZP6uYoOAYCoF0bRYk3H+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-transfer-encoding:sender:list-id; s=fm2;
    t=1525602676; bh=LTsun5XMdEaAvh9CdLtoJGHbQpu26AdCmmyovF5Otss=; b=
    gvv18QhPHtpxiV7fD6oeKkopx0Cqa6gZrrGFoe9NnqFG4ZbL9LrNNVWR3mpIC1bU
    b+rOttbQys+dymrtrlRPKbQ6askmLh1NGIhvsA5ha6CMY2SaqkacnLLdhqKP+iAS
    KespQJhD3jH6wfjh7CP8atRSPBXdVv/uT35N6TVYqYmzYN/JAQBd3xEYN8VWBAq8
    9QyBfVLDbsRBBPzcFe3eziMmUmEqYcgbpIETJPa9d+55tyFanSE2PbIVrKwGNt+e
    vvgFSrQfZaNlDQVmfin7ucEJMAvemDnSIc9pzcyONwyqtsdwKBL2RqYtcStCHVsx
    Vp57x/rUAqsMl88w6rHtQA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org
    header.i=@codeaurora.org header.b=P44nICoU x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org
    header.i=@codeaurora.org header.b=YeDXrm8g x-bits=1024 x-keytype=rsa
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
      header.i=@codeaurora.org header.b=P44nICoU x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org
      header.i=@codeaurora.org header.b=YeDXrm8g x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfHqDmLtch5Ia712mbGf/CO+az7OyEzGXXiQZGA76vlXStIBoTvvCNaHv2+CO2GtrwBFsORYWu2yRkPF7fu3smni03TTsoImcYzlzo4Pp+IZe1niUGqY9
    wrrFJnN/6N8gGPHli0+E7+VjzOWxsEy4Oeb/EAGZ1Ie18y6L+g6CEEDeCHUPyddenc1GUcFS58nwA0kbf+TsHJ8fwzxMSybbwZo4ZRNW94uZxOQxXhlNmoI6
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=LpQP-O61AAAA:8 a=8cCazns7UaYTUAZV410A:9 a=AjGcO6oz07-iQ99wixmX:22
    a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeEFKbP (ORCPT <rfc822;greg@kroah.com>);
        Sun, 6 May 2018 06:31:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51040 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbeEFKbN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 6 May 2018 06:31:13 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC556601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, stable@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Keith Busch <keith.busch@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI: pciehp: Add quirk for QDF2400 Command Completed erratum
Date: Sun,  6 May 2018 06:30:53 -0400
Message-Id: <1525602662-1873-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The QDF2400 controller does not set the Command Completed bit unless
writes to the Slot Command register change "Control" bits.  Command
Completed is never set for writes that only change software notification
"Enable" bits.  This results in timeouts like this:

pciehp 0000:00:00.0:pcie004: Timeout on hotplug command 0x1038

Cc: stable@vger.kernel.org
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/hotplug/pciehp_hpc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index e70eba5..974a8f1 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -914,3 +914,9 @@ static void quirk_cmd_compl(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+
+DECLARE_PCI_FIXUP_CLASS_EARLY(0x17cb, 0x400,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+
+DECLARE_PCI_FIXUP_CLASS_EARLY(0x17cb, 0x401,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
-- 
2.7.4
