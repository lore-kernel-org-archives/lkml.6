Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9E9C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 05:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6329A213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 05:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBtN7QFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6329A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeJDMsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 08:48:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54409 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbeJDMsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 08:48:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so7750659wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 22:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Iq6jh2pTCrOmtOqanK1ksrTWknGicMF7CURy3y1Jj4=;
        b=dBtN7QFvAZ/dULL46bz4hGfPbMxaYYW0EMKNRt5dnqx7a7BpVA7SKPxj9GLwLrrzRb
         RdgroMPJzWgEvFzvW/4v9amurx6Rf30z6GDiVCCxd5rZDi9XWP/QeWE5Mw1ooIc8wb3U
         AisLwlrUFBRtidg/Rlb+/V8dG2xPg7emtctCAm800dDCYvkUY8RZD2HyldeDfHHTiB+L
         WYU232t3qp08h5ajz2bvsK3i1a0uVUHcCYr90qJc8qTNEo5gMDfqnV9eXH1NRV3NnQbS
         d7mmkP9SGhnyQWoAVCStS6U0zC51UbzW0L0bZD8YnNTqGpVrAd9qL1Cl0eTW+iPJw5sg
         fbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Iq6jh2pTCrOmtOqanK1ksrTWknGicMF7CURy3y1Jj4=;
        b=c88RRNe9mGQ30ez9ahfS3RX1axNaCq+kPagliRRX4n+9Llw79JPnkAdG0n43/SBpgl
         OZ+qQeFTfvRvfnElISPu1VX968iZQGgxwD8ZLyMDNUwbrGj/itvIRys9Q9U2xcVvqRfQ
         Tf9xyo7NRksdzWWlU3X+Ze1hVEd2/yhO3WwnPmk75aZhaBbccum3BspT+U6iUuxjEDUO
         MmONRks517IvGbUnMrAoY8Juu4Q/RvqNQDghdoRKBunFzKI0Zne1C8sSRtTUjMZ5/Ql3
         nqQ4Kd7jvY/SkYkjUgMAyBko5B8L2Sl3WINgrqyc1HFMKD0NzjcRz+CnQynxdQj8WMw6
         RHSQ==
X-Gm-Message-State: ABuFfoi7zV9a62sDsk10IwbCA+k2Mcuc8O4uJzhadifQeAE0i7huv2W1
        z2ZoJ7gIgoaNe8bxPWzHEno=
X-Google-Smtp-Source: ACcGV629kVjOn0EaR0Be7iaZ8WB1ho0VC0QrCU5k1SMYpud3g6rk0G6SkRKYphe/2c4zpU48HhzWFQ==
X-Received: by 2002:a1c:7816:: with SMTP id t22-v6mr3601030wmc.46.1538632598118;
        Wed, 03 Oct 2018 22:56:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id l11-v6sm1892930wrn.61.2018.10.03.22.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 22:56:37 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] staging: emxx_udc: Remove unused device_desc declaration
Date:   Wed,  3 Oct 2018 22:56:00 -0700
Message-Id: <20181004055559.3197-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/staging/emxx_udc/emxx_udc.c:1373:37: warning: variable
'device_desc' is not needed and will not be emitted
[-Wunneeded-internal-declaration]
static struct usb_device_descriptor device_desc = {
                                    ^
1 warning generated.

This definition hasn't been attached to anything since the driver was
introduced in commit 33aa8d45a4fe ("staging: emxx_udc: Add Emma Mobile
USB Gadget driver") and neither GCC nor Clang emit any reference to the
variable in the final assembly. The only reason GCC doesn't warn about
this variable being unused is the sizeof function.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

This seems kind of wrong given this is a USB driver but there isn't an
instance of a platform_driver in the kernel tree having a usb device
descriptor declaration so I'm unsure of how to handle this warning aside
from just removing the definition but I'm certainly open to suggestions.

 drivers/staging/emxx_udc/emxx_udc.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 0e8d3f232fe9..65cc3d9af972 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -1368,25 +1368,6 @@ static void _nbu2ss_set_endpoint_stall(
 	}
 }
 
-/*-------------------------------------------------------------------------*/
-/* Device Descriptor */
-static struct usb_device_descriptor device_desc = {
-	.bLength              = sizeof(device_desc),
-	.bDescriptorType      = USB_DT_DEVICE,
-	.bcdUSB               = cpu_to_le16(0x0200),
-	.bDeviceClass         = USB_CLASS_VENDOR_SPEC,
-	.bDeviceSubClass      = 0x00,
-	.bDeviceProtocol      = 0x00,
-	.bMaxPacketSize0      = 64,
-	.idVendor             = cpu_to_le16(0x0409),
-	.idProduct            = cpu_to_le16(0xfff0),
-	.bcdDevice            = 0xffff,
-	.iManufacturer        = 0x00,
-	.iProduct             = 0x00,
-	.iSerialNumber        = 0x00,
-	.bNumConfigurations   = 0x01,
-};
-
 /*-------------------------------------------------------------------------*/
 static void _nbu2ss_set_test_mode(struct nbu2ss_udc *udc, u32 mode)
 {
-- 
2.19.0

