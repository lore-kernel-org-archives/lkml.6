Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F385CECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DED22147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j55spvxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DED22147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeIQGWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 02:22:50 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39851 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbeIQGWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 02:22:50 -0400
Received: by mail-it0-f66.google.com with SMTP id h1-v6so8898425itj.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 17:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fmaXJem1u+BE9/4vZE6vncVsavp9C4jAYD9xOClR9Ws=;
        b=j55spvxVALibpBjYKZ95Xh7msT3+fcBOUwE0xIpQQRNAl65DwFA9J+6Hq/horkzlJq
         u+XdmzsBuVcnJfAvdnVFJ/d1vsbMb+OS6PN87paPYFMax4oJ6RTFCcKULJMnKUc9hpBe
         jS8tCzocYnhkd3KXu/j/hNSHSOiwGA3N1b62o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fmaXJem1u+BE9/4vZE6vncVsavp9C4jAYD9xOClR9Ws=;
        b=ckNBI+2LIsRBXb2BErSymSSVfmnDoglNZXAg50QXX9ZNoabVJVV6+LHI2ywSR0p1yL
         OxAWwybTQ+L6JcYT7t/uyK5dXjLwWOnPeHICEgsg7ntYOIUuioVq/J+FmVcSzuYVPGgc
         LScKVREw4Fr9tsjfEv12Fs2FmF6trjsosSF7PL4N3OpJmX53YhtXzTLPLLxsq2xy9iCH
         y7ckMwfN3r7LGdCiwy4lqSOZlmpGLiNGb5Y1iquH0yit0oePTCI98wdOYwsm77455aqh
         BMetlRWN0KEr/LKYclPO8xXqwvNComXrQ/8apOVHYX/ascJkrvkbEDPeZX5nM6n2pN3r
         +nxw==
X-Gm-Message-State: APzg51DOa29mtySLkAK/aiBWc2xcOQ9MLn7oeWQ96wAnY44Da30/ZjVW
        xSBS0VGUWO2iMq6H8G3l8Sj5Pg==
X-Google-Smtp-Source: ANB0VdZ7DCJElnnbt0SCXqRF2wjD0+DUlBWOrQPTPBagvXu5hY6VugmGc2VJiCQeujngZLJf8wgMAw==
X-Received: by 2002:a24:bcc4:: with SMTP id n187-v6mr10370044ite.144.1537145876925;
        Sun, 16 Sep 2018 17:57:56 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id f64-v6sm829972ite.4.2018.09.16.17.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 17:57:56 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 00/14] ASoC: Add support to WCD9335 Audio Codec
Date:   Sun, 16 Sep 2018 17:57:13 -0700
Message-Id: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thankyou for reviewing v3 patchset, here is v4 addressing comments from v3.

Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC.
It is integrated in multiple Qualcomm SoCs like: MSM8996, MSM8976,
and MSM8956 chipsets.

WCD9335 had multiple functional blocks, like: Soundwire controller,
interrupt mux, pin controller, Audio codec, MBHC, MAD(Mic activity Detection),
Ultrasonic proximity and pen detection, Battery-voltage monitoring and
Codec processing engine.

Currently this patchset has been only tested with SLIMbus interface due
to hardware avaiablity, but it can be easily made to work with both SLIMbus
and I2C/I2S.    

This patchset adds very basic playback and capture support witout much
fancy features. New features will be added once the basic support is in.
This patchset is tested on top of linux-next on DB820c for both playback
, capture paths and MBHC.

Some parts of the code has been inherited from Qualcomm andriod kernel,
so credits to various authors.

WCD9335 can be interfaced via I2S/I2C or SLIMbus. 

Here is my test branch incase someone want to try this out:
https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=wcd9335

Thanks,
Srini

Changes since v3 (https://lkml.org/lkml/2018/9/4/318/)
 - Updated mbhc dt bindings according to Robs Comments.
 - Added a cleanup patch to common up fixups.
 - Addressed various comments on mfd driver by Lee Jones.
 - Added acks on bindings and irq support.
 - fixed module loading

Srinivas Kandagatla (14):
  ASoC: dt-bindings: update wcd9335 bindings.
  mfd: wcd9335: add support to wcd9335 core
  mfd: wcd9335: add wcd irq support
  ASoC: wcd9335: add support to wcd9335 codec
  ASoC: wcd9335: add CLASS-H Controller support
  ASoC: wcd9335: add basic controls
  ASoC: wcd9335: add playback dapm widgets
  ASoC: wcd9335: add capture dapm widgets
  ASoC: wcd9335: add audio routings
  ASoC: dt-bindings: Add WCD9335 MBHC specific properties
  ASoC: wcd9335: add mbhc support
  ASoC: apq8096: add slim support
  ASoC: apq8096: add headset JACK support
  ASoC: qcom: common: move be_hw_fixup to common

 .../devicetree/bindings/sound/qcom,wcd9335.txt     |   30 +-
 drivers/mfd/Kconfig                                |   13 +
 drivers/mfd/Makefile                               |    4 +
 drivers/mfd/wcd9335-core.c                         |  394 ++
 include/linux/mfd/wcd9335/registers.h              |  640 +++
 include/linux/mfd/wcd9335/wcd9335.h                |   81 +
 sound/soc/codecs/Kconfig                           |    5 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/wcd-clsh-v2.c                     |  577 +++
 sound/soc/codecs/wcd-clsh-v2.h                     |   49 +
 sound/soc/codecs/wcd9335.c                         | 5241 ++++++++++++++++++++
 sound/soc/qcom/apq8096.c                           |  128 +-
 sound/soc/qcom/common.c                            |   17 +
 sound/soc/qcom/sdm845.c                            |   22 +-
 14 files changed, 7168 insertions(+), 35 deletions(-)
 create mode 100644 drivers/mfd/wcd9335-core.c
 create mode 100644 include/linux/mfd/wcd9335/registers.h
 create mode 100644 include/linux/mfd/wcd9335/wcd9335.h
 create mode 100644 sound/soc/codecs/wcd-clsh-v2.c
 create mode 100644 sound/soc/codecs/wcd-clsh-v2.h
 create mode 100644 sound/soc/codecs/wcd9335.c

-- 
2.9.3

