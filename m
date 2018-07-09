Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC9AC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E2020882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VgwgJ0F2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E2020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932699AbeGILnz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:43:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39044 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932628AbeGILnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:43:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id h10-v6so10630636wre.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=crBqCViCC9Ovqe5xgzjvxQQEKBx/gq2s7nPuxA1sHTE=;
        b=VgwgJ0F2recJVuvbfU2A5z7sE1ytwUe5FjGrwlRbZJR22j9mZ/b8eA5hQ6ghe3I+0P
         MVKM4M5WhfbV5C+UdC7PPH2f/7hoL2BhbHiCVoR40kn8ICccylxAdsP0L+MBJ3INNbz9
         Pg6iSxNtOI63Of3p9iPm8GXkHWGzRamSFCs9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=crBqCViCC9Ovqe5xgzjvxQQEKBx/gq2s7nPuxA1sHTE=;
        b=O782rAsfrEr9VAOcML5Dw6Fl0j5WeOG4JBZF6b3GJK6Ut7kSBvAK5qpgM25QGTUVrW
         Sn0Q5k6+gN7pXFaKcNMmzhotCxNxUkegIe2T35Vb8Z1ztX2kiZ1sRR+TTNoxLHzNAe54
         7kX98FKPY34VStUOO1VFfsdtH2ZK15pjLpdiXlTkf1hLObrhnHXDJ+I91M/0Y1FHsAQm
         fjR2J8cL2yT2tc6tfwyVeISxVCs3vevYro7Y1x4Mc1Lo3mr0a+vMZP1zph7BUP1DNr6O
         YXciBf660k6+zD/cjFrn5GtIowCJ6B9qvPHNZErAOhwdjcRbpmglVxwQRh8nsGOCoKKk
         Nhcw==
X-Gm-Message-State: APt69E2iq1gphevfqbrrUS5ISeT6tNk7KLjKrFr1tpkGt+5zm0nuoZIz
        g/kmtjYudoPwDe5N5Mjk+KFWkaavMM8=
X-Google-Smtp-Source: AAOMgpcCtdkizcm9NCiS6KrqAzNQ4JHTXGWwhnCG8Oi5e9Mmgd8DZdg57DREloKyLAcCvXmLrWI68w==
X-Received: by 2002:adf:a9f0:: with SMTP id b103-v6mr13922506wrd.271.1531136632159;
        Mon, 09 Jul 2018 04:43:52 -0700 (PDT)
Received: from localhost ([49.248.189.240])
        by smtp.gmail.com with ESMTPSA id z62-v6sm12708477wmc.10.2018.07.09.04.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 04:43:51 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-soc@vger.kernel.org
Subject: [PATCH v6 0/7] thermal: tsens: Refactoring for TSENSv2 IP
Date:   Mon,  9 Jul 2018 17:13:22 +0530
Message-Id: <cover.1531135999.git.amit.kucheria@linaro.org>
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
