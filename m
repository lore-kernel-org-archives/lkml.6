Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289FEECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DD12086D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pbMAVZBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5DD12086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbeGQQKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:10:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54698 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbeGQQKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:10:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so1970884wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9ALvnp5uq2xLjL8h9XoNNtkDEu/doiTiZp6Fj7u9vNo=;
        b=pbMAVZBT9/aEWBYTIJMttF8XDtjNc0VOUWAtwyo/FYEeHyUGLSQaiA/vFPuCvIUIds
         KdmqX5nmhfbGlXmDJUveTzehNqmPWhB/4U/p+eTxrQycZCvO9xlsv9obRoAin1UZW1IG
         SfTxJwx/eJ4YAhWp/13MHi7nT3bET7eHHWb9oImPbzRRn0z9Y4XH+jzlj7/MXvXm95UM
         FxZH/2eXKJBiFXKTPzR45yQFuccZqWNhuO3U97k/fhrIjyyVFmZN0b5lh4rkYoLYEE1y
         yXu8oOHGFnHw1DrFh1PzC61Mf64Os3ALj6uGurxtkF8qc4c6hHPnGbFOyVDUOr8eGEgE
         swTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9ALvnp5uq2xLjL8h9XoNNtkDEu/doiTiZp6Fj7u9vNo=;
        b=N52ldGPnWYN2mWxV4aDCquKeyTbhTWXfxxmqQ79uPvg4Qwou7vg7L8dshx1wbVH+hP
         B0p66PGojnO83N2EjWSVbC5pGVZP2Tq7E3QOB2w/iVhDhY7kn6DjGVafYgLruypkRdDD
         VDgujHGJazJZ4li4kxs3HNtgQZzRzyyKTObPv8zoCX7UVuRazV65LsARoMroM9ShQjd+
         FHh7l/pwtGolYHLhHs5cK1WYJMC4samoODP3Eyaeg42yspu33+aErWBKyxqrl44mYWNG
         Sy4KTuov21kkzm+CuIdzDbJz0jO7U8SRzGCUUGCGXZzsUb1PU+GYzQwmDDpnuaQ08Zmr
         OeRQ==
X-Gm-Message-State: AOUpUlHqrSKN3VKFVm/S7sJslpNf0TbUCpy/xmMj3WtKLcu6oDXKi9ik
        Mq2z3PwM/ILsze9ANuGy1USfVQ==
X-Google-Smtp-Source: AAOMgpfp2/cAYqQvL/RVZFWf79AvqY0RxDQQuMSUu9eie/5b6EReDvj+GSn4gEPATQNqsLUdFYbJog==
X-Received: by 2002:a1c:b915:: with SMTP id j21-v6mr1771836wmf.104.1531841815589;
        Tue, 17 Jul 2018 08:36:55 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h12-v6sm16971464wmb.3.2018.07.17.08.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:36:55 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 07/15] ASoC: meson: add axg tdm formatters DT binding documentation
Date:   Tue, 17 Jul 2018 17:36:32 +0200
Message-Id: <20180717153643.8806-9-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180717153643.8806-1-jbrunet@baylibre.com>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT binding documentation for axg's TDM formatters: TDMIN
and TDMOUT.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-tdm-formatters.txt  | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
new file mode 100644
index 000000000000..1c1b7490554e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
@@ -0,0 +1,28 @@
+* Amlogic Audio TDM formatters
+
+Required properties:
+- compatible: 'amlogic,axg-tdmin' or
+	      'amlogic,axg-tdmout'
+- reg: physical base address of the controller and length of memory
+       mapped region.
+- clocks: list of clock phandle, one for each entry clock-names.
+- clock-names: should contain the following:
+  * "pclk"     : peripheral clock.
+  * "sclk"     : bit clock.
+  * "sclk_sel" : bit clock input multiplexer.
+  * "lrclk"    : sample clock
+  * "lrclk_sel": sample clock input multiplexer
+
+Example of TDMOUT_A on the A113 SoC:
+
+tdmout_a: audio-controller@500 {
+	compatible = "amlogic,axg-tdmout";
+	reg = <0x0 0x500 0x0 0x40>;
+	clocks = <&clkc_audio AUD_CLKID_TDMOUT_A>,
+		 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK>,
+		 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK_SEL>,
+		 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>,
+		 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>;
+	clock-names = "pclk", "sclk", "sclk_sel",
+		      "lrclk", "lrclk_sel";
+};
-- 
2.14.4

