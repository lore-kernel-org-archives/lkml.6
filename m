Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B715CC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5FC2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/KCqhGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5FC2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbeLBVXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:23:53 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40874 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeLBVXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:23:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id q26so3723746wmf.5;
        Sun, 02 Dec 2018 13:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=321l4njH4VKx1kXcZRO12v94G6OHeKZhCHKTSWfxtGw=;
        b=c/KCqhGMlJRWoAy0adHmP/uhcwsLnoDcS82IjHwJKQoG/kYnmPB+Y1utTr6x5pAyov
         f+RUXTAC+rfWumUm2W9df6BQfsDs3soW/+ArqYdu8NLtCjEcgpnnNYneqmev1HIE8Z4R
         BInFXhhLPNJD/ffVmOKdoQQ20FciNI8VEhOJqbqu9TV9OkCt7IF0C5+3VMwd9ZufYEaB
         XVwVz7yg06QT5hlhUeUxz3lnjdwRlOSJwgGa8759CeCh8hfnfW5RioAXB3oNeGTrlKRI
         yN5PW6XrpDvsLYrV6ZsUNt6P3SKJSm7w/e0Nd9be123lDTALFEL9Fb2dEJgG4Zl/Vhrn
         a0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=321l4njH4VKx1kXcZRO12v94G6OHeKZhCHKTSWfxtGw=;
        b=W52wIsDbgqKwxEXQjTvJTs2Mb1M4FY6jc67knbosmpi8N/g5efwUY2bM6NhVfc3dqP
         cEGC7DqBmrndMP6fKFV6XWv0eHJTeM7+bNg8WEgwRgVVGjfSTeoE9pRNGtS5XIHcE+KM
         5J/mWlZBlk8bZFwa2jYRGaHxd7O5N0FC2NkjJICtC3mTlaO4zFmaQVfJMlE4XfOEONDZ
         H7u7T4cBIW4NeMqu9VP+06QsTWeLvw4nlCHzo+LNDiEE2c2YxnNbbp2Rprjfb5OLiOn9
         rv+9K5Pnfsu44lzRoEeIul3sNY50WNaPRQ/kMmLhQ32EIpYC6LYyz2SJyKo3jfpy2umA
         SdRA==
X-Gm-Message-State: AA+aEWZwzuE/NKITLC6R5eFNSLxlxlLdabadilVcIof2ZoqtbNeY2x/n
        sJrc+RpR8WAz31FuoPmKllkugQoCkJI=
X-Google-Smtp-Source: AFSGD/UFiJgDOUG3QDNwHWa5gq+EOo3BLWA/KPHD5LPyqkAK+EC7gjFf4e40y2GkJe47hvXvBg5D8A==
X-Received: by 2002:a1c:1a90:: with SMTP id a138mr6208939wma.109.1543785827957;
        Sun, 02 Dec 2018 13:23:47 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id d2sm9551043wrs.97.2018.12.02.13.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 13:23:47 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [RFC PATCH 10/10] ARM: dts: suniv: f1c100s: Activate Audio Codec for Lichee Pi Nano
Date:   Mon,  3 Dec 2018 00:23:17 +0300
Message-Id: <11eb58fbfd223e041d03b6cec3363a7d08bdad45.1543782328.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543782328.git.mesihkilinc@gmail.com>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner suniv F1C100s now has basic audio codec support. Activate it
for Lichee Pi Nano board.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts b/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
index a1154e6..7618f8c 100644
--- a/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
+++ b/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
@@ -24,3 +24,11 @@
 	pinctrl-0 = <&uart0_pe_pins>;
 	status = "okay";
 };
+
+&codec {
+	allwinner,audio-routing =
+		"Headphone", "HP",
+		"Headphone", "HPCOM",
+		"MIC", "Mic";
+	status = "okay";
+};
-- 
2.7.4

