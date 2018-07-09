Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A6EC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CB42089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SojkzGrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CB42089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932567AbeGIL2I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:28:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39783 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754523AbeGIL2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:28:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so10581921wre.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=p3xNv2RuZPHpmvXOJfLu7e6wt8kyAwGJqwKeuGO1X1Q=;
        b=SojkzGrNnE07wJsmb4xr3KA7C89TcQexL/NY9jz9R+sx/VnkCAWJsRJvcJISi9Q8F7
         OsXsu3C6WWz6jG9VvmQkjV+PGAld6BUjPPIktjunfnjIDm7QoOCvsNMy+rnHyFiShPm/
         +VnFPnYD19lLgIZTKIpcDJFFRajIk2Hxds8ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p3xNv2RuZPHpmvXOJfLu7e6wt8kyAwGJqwKeuGO1X1Q=;
        b=s8MJ7ffVq5l+PF0+AbME/cI+/hzPu7e+O1pC2bY+27Mb8XF/5u3Fo10ko7TZbKaQBX
         wa0NLKjayD6T2NulP/1u7FTH5+NxGDDfACYoRbXW2752RhTmlgFvN5qGiJ1qw7BIZKUk
         sckrTZdRWs1pLrIOkgIf8tIqoeY+Db/0VQAVRo/VLIYVrN/xoKm2OZXmBK/G6Y5cPrCD
         mVwXt4AV+tLMDv+ef3l74EnZYjzeso1zSgx3HAXX5CONtAcK1h9e4N9my7AeHKAZAhYk
         w26/2l4F8Os1Lbq7MNF47RAKH9ZgM1F9909Z5eKqfMOq6jUgUHI/ARG33hQJ++PpsKgn
         wSfA==
X-Gm-Message-State: APt69E0gfW+Ev0xvVReePNF75yZ1H3/gFJSTxZMojKtQ7jdeyo4qmK90
        PUDct4fO+cfZSWMB1cWLtQTRgTbRU2Q=
X-Google-Smtp-Source: AAOMgpftIHQ5aHpXbsHPGDD1Rs/ye1Ro4g2ajEJzPutUE3HfR7SCRJByN8HyEV2AVVqF7lRZM0W57A==
X-Received: by 2002:adf:e50f:: with SMTP id j15-v6mr14976132wrm.111.1531135683456;
        Mon, 09 Jul 2018 04:28:03 -0700 (PDT)
Received: from localhost ([49.248.189.240])
        by smtp.gmail.com with ESMTPSA id h4-v6sm15647409wre.89.2018.07.09.04.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 04:28:02 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-soc@vger.kernel.org
Subject: [PATCH v5 0/7] thermal: tsens: Refactoring for TSENSv2 IP
Date:   Mon,  9 Jul 2018 16:57:33 +0530
Message-Id: <cover.1531133611.git.amit.kucheria@linaro.org>
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
  dt: qcom: 8996: thermal: Move to DT initialisation
  thermal: tsens: Rename tsens-8996 to tsens-v2 for reuse
  thermal: tsens: Add generic support for TSENS v2 IP
  dt: thermal: tsens: Document the fallback DT property for v2 of TSENS
    IP
  arm64: dts: sdm845: Add tsens nodes

 .../devicetree/bindings/thermal/qcom-tsens.txt     | 25 +++++++++++++----
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 12 +++++++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 16 +++++++++++
 drivers/thermal/qcom/Makefile                      |  2 +-
 drivers/thermal/qcom/tsens-common.c                | 11 ++++++++
 drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c}  | 32 ++++++++++------------
 drivers/thermal/qcom/tsens.c                       |  3 ++
 drivers/thermal/qcom/tsens.h                       |  8 ++++--
 8 files changed, 81 insertions(+), 28 deletions(-)
 rename drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} (64%)

-- 
2.7.4

