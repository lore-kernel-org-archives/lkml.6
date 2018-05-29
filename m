Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932985AbeE2KU5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:20:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36570 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932693AbeE2KUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:20:53 -0400
X-Google-Smtp-Source: ADUXVKKbPSi5ew1ONBysUGWVCWrmJH5W94BNgQniNRgu4hueP7uQBdFp2k3iacH4Kn269VF8Bh8ixw==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, robh+dt@kernel.org,
        bgoswami@codeaurora.org
Cc: mark.rutland@arm.com, lgirdwood@gmail.com, plai@codeaurora.org,
        tiwai@suse.com, perex@perex.cz, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/6] ASoC: qdsp6: Add support to TDM ports
Date: Tue, 29 May 2018 11:18:27 +0100
Message-Id: <20180529101833.30489-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds supports to 40 TDM ports available in q6AFE module.

Among these 6 patches, there are 2 cleanup patches, first one which
makes i2s use common prepare function and the second one is add
macros for routings to make it easy to add new port routings.
Rest of the 4 patches are tdm dt-bindings, afe port prepare support
in afe, afe-dais support and adding tdm routing update.

These patches have been tested by Rohit on SDM845.

Thanks,
Srini

Srinivas Kandagatla (6):
  ASoC: qdsp6: dt-bindings: Add q6afe tdm dt binding
  ASoC: qdsp6: qdafe: add support to tdm ports
  ASoC: qdsp6: q6afe-dai: use q6afe_dai_prepare() for MI2S
  ASoC: qdsp6: q6afe-dai: add support to tdm dais
  ASoC: qdsp6: q6routing: Add macros for mixers
  ASoC: qdsp6: q6routing: Add support to all TDM Mixers

 .../devicetree/bindings/sound/qcom,q6afe.txt       |   68 ++
 include/dt-bindings/sound/qcom,q6afe.h             |   80 ++
 sound/soc/qcom/qdsp6/q6afe-dai.c                   |  621 ++++++++++-
 sound/soc/qcom/qdsp6/q6afe.c                       |  429 +++++++-
 sound/soc/qcom/qdsp6/q6afe.h                       |   20 +-
 sound/soc/qcom/qdsp6/q6routing.c                   | 1084 ++++++++++----------
 6 files changed, 1733 insertions(+), 569 deletions(-)

-- 
2.16.2
