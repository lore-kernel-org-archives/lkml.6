Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE92ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F5420779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GwwVnft5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F5420779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388444AbeGWRAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:00:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36901 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387968AbeGWRAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:00:08 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so1726965wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 08:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uOSHNGuwMIQPaOng5qdIAcC0fCSRyc9ISZGk86LG6+c=;
        b=GwwVnft5qHo7WIdXv4bdoFEk+uTepqDVQxIE7DhTPyHqWrNY4fIkZld9sgeXatrvu6
         sZXovjeKd109qebG7Imtfu1xzsffG5npy1/6uXCy4DRRMFly2COZRSA7ey91lLdQVFeA
         suc/xvtG3Erb0UWtaG8Jx6057fFfOz0Flghog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uOSHNGuwMIQPaOng5qdIAcC0fCSRyc9ISZGk86LG6+c=;
        b=L15j3uTAKBYG4l6hrXxNYTuwL3cjrjaObc+ighKrkXDxoie8j26DZ3W6H1Uzul+3un
         BUh7jTwE6zrPeLDxNuOMbRIYVnnG5wfN5h2nQuO/JHMn4dRLMPHZK9Ei95sYviQnt891
         EdAvM/vj7xnl07MMXU4wfPWdJF5FyK9OAmdVQ3oRDEzF558Xvm/wN6D/cOREULOUn0UP
         cUtla6/fyXCynYxYnNxPgT7MdY7eaCOkcWY5yjCrmCfBr979tfSBlZqzxthz6VrcgScb
         x+PC5WImbkiR8BdfMoESBnELFfWTyKkFDYfsetDkQZTCCNIVjVToq/7vEMoK/nJvdHpc
         b8gg==
X-Gm-Message-State: AOUpUlGSfMXXl4IccjTIIqhX7Ku1X65T28TwlXz65IQZuzrrRhiSIqjU
        AU/p9YI7JTeho82pKTM/HfcYjA==
X-Google-Smtp-Source: AAOMgpedSOTSp/eOXwQ+e8JqJQRylDbnSuScZf461xzb8ftFvBB6b8PPHOp+Cm6EAq2AEYuSO7jn2g==
X-Received: by 2002:a1c:4143:: with SMTP id o64-v6mr8372905wma.123.1532361495830;
        Mon, 23 Jul 2018 08:58:15 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 14-v6sm206385wmt.1.2018.07.23.08.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 08:58:15 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/12] mfd: Add support to WCD9335 Audio Codec
Date:   Mon, 23 Jul 2018 16:53:58 +0100
Message-Id: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
and capture paths.

This patchset also depends on the SLIMbus Stream apis which is already merged
via char-misc tree for 4.19.

Some parts of the code has been inherited from Qualcomm andriod kernel,
so credits to various authors.

WCD9335 can be interfaced via I2S/I2C or SLIMbus. 

Here is my test branch incase someone want to try this out:
https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=wcd9335

Thanks,
Srini

Srinivas Kandagatla (12):
  mfd: dt-bindings: Add wcd9335 mfd bindings
  mfd: wcd9335: add support to wcd9335 core
  mfd: wcd9335: add wcd irq support
  ASoC: dt-bindings: add dt bindings for wcd9335 audio codec
  ASoC: core: add support to snd_soc_dai_get_channel_map()
  ASoC: wcd9335: add support to wcd9335 codec
  ASoC: wcd9335: add CLASS-H Controller support
  ASoC: wcd9335: add basic controls
  ASoC: wcd9335: add playback dapm widgets
  ASoC: wcd9335: add capture dapm widgets
  ASoC: wcd9335: add audio routings
  ASoC: apq8096: Add support to Analog audio via WCD9335 slim

 .../devicetree/bindings/mfd/qcom,wcd9335.txt       |  130 +
 .../devicetree/bindings/sound/qcom,wcd9335.txt     |   21 +
 drivers/mfd/Kconfig                                |   18 +
 drivers/mfd/Makefile                               |    4 +
 drivers/mfd/wcd9335-core.c                         |  278 ++
 drivers/mfd/wcd9335-irq.c                          |  172 +
 include/dt-bindings/mfd/wcd9335.h                  |   43 +
 include/linux/mfd/wcd9335/registers.h              |  580 +++
 include/linux/mfd/wcd9335/wcd9335.h                |   43 +
 include/sound/soc-dai.h                            |    8 +
 sound/soc/codecs/Kconfig                           |    5 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/wcd-clsh.c                        | 1010 ++++
 sound/soc/codecs/wcd-clsh.h                        |   69 +
 sound/soc/codecs/wcd9335.c                         | 4981 ++++++++++++++++++++
 sound/soc/qcom/apq8096.c                           |   68 +
 sound/soc/soc-core.c                               |   22 +
 17 files changed, 7454 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/qcom,wcd9335.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
 create mode 100644 drivers/mfd/wcd9335-core.c
 create mode 100644 drivers/mfd/wcd9335-irq.c
 create mode 100644 include/dt-bindings/mfd/wcd9335.h
 create mode 100644 include/linux/mfd/wcd9335/registers.h
 create mode 100644 include/linux/mfd/wcd9335/wcd9335.h
 create mode 100644 sound/soc/codecs/wcd-clsh.c
 create mode 100644 sound/soc/codecs/wcd-clsh.h
 create mode 100644 sound/soc/codecs/wcd9335.c

-- 
2.16.2

