Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B9AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E5D205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdQbYAd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E5D205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbeK3BYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:24:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:48002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729808AbeK3BYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:24:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F17E205C9;
        Thu, 29 Nov 2018 14:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501162;
        bh=aAFCEwZBZ4HzIX26eg5dW3CSARU/eNkH4/srGc/vgd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CdQbYAd2vN9WuwCPHauI5UvQo80Fel65AHcVB1q67gXM6HgJaMRGF5INDXnoEa4Gt
         rh5SYWTjdj9LJ/M+ZAN9nu2WGXH9cyrNh4AMnlDvYQJfX7u70CGN30f74X3QrYrSLj
         wuJBQlL6f9s5p5UlXIxecwpKrLESlPZv5G0P0LkE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Enno Boland <gottox@voidlinux.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 67/86] Input: xpad - fix GPD Win 2 controller name
Date:   Thu, 29 Nov 2018 15:12:32 +0100
Message-Id: <20181129140115.532600299@linuxfoundation.org>
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

[ Upstream commit dd6bee81c942c0ea01030da9356026afb88f9d18 ]

This fixes using the controller with SDL2.

SDL2 has a naive algorithm to apply the correct settings to a controller.
For X-Box compatible controllers it expects that the controller name
contains a variation of a 'XBOX'-string.

This patch changes the identifier to contain "X-Box" as substring.  Tested
with Steam and C-Dogs-SDL which both detect the controller properly after
adding this patch.

Fixes: c1ba08390a8b ("Input: xpad - add GPD Win 2 Controller USB IDs")
Cc: stable@vger.kernel.org
Signed-off-by: Enno Boland <gottox@voidlinux.eu>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 66cc37b41113..69b44aebaf01 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -128,7 +128,7 @@ static const struct xpad_device {
 	u8 mapping;
 	u8 xtype;
 } xpad_device[] = {
-	{ 0x0079, 0x18d4, "GPD Win 2 Controller", 0, XTYPE_XBOX360 },
+	{ 0x0079, 0x18d4, "GPD Win 2 X-Box Controller", 0, XTYPE_XBOX360 },
 	{ 0x044f, 0x0f00, "Thrustmaster Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f03, "Thrustmaster Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
-- 
2.17.1



