Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB25EC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713422145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPlE+BvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713422145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732621AbeK3B3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:29:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:56584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731418AbeK3B3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:29:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2655B205C9;
        Thu, 29 Nov 2018 14:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501460;
        bh=2rfLHewgu6THuiILGs68UjHLJccIuPXhfllpzM+1rGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MPlE+BvR1bGAdnXSheUZ3ZIE+Tvc2pI3TJlIVBK/mwemLNGyfkKQjeQ25yXrKQUG0
         NuETjRepzFihB9IkdUbZCNE5egpRjuujpozjG3KDSDzQp2ueoFB5FK/XLG2BpZgAau
         3T9mn1wuwp7zYCteiLtdW77e6XDx2GEkxtnYuFQg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ethan Lee <flibitijibibo@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 67/92] Input: xpad - add GPD Win 2 Controller USB IDs
Date:   Thu, 29 Nov 2018 15:12:36 +0100
Message-Id: <20181129140111.736144695@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
References: <20181129140106.520639693@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c1ba08390a8bb13c927e699330896adc15b78205 ]

GPD Win 2 Website: http://www.gpd.hk/gpdwin2.asp

Tested on a unit from the first production run sent to Indiegogo backers

Signed-off-by: Ethan Lee <flibitijibibo@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 5bf85c43e6d9..66cc37b41113 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -128,6 +128,7 @@ static const struct xpad_device {
 	u8 mapping;
 	u8 xtype;
 } xpad_device[] = {
+	{ 0x0079, 0x18d4, "GPD Win 2 Controller", 0, XTYPE_XBOX360 },
 	{ 0x044f, 0x0f00, "Thrustmaster Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f03, "Thrustmaster Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
@@ -414,6 +415,7 @@ static const signed short xpad_abs_triggers[] = {
 
 static const struct usb_device_id xpad_table[] = {
 	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* X-Box USB-IF not approved class */
+	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 Controller */
 	XPAD_XBOX360_VENDOR(0x044f),		/* Thrustmaster X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft X-Box 360 controllers */
 	XPAD_XBOXONE_VENDOR(0x045e),		/* Microsoft X-Box One controllers */
-- 
2.17.1



