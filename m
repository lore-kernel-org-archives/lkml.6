Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93ACBC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483062151D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NMtLNU3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483062151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeIZQiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:38:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39393 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeIZQiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:38:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id s14-v6so26408191wrw.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 03:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lcd6u1ndTCnAc1VHhAVdt0N3LitCvS0N9H8ozFD8tYE=;
        b=NMtLNU3f+JW+ic3veGUj+7PyrO++3Mv3VnrVgAiHhHhoTLWHi3u8muLf7J6DDO693V
         nRGqo4ePRsIJWwqHVyXI3DZpynGcnTz0209FaSFZ40zKrc2aIDt/ETI2SFWtx0kvh+w0
         yz1V/x6ozWQR8r+m0k1gWvNTD6hj1APoWDMyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lcd6u1ndTCnAc1VHhAVdt0N3LitCvS0N9H8ozFD8tYE=;
        b=o3fQ/6/kcqJHh/cIKFJldAJb3K9ss/fZx57iaVA2OnuY29XS9cbAkqGhFAvBKJne4W
         gH1szCO5siAq2jJhv5lvWCk7zzjjaZ6p7u+T5fr7B49/TxIIgMZSOJ6SFnUiKS6TaPSp
         0KeI7GGQiCFwTzR0TZwVgmJWdGezfMcZlYcsT3mp5TsQttK3F0bx2OAcI1IfKsKyD6uY
         iqsOJMwgfYY2iTjTYU/lMWfydcff2sX4aolTYgCyMXRtF3qrvZaJkc+T6FnDogZiFTtv
         gpo+liVW7Z/nlVeJkRKl1/6r2PisCIXftupMULR/dQxww7k5QB9c0QkfuHgyE6FiNAyC
         J3Xg==
X-Gm-Message-State: ABuFfoj/izrBBoDj0TxDUxixyU5qyb29bDEouI3YVh5PeK3X2HbnrLe9
        rzizvmDumlc6R2Rf4T704ZFgTQ==
X-Google-Smtp-Source: ACcGV63FHtOgDt2F+TjLEQEdMg8AhpmPxnHtFo2PRQH2wBNJ+gLst0w2SVMq3nj6X/LzTk3SkinDNA==
X-Received: by 2002:adf:9a84:: with SMTP id a4-v6mr4389463wrc.78.1537957555741;
        Wed, 26 Sep 2018 03:25:55 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id b12sm4442648wrx.11.2018.09.26.03.25.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Sep 2018 03:25:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, vkoul@kernel.org,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org,
        lgirdwood@gmail.com, tiwai@suse.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/5] ASoC: qdsp6: add compress offload support
Date:   Wed, 26 Sep 2018 11:23:44 +0100
Message-Id: <20180926102349.23481-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support to very basic MP3 playback compress offload
support via QDSP ASM module.

Tested this patchset on DB410c with APQ8016 and DB820c with APQ8096 using
tinycompress library.

Adding other codec support should be trivial w.r.t qdsp6 side, however
there are other dependencies like compress UAPI header changes and
FastRPC which are being worked in parallel. Once ready will post them!

thanks,
srini

Changes since v1 (https://patchwork.kernel.org/cover/10585805/)
- added support to snd_compr_set_runtime_buffer()
- make use of generic copy function
- few trivial cleanups suggested by Vinod Koul

Srinivas Kandagatla (5):
  ALSA: soc-compress: add support to snd_compr_set_runtime_buffer()
  ALSA: compress: make use of runtime buffer for copy
  ASoC: q6asm-dai: dt-bindings: Add support to compress dais
  ASoC: qdsp6: q6asm: add support to MP3 format
  ASoC: qdsp6: q6asm-dai: Add support to compress offload

 .../devicetree/bindings/sound/qcom,q6asm.txt  |  27 ++
 include/sound/compress_driver.h               |  19 +
 sound/core/compress_offload.c                 |  18 +-
 sound/soc/qcom/Kconfig                        |   1 +
 sound/soc/qcom/qdsp6/q6asm-dai.c              | 377 +++++++++++++++++-
 sound/soc/qcom/qdsp6/q6asm.c                  |   5 +
 6 files changed, 443 insertions(+), 4 deletions(-)

-- 
2.19.0

