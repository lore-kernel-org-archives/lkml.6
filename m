Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 519CBC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079992086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IwQn0X/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079992086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754314AbeFLKz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:55:27 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42413 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752705AbeFLKzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:55:24 -0400
Received: by mail-lf0-f67.google.com with SMTP id v135-v6so35288356lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fzBlCrJ6jeGfX+l3042a5feqkgUj0LvDkEEkOYZ6UKs=;
        b=IwQn0X/VnpS752Ed7tbdQHkRuAp1uYmuwUUaIBbyvFAbgq7lKE+mlSUu/tRyLpJi+S
         Qflf4SEqtjCjaVBX6yL56OqA3LTPpCaX1EYsz8dYjFt2N+/p5rw9kdz3+mXIye58x4b0
         xf8U8c8Gbx8weNgYREh38LgarUg56JoaFBdGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fzBlCrJ6jeGfX+l3042a5feqkgUj0LvDkEEkOYZ6UKs=;
        b=EYBigj/mAuBFZzy89Ss1r4iuQO7jfhnXNo37P5lpn6Io5T7LFts9IglZwqJHbfRPH3
         ug+/h2xo0S+F4Utv6IDen0kyHVslCYcWqpEx3ppSadhuyrwInMk7y6AGhPc5XO1IK2xW
         D+i8+nPFHqbCT8vtgsVjTB1c447UXyEkWveh47ICdEmcGYetozGZu0VOHeIJ7vJrYZ+t
         EERoB15isX7niSEJEcdbk644OquWb7LV6Kqzy7kofRvTZ9NdWSwTff7NhIUldfyuGn/L
         2E8vdyvLjMsmie8MfPYGqi4Ci5IdkA9X3AKpAcmb5XeBR9/6P6PPnGGAPs1DUy3KEsaM
         BpPQ==
X-Gm-Message-State: APt69E3NDB4xW7C8VgzpKDzdC9coi+BapVPkRQ06xRoFfIoXjR3aJwsc
        mHqFqpcs0MJ7CVrxhSkrC7/fym9wvU4=
X-Google-Smtp-Source: ADUXVKIF7Dz/ElVHISu/w+S+b/U1L49lgwZOFHCO63XkUN4r6rVtKC/S1zj8BBapeeNZZOpQ1iHKfA==
X-Received: by 2002:a19:f71a:: with SMTP id z26-v6mr1747999lfe.137.1528800922743;
        Tue, 12 Jun 2018 03:55:22 -0700 (PDT)
Received: from localhost (85-76-96-64-nat.elisa-mobile.fi. [85.76.96.64])
        by smtp.gmail.com with ESMTPSA id i21-v6sm144516lfa.18.2018.06.12.03.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 03:55:21 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-soc@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
Subject: [PATCH v2 0/5] thermal: tsens: Prepare for version 2 of TSENS IP
Date:   Tue, 12 Jun 2018 13:54:52 +0300
Message-Id: <cover.1528799892.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a mixed bag: Some code moves to deal with version 2 of the
TSENS IP in common functions, new platform support (sdm845), a cleanup
patch and a DT change to have a common way to deal with the SROT and TM
registers despite slightly different features across the IP family and
different register offsets.

I can merge the tsens-8996.c and tsens-sdm845.c files into a tsens-v2.c if
desired.

Changes since v1:
- Move get_temp() from tsens-8996 to tsens-common and rename
- Change 8996 DT entry to allow init_common() to work across sdm845 and
  8996 due to different offsets

Amit Kucheria (5):
  thermal: tsens: Get rid of unused fields in structure
  dt: qcom: 8996: thermal: Move to DT initialisation
  thermal: tsens: Move 8996 get_temp() to common code for reuse
  thermal: tsens: Add support for SDM845
  thermal: tsens: Check if we have valid data before reading

 .../devicetree/bindings/thermal/qcom-tsens.txt     |  1 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 12 +++-
 drivers/thermal/qcom/Makefile                      |  2 +-
 drivers/thermal/qcom/tsens-8996.c                  | 74 +-------------------
 drivers/thermal/qcom/tsens-common.c                | 78 +++++++++++++++++++---
 drivers/thermal/qcom/tsens-sdm845.c                | 15 +++++
 drivers/thermal/qcom/tsens.c                       |  3 +
 drivers/thermal/qcom/tsens.h                       |  8 ++-
 8 files changed, 107 insertions(+), 86 deletions(-)
 create mode 100644 drivers/thermal/qcom/tsens-sdm845.c

-- 
2.7.4

