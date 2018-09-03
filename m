Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B873BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1EC2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1EC2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbeICVev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:34:51 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:44411 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbeICVeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:34:06 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue105 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0MANKs-1g3yt827o2-00BbCa; Mon, 03 Sep 2018 19:12:56 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Woojung Huh <woojung.huh@microchip.com>
Cc:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 1/4 next] net: lan78xx: Bail out if lan78xx_get_endpoints fails
Date:   Mon,  3 Sep 2018 19:12:36 +0200
Message-Id: <1535994759-8938-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535994759-8938-1-git-send-email-stefan.wahren@i2se.com>
References: <1535994759-8938-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:BL4mbsVup+oTe9EvMq/D8jhxS4LWLU2qYp6W7/Kk2gLsufXX9j4
 Q6qdE30ETptW/wy5dSsnze3bMzJYP1nF9tAHGT0gvdY5LonBjdWxh1zPC9PL/eALqJhyzwA
 STmZ4FAsNhuPVmGm9eB/YdEmVzbUn1OA6Azlgo8u85QysZzT0xJYPiYavNkvWp+HUjjVzOH
 ewxbuZdsuP5KFiUK0hg5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Te/p+sDip7Q=:CgIwKBBM/7R2VYUQOO9r5B
 /WuyyL7n3/u0388erubDhCY4vtwQJlckHHGvHjRQZVKVj2SY7HQk64G/eZQx3dP2C267IVeIO
 EySWq67M1wDidfteA2e66ZfUmAiB3Kp3lbdydILELdyKc/dHzy7vJT/m9x6LtVUILH4o9tGsb
 P59ddnPkMacM5RtLvwE7ikcTOrO64QhPwAwnj0p4eZuDsbDaxphuDuqEE/RuLCFj1QAy1LJYv
 WhbjYAiJyJXh0tt14pCZRwA7UvMTZKgpZUqAuVguBsmTjPERfFtg17J7k07jOr0Xz4e1Uss90
 KKIWpObPtSFNJSEsS4cWINUGD39mN9dEGh5gOeycU1EitYbULeHblEuidH6kznrtO/g99jMID
 gYRtzzeuxt5DsrGrINKU7y5ULenSKiBn53mSPsFSWfHBm5yphufvqAYzwu0P42PxiCJHw0V+N
 ofASIb82LV7Ul5dm51xRLjAgmPM69ALPlUdlmwSiC4+oPXIliHVxdB4HfOb3Q9XuQguTMQiRd
 dLfvs+vp6+xPMBe0R6c5atzllW5KL7rydyRJ+mhX+VE+1gCmw+YlF+F5jGxFgSD+9N5DINdPC
 u9M06oZQp/8p3Cp4qgLflJ3rUhqAGTtc3TOo04VRFqLW8xE1D8NwuZSHP+t68oYKBqf63kXpK
 sxb0kja5PMBVdDFpg88Ez/CCsjCQ/h1P1X0PX682i5D7ZMk3oPF0FI1kseO/I7f4KPhw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to bail out if lan78xx_get_endpoints() fails, otherwise the
result is overwritten.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/net/usb/lan78xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index a9991c5..3f70b94 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2952,6 +2952,11 @@ static int lan78xx_bind(struct lan78xx_net *dev, struct usb_interface *intf)
 	int i;
 
 	ret = lan78xx_get_endpoints(dev, intf);
+	if (ret) {
+		netdev_warn(dev->net, "lan78xx_get_endpoints failed: %d\n",
+			    ret);
+		return ret;
+	}
 
 	dev->data[0] = (unsigned long)kzalloc(sizeof(*pdata), GFP_KERNEL);
 
-- 
2.7.4

