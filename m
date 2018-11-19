Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668F0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA582151B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbXAMSVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA582151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405061AbeKTDX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:23:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:35506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403980AbeKTDX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:23:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2424214E0;
        Mon, 19 Nov 2018 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646753;
        bh=5Ey/zO5+es0ot1ptFqlEOwZSRZhRUn7c49uDpBkpHHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XbXAMSVfA9P7yPLbX3aLEUbOQZuQmG04hKOWrvrAIUi2CcMcIKVA8sOSojWUc0gKX
         uT2qCqcu41baFeLH0rwCBrmYq7Db1rslmnX1Q7ijjznocJ0hcYVsKuYpsl6YsL9nYJ
         /ZhfjrJW62OUgemVB/SgbihTETW1cMGV4oPRCg94=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.4 078/160] media: em28xx: fix input name for Terratec AV 350
Date:   Mon, 19 Nov 2018 17:28:37 +0100
Message-Id: <20181119162638.781033654@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
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
@@ -2021,13 +2021,13 @@ struct em28xx_board em28xx_boards[] = {
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


