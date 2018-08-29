Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF974C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690382086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tgi+QZto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690382086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeH2LxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:53:06 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46086 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeH2LxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:53:06 -0400
Received: by mail-lf1-f66.google.com with SMTP id e23-v6so3498507lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xyWbqbCE4wZxaLiMxysHaZI/IEJUTJxkdFci776hUZs=;
        b=Tgi+QZtoyNhJOQ14JPfDpqvUadSkcmNJ8NX7vZAFgCnZxYVROWT7x9pMN0DXJpN9Hx
         eMTj0ckS3JG65wdD1b+MytZpIIOW0oZNhTiyDPwV50S0ng/F4cYMfRZQys0dxr+3BtvM
         XN8A2b1mL+hcgU7DVueOWIpTY2snbcjqq+Zlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xyWbqbCE4wZxaLiMxysHaZI/IEJUTJxkdFci776hUZs=;
        b=E7K3E8s9BouV/flCP2JgarjHV2p3tfs/jRH7NEzgyNfF//U4LHd3OpkkYYv2fPpWWx
         vbxopKaS1bBlzXPMt9yfIIzrQSGjOB/N/lIlB4EqkrZ4bNoFx9qR8LZIDb+lehXOZmjN
         PS1fHvV3A9DLALUrang0etZpV0eTAhOe+UvMBgzTOBQt9+BBrryZQ+Qq2Elh6YaLUR84
         UcXn2CLbI4SJgvm4mobsjeO6eKaRGUzofkDzd0RX8ek4QHgaBzuz1Tp7Y9c0qRhQXoXw
         5W8pp03rkNDCLnnlS+bhlg3Evc2MgsfXb2jtJB6Es7VZkw9hPimlPq/sP6n2NRSZ8Xr1
         +wJA==
X-Gm-Message-State: APzg51DdbtIMbhd0bZGWg3blflT5qMrB8UllZBZRPe0PqaBepbxUp++S
        5zMpx5L55Qu9Gvr5EC3/ynAmuw==
X-Google-Smtp-Source: ANB0VdaI37cMu7QYQqBPRt0HshL7Mvi0Bgkm+dMzt9GA2FGa/YcPXTMAZ7ETzWtAZDd0OIJ2e07Kfw==
X-Received: by 2002:a19:b585:: with SMTP id g5-v6mr3367353lfk.149.1535529447567;
        Wed, 29 Aug 2018 00:57:27 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id u19-v6sm596232lje.51.2018.08.29.00.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 00:57:26 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/9] soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs
Date:   Wed, 29 Aug 2018 09:57:14 +0200
Message-Id: <20180829075724.9095-1-niklas.cassel@linaro.org>
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


Changes since v5:
-kbuild test robot now uses gcc 8, so it found some new  warnings
 with -Wstringop-truncation, created 2 new patches for this.
-Removed depends on OF from QCOM_RPMH, new patch.

Niklas Cassel (9):
  soc: qcom: smem: Add missing include of sizes.h
  soc: qcom: llcc-slice: Add missing include of sizes.h
  soc: qcom: smp2p: Add select IRQ_DOMAIN
  soc: qcom: smsm: Add select IRQ_DOMAIN
  soc: qcom: Remove bogus depends on OF from QCOM_SMD_RPM
  soc: qcom: Remove depends on OF from QCOM_RPMH
  soc: qcom: wcnss_ctrl: Avoid string overflow
  soc: qcom: apr: Avoid string overflow
  soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs

 drivers/soc/qcom/Kconfig      | 21 ++++++++++++---------
 drivers/soc/qcom/apr.c        |  4 ++--
 drivers/soc/qcom/llcc-slice.c |  1 +
 drivers/soc/qcom/smem.c       |  1 +
 drivers/soc/qcom/wcnss_ctrl.c |  2 +-
 5 files changed, 17 insertions(+), 12 deletions(-)

-- 
2.17.1

