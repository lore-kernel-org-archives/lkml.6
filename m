Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2D2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639EF2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639EF2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbeICVeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:34:12 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:46269 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbeICVeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:34:11 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue105 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0LoIBN-1fPkRN3Zbl-00gEw7; Mon, 03 Sep 2018 19:12:56 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Woojung Huh <woojung.huh@microchip.com>
Cc:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 2/4 next] net: lan78xx: Drop unnecessary strcpy in lan78xx_probe
Date:   Mon,  3 Sep 2018 19:12:37 +0200
Message-Id: <1535994759-8938-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535994759-8938-1-git-send-email-stefan.wahren@i2se.com>
References: <1535994759-8938-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:dP6QZtZYzbdKIE6oE3N8dDZScw/W4mGynwDISB3H9147qWLNu6q
 V4A6u2nvpad70NzAW4kqkUB3mv0bJbArwhnkvPlFZST9YRseTlNbrXFpEjiqzwxq1G3L5YB
 EOYyt2FIiiDs/7Fml7BECkImq6iGhgLRWJE4Q/JZbLKcxYcfLKWCwAue1o8hBEuESlbAOSF
 EgTc6p5W/knjLfh0CE4Mw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:95DVrgEnyyY=:ZxKls4R0GdnLGDTbB5OoNY
 oUmHK1d5fv2uXSPN0IWc4h7chEizACn1/i3nPsJvc2dRUp5LYTF+rgYu4lrQikhnFAHXPQrys
 9e9JAU3qqVy9MYWLTp5uJCIGDxpCXNxN6bKHKDhVkB72LabEtQYwyL0tcNoNQuL6cLgWA7ebx
 VgNAo6Ii+4AoObE9rWJVXdNFIldWbC82WiYoio+hRxoPVQROU0sFbIADnxi7cGVBbSqTl43kc
 gADI7V/eIVmw6jkFDmxP1/exURgU159WDFpV2xVpsmuXe2SfuHakXID1fWr+LVlNK99IVIuE1
 x1WDwtSrIAhlc0apYFg3/6LFQyay2ZCnFRvS50fdgZDqdpeidfTxmI3SRWtGlXTJzKTTczoqm
 JUAy0i4Q3mr7D538yty3MUO3k+aWOgsGwM/IGQRyD5jIiuaua+L57Zq1XQiZwsYOz3n3thsBw
 aY3r287/ZA28wHoOwia0NRIXp6eOwCX5JGY0x0ZdWYMFINYILfR3D2a9HYqoH3MjpFyByFQuX
 dTijet5RcnyhR1Mxo571JMQaerdHg36CyFM9aywOrE3VKwOTNGJ4FlNPu2xOGCmUUpXfOpCjL
 yW8zCuur1pK279nVJfm0OLMLiMrgtmOqb4weFpOy3KBDU3lfoUYqUSdCYWQ6i0G88nM6/ig1U
 agMs0PXh+OWaY2jCQbQH/o3RPvt8/0t9HXRK9NANsnqlEeRPPxZ514Rb9hyD2t6Qn6eg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for this strcpy because alloc_etherdev() already
does this job.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/net/usb/lan78xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 3f70b94..3d505c2 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3766,7 +3766,6 @@ static int lan78xx_probe(struct usb_interface *intf,
 	ret = lan78xx_bind(dev, intf);
 	if (ret < 0)
 		goto out2;
-	strcpy(netdev->name, "eth%d");
 
 	if (netdev->mtu > (dev->hard_mtu - netdev->hard_header_len))
 		netdev->mtu = dev->hard_mtu - netdev->hard_header_len;
-- 
2.7.4

