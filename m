Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3DEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1263120869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1263120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbeKLFsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49416 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729552AbeKLFsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:03 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsQ-0000l5-AD; Sun, 11 Nov 2018 19:58:34 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsN-0001Nn-Us; Sun, 11 Nov 2018 19:58:31 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>,
        "Hans Verkuil" <hansverk@cisco.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.951690394@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 022/366] media: cx231xx: Add support for AverMedia
 DVD EZMaker 7
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 29e61d6ef061b012d320327af7dbb3990e75be45 upstream.

User reports AverMedia DVD EZMaker 7 can be driven by VIDEO_GRABBER.
Add the device to the id_table to make it work.

BugLink: https://bugs.launchpad.net/bugs/1620762

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Hans Verkuil <hansverk@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/usb/cx231xx/cx231xx-cards.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/media/usb/cx231xx/cx231xx-cards.c
+++ b/drivers/media/usb/cx231xx/cx231xx-cards.c
@@ -727,6 +727,9 @@ struct usb_device_id cx231xx_id_table[]
 	 .driver_info = CX231XX_BOARD_CNXT_RDE_250},
 	{USB_DEVICE(0x0572, 0x58A0),
 	 .driver_info = CX231XX_BOARD_CNXT_RDU_250},
+	/* AverMedia DVD EZMaker 7 */
+	{USB_DEVICE(0x07ca, 0xc039),
+	 .driver_info = CX231XX_BOARD_CNXT_VIDEO_GRABBER},
 	{USB_DEVICE(0x2040, 0xb110),
 	 .driver_info = CX231XX_BOARD_HAUPPAUGE_USB2_FM_PAL},
 	{USB_DEVICE(0x2040, 0xb111),

