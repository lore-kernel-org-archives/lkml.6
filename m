Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031489AbeBOM1V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 07:27:21 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54498 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031169AbeBOM1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 07:27:17 -0500
X-Google-Smtp-Source: AH8x225niF+tmBVP6jUvbY0ocZxicg/55N5KeVcou73yD5s/VwHIFoclnxXuPXgXJx6UG8Aunbv9cA==
From: srinivas.kandagatla@linaro.org
To: vinod.koul@intel.com, andy.gross@linaro.org, dmaengine@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, david.brown@linaro.org,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org, yanhe@quicinc.com, ramkri@qti.qualcomm.com,
        sdharia@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/5] dmaengine: qcom: bam_dma: fixes for remotely controlled bam
Date: Thu, 15 Feb 2018 12:25:06 +0000
Message-Id: <20180215122511.13517-1-srinivas.kandagatla@linaro.org>
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

Changes since v2:
	return clk error in default case, suggested by Bjorn

Srinivas Kandagatla (5):
  dmaengine: qcom: bam_dma: make bam clk optional
  dt-bindings: dmaengine: bam_dma: add remote controlled bindings
  dmaengine: qcom: bam_dma: get num-channels and num-ees from dt
  dmaengine: qcom: bam_dma: do not write to global regs in remote mode
  dmaengine: qcom: bam_dma: disable runtime pm on remote controlled

 .../devicetree/bindings/dma/qcom_bam_dma.txt       |  4 ++
 drivers/dma/qcom/bam_dma.c                         | 59 +++++++++++++++++-----
 2 files changed, 49 insertions(+), 14 deletions(-)

-- 
2.15.1
