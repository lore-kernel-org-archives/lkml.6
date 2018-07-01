Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A72C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13535252CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13535252CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031045AbeGAQfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:35:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35712 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753627AbeGAQe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:34:59 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4D7E592B;
        Sun,  1 Jul 2018 16:34:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans Verkuil <hansverk@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.14 128/157] media: cx231xx: Add support for AverMedia DVD EZMaker 7
Date:   Sun,  1 Jul 2018 18:23:20 +0200
Message-Id: <20180701160859.318053841@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 29e61d6ef061b012d320327af7dbb3990e75be45 upstream.

User reports AverMedia DVD EZMaker 7 can be driven by VIDEO_GRABBER.
Add the device to the id_table to make it work.

BugLink: https://bugs.launchpad.net/bugs/1620762

Cc: stable@vger.kernel.org
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Hans Verkuil <hansverk@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/cx231xx/cx231xx-cards.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/media/usb/cx231xx/cx231xx-cards.c
+++ b/drivers/media/usb/cx231xx/cx231xx-cards.c
@@ -918,6 +918,9 @@ struct usb_device_id cx231xx_id_table[]
 	 .driver_info = CX231XX_BOARD_CNXT_RDE_250},
 	{USB_DEVICE(0x0572, 0x58A0),
 	 .driver_info = CX231XX_BOARD_CNXT_RDU_250},
+	/* AverMedia DVD EZMaker 7 */
+	{USB_DEVICE(0x07ca, 0xc039),
+	 .driver_info = CX231XX_BOARD_CNXT_VIDEO_GRABBER},
 	{USB_DEVICE(0x2040, 0xb110),
 	 .driver_info = CX231XX_BOARD_HAUPPAUGE_USB2_FM_PAL},
 	{USB_DEVICE(0x2040, 0xb111),


