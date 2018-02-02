Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2948269-1517591361-2-8969702754351616370
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591360; b=pM1XgZGT4qnblc6ql1XK1K5GK8HL1rcU9TD3q/UZpq4MGD8
    fjrEoyedjqlFS/RHdhbu1QwZ9tQByyQzifrvw4craxw05MPLvGiL4/mT6bS6LdwN
    hnuYl0QXqElHIMgH6TnlyGli5STRAVO/vWyIbDOtvSQSluvhHvwQeDvtg1TN6TJM
    MA2bfv+xaRFYiVfCE7sPqmrT0Da3CI7t8QpCD4a6s/+IroM44OUqfg1dPp9APC29
    AHoGNVgYwD/DhvKPpcpmHPiMYML4zKy4t5p3/hgDDUc2emsaVFQJv6BHmZlkNHAW
    kAQ+BgBa7Z5PODPDpN60vzd6Z/k6DBNQTBP21Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591360; bh=5jhEvJ+c5n1igWezhtLNK9WU52
    /PMDw5NifM4T3hlE4=; b=eNSiFD5nACsbG7POdh1GinB8gs3GScyQf1SxlEblML
    aUPayqnsxJpIa8qpYG+Ej9dx1LjyLc4i1KHbij2CHtNNU6GJyl9Vgge97wXr0IUt
    6wnuLWu3e58/y4eg/hbXZS+p6GYKR8R4vkfiFwu6W5hJHkNKqd0wAdN1JKVpM9VH
    vUFsj1RwVeuHOdz5iB6y22lhCreOq5A8irPRfPu6cyUIDKxvh+MkQmeZcaL57sIx
    rA2TEhTr/EGi9Xgea5Q1MW32K0oiqaL6v0/ACJj5E0qsLOa1CquTHqPB6g8M8Rah
    sIdfnX3hoWrD42E+QpE0Z54dNOc5MzbZbj6mfi70TTCQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752494AbeBBRJQ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:09:16 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37798 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753057AbeBBRJH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:09:07 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 049/156] nvme-pci: disable APST on Samsung SSD 960 EVO + ASUS PRIME B350M-A
Date: Fri,  2 Feb 2018 17:57:10 +0100
Message-Id: <20180202140842.503134182@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>


[ Upstream commit 8427bbc224863e14d905c87920d4005cb3e88ac3 ]

The NVMe device in question drops off the PCIe bus after system suspend.
I've tried several approaches to workaround this issue, but none of them
works:
- NVME_QUIRK_DELAY_BEFORE_CHK_RDY
- NVME_QUIRK_NO_DEEPEST_PS
- Disable APST before controller shutdown
- Delay between controller shutdown and system suspend
- Explicitly set power state to 0 before controller shutdown

Fortunately it's a desktop, so disable APST won't hurt the battery.

Also, change the quirk function name to reflect it's for vendor
combination quirks.

BugLink: https://bugs.launchpad.net/bugs/1705748
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/pci.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2282,7 +2282,7 @@ static int nvme_dev_map(struct nvme_dev
 	return -ENODEV;
 }
 
-static unsigned long check_dell_samsung_bug(struct pci_dev *pdev)
+static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 {
 	if (pdev->vendor == 0x144d && pdev->device == 0xa802) {
 		/*
@@ -2297,6 +2297,14 @@ static unsigned long check_dell_samsung_
 		    (dmi_match(DMI_PRODUCT_NAME, "XPS 15 9550") ||
 		     dmi_match(DMI_PRODUCT_NAME, "Precision 5510")))
 			return NVME_QUIRK_NO_DEEPEST_PS;
+	} else if (pdev->vendor == 0x144d && pdev->device == 0xa804) {
+		/*
+		 * Samsung SSD 960 EVO drops off the PCIe bus after system
+		 * suspend on a Ryzen board, ASUS PRIME B350M-A.
+		 */
+		if (dmi_match(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC.") &&
+		    dmi_match(DMI_BOARD_NAME, "PRIME B350M-A"))
+			return NVME_QUIRK_NO_APST;
 	}
 
 	return 0;
@@ -2336,7 +2344,7 @@ static int nvme_probe(struct pci_dev *pd
 	if (result)
 		goto unmap;
 
-	quirks |= check_dell_samsung_bug(pdev);
+	quirks |= check_vendor_combination_bug(pdev);
 
 	result = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
 			quirks);
