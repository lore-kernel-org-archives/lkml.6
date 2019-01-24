Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDB7C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B894B218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360670;
	bh=nMm7cQdjaL+QIf+8GL2t/uWhO5vbZJxEC+65+cQHm1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EnS8emt+pbe86G0EGV95L4AYcpavn1feFjKLuiIqKL50ch5QX5Mkhu6NbQ70lbCus
	 5uabZ7JSr2gaER89t4SQWrhi9qjBx4sKNzu7LcTzPXgWL/8I8TLui8FrznUHgIR8dU
	 7Yt0v75hOxTcl5G91DedCczD4JPPaWmhllBRjKOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbfAXULJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:11:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730167AbfAXT1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:27:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 708FE218FC;
        Thu, 24 Jan 2019 19:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358033;
        bh=nMm7cQdjaL+QIf+8GL2t/uWhO5vbZJxEC+65+cQHm1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BM/GIbNNZnbaN4TTIBzX/IlG5yYbvx4djfdFP9ucqpCUk+BMwBi8kAp6DDbcXodSH
         /j2zlrJ1Ra8RsRid3Iop1uCa2BU88+9UFHMd57rG9OCA5HqE74F/Iooqb6aRiTRjr5
         /g9J37jurcxyDxfdhfR6penXNi1uMQyW+W4+U9/w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 073/104] r8169: Add support for new Realtek Ethernet
Date:   Thu, 24 Jan 2019 20:20:02 +0100
Message-Id: <20190124190203.582446352@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -324,6 +324,8 @@ enum cfg_version {
 };
 
 static const struct pci_device_id rtl8169_pci_tbl[] = {
+	{ PCI_VDEVICE(REALTEK,	0x2502), RTL_CFG_1 },
+	{ PCI_VDEVICE(REALTEK,	0x2600), RTL_CFG_1 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8129), 0, 0, RTL_CFG_0 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8136), 0, 0, RTL_CFG_2 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8161), 0, 0, RTL_CFG_1 },


