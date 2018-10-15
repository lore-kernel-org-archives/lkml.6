Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F15C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75BD208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OMdbV+uc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75BD208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbeJPC1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:27:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43959 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeJPC1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:27:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id p24-v6so10111532pff.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 11:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Qiu8Dvy3vDRSEHcPlzDNP8QsXRKz7bTKvoZBD63ZTNM=;
        b=OMdbV+ucwIYZrixx6j5zsAk6BNjmMVOgtwlSY/rMQN2EkVL027+DtAnFvlSAF2Y+HZ
         fRe9VaokeU6RVznlh3swyd/QtNzjSzDojMLjVLT/AWLTXz+QrZ6MdNNmCztjlkn0fOmw
         5hES6M0K53+14zWiCt4HaOX2TCR7/ePswmKfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qiu8Dvy3vDRSEHcPlzDNP8QsXRKz7bTKvoZBD63ZTNM=;
        b=C90hd25nb7VnjJ4dAkaEtvvbHqEEamH8PTiqD2iiTTQY45o+9A6lrL51+X5vIP4Ayb
         d/DibHVA8TfQFN5AUFIhPEyr9DtrO7CS+9JjfgnGVxl0pzBJCO35IZka0gg3KuOa5aSi
         gL+VDdTcp8eOO38ZlgHHQ7fs1q2Ciirylube7jcr0WuQb0TBhDkisNd00jRNC0+NtS7n
         RJRx2EHkeQulr5JfTRKhfPdmWQbU90pyp99GTbT1lknIRtK9XuZYsyM0HHPS8jbT54lx
         S5bMLdsexUkzTBGQO2YQyXNQGXYNWB3lkwljtEYAdsNObzQ393E4P5osz4Ate9NR4MlI
         qXrw==
X-Gm-Message-State: ABuFfohv19oqcx7afsRFlypeo7w+YUmFINvxUYTvWjcSbKHGjq1JVcuV
        5c3t3oCm40FdzaQClvTXkGfvI6Sf2/M=
X-Google-Smtp-Source: ACcGV63p4jrBZzbmHjR4EhNvK5GGJY3qXOR400h6tsP/oKJOSnyHYlLfA78cELhur3wWC09Htb5Wqw==
X-Received: by 2002:a63:2807:: with SMTP id o7-v6mr16877509pgo.155.1539628849449;
        Mon, 15 Oct 2018 11:40:49 -0700 (PDT)
Received: from localhost ([49.248.168.189])
        by smtp.gmail.com with ESMTPSA id q24-v6sm19205427pfi.165.2018.10.15.11.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 11:40:48 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, andy.gross@linaro.org, vkoul@kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-soc@vger.kernel.org
Subject: [PATCH v1 0/4] thermal: tsens: Add support for QCS404 platform
Date:   Tue, 16 Oct 2018 00:10:39 +0530
Message-Id: <cover.1539627762.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Qualcomm QCS404 platform that contains v1 of the TSENS
IP. Introduce a fallback binding to handle "v1" functionality.

These patches apply on top of previous tsens-related patches sent to the
list pending merge along with various qcs404 patches under review
(available in this branch[1] for convenience).

[1] https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/log/?h=integration-linux-qcomlt

Amit Kucheria (4):
  dt: thermal: tsens: Add bindings for qcs404
  drivers: thermal: tsens: Add generic support for TSENS v1 IP
  arm64: dts: qcom: qcs404: Add tsens controller
  arm64: dts: qcom: qcs404: Add thermal zones for each sensor

 .../bindings/thermal/qcom-tsens.txt           |   3 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi          | 226 ++++++++++++++++++
 drivers/thermal/qcom/Makefile                 |   2 +-
 drivers/thermal/qcom/tsens-v1.c               | 196 +++++++++++++++
 drivers/thermal/qcom/tsens.c                  |   3 +
 drivers/thermal/qcom/tsens.h                  |   2 +-
 6 files changed, 430 insertions(+), 2 deletions(-)
 create mode 100644 drivers/thermal/qcom/tsens-v1.c

-- 
2.17.1

