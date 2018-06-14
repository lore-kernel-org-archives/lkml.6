Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 15847C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5EC8208B5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gHYqID92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5EC8208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754993AbeFNKnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:43:46 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34938 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754900AbeFNKno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:43:44 -0400
Received: by mail-lf0-f65.google.com with SMTP id i15-v6so8666055lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 03:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BLsx5nLPISpUVoW0qG4Sr8m/gmithxdi0bWcJAO5x1Y=;
        b=gHYqID92npBbu9mu2pLVuXcXjchXxgLtIkabA1+Eu3KAvR0c2kg6o1y/vcCki5e/TG
         v+xmwd+Mxk9CByCBvaMH4Fhw1QGO7yJPBvjIkxWylq0njB48Z+A149DM+C3JtD7tG9/2
         NkOjpz9y61l8sDerDZJBfwJPPvXhXVZKPA5ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BLsx5nLPISpUVoW0qG4Sr8m/gmithxdi0bWcJAO5x1Y=;
        b=S5WMqoqGZF0g9t5kz/RwjEAlSaxvPpz6i1nq/gnqSHkZpqC9uteh2aMkz85MaQ9J7/
         DlU963TwIbNXUbALxZkBPb08ec7wLuzyRRqJOYDnZaGiIjOpCctCVMVmFfCcdXQMXam+
         /tx8pXkidt50s1DlqhmAjJWvpBF6cHQoqA9oqhjsDwGBAEtF89yheLb/KeTCQPCldArT
         lN9mJs1+DwAfcIpFN0/pObHzfLSyK2kw4+7XmjyGY+4mZqq08qhxibrRHuh4V1nBeDRB
         aiFUw6BEVDtlYAeRBhD6YgWtCvmqreOfzYT8SfaioK/tqQX4vb5MQzl880oCcSPyqiXN
         Dd3g==
X-Gm-Message-State: APt69E0//LtnWYHUpD0TAd9q2t0H25MTfzbxLydB6F5gMjpXsBGtzZSE
        sAygw1bitfp3Q0WZDi+NH9BSzr47Vuk=
X-Google-Smtp-Source: ADUXVKKDxW56qfgqva23QIV1QDR1vB0qexWcMXosBcnjSpFbSCuz/fHn1kYQqFVj5UxCMMhysnDzpQ==
X-Received: by 2002:a2e:575c:: with SMTP id r28-v6mr1341708ljd.51.1528973022657;
        Thu, 14 Jun 2018 03:43:42 -0700 (PDT)
Received: from localhost (85-76-96-172-nat.elisa-mobile.fi. [85.76.96.172])
        by smtp.gmail.com with ESMTPSA id r84-v6sm894711ljb.24.2018.06.14.03.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 03:43:41 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-soc@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
Subject: [PATCH v3 0/6] thermal: tsens: Refactoring for TSENSv2 IP
Date:   Thu, 14 Jun 2018 13:43:10 +0300
Message-Id: <cover.1528972165.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a mixed bag: Some code moves to deal with v2 of the
TSENS IP into common functions, a new qcom,tsens-v2 DT property to cover
all v2 platforms, new platform support (sdm845), a cleanup
patch and a DT change to have a common way to deal with the SROT and TM
registers despite slightly different features across the IP family and
different register offsets.

Rob, I haven't added your Ack to patch 4 because it changed a bit.

Regards,
Amit

Changes since v2:
- Based on review, moved tsens-8996.c to tsens-v2.c and changed
  corresponding function names, struct names to allow for generic tsensv2
  platforms
- All v2 platforms will now only need to use the qcom,tsen-v2 property
- Added a DT patch to initialize tsens driver on sdm845, now that 4.18-rc1
  will contain an sdm845.dtsi

Changes since v1:
- Move get_temp() from tsens-8996 to tsens-common and rename
- Change 8996 DT entry to allow init_common() to work across sdm845 and
  8996 due to different offsets


Amit Kucheria (6):
  thermal: tsens: Get rid of unused fields in structure
  dt: qcom: 8996: thermal: Move to DT initialisation
  thermal: tsens: Rename tsens-8996 to tsens-v2 for reuse
  thermal: tsens: Add support for SDM845
  thermal: tsens: Check if we have valid data before reading
  arm64: dts: sdm845: Add tsens nodes

 .../devicetree/bindings/thermal/qcom-tsens.txt     |  1 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 12 ++++++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 16 +++++++++
 drivers/thermal/qcom/Makefile                      |  2 +-
 drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c}  | 42 +++++++++++++---------
 drivers/thermal/qcom/tsens.c                       |  3 ++
 drivers/thermal/qcom/tsens.h                       |  7 ++--
 7 files changed, 61 insertions(+), 22 deletions(-)
 rename drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} (65%)

-- 
2.7.4

