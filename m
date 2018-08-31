Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A921C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8FD2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JjdW3rSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8FD2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbeHaTKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:10:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39963 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbeHaTKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:10:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id n2-v6so11515998wrw.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+SFT4n9BbB1i3eN7ZRd6EdLeaO+8O6eU3L/eMnxt3mI=;
        b=JjdW3rSbxgDn7Gy7InxPXoSymmJpBU7YOVkerK/HEYMHuo51jP/89nJ0LSQWlBSmIJ
         ZN9dAU5UX55o1kXdGtHy8rwQVoJnebwhB1Ek0NXVoSHkkz1GKqts0Ovo6Tgkg+N6jU5L
         hSxH1px9AwIGw5WdwMtYPK9Mw30XVMbw5fwW/xy1pPav1g71MM9bOg/uv31F1cQjh5rM
         v32l/FmlWfGAMlkyIccqNu6lM6zqcBcgTpiFE7+rrtwMfhJRVTvU/Gufi+JHXHwqhu/X
         1QCZNWNUoTABiJUzhzsXgQFHOb8AKt5abgxqF0jI/fxgCA3Vjx8o2nFuF1MafvuQ0gdw
         RPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+SFT4n9BbB1i3eN7ZRd6EdLeaO+8O6eU3L/eMnxt3mI=;
        b=CBdTInOYRdRAGkVe/7PTBzlUcaRyw6L4xJ1wIgawCagHmICJPBFqiuJnWCSIUKvlwb
         nlUj+vPcRqbseFFt+gI3pZ0Vqgl+jS2nHKFMdVJQPtyIXoms+VW7xSkc/RXfOCwC2iMC
         oonS1fn4dsplA2XHpPBjAed9KPsEovG7hPWSistUbpMe59W1nXz8E/zLY9Z/0xfUjGK/
         k/L9xN6f0osBctWjHkT9zwCtsZXrCMyfvejI+FcrMKcbJZ/sOwS/+xZHu6LIGd4dabLJ
         wEVBQwtqvdDx+SpULX1A7QLxpsbH/RmRf1w4fA/dYUC7hg2HEEQO5rRpL3kbD3Pi8A0G
         kNCw==
X-Gm-Message-State: APzg51C5zH6qg+mmgL/95klad9n+gWr+1Lvf2oEZE/cpP+AQ7gnA7OPJ
        d6vVAWCL2QRds+u0VhufKzHbJw==
X-Google-Smtp-Source: ANB0VdZFBxT1SImXBvvQfkaov8xjjztCZGoTj7mmii7CG8pWRLOc/J7cXIZs5Xhe3aXzMguavMmYrg==
X-Received: by 2002:a5d:4d82:: with SMTP id b2-v6mr10784722wru.80.1535727746061;
        Fri, 31 Aug 2018 08:02:26 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 184-v6sm8759797wmv.6.2018.08.31.08.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 08:02:25 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] arm64: dts: meson-axg: s400: add dmic codec
Date:   Fri, 31 Aug 2018 17:02:17 +0200
Message-Id: <20180831150218.8307-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831150218.8307-1-jbrunet@baylibre.com>
References: <20180831150218.8307-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 7 digital mics on the MIC daughter board attached
to the s400 board, so add the digital microphone codec to
its DTS

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index ff64c429d432..f3e16cbbc61e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -86,6 +86,15 @@
 		sound-name-prefix = "DIT";
 	};
 
+	dmics: audio-codec@3 {
+		#sound-dai-cells = <0>;
+		compatible = "dmic-codec";
+		num-channels = <7>;
+		wakeup-delay-ms = <50>;
+		status = "okay";
+		sound-name-prefix = "MIC";
+	};
+
 	emmc_pwrseq: emmc-pwrseq {
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
-- 
2.17.1

