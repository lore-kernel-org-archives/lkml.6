Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E29C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 18:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9B6208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 18:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+FVXGuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9B6208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbeJABMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 21:12:16 -0400
Received: from mail-yb1-f172.google.com ([209.85.219.172]:41850 "EHLO
        mail-yb1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbeJABMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 21:12:13 -0400
Received: by mail-yb1-f172.google.com with SMTP id d14-v6so4720802ybs.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 11:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mptzzC+JqCU2pB6tbylDrqyliO2z0rVwC0/F0Nr/0T4=;
        b=j+FVXGuQYDpEqK8MGsoY96hTrDV2i6GdRYM5TI/hc7o+xbKsk8yiJZMmpio9IyEOfx
         8sqy6ocCTup1XUuQINPxc6waAoGmY3FX2rClVd7MW422jiToJL34x7C8H0zOgBxFPmQy
         PmyyfoDmQrGd1S7xsjLUjVGwD9k6F4QMX7Wo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mptzzC+JqCU2pB6tbylDrqyliO2z0rVwC0/F0Nr/0T4=;
        b=HyoBDPwDodHd98wqeEqkZxTRdYiV5LsY22mtJNqGVktAsqjXI+Br6TAQRx6kJqEi93
         PmaU9CYKdqEYc1aP51wLJrnfiDUC+AaMIxyEY+ZeB7kGqEQECXVUrFzf5pPVH5fi6hiE
         5yIHOtyGJuJ+lsBbADnKtQkOegFoMheka5Pfq2xjzJeFOiqsaEYZgjU+jucbhPyVB5Je
         uD8EGWCisrtZUzpsynl6QnJnGgXERsoz4n5AwtsgLNKg6lutkvoEAzj1lkekhsv6sOLT
         w4DMm50lMeCD4wJEthQNcCpajqz5l4rxdEGvN7I4dwShPzfxg829Fa4oYTivno7I4qtV
         YWyQ==
X-Gm-Message-State: ABuFfogYs28ZJcaOolJex3a6+QbhcfhQq0iHY5FqvePH4uuEPS5w36Ok
        Ce82R89WcqXSeWWA9XsQ9PWt9Q==
X-Google-Smtp-Source: ACcGV62v+LSZ6F7559VIXVvc6vnxGB4JesoQFpPxcAtLmNRarm4Ew2JOqpUHdzgRDIiBtSFzYduw2w==
X-Received: by 2002:a25:29c5:: with SMTP id p188-v6mr4171276ybp.368.1538332686072;
        Sun, 30 Sep 2018 11:38:06 -0700 (PDT)
Received: from localhost ([2600:1700:141:4960:b19b:8662:2992:bdd8])
        by smtp.gmail.com with ESMTPSA id g81-v6sm4573931ywe.109.2018.09.30.11.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 11:38:05 -0700 (PDT)
From:   Andy Gross <andy.gross@linaro.org>
To:     arm@kernel.org
Cc:     Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [GIT PULL] Qualcomm ARM64 DT updates for 4.20
Date:   Sun, 30 Sep 2018 13:37:59 -0500
Message-Id: <1538332682-12018-2-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538332682-12018-1-git-send-email-andy.gross@linaro.org>
References: <1538332682-12018-1-git-send-email-andy.gross@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.20

for you to fetch changes up to 6db0483cf622fc690e32e0804f8b86061f13962a:

  Revert "dt-bindings: thermal: qcom-spmi-temp-alarm: Fix documentation of 'reg'" (2018-09-30 12:59:52 -0500)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.20

* Update Coresight for MSM8916
* Switch to use mailbox for smp2p and smd on MSM8996
* Add dispcc, dsp, USB, regulator, and other nodes for SDM845
* Drop model/compatible from MSM8916 and MSM8996
* Add compat for db820c
* Add MSM8998 SoC and board support along with associated nodes
* Add RESIN/PON for Qualcomm PM8916 and PM8994

----------------------------------------------------------------
Andy Gross (2):
      Revert "dt-bindings: iio: vadc: Fix documentation of 'reg'"
      Revert "dt-bindings: thermal: qcom-spmi-temp-alarm: Fix documentation of 'reg'"

Bjorn Andersson (10):
      arm64: dts: qcom: msm8998: Add RPM and regulators for MTP
      arm64: dts: qcom: msm8998: Add tsens and thermal-zones
      arm64: dts: qcom: msm8998: Add pmi8998 file
      arm64: dts: qcom: msm8998: Add smem related nodes
      arm64: dts: qcom: msm8998: Add firmware node
      arm64: dts: qcom: msm8998: Add the qfprom node
      arm64: dts: qcom: msm8998: Add smp2p nodes
      arm64: dts: qcom: Populate pm8998 with additional nodes
      arm64: dts: qcom: sdm845: Add adsp, cdsp and slpi smp2p
      arm64: dts: msm8996: Transition smp2p and smd to mailbox

Douglas Anderson (2):
      arm64: dts: qcom: sdm845-mtp: Add RPMh VRM/XOB regulators
      arm64: dts: qcom: sdm845-mtp: Add nodes for USB

Joonwoo Park (1):
      arm64: dts: Add msm8998 SoC and MTP board support

Manu Gautam (1):
      arm64: dts: qcom: sdm845: Add USB-related nodes

Matthias Kaehlcke (6):
      dt-bindings: iio: vadc: Fix documentation of 'reg'
      arm64: dts: qcom: pm8998: Add adc node
      arm64: dts: sdm845: Add dispcc node
      dt-bindings: thermal: qcom-spmi-temp-alarm: Fix documentation of 'reg'
      arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
      arm64: dts: qcom: pm8998: Add pm8998 thermal zone

Niklas Cassel (3):
      arm64: dts: db820c: Add qcom,apq8096 to compatible string
      arm64: dts: msm8916: Drop model and compatible
      arm64: dts: msm8996: Drop model

Sibi Sankar (1):
      arm64: dts: qcom: Add AOSS reset driver node for SDM845

Suzuki K Poulose (1):
      arm64: dts: msm8916: Update coresight bindings for hardware ports

Vinod Koul (4):
      arm64: dts: qcom: pm8916: Add PON node
      arm64: dts: qcom: pm8994: Add PON node
      arm64: dts: qcom: apq8016-sbc: Add resin node
      arm64: dts: qcom: apq8096-db820c: Add resin node

 arch/arm64/boot/dts/qcom/Makefile            |   1 +
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi    |  14 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts  |   2 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi |  14 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi        |  98 ++--
 arch/arm64/boot/dts/qcom/msm8996.dtsi        |  15 +-
 arch/arm64/boot/dts/qcom/msm8998-mtp.dts     |  13 +
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi    | 243 ++++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi        | 690 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8916.dtsi         |  18 +-
 arch/arm64/boot/dts/qcom/pm8994.dtsi         |  18 +
 arch/arm64/boot/dts/qcom/pm8998.dtsi         |  75 ++-
 arch/arm64/boot/dts/qcom/pmi8998.dtsi        |  40 ++
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts      | 382 +++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi         | 300 ++++++++++++
 15 files changed, 1858 insertions(+), 65 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pmi8998.dtsi
