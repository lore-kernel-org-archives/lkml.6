Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF25ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0566A2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tjader-com-br.20150623.gappssmtp.com header.i=@tjader-com-br.20150623.gappssmtp.com header.b="1j6bfhX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0566A2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tjader.xyz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbeIST5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:57:55 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43519 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732109AbeIST5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:57:55 -0400
Received: by mail-qt0-f194.google.com with SMTP id g53-v6so5196892qtg.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 07:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tjader-com-br.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qi2pCPuTInTVjK6krdf0OFHYlKVGmkEqe1iG8TFiInU=;
        b=1j6bfhX1wGGb3jx98TEPyK1B/56J60VsRv8QHfprJh9cduymte3iwQYBtOBN1gcjKR
         jMAq1WtjwtXIOtkf//+SKxnujiWI20EUND9G+swVY9OysEi/DOfCY8ZTM1VNGDO8ZIt/
         in6miozMqqcr0gL5btrJbnAp0Xt9uu/36WrIOseLLSiajRuz1uZhY+m/e1aVkn8Fig5x
         OiaFwsy1hIOKQtnoIkO01zJp2OIwXKdki9p6b3cqoH2V0gxi1A+aCKS1idMNyLsx9nB/
         zaSPNBVNUqq1q3CTgM62rTPE8P4uo5c5M6IG5Fk0iHknxSgjbczjsKbtz0T1v5s7GRAa
         hmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=qi2pCPuTInTVjK6krdf0OFHYlKVGmkEqe1iG8TFiInU=;
        b=fWG9PDg1iTQ3erg1hWHhVzw7RzHmAIjweFmLchAc49H8vdS727F27jKNqRIbEihj8G
         VzspEbga4KE7tTCNl0PznsGwnwkvhKa3Ldh5kQFGmRlIMYqUsQmBIsC5GMNRthcBmezo
         LRrSpojkqqpVKoDNMJiMLnRsRVKaaXkjOonoO0Y3nDcn9ml4Cb/6ErLNEO0zHUxtZ2su
         b+D8UmcSLuXD1f5d7W4+WLJnLKuxFQp1NQ2KXZGvzxSQ0FvLgpo1QGPWo4HdFUy7Qr79
         69HXn3ace5ZH0Cfrbzv2X9RvoPF/CCzUN2a660rZ451uyy7Sl/kP7JRU1G8B5R9bCjEf
         pGxw==
X-Gm-Message-State: APzg51AtGQp2tAluB3YITQekP0kzOaRvr+u2rFCzJx9p58ZJyoS/Dd4A
        ZdbQ/ppxO/fKdl32GXdrvAVrwQ==
X-Google-Smtp-Source: ANB0VdaGfhvfh7R7015QLNrRrAsnmim1+xQ10oLVME7FmRIo8ao5Gi0OVV/23wKlqF/GQ33PUKUTGQ==
X-Received: by 2002:aed:3c55:: with SMTP id u21-v6mr24499915qte.198.1537366786667;
        Wed, 19 Sep 2018 07:19:46 -0700 (PDT)
Received: from smellerbee.basingse.tjader.xyz ([2804:14d:5cd4:84dd:8fb:bdff:fe0b:4c1d])
        by smtp.gmail.com with ESMTPSA id p22-v6sm6483599qtk.29.2018.09.19.07.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 07:19:46 -0700 (PDT)
From:   =?UTF-8?q?Rodrigo=20Exterck=C3=B6tter=20Tj=C3=A4der?= 
        <rodrigo@tjader.xyz>
Cc:     =?UTF-8?q?Rodrigo=20Exterck=C3=B6tter=20Tj=C3=A4der?= 
        <rodrigo@tjader.xyz>, Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: allwinner: Olimex A64-OLinuXino: fix ethernet
Date:   Wed, 19 Sep 2018 11:19:36 -0300
Message-Id: <20180919141938.18791-1-rodrigo@tjader.xyz>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without "allwinner,tx-delay-ps = <600>;" on the DTP it can receive packets
but not send.

Signed-off-by: Rodrigo Exterckötter Tjäder <rodrigo@tjader.xyz>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index 5245de3a1f35..75a435b9509b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -90,6 +90,7 @@
 	phy-mode = "rgmii";
 	phy-handle = <&ext_rgmii_phy>;
 	phy-supply = <&reg_dcdc1>;
+	allwinner,tx-delay-ps = <600>;
 	status = "okay";
 };
 
-- 
2.18.0

