Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031074AbeBNOtk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:49:40 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53715 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030821AbeBNOrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:47:08 -0500
X-Google-Smtp-Source: AH8x224yB5b930E+KGeubYpAvR8YZz/SHE5Ka6o5q/MNOtcShTG6cewLLtkPCgi71NLYTwxPssGNJw==
From: srinivas.kandagatla@linaro.org
To: vinod.koul@intel.com, andy.gross@linaro.org, dmaengine@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, david.brown@linaro.org,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, yanhe@quicinc.com, ramkri@qti.qualcomm.com,
        sdharia@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/5] dmaengine: qcom: bam_dma: fixes for remotely controlled bam
Date: Wed, 14 Feb 2018 14:44:54 +0000
Message-Id: <20180214144459.29813-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Andy,

I did hit few issues while trying out SLIMBus BAM on DB820c, this BAM instance
is remotely controlled and powered up after ADSP is booted using QMI commands.

Firstly some of the master registers are written even when the BAM is remotely
controlled, and secondly reading registers when bam is not ready yet.

These 4 patches address these issues, there are few more issues like doing PM
in simillar usecase, these will be addressed soon.

Thanks,
Srini

Changes since v1:
	- Move dt bindings to separate patch
	- merge num-channels and num-ees driver changes
	- fixed few typos.
	- added runtime pm disable, as suggested by Sagar

Srinivas Kandagatla (5):
  dmaengine: qcom: bam_dma: make bam clk optional
  dt-bindings: dmaengine: bam_dma: add remote controlled bindings
  dmaengine: qcom: bam_dma: get num-channels and num-ees from dt
  dmaengine: qcom: bam_dma: do not write to global regs in remote mode
  dmaengine: qcom: bam_dma: disable runtime pm on remote controlled

 .../devicetree/bindings/dma/qcom_bam_dma.txt       |  4 ++
 drivers/dma/qcom/bam_dma.c                         | 66 +++++++++++++++-------
 2 files changed, 51 insertions(+), 19 deletions(-)

-- 
2.15.1
