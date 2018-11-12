Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59E2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B00E21582
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=birdec.tech header.i=@birdec.tech header.b="R6z0QuqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B00E21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birdec.tech
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbeKLQ7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 11:59:03 -0500
Received: from host.euro-space.net ([87.117.239.2]:48675 "EHLO
        host.euro-space.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbeKLQ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 11:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=birdec.tech
        ; s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KajoBBNZ7pUWOgk7j0GbDhQ7N3Nxsut1xojxqObaNtg=; b=R6z0QuqRvs8ELqTjDpakrl9YuE
        WxQPB4SW/F4TmYyuhaFqe/oXCDuaQbg2nkcrIdSQVSaTk1M2BR+L4vO+Ovt2e339t9LipRTK4m+ZP
        1yXyxmSJL6DbVK52Z2rsH7uekRLtz7mOfpgekaSXoM+ZU7nuIE4fykZaLwDcpLO2Q00QbrtotR7dC
        HQVMZF1TpBDsI8ilkr5hRLsxonWTtpwQCTgIK1AmvVsnKw9U68Sj5nVlcTHocJIHbN74EMgNJpBud
        5BC58PC+IXfxReodSC9uziFM8OBLEi+wosdF+bLfAfAeZy8MWe+6pgRSud6TWuEU+ZBdcVD7qd+gN
        X6H5j5lw==;
Received: from x4e33ae63.dyn.telefonica.de ([78.51.174.99]:51016 helo=gentoo0.localdomain)
        by host.euro-space.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <kmarinushkin@birdec.tech>)
        id 1gM6JN-0002vg-Tb; Mon, 12 Nov 2018 07:07:05 +0000
From:   Kirill Marinushkin <kmarinushkin@birdec.tech>
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: sound: Add documentation for pcm3060 property out-single-ended
Date:   Mon, 12 Nov 2018 08:08:32 +0100
Message-Id: <20181112070834.16979-1-kmarinushkin@birdec.tech>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181105112036.GC5365@sirena.org.uk>
References: <20181105112036.GC5365@sirena.org.uk>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.euro-space.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - birdec.tech
X-Get-Message-Sender-Via: host.euro-space.net: authenticated_id: kmarinushkin@birdec.tech
X-Authenticated-Sender: host.euro-space.net: kmarinushkin@birdec.tech
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Output of pcm3060 codec may be configured as single-ended or differential

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/sound/pcm3060.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/pcm3060.txt b/Documentation/devicetree/bindings/sound/pcm3060.txt
index 90fcb8523099..97de66932d44 100644
--- a/Documentation/devicetree/bindings/sound/pcm3060.txt
+++ b/Documentation/devicetree/bindings/sound/pcm3060.txt
@@ -9,9 +9,15 @@ Required properties:
 - reg : the I2C address of the device for I2C, the chip select
         number for SPI.
 
+Optional properties:
+
+- ti,out-single-ended: "true" if output is single-ended;
+                       "false" or not specified if output is differential.
+
 Examples:
 
 	pcm3060: pcm3060@46 {
 		 compatible = "ti,pcm3060";
 		 reg = <0x46>;
+		 ti,out-single-ended = "true";
 	};
-- 
2.13.6

