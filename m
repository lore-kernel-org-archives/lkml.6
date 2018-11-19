Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E99C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3C9214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cv1ZCNJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3C9214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406711AbeKTD3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:29:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405697AbeKTD3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:29:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFDD42148E;
        Mon, 19 Nov 2018 17:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647100;
        bh=D4Q7lUKRIaB3gm7l76vFCcBCP43h3MWlLOT41zQAgrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cv1ZCNJl9qMMOE0EP9FxavhYQZ3M0pGJjRDZ2ih5QKqoGe91UnI95PPqi9vA+hiHQ
         KZiJfsPojFtczD4u2XZ6bnTA+g8INZ+XTY3MC84DUYUvWdzPRG74kzuPvGL+kudzte
         7vZT7fU6lIvN7Soi8fQMx8swetO13jEK/s0pGodQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 3.18 50/90] media: em28xx: fix input name for Terratec AV 350
Date:   Mon, 19 Nov 2018 17:29:32 +0100
Message-Id: <20181119162628.905420843@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

commit 15644bfa195bd166d0a5ed76ae2d587f719c3dac upstream.

Instead of using a register value, use an AMUX name, as otherwise
VIDIOC_G_AUDIO would fail.

Cc: stable@vger.kernel.org
Fixes: 766ed64de554 ("V4L/DVB (11827): Add support for Terratec Grabster AV350")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/em28xx/em28xx-cards.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -2001,13 +2001,13 @@ struct em28xx_board em28xx_boards[] = {
 		.input           = { {
 			.type     = EM28XX_VMUX_COMPOSITE1,
 			.vmux     = TVP5150_COMPOSITE1,
-			.amux     = EM28XX_AUDIO_SRC_LINE,
+			.amux     = EM28XX_AMUX_LINE_IN,
 			.gpio     = terratec_av350_unmute_gpio,
 
 		}, {
 			.type     = EM28XX_VMUX_SVIDEO,
 			.vmux     = TVP5150_SVIDEO,
-			.amux     = EM28XX_AUDIO_SRC_LINE,
+			.amux     = EM28XX_AMUX_LINE_IN,
 			.gpio     = terratec_av350_unmute_gpio,
 		} },
 	},


