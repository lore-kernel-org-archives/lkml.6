Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6F4C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA342083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762651;
	bh=QdNbCh7dLPRGoEysbrinqDa8B6I0fzxMbs+Dv6On3KI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wpOgrZP+uPWizt7DQ7IckWCd37043NWXoVYqVZsnNwL2ZiJfduEXtqgkW+n75uyOp
	 11RIAwSweko9uS2VvdSbT+sKKzNxjnPiKWhAf5u4T7KUIPTdjZoMObYyKd1t+Jtxzm
	 dodN6yJ2dkaglXPG12vRPBMw4s5PVHhukOQ0K7kc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbfA2Lut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:50:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:42050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731423AbfA2Luj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:50:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E58120882;
        Tue, 29 Jan 2019 11:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762638;
        bh=QdNbCh7dLPRGoEysbrinqDa8B6I0fzxMbs+Dv6On3KI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uyzkg/wpDyGdM/ZlDfeJ+0v94BzI3SuLcYjstNJOIoSPLCSPH0HdSAV63QY2/Defe
         RRsPkI1jfyTdl7bJEdXM2hlcWuy7qRWU0MzFk1XK4BGV7O0TldHYo7/FrrQLMTkCTz
         BpD229xQJ0AGgZ7rREkFWbJnoJYMu2I649rg7T4k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Panfil <tom@steelseries.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 34/68] Input: xpad - add support for SteelSeries Stratus Duo
Date:   Tue, 29 Jan 2019 12:35:56 +0100
Message-Id: <20190129113134.408332979@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Panfil <tom@steelseries.com>

commit fe2bfd0d40c935763812973ce15f5764f1c12833 upstream.

Add support for the SteelSeries Stratus Duo, a wireless Xbox 360
controller. The Stratus Duo ships with a USB dongle to enable wireless
connectivity, but it can also function as a wired controller by connecting
it directly to a PC via USB, hence the need for two USD PIDs. 0x1430 is the
dongle, and 0x1431 is the controller.

Signed-off-by: Tom Panfil <tom@steelseries.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/joystick/xpad.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -255,6 +255,8 @@ static const struct xpad_device {
 	{ 0x0f30, 0x0202, "Joytech Advanced Controller", 0, XTYPE_XBOX },
 	{ 0x0f30, 0x8888, "BigBen XBMiniPad Controller", 0, XTYPE_XBOX },
 	{ 0x102c, 0xff0c, "Joytech Wireless Advanced Controller", 0, XTYPE_XBOX },
+	{ 0x1038, 0x1430, "SteelSeries Stratus Duo", 0, XTYPE_XBOX360 },
+	{ 0x1038, 0x1431, "SteelSeries Stratus Duo", 0, XTYPE_XBOX360 },
 	{ 0x11c9, 0x55f0, "Nacon GC-100XF", 0, XTYPE_XBOX360 },
 	{ 0x12ab, 0x0004, "Honey Bee Xbox360 dancepad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x12ab, 0x0301, "PDP AFTERGLOW AX.1", 0, XTYPE_XBOX360 },
@@ -431,6 +433,7 @@ static const struct usb_device_id xpad_t
 	XPAD_XBOXONE_VENDOR(0x0e6f),		/* 0x0e6f X-Box One controllers */
 	XPAD_XBOX360_VENDOR(0x0f0d),		/* Hori Controllers */
 	XPAD_XBOXONE_VENDOR(0x0f0d),		/* Hori Controllers */
+	XPAD_XBOX360_VENDOR(0x1038),		/* SteelSeries Controllers */
 	XPAD_XBOX360_VENDOR(0x11c9),		/* Nacon GC100XF */
 	XPAD_XBOX360_VENDOR(0x12ab),		/* X-Box 360 dance pads */
 	XPAD_XBOX360_VENDOR(0x1430),		/* RedOctane X-Box 360 controllers */


