Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378F1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D96205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOfq9gNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D96205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbeK3BZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:25:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:48388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731125AbeK3BZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:25:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C98D205C9;
        Thu, 29 Nov 2018 14:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501176;
        bh=2xhxOuqljGZhGbfB62xVA1yWEw/ufRkYiNz1XjsSoXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kOfq9gNOVYgU3W51rDyfMUV+t1QYYpXbEWy0A0a82i+q80Jtt8RpCVo1v7I9ZGVO1
         VPQC31JM+Iqq++Z4mjKzm93LFMtju01pOKYVTBRVKaNH7hBWMIxjgOsbMI4EBkhvvS
         3MY2obUn6TAkxv+Mzkh5bzXX1FyDp5dGZoaFkzWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 38/86] Input: xpad - remove unused function
Date:   Thu, 29 Nov 2018 15:12:03 +0100
Message-Id: <20181129140113.311747833@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a6ed4a18ba6a6f5a01e024b9d221d6439bf6ca4c ]

There are two definitions of xpad_identify_controller(), one is used
when CONFIG_JOYSTICK_XPAD_LEDS is set, but the other one is empty
and never used, and we get a gcc warning about it:

drivers/input/joystick/xpad.c:1210:13: warning: 'xpad_identify_controller' defined but not used [-Wunused-function]

This removes the second definition.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: cae705baa40b ("Input: xpad - re-send LED command on present event")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 2f481ce2c8b0..cd1de2851f1d 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1209,7 +1209,6 @@ static void xpad_led_disconnect(struct usb_xpad *xpad)
 #else
 static int xpad_led_probe(struct usb_xpad *xpad) { return 0; }
 static void xpad_led_disconnect(struct usb_xpad *xpad) { }
-static void xpad_identify_controller(struct usb_xpad *xpad) { }
 #endif
 
 static int xpad_start_input(struct usb_xpad *xpad)
-- 
2.17.1



