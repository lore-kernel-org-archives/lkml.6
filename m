Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71317C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4832A2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfANUQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:16:18 -0500
Received: from shell.v3.sk ([90.176.6.54]:48919 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfANUQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:16:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D8B734A3E4;
        Mon, 14 Jan 2019 21:16:14 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id shm6RMeZyfwZ; Mon, 14 Jan 2019 21:16:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9C7CE4A3EF;
        Mon, 14 Jan 2019 21:16:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Z6Ur-5TjVq4q; Mon, 14 Jan 2019 21:16:11 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id BE2804A3E4;
        Mon, 14 Jan 2019 21:16:10 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>, stable@vger.kernel.org
Subject: [PATCH] USB: EHCI: ehci-mv: add MODULE_DEVICE_TABLE
Date:   Mon, 14 Jan 2019 21:16:08 +0100
Message-Id: <20190114201608.17514-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes autoloading the module by the OF compatible string.

Fixes: 813e18b18a87f31c5b216ea7546127deac3ae1ae
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/usb/host/ehci-mv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index f26109eafdbf..66ec1fdf9fe7 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -302,3 +302,4 @@ MODULE_AUTHOR("Chao Xie <chao.xie@marvell.com>");
 MODULE_AUTHOR("Neil Zhang <zhangwm@marvell.com>");
 MODULE_ALIAS("mv-ehci");
 MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, ehci_mv_dt_ids);
--=20
2.19.2

