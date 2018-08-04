Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A3DC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 04:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95B9217B4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 04:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4cAde8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95B9217B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeHDGA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 02:00:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46622 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeHDGA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 02:00:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14-v6so3199887pgv.13;
        Fri, 03 Aug 2018 21:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=qO0CNVPhjMUfB7LImuFLHrl5c/y8i8ItKIwaOWn3jhs=;
        b=N4cAde8LnWGB2ZNR+yYtmfMAvgAxWkQn/N2DvgVnxbpT9PWk5n+jRGEp7eTlhjpUnh
         yJYTXeOLnFi38Bd6oxLnYbN+uOi5GU7nA2EzJuMVAqYfHIUgHvtfZ1nIL1QSVJZVeB1/
         KzZZYx83EHVHZA/8exCot/uchpuTQ7yLWcgmqlrsUUjl6yQcTZfHlUrrmaRdoXean/it
         YQhSdVh/3mClR+sHpM4QZTCwz0p6lSPG++9o+H9R9zqJGd0D4EfwwGQErrEOg3OXqU4w
         eSaAuhjw6Sl+wXfZdqaIwOZuWxKE74ZgYSe7R1wP6FtLe1/3uI+qzQLXD9t93THeNyCK
         f4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=qO0CNVPhjMUfB7LImuFLHrl5c/y8i8ItKIwaOWn3jhs=;
        b=hwKhm9OSUgvFKWxbgZzGgetbvVHnsfneJvzPuFW4PZBeX/6mxPzslbOKuU3j9jLwWq
         sG1C9ynJeUwrSbafhj7vAn6wiuJtbW4q4Ziknh5CyY9PdmAfB5kgQ5BOxaUzZYJYqIlw
         nnYEzWdsYveKCPxaDW2iYmH85mgbtNj3F39lNZLStJTzyfVXN4CK2kRCndbn6J1R6Pk6
         T/jnF24fulBcj5htm/4AunPHXfdufluRVhaTw0p8q+6Ip+O4BYxH/ZgLgm/BeBlVcmRT
         /qP8p6mo60XDRyujnfl/H4lLWMemL4lridlyh3O7VxGsd4PIdvwxubCJ3o9TwUzQeli/
         qklw==
X-Gm-Message-State: AOUpUlERMPvx/X6nV+baPUenm8kByMXI3J3a5scvoecoSmzujzoOddd8
        FlcPc0duZzO23GvEpSMdkS0=
X-Google-Smtp-Source: AAOMgpfSS4btyvxefDF6CbysJxJwwpbLHDa+v+mCAyHqp1Q9hPp8fV3bcdlYKnPD0SocB+xhe2aXaQ==
X-Received: by 2002:a63:7a43:: with SMTP id j3-v6mr6124658pgn.363.1533355281180;
        Fri, 03 Aug 2018 21:01:21 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h132-v6sm8865862pfc.100.2018.08.03.21.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 21:01:20 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] USB: OHCI: ohci-sm501: complete URBs in BH context
Date:   Fri,  3 Aug 2018 21:01:19 -0700
Message-Id: <1533355279-26725-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing an USB drive connected to ohci-sm501 results in a large number
of runtime warnings.

WARNING: CPU: 0 PID: 0 at ./include/linux/dma-mapping.h:541
hcd_buffer_free+0x148/0x178
Modules linked in:

CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-rc7-00014-g7ec386e4c991-dirty
PC is at hcd_buffer_free+0x148/0x178
PR is at hcd_buffer_free+0x66/0x178
PC  : 8c26cbb0 SP  : 8c481da8 SR  : 400080f1
TEA : c00c8fe0
R0  : 000000f0 R1  : 000000f0 R2  : 8f9bb890 R3  : 00000000
R4  : 8f9c8800 R5  : 00001004 R6  : b07c6000 R7  : 007c6000
R8  : 00001004 R9  : 8f9bb814 R10 : 8c388104 R11 : 007c6000
R12 : b07c6000 R13 : 8f875680 R14 : 00000000
MACH: 000002fe MACL: 0000017c GBR : 00000000 PR  : 8c26cace

Call trace:
 [<(ptrval)>] usb_hcd_unmap_urb_for_dma+0xf4/0x13c
 [<(ptrval)>] arch_local_save_flags+0x0/0x8
 [<(ptrval)>] __usb_hcd_giveback_urb+0x2e/0xdc
 [<(ptrval)>] arch_local_save_flags+0x0/0x8
 [<(ptrval)>] finish_urb+0x8a/0x164
 [<(ptrval)>] arch_local_save_flags+0x0/0x8
 [<(ptrval)>] printk+0x0/0x48
 [<(ptrval)>] ohci_work.part.11+0x150/0x41c
 [<(ptrval)>] td_done.isra.4+0x0/0x11c
 [<(ptrval)>] vprintk_default+0x14/0x20
 [<(ptrval)>] arch_local_save_flags+0x0/0x8
 [<(ptrval)>] ohci_irq+0x20c/0x314
 [<(ptrval)>] usb_hcd_irq+0x16/0x28

Code analysis shows that interrupts are indeed disabled in ohci_irq().
Handle the situation by setting the HCD_BH flag in the ohci-sm501 driver.
With this flag set, urbs are released in a tasklet and not by the
interrupt handler.

Fixes: f54aab6ebcecd ("usb: ohci-sm501 driver")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/host/ohci-sm501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-sm501.c b/drivers/usb/host/ohci-sm501.c
index c9233cddf9a2..eeb5b3137cf2 100644
--- a/drivers/usb/host/ohci-sm501.c
+++ b/drivers/usb/host/ohci-sm501.c
@@ -49,7 +49,7 @@ static const struct hc_driver ohci_sm501_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq =			ohci_irq,
-	.flags =		HCD_USB11 | HCD_MEMORY | HCD_LOCAL_MEM,
+	.flags =		HCD_USB11 | HCD_MEMORY | HCD_LOCAL_MEM | HCD_BH,
 
 	/*
 	 * basic lifecycle operations
-- 
2.7.4

