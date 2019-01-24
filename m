Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188AEC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC401218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358484;
	bh=z+fXWaGPzFwEWZFIWyvaL8cSJFYKzfql05pzUgF1HkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bGB0LQbK2y00PqP4335OqE01JStvjXvpdkbc5dwYWJEB+Nw2xnpsiChbsZPZMPO+7
	 7ID/kUUKAMsjnt4yCS05TzlPOV724Tkp3GBAbVvD8bzJxGu47FGt3seHdpU2wbyHkB
	 tSsKUX/VLezWjok2F3m5E0UdzTS5qiZI68jPfCAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbfAXTen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:34:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732241AbfAXTem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:34:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04A8421905;
        Thu, 24 Jan 2019 19:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358481;
        bh=z+fXWaGPzFwEWZFIWyvaL8cSJFYKzfql05pzUgF1HkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7Pdn9gBcuvRARfi7/17IBC8VCLuzFH0vswQ0vxn8jDKO6oXTg2gxFdVTfmCaRg1o
         CNmmG7kPAfMwUCz+435/ugmZPAHf3a3375/8PwHyhPC5Fv6U85eNhHOjih97eJOFqI
         jFaomsM4mIz8mRhfJ7vnGgnYqylJ2PpHb2BKluwM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 007/106] r8169: Add support for new Realtek Ethernet
Date:   Thu, 24 Jan 2019 20:19:24 +0100
Message-Id: <20190124190206.861025806@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 36352991835ce99e46b4441dd0eb6980f9a83e8f ]

There are two new Realtek Ethernet devices which are re-branded r8168h.
Add the IDs to to support them.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -214,6 +214,8 @@ enum cfg_version {
 };
 
 static const struct pci_device_id rtl8169_pci_tbl[] = {
+	{ PCI_VDEVICE(REALTEK,	0x2502), RTL_CFG_1 },
+	{ PCI_VDEVICE(REALTEK,	0x2600), RTL_CFG_1 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8129), 0, 0, RTL_CFG_0 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8136), 0, 0, RTL_CFG_2 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8161), 0, 0, RTL_CFG_1 },


