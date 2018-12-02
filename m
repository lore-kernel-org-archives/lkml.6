Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68CBC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDCB21473
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZsJd0ab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDCB21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbeLBVXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:23:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44028 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbeLBVXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:23:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so10112771wrs.10;
        Sun, 02 Dec 2018 13:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=y4Pigh91c3qMXMgWaohLTWbgGJ76Vl21itHuMEWGe2Y=;
        b=SZsJd0abWfXSSoJwmX9Qgu7FaiLkulvVrqRj652ySMDdDzG2ea9+jxsPA5ZVeonFph
         je79w+GNz2mqZz4NXHXj9YH7csrodLbBvHksMcm2TZlVrVZiucpklaOZrY/6aJ+rCdKp
         PeXBUSHHAfHxrNM+9i4HQA1DXupT4nekNRa/rK1Yn3Iy8ZqUU13R6fNc9q3C7BPsKIVy
         5Wheif6BivE/iATa0s5K3nF71SikMN2Oc0A/RsdQ1hVPd/PzMaBCbGENqsiK2txpkpHB
         U/NAnP2G5Ms/n8BGd5BOz7fvcqmQ+LFjehfsN2t4xnzn66Ve9m07FnpWgzIVBtopd6w5
         gImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y4Pigh91c3qMXMgWaohLTWbgGJ76Vl21itHuMEWGe2Y=;
        b=I26ojTIOgiamDbL5VuIO9VscPWb5Iejs+CdwJEG4M39/e+swHITosapT0dCKKbD/4+
         c6qrIuXT/uTKkhS/rDrWHKv+JkGwkTkg/JwuymZTE9co/+lvvUNNiefSQCE2LtjZa+FU
         ZglUTAC/nvxzpNuNHjgh2B1UBOtLvpiMZm+qP95q31IYP9qOShdrQ2I2se7EmRJrXMav
         Byf48o1J2Bdr23qt3hNUUNzLdufcgz96PjkcBlIQhyOb3HXW0EnmloWzjY5jWbMsi3AM
         SR0xCGo474GEiNxCSp79PH45sVovbhB4WeiaBRKiYoJg34kJlesrePBU4wNmwqSOGjcg
         zCHw==
X-Gm-Message-State: AA+aEWZfqWfP72aUfYm+tQ3G9hdrdZ2nVd1NoAZzXswYgO7FrE6V17ft
        UcOgzrjfLen8KRyMs5gRWIzOmYQGYh4=
X-Google-Smtp-Source: AFSGD/URshyVaqMcmEPLl6bVYviO3uoCEO0X9JpSRaRjTrOeIUeSH84v5c29LQm0fjrHKfieStuxVQ==
X-Received: by 2002:adf:e284:: with SMTP id v4mr7253944wri.26.1543785810325;
        Sun, 02 Dec 2018 13:23:30 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id d2sm9551043wrs.97.2018.12.02.13.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 13:23:29 -0800 (PST)
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
Subject: [RFC PATCH 00/10] Add support for DMA and audio codec of F1C100s
Date:   Mon,  3 Dec 2018 00:23:07 +0300
Message-Id: <cover.1543782328.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is RFC patchset for Allwinner suniv F1C100s to support DMA and
audio codec.

Allwinner F1C100s has a audio codec that has necessary digital and
analog parts. It has r-l headphone output and microphone, line, r-l
FM inputs. ADC can capture any inputs and also output channels via mux.
Any input channels or DAC samples can feed output channels. 

Add support for this audio codec.

F1C100s utilizes DMA channels to send and receive ADC-DAC samples. So
DMA support needed. Patch 1~5 adds support for DMA. Suniv F1C100s has 
very similar DMA to sun4i. But there is some dissimilarities also. 
Suniv features a DMA reset bit in clock  control unit. It has smaller 
number of DMA channels. Several registers has different addresses. 
It's max burst size is 4 instead of 8. Also DMA endpoint numbers are 
different.

Patch 6 adds DMA max burst option to sun4i-codec.

Patch 7~8 Add support for suniv F1C100s audio codec.

Patch 9 adds audio codec to suniv-f1c100s.dtsi

Patch 10 adds audio codec support to Lichee Pi Nano board.
 
Thanks!

Mesih Kilinc (10):
  dma-engine: sun4i: Add a quirk to support different chips
  dma-engine: sun4i: Add has_reset option to quirk
  dt-bindings: dmaengine: Add Allwinner suniv F1C100s DMA
  dma-engine: sun4i: Add support for Allwinner suniv F1C100s
  ARM: dts: suniv: f1c100s: Add support for DMA
  ASoC: sun4i-codec: Add DMA Max Burst field
  dt-bindigs: sound: Add Allwinner suniv F1C100s Audio Codec
  ASoC: sun4i-codec: Add support for Allwinner suniv F1C100s
  ARM: dts: suniv: f1c100s: Add support for Audio Codec
  ARM: dts: suniv: f1c100s: Activate Audio Codec for Lichee Pi Nano

 .../devicetree/bindings/dma/sun4i-dma.txt          |   4 +-
 .../devicetree/bindings/sound/sun4i-codec.txt      |   5 +
 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts  |   8 +
 arch/arm/boot/dts/suniv-f1c100s.dtsi               |  25 ++
 drivers/dma/Kconfig                                |   4 +-
 drivers/dma/sun4i-dma.c                            | 221 ++++++++++--
 sound/soc/sunxi/sun4i-codec.c                      | 371 ++++++++++++++++++++-
 7 files changed, 601 insertions(+), 37 deletions(-)

-- 
2.7.4

