Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FE1C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3996621479
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxlZOsNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3996621479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbeJQBIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbeJQBIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:08:16 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 010E72089E;
        Tue, 16 Oct 2018 17:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710212;
        bh=AtX+iCI/O4X5Z58Ge0TksV3JAKi99Kx9AErOioFZ/lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IxlZOsNNH3m0EiIqOhM+5XJRDA0QOjcbjE8cKggMkXVJ2bw0D/9RHGAt1Sj5BI2Gz
         uUgyqJf2jUupgYypDe1HmdnoI6UW3mYtkNrO7MygOpFXCC9FCorf6dYHBImUSaBu8q
         4HWeXh6mln+Y4QpGLcVldT2896d7/uhsjxVXtrMI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ramses=20Ram=C3=ADrez?= <ramzeto@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.18 126/135] Input: xpad - add support for Xbox1 PDP Camo series gamepad
Date:   Tue, 16 Oct 2018 19:05:56 +0200
Message-Id: <20181016170523.950110200@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ramses Ramírez <ramzeto@gmail.com>

commit 9735082a7cbae572c2eabdc45acecc8c9fa0759b upstream.

The "Xbox One PDP Wired Controller - Camo series" has a different
product-id than the regular PDP controller and the PDP stealth series,
but it uses the same initialization sequence. This patch adds the
product-id of the camo series to the structures that handle the other
PDP Xbox One controllers.

Signed-off-by: Ramses Ramírez <ramzeto@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/joystick/xpad.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -231,6 +231,7 @@ static const struct xpad_device {
 	{ 0x0e6f, 0x0246, "Rock Candy Gamepad for Xbox One 2015", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x02ab, "PDP Controller for Xbox One", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x02a4, "PDP Wired Controller for Xbox One - Stealth Series", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x02a6, "PDP Wired Controller for Xbox One - Camo Series", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0301, "Logic3 Controller", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x0346, "Rock Candy Gamepad for Xbox One 2016", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0401, "Logic3 Controller", 0, XTYPE_XBOX360 },
@@ -530,6 +531,8 @@ static const struct xboxone_init_packet
 	XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_pdp_init2),
 	XBOXONE_INIT_PKT(0x0e6f, 0x02a4, xboxone_pdp_init1),
 	XBOXONE_INIT_PKT(0x0e6f, 0x02a4, xboxone_pdp_init2),
+	XBOXONE_INIT_PKT(0x0e6f, 0x02a6, xboxone_pdp_init1),
+	XBOXONE_INIT_PKT(0x0e6f, 0x02a6, xboxone_pdp_init2),
 	XBOXONE_INIT_PKT(0x24c6, 0x541a, xboxone_rumblebegin_init),
 	XBOXONE_INIT_PKT(0x24c6, 0x542a, xboxone_rumblebegin_init),
 	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_rumblebegin_init),


