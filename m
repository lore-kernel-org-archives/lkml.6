Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FE2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91B82177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SdxGfC9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfAJPG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:06:27 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52138 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbfAJPG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:06:26 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so11592427wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 07:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8maFnBPTpmay9QuQUCsxmg+Of1sOU1fT8fC7dqM80v8=;
        b=SdxGfC9Rw2nzjnPy9sLnWcIlRT1w8SfvrLN/RSRykXHQdnGmOolU7xlx/rmH7fR1um
         F9+rDpNW6l1jm9hLRwrD/RGTkeFnRxcLKA25bj0Xzh6RyVKaPtftKITNEk46ddMzF28R
         CGcfX2Vo6U/HOZOkv0Ef549wi/fP75SVqlrg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8maFnBPTpmay9QuQUCsxmg+Of1sOU1fT8fC7dqM80v8=;
        b=GdBy3OgtdLcGaUtOpHfqEZfai0HjiKpVPm9qrMDS8NPQaAsGjKcyJQdZYmSAmKG91+
         CAyN01udPQNSbmt6AXDmhGDnb/3BIAzvhFZSSeTUQGu5/zyyIRVc5Cd5zXnm+u2mmdiG
         FVA/D6rjhMM8AhCxAk9LfwzAtAJJufUecO/vJV/mIzjtI9bYMOrp3wAHfCEBWFJlETzL
         GOLL/FLMaT9JHR0+utquQ7GNmZU8yfdytEsjsLKwsG20hujmWE2Y+zG8oFHt7a2CL2eH
         XGaYva+mdgIkTCfOpCCr1X9NhFICBfD1ByD2Bh4RgGglCdYOU+BRNLS4DjdC2zFQ/n7f
         ou+A==
X-Gm-Message-State: AJcUukfyChENz4kzJ4L2ZfUeXm+SX/EaRPz6HZLX/U/alxTcKVVAt25Z
        cQeMvhbtC1fnrXFKYTqp+C7WDA==
X-Google-Smtp-Source: ALg8bN515Ui3pME8BUv4OD13Z4V9Ks4AkeqNjXRsyp3u2PjHd5VH0wybG21ZmV1gNLz27sofM3sRyA==
X-Received: by 2002:a7b:c34c:: with SMTP id l12mr10103657wmj.147.1547132784123;
        Thu, 10 Jan 2019 07:06:24 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id b12sm51063754wrt.17.2019.01.10.07.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 07:06:23 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 0/8] ASoC: Add support to WCD9335 Audio Codec
Date:   Thu, 10 Jan 2019 15:06:08 +0000
Message-Id: <20190110150616.2332-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thankyou for reviewing v4 patchset, here is v5 addressing comments from v4.
Major change is moving the driver out of MFD as there are no immediate plans
to add support to other drivers on this codec.

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

This patchset adds very basic playback and capture support without much
fancy features. New features will be added once the basic support is in.
This patchset is tested on top of linux-next on DB820c for both playback
, capture paths and MBHC.

Some parts of the code has been inherited from Qualcomm andriod kernel,
so credits to various authors.

WCD9335 can be interfaced via I2S/I2C or SLIMbus. 

Here is our integration branch incase someone want to try this out:
https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/log/?h=integration-linux-qcomlt

Thanks,
Srini

Changes since v4 (https://lkml.org/lkml/2018/9/17/21/)
 - Move the driver out of MFD as discussed with Lee
 - defer support to MBHC for more testing!

Srinivas Kandagatla (8):
  ASoC: dt-bindings: update wcd9335 bindings.
  ASoC: wcd9335: add support to wcd9335 codec
  ASoC: wcd9335: add CLASS-H Controller support
  ASoC: wcd9335: add basic controls
  ASoC: wcd9335: add playback dapm widgets
  ASoC: wcd9335: add capture dapm widgets
  ASoC: wcd9335: add audio routings
  ASoC: apq8096: add slim support

 .../bindings/sound/qcom,wcd9335.txt           |   10 +-
 sound/soc/codecs/Kconfig                      |    6 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wcd-clsh-v2.c                |  576 ++
 sound/soc/codecs/wcd-clsh-v2.h                |   49 +
 sound/soc/codecs/wcd9335.c                    | 5275 +++++++++++++++++
 sound/soc/codecs/wcd9335.h                    |  640 ++
 sound/soc/qcom/apq8096.c                      |   71 +-
 8 files changed, 6623 insertions(+), 6 deletions(-)
 create mode 100644 sound/soc/codecs/wcd-clsh-v2.c
 create mode 100644 sound/soc/codecs/wcd-clsh-v2.h
 create mode 100644 sound/soc/codecs/wcd9335.c
 create mode 100644 sound/soc/codecs/wcd9335.h

-- 
2.20.1

