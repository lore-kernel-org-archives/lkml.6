Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909F4ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF73208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iuHkMrd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF73208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbeGPKio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:38:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39919 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbeGPKik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:38:40 -0400
Received: by mail-wm0-f68.google.com with SMTP id h20-v6so15135378wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bz7Z/Eu7qhcj5oPSVTX8Tce533DOkSc1ji6nSqBS1BA=;
        b=iuHkMrd2Wot5GEyI/WbzsEc25X4nyFyTubtfVWKXRbgkivOWa9d3bRZM2tTWQ+aq01
         kGMJWC9AWlTkVN55qupzQdyadogefQoSrriY6HjRy12QoQBEW+mj1mfOR5g7CODjMf6U
         tzMH1USjp6jldIE9/gAkHqsdCBdjnGjEEIqHdx06/FXNeZ/nZopfFyqbCyYnnwUtpfXl
         +lUCB850/+gB2iRvUaq53mgx3mFoSb97pSMTGqbJFL/iwqC+LLuU41QUfEgpDV20GPIQ
         8hdFcZhAwQJSmeCTo40qu11s3lfgEGkx2542f/F4dl/iUtXoPYolh8OZk1WirHyfvmBZ
         pzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bz7Z/Eu7qhcj5oPSVTX8Tce533DOkSc1ji6nSqBS1BA=;
        b=rxSi6njfjoq/NFQ2j6UDFhFl+pFIZZqyxdt9m1913sLNvlpmGGeip8mDYloieBqlhU
         /HJY9iEcuwHr47jHWVhStfjyO+xAHc4y51ERW6b1uR2RndKhT4kxlsNQDKjptocRGTr/
         G18OPJMU6rpd/nONNabmxGmeFZXELTxzQZug3KLNxn0VM6KMr4+8YEC9MStpcEA78bmg
         NXBWpxaVxNbpXUhTjQ4oikhCDUKJ2cn4bL3VntC9XyrQSVsbph5WQBijA1vAcfG5FZOU
         npc6XAfBpZALUE73kOAu/u2n0OyiVbUNDKtgLxohX3McyyU8NlFQSChOwTfXbnMulMJm
         JnHg==
X-Gm-Message-State: AOUpUlEqvqyxFsIBzdns8iDGEWzd9mc8OPx9DXZ6mk/prgWbBNGHU/Aj
        ts0kSoKxRvTT2VwLIOjfrZPGXg==
X-Google-Smtp-Source: AAOMgpeWHWX1UPWWX6RRrDnPIExK4z5Ij/jVPTo85qYotwgxzkhFl+8Mk6Rb5AmueCuLktqBZl54qA==
X-Received: by 2002:a1c:dac6:: with SMTP id r189-v6mr9443638wmg.150.1531735918387;
        Mon, 16 Jul 2018 03:11:58 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id h14-v6sm10219094wro.15.2018.07.16.03.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 03:11:57 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 3/6] ARM64: dts: meson-axg: remove spdif out from gpio a7
Date:   Mon, 16 Jul 2018 12:11:48 +0200
Message-Id: <20180716101151.31109-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180716101151.31109-1-jbrunet@baylibre.com>
References: <20180716101151.31109-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spdif out in not multiplexed on gpio A7 (spdif in is)
Remove this entry to fix the problem.

Fixes: 53c03b0aff36 ("ARM64: dts: meson-axg: add spdif output pins")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 08e5f431c025..cc908c9b5306 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -575,13 +575,6 @@
 					};
 				};
 
-				spdif_out_a7_pins: spdif_out_a7 {
-					mux {
-						groups = "spdif_out_a7";
-						function = "spdif_out";
-					};
-				};
-
 				spdif_out_a11_pins: spdif_out_a11 {
 					mux {
 						groups = "spdif_out_a11";
-- 
2.14.4

