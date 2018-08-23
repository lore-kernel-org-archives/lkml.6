Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE1CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FB12098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FB12098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbeHWL30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:29:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44320 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbeHWL3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:29:25 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B2BBFBB6;
        Thu, 23 Aug 2018 08:00:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Lechner <david@lechnology.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 61/79] net: usb: rtl8150: demote allmulti message to dev_dbg()
Date:   Thu, 23 Aug 2018 09:53:37 +0200
Message-Id: <20180823074923.138104553@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074918.641878835@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Lechner <david@lechnology.com>

[ Upstream commit 3a9b0455062ffb9d2f6cd4473a76e3456f318c9f ]

This driver can spam the kernel log with multiple messages of:

    net eth0: eth0: allmulti set

Usually 4 or 8 at a time (probably because of using ConnMan).

This message doesn't seem useful, so let's demote it from dev_info()
to dev_dbg().

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/rtl8150.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -681,7 +681,7 @@ static void rtl8150_set_multicast(struct
 		   (netdev->flags & IFF_ALLMULTI)) {
 		rx_creg &= 0xfffe;
 		rx_creg |= 0x0002;
-		dev_info(&netdev->dev, "%s: allmulti set\n", netdev->name);
+		dev_dbg(&netdev->dev, "%s: allmulti set\n", netdev->name);
 	} else {
 		/* ~RX_MULTICAST, ~RX_PROMISCUOUS */
 		rx_creg &= 0x00fc;


