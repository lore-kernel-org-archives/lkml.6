Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC17C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A4C206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPo8S3kW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A4C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeLDObv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:31:51 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39520 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbeLDObv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:31:51 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so8387781pld.6;
        Tue, 04 Dec 2018 06:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L3Q/mHBTAzWwFgQZvyB2IxLWVpAKO2ep8BOnL+Pye84=;
        b=FPo8S3kWaG5Zgy21CiYKvRJTVL1C4YJG1/N1NADWoXk3GoBKaqiLGCSTMeB68xVQVl
         Lb7OkM72iIjeUNwBszrZ0CaO0m17BsxfxNjjrJTdTCaneWE5nNyAtkwIraVP8jriEntI
         0zuYvxcty/WD6s0ADLMlYPppw8KAavyoyn1kP7SFuA8V1+2I8iWFIpuce2dpotl/vYjW
         PIQ8lBo1626fCLaz3ToZr+P2IIzuiNpoq5lCzY/ipdhChtAgyOVUZTPIygh51foBoLmZ
         UDfUb//tCZ5aZjjbOUE053Qy12qmo1HJ/HU/SV5IuhnfjnqMwJ/0kMldgFhlntKSRzKm
         aqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L3Q/mHBTAzWwFgQZvyB2IxLWVpAKO2ep8BOnL+Pye84=;
        b=GFcl2MadOMPXxHAdMQ1Dg3QY4vgfxv5IFZrSmK3qEmlrH7USa2j+6F1Qw+lQHP5hwo
         2G4ohyGwVIdlUg1m7yeBDPPxWdNqPlLAUqTIo37QGSJnYPB4t5LF8ebea/g5euS3fuqI
         xe7oaOZPi4zirEGXj3dNO5qMPngov2gquXi4t99t03yFFX1d+KcLkC7GKMmqaksZKv4o
         s6oih1r0kaZJHRcvI3jGKsMqH4gJP84EJtLEcnT99IZq3w2OU4ibeGbgGLGl9/HgJFzE
         hRNGPxdxCEDOVYhVAPKvqjPouTIQSdfftjwFkAuwFpSlWh9i8y1D1qoujDNdSJ45lxU5
         pM2Q==
X-Gm-Message-State: AA+aEWadoSRgga27E31jJdBb3ZqY+LIM4/+Z6ejpYcXL0B3b2e64aH7S
        UKXM4wNiobusIm7SuYBN9dx9Kr2n
X-Google-Smtp-Source: AFSGD/Xo0Mcts0W3WkCpz3vJgLMNeQLt3Jdwb9f8lBEDZnyK2hT0Rj3gWlfpFa8K9EwiL4kkEDi+Sg==
X-Received: by 2002:a17:902:b7c7:: with SMTP id v7mr20274693plz.75.1543933909862;
        Tue, 04 Dec 2018 06:31:49 -0800 (PST)
Received: from localhost.localdomain ([163.152.162.242])
        by smtp.gmail.com with ESMTPSA id t13sm21598363pgr.42.2018.12.04.06.31.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 06:31:49 -0800 (PST)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        mathias.nyman@linux.intel.com, heikki.krogerus@linux.intel.com,
        linux-kernel@vger.kernel.org, balbi@kernel.org
Subject: [PATCH] usb: core: Remove unnecessary memset()
Date:   Tue,  4 Dec 2018 23:31:43 +0900
Message-Id: <20181204143143.8407-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

register_root_hub() calls memset() setting usb_dev->bus->devmap.
devicemap to 0 during hcd probe function (usb_hcd_pci_probe). But
in previous function which is also the procedure of usb_hcd_pci_probe(),
usb_bus_init() already initialized bus->devmap calling memset().
Furthermore, register_root_hub() is called only once in kernel.
So, calling memset() which resets usb_bus->devmap.devicemap in
register_root_hub() is redundant.

Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/usb/core/hcd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 487025d31d44..015b126ce455 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1074,8 +1074,6 @@ static int register_root_hub(struct usb_hcd *hcd)
 
 	usb_dev->devnum = devnum;
 	usb_dev->bus->devnum_next = devnum + 1;
-	memset (&usb_dev->bus->devmap.devicemap, 0,
-			sizeof usb_dev->bus->devmap.devicemap);
 	set_bit (devnum, usb_dev->bus->devmap.devicemap);
 	usb_set_device_state(usb_dev, USB_STATE_ADDRESS);
 
-- 
2.19.2

