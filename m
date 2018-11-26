Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A98EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DB820855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="LFsOkagU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DB820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeK0Dd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:33:29 -0500
Received: from plaes.org ([188.166.43.21]:50594 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbeK0Dd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:33:29 -0500
Received: from localhost (85.253.196.132.cable.starman.ee [85.253.196.132])
        by plaes.org (Postfix) with ESMTPSA id 7361240217;
        Mon, 26 Nov 2018 16:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1543250330; bh=PT+Hted/gaingRvzrdZy984e1XwzSefxE5UPqk+oZzE=;
        h=From:To:Cc:Subject:Date:From;
        b=LFsOkagUUgtKcqopFkDgX2o2lQtLFQ8sb/Qs0N3H7KG3krI3EeRBiG3As+vgpoUAR
         uId+HKkFg5FuNk0d6lI0ZJxcqO64oijMlO0pXQAwcw77Wtg4JlokC3m3E5troWcRB+
         k/9pOo3cys4+UJBABleoCwwD4jfyQOWCxLdf0i+X54/vmboNa1Bhe+Zceuq281nhyO
         EoSVtE5Jlol5qx8dsQVAgMIJ5M2akr9Y6nnrn7KMXv8RLzrBse9pH8KZ0YoC4MLhrD
         jSu9HO/3rFcfUocl5SAdEN4oVFb7cgghk8t+3y6N1szQ/48UoxnKsvYgOgEZT60QtY
         ftmgOHahTAJnw==
From:   Priit Laes <plaes@plaes.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Priit Laes <plaes@plaes.org>
Subject: [PATCH] media: Kconfig: Add configuration entry for MEDIA_MEM2MEM_SUPPORT
Date:   Mon, 26 Nov 2018 18:38:44 +0200
Message-Id: <20181126163844.18729-1-plaes@plaes.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is no easy way to enable mem2mem based video
processor drivers (cedrus for example). Simplify this by adding
separate category to media support.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/media/Kconfig | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index 8add62a18293..f2a773896dcf 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -56,6 +56,14 @@ config MEDIA_DIGITAL_TV_SUPPORT
 	  Say Y when you have a board with digital support or a board with
 	  hybrid digital TV and analog TV.
 
+config MEDIA_MEM2MEM_SUPPORT
+    bool "Mem2mem devices (stateless media decoders/encoders support)"
+    ---help---
+	  Enable support for mem2mem / stateless media decoders/encoders.
+
+	  Say Y when you have a system with stateless media encoder/decoder
+	  support.
+
 config MEDIA_RADIO_SUPPORT
 	bool "AM/FM radio receivers/transmitters support"
 	---help---
@@ -95,7 +103,7 @@ source "drivers/media/cec/Kconfig"
 
 config MEDIA_CONTROLLER
 	bool "Media Controller API"
-	depends on MEDIA_CAMERA_SUPPORT || MEDIA_ANALOG_TV_SUPPORT || MEDIA_DIGITAL_TV_SUPPORT
+	depends on MEDIA_CAMERA_SUPPORT || MEDIA_ANALOG_TV_SUPPORT || MEDIA_DIGITAL_TV_SUPPORT || MEDIA_MEM2MEM_SUPPORT
 	---help---
 	  Enable the media controller API used to query media devices internal
 	  topology and configure it dynamically.
@@ -118,7 +126,7 @@ config MEDIA_CONTROLLER_DVB
 config VIDEO_DEV
 	tristate
 	depends on MEDIA_SUPPORT
-	depends on MEDIA_CAMERA_SUPPORT || MEDIA_ANALOG_TV_SUPPORT || MEDIA_RADIO_SUPPORT || MEDIA_SDR_SUPPORT
+	depends on MEDIA_CAMERA_SUPPORT || MEDIA_ANALOG_TV_SUPPORT || MEDIA_RADIO_SUPPORT || MEDIA_SDR_SUPPORT || MEDIA_MEM2MEM_SUPPORT
 	default y
 
 config VIDEO_V4L2_SUBDEV_API
-- 
2.19.1

