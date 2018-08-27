Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D40C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54257208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HA5LBrO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54257208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeH0PWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:22:47 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46429 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeH0PWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:22:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id e23-v6so11621718lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 04:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AX+2V9AS14/HHimR45LXoxsjtY/2MNCdPjIB+6ws+Rc=;
        b=HA5LBrO0qLVVFWTCxMHYqWHUXo8w3ocHot4LM/Yilz99Rl8gPHishVvwNhsZX/i/pK
         9GAYmiUnNk5UIj8Muz3joC8snvGrJw0cAO5QoNLYY5PBjpxDn0Ok0Zuj7BiiJRmkD/4n
         0dB6/bcl8grDphx+dprB9Zeo7DiQl84Wd5YMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AX+2V9AS14/HHimR45LXoxsjtY/2MNCdPjIB+6ws+Rc=;
        b=PcoeA8VRHalspKDkXK/w/To1PUDnp2ZedfzvQBislSyUKOlk4b+vtphOxX/iQSu7a0
         c8szzFWXAflebIvYdyGUP8bt32UmSY9FbMpstFkDZAhRzjk8M1+myHvpiroIda+mBOVw
         IiXJtGVIkY6F0It3xwGcfJf8t9IUIf83oyerGPDRFL/FDmDAzwZT7otaSrcwq/NsWDb1
         u6y5bMz7z3QipAiP9rft4LKdWTCDPQ+vsJphxiTkQxraW50PmsNAllVmJJW49cwevUWn
         wnitXCdOA2uz8gtxe6ccY5QxUUMMkQFX4iC3llKhUnUYtI4hMHiwqMEP4qACskYIW6U3
         2G5w==
X-Gm-Message-State: APzg51C97z12DaUPADUXMxIHsaYygCYm+g7Hxf2fH3JnU5IPh0G/qjla
        zxdrL6VlaNEo0HNi+76SFtee/Q==
X-Google-Smtp-Source: ANB0VdaBZtBnrOXmX1Kg53EH7RWQXcWTgoqM56sGXXF95GjJ2Sypv85xnnTa/V9iDDGkwCijXQEm/g==
X-Received: by 2002:a19:c646:: with SMTP id w67-v6mr8589211lff.108.1535369787359;
        Mon, 27 Aug 2018 04:36:27 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id z15-v6sm2737503lji.58.2018.08.27.04.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 04:36:26 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/6] soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs
Date:   Mon, 27 Aug 2018 13:35:58 +0200
Message-Id: <20180827113605.9594-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit cab673583d96 ("soc: Unconditionally include qcom Makefile"),
we unconditionally include the soc/qcom/Makefile.

This opens up the possibility to compile test the code even when
building for other architectures.

This patch series prepares and enables all but two Kconfigs to be
compile tested even when building for other architectures.


Changes since v3:
-Picked up Vinod's Reviewed-by tags.
-Rebased against v4.19-rc1

Niklas Cassel (6):
  soc: qcom: smem: Add missing include of sizes.h
  soc: qcom: llcc-slice: Add missing include of sizes.h
  soc: qcom: smp2p: Add select IRQ_DOMAIN
  soc: qcom: smsm: Add select IRQ_DOMAIN
  soc: qcom: Remove bogus depends on OF from QCOM_SMD_RPM
  soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs

 drivers/soc/qcom/Kconfig      | 19 +++++++++++--------
 drivers/soc/qcom/llcc-slice.c |  1 +
 drivers/soc/qcom/smem.c       |  1 +
 3 files changed, 13 insertions(+), 8 deletions(-)

-- 
2.17.1

