Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B2CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B23E20652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xo8EJJfg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jxEYAraw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfARMXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:23:11 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48564 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfARMXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:23:10 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5FD646085C; Fri, 18 Jan 2019 12:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547814189;
        bh=OkMNfwsTNZEwIUZmtBv7DZpOeP+QmH1Yp3wAF7wAc8A=;
        h=From:To:Cc:Subject:Date:From;
        b=Xo8EJJfg4ocE7kF46nlygPCUbTOIvF9cRf8gMcCfKb4thx5t1Xd5rGIChOqzVwWqa
         xt8h9ImJaYGnF+ziifFqNsH9qh4KyF13alMPOHo/YIbSz1+1qKY8+STjeq1TSSok47
         3zcxfVcBcAwVFmQS4cGcTZFmik3BQUDJJiI+H2BE=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B28216055C;
        Fri, 18 Jan 2019 12:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547814188;
        bh=OkMNfwsTNZEwIUZmtBv7DZpOeP+QmH1Yp3wAF7wAc8A=;
        h=From:To:Cc:Subject:Date:From;
        b=jxEYAraw2noIckbqz+6RdNorPBOj5pL6Ppyt/mVIKv2Rc9t+E5HO1XKsV8KGvoTB3
         j6YdPgfXO5entfuMkcGp5NB+o9dUy/qLDAd1nFk2ek2rYcYoMFH1zucvpHTwFSo+C3
         d39O8vqcHmM2ZpAwa/vB2stHkfhiNTmeeEbpJ9ak=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B28216055C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCHv3 0/4] Add coresight support for SDM845 and MSM8996
Date:   Fri, 18 Jan 2019 17:52:52 +0530
Message-Id: <cover.1547813804.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for coresight on SDM845 and MSM8996.

* Patch 1 adds device tree nodes for SDM845 coresight components.

* Patch 2 adds device tree nodes for MSM8996 coresight components.

* Patch 3 enables support for ETMv4.2 and enables SDM845 to make
  use of same driver(etm4x).

* Patch 4 is a trivial removal of duplicate header file.

Patch 1 and 3 depends on below AOSS QMP patches by Bjorn:
 https://patchwork.kernel.org/patch/10749469/
 https://patchwork.kernel.org/patch/10749481/
 https://patchwork.kernel.org/patch/10749479/
 https://patchwork.kernel.org/patch/10749475/

This patch series has been tested on SDM845 MTP and MSM8996
based Dragonboard 820c.

v3:
 * Added arm,scatter-gather property as suggested by Suzuki.

v2:
 * Added coresight support for msm8996 based on Vivek's patch.
   Cleaned up and added coresight cpu debug nodes for msm8996.
 * Merged coresight dtsi file into sdm845.dtsi as suggested by Bjorn
 * Addressed Mathieu's feedback about masking the minor version in
   etm4_arch_supported() and added a comment for reason to bypass
   the AMBA bus discovery method.

Sai Prakash Ranjan (3):
  arm64: dts: qcom: sdm845: Add Coresight support
  coresight: etm4x: Add support to enable ETMv4.2
  arm64: dts: qcom: sdm845: Remove the duplicate header inclusion

Vivek Gautam (1):
  arm64: dts: qcom: msm8996: Add Coresight support

 arch/arm64/boot/dts/qcom/msm8996.dtsi         | 448 +++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 449 +++++++++++++++++-
 drivers/hwtracing/coresight/coresight-etm4x.c |   2 +-
 drivers/hwtracing/coresight/coresight-etm4x.h |   2 +-
 4 files changed, 898 insertions(+), 3 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

