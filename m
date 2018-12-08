Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37C9C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696EB20892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dmz5BwRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696EB20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbeLHFNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 00:13:18 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42451 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeLHFNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 00:13:17 -0500
Received: by mail-oi1-f196.google.com with SMTP id w13so5105477oiw.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 21:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=61Bb+nWCTjnAlYvzPgw6H01DWz5Odm+nab79rd34nOU=;
        b=dmz5BwRsh6u7gq+jHybhXvo+YcJ5jgbwLZV+IGukcUv+pw7T3lhM+yfEEO803UshUL
         BdVD2pnKlIN4HisXJ/XAauJ5PzZXUt1sZ3ufEJX2KVCSw2wyokT0oNGh5wOUm5G3V2Nv
         mJ+CZfMZ7Ma7HXtQzRNaBBvwlotoEg28hDa9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=61Bb+nWCTjnAlYvzPgw6H01DWz5Odm+nab79rd34nOU=;
        b=CoBotvyN+RUqk6PTlL4yAEX+7gSTARRQvJBfCUGk18ObCRblj4PiCWS6M70i/SnKLw
         1ccF2MqDUNGeoL7ytUXAUK3bd97Tzch24Z1DdlHQmE1axsZhsymFxLAVuxxHBIOyzyN7
         AKFvYkKZY6AD8Oofff/LXVwie5cLE2DiM7Srwtcx8s5dk0/WcfWTOGCGYyQ9Y3/Tnqim
         pdCQ7B+95SVK+6ikxi54TwEcdRXIlib+3zEnK6hU1FMlB/a4xyDfMZrmkjC/Q2oBLlGd
         y2UJILTpM36te/jNuOCOnDhVZDSGmmw/gvahTBMN534v31PjZS7Yj525PV7OQ/92tfbK
         hvZg==
X-Gm-Message-State: AA+aEWbaD/ttz995LsHSuERfSlo/IujLql11QwI8kLG0L4yV0xy7xH7J
        lcZDOS0TllYwg8cejOvcAijVwA==
X-Google-Smtp-Source: AFSGD/W8SgYgQt47bWwnFgxF3zzSaNHoY5GaW1YYvP4qrpTR7Jx8oE2G3BmDR23dw+NmvfE+CSJ1mA==
X-Received: by 2002:aca:36d5:: with SMTP id d204mr2980601oia.234.1544245996434;
        Fri, 07 Dec 2018 21:13:16 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:1524:ebd:d530:a61b])
        by smtp.gmail.com with ESMTPSA id r9sm3143749otq.81.2018.12.07.21.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 21:13:15 -0800 (PST)
From:   Andy Gross <andy.gross@linaro.org>
To:     arm@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Olof Johansson <olof@lixom.net>
Subject: [GIT PULL] Qualcomm ARM64 DT updates for 4.21 - Part 2
Date:   Fri,  7 Dec 2018 23:13:13 -0600
Message-Id: <1544245994-4228-1-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 70827d9f6bc4f481fafe790dd6654ba568526768:

  arm64: dts: qcom: msm8998: Fix compatible of scm node (2018-11-30 07:59:02 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.21-2

for you to fetch changes up to 1504b91c819359b574b55c269c850352260b8d19:

  arm64: dts: msm8996: Use dwc3-qcom glue driver for USB (2018-12-07 14:10:56 -0600)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.21 Part 2

* Switch to use dwc3-qcom glue driver on MSM8996
* Fix issue with xo clk name on MSM8998
* Add cooling maps on MSM8916
* Add UART nodes on SDM845
* Add camera subsystem support on MSM8996 and MSM8916

----------------------------------------------------------------
Andy Gross (1):
      arm64: dts: qcom: msm8998: Fixup clock to use xo_board

Manu Gautam (1):
      arm64: dts: msm8996: Use dwc3-qcom glue driver for USB

Matthias Kaehlcke (1):
      arm64: dts: qcom: sdm845: Add UART nodes

Todor Tomov (6):
      arm64: dts: qcom: msm8916: Add IOMMU sub-node for VFE context bank
      arm64: dts: qcom: msm8916: Add CAMSS support
      arm64: dts: qcom: Add Camera Control Interface pinctrls
      arm64: dts: qcom: Add pinctrls for camera sensors
      arm64: dts: qcom: msm8996: Add VFE SMMU node
      arm64: dts: qcom: msm8996: Add CAMSS support

Viresh Kumar (1):
      arm64: dts: msm8916: Add all CPUs in cooling maps

 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi |   6 +-
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi   |  76 ++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi        |  97 +++++++++-
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi   | 120 ++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi        | 162 +++++++++++++++-
 arch/arm64/boot/dts/qcom/msm8998.dtsi        |   3 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi         | 270 +++++++++++++++++++++++++++
 7 files changed, 725 insertions(+), 9 deletions(-)
