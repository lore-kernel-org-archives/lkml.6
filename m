Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF12C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967BE20883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IjdOWZus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967BE20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbeGLIsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:48:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51801 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeGLIsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:48:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so4844760wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 01:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GOXWl/z34hHA2XGqcYPCz7CNtTJlW95blvBhKy5ro8Q=;
        b=IjdOWZusOrcLQrmlweJfvJROXyS7Yga0Qx1nAdxfWEI8g1afIMknXwxQb3u/jTFQ3B
         SBAux/b1HsaywBtXfeNy34NdcZBlnaIzqRCvYJ0smOng4ZdtnfN2RNFv3RtF3hTVQJd2
         sExRkayL5EitzIsDrZ3SmxeAUtP9KgigMaseg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GOXWl/z34hHA2XGqcYPCz7CNtTJlW95blvBhKy5ro8Q=;
        b=P1MUdMBK0UKxjHUrpiwnJ/VXEpEzxfqKerxzldct0wpn5/GgkPMiN1IpBEKXBDyL9B
         dD29L6NTIDSn362A4D6u3Pzt2sa0DYl1/TamegdsWvq8yAeIEKnoUCuwUY+ILbd4RQ//
         llUvSY7wT05uJiVW9coVhYgR03cMBRIDMf/ILzlUTds/o8TK0k0596FpcwyJvV1wwUrz
         OR92xORkD9W3/LVartiOlQDf41p9mq1nm8FiGZzaVY2XXCORBbIpnLJj4ljLx5UbWCIB
         S/UdnGq68Hb5NGw4fxHHNM7EeQ+Vj/a+65524QBUMTNxuxWKi+QLQFO63xop8tpLhtE6
         QbZw==
X-Gm-Message-State: AOUpUlHOXC6CWDywexqRnN7vSL89Sg5WojgxvEJGdQp3Bll6Z4VXEk01
        kU32p+EFPWKllXvPRdEqGBTnUfcE0rQ=
X-Google-Smtp-Source: AAOMgpcupDt4f7jPG0cCiYTieO8hKnETScvAg1wQvUrKGdonVkjeOzFFFW8BKJgME7sg5ggG5G/7qw==
X-Received: by 2002:a1c:4c0e:: with SMTP id z14-v6mr795833wmf.89.1531384772863;
        Thu, 12 Jul 2018 01:39:32 -0700 (PDT)
Received: from localhost ([103.249.91.93])
        by smtp.gmail.com with ESMTPSA id l6-v6sm2979179wmh.41.2018.07.12.01.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 01:39:32 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org,
        Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-soc@vger.kernel.org
Subject: [PATCH v7 0/7] thermal: tsens: Refactoring for TSENSv2 IP
Date:   Thu, 12 Jul 2018 14:09:01 +0530
Message-Id: <cover.1531384019.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a mixed bag:
- Some code moves to allow code sharing between different SoCs with v2 of
  the TSENS IP,
- a generic qcom,tsens-v2 property as a fallback compatible for all v2.x.y
  platforms,
- new platform support (sdm845)
- a cleanup patch and
- a DT change to have a common way to deal with the SROT and TM registers
  despite slightly different features across the IP family and different
  register offsets.

Changes since v6:
- Fix comments and patch descriptions as per Doug's review
- Rename tsens to thermal-sensor in DT
- Add various review tags

Changes since v5:
- Actually fix unit addressses for the two tsens blocks as per Stephen's comment.

Changes since v4:
- Revert back to a single fallback bindind qcom,tsens-v2 as per Rob's
  suggestion.
- Rework how old (unsplit SROT and TM address space) DTs are handled by
  needing a 0x1000 offset but still sharing common code in tsens-v2.c
- Remove the patch to added TRDY checks while we investigate Matthias'
  reports
- Fix unit addressses for the two tsens blocks as per Stephen's comment.

Changes since v3:
- Introduce qcom,tsens-v2.4.0 property and make qcom,tsens-v2 a
  fallback, compatible property.
- Rename ops_v2 to ops_generic_v2

Changes since v2:

- Based on review, moved tsens-8996.c to tsens-v2.c and changed
  corresponding function names, struct names to allow for generic tsensv2
  platforms
- All v2 platforms will now only need to use the qcom,tsen-v2
  property
- Added a DT patch to initialize tsens driver on sdm845, now that
  4.18-rc1 will contain an sdm845.dtsi

Changes since v1:
- Move get_temp() from tsens-8996 to tsens-common and rename
- Change 8996 DT entry to allow init_common() to work across
  sdm845 and 8996 due to different offsets

Amit Kucheria (7):
  thermal: tsens: Get rid of unused fields in structure
  thermal: tsens: Add support to split up register address space into
    two
  arm64: dts: msm8996: thermal: Initialise via DT and add second
    controller
  thermal: tsens: Rename tsens-8996 to tsens-v2 for reuse
  dt: thermal: tsens: Document the fallback DT property for v2 of TSENS
    IP
  thermal: tsens: Add generic support for TSENS v2 IP
  arm64: dts: sdm845: Add tsens nodes

 .../devicetree/bindings/thermal/qcom-tsens.txt     | 31 +++++++++++++++++----
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 14 ++++++++--
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 16 +++++++++++
 drivers/thermal/qcom/Makefile                      |  2 +-
 drivers/thermal/qcom/tsens-common.c                | 12 ++++++++
 drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c}  | 32 ++++++++++------------
 drivers/thermal/qcom/tsens.c                       |  3 ++
 drivers/thermal/qcom/tsens.h                       |  8 ++++--
 8 files changed, 88 insertions(+), 30 deletions(-)
 rename drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} (64%)

-- 
2.7.4

