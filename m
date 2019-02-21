Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54BAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6262086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qhzt7MEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfBUGoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 01:44:13 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45230 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfBUGoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 01:44:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so13282300pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 22:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ucUtegZe1upQP242hoTwearYM1VQXiCgWhdPoc8C/vc=;
        b=qhzt7MEdol/MHYLShxFU+XiT/avTjv6M5Cc4ZwCpkShi8C8NNM/hTzs/ssCmE2asHr
         AXuL4BD/yueLNf9bhj3hbbZeBXsP65CMXveg8P3qc+FGp6leUs9/eJTWrQC9YCtU/Yw/
         07MKFnX/Y1EmB0ZXYynh4T27ZD2ypeKbgLC5/Nnw4LK412YwN9G2UYZpziQMRLDHhh7y
         7mI3WlDwR7ggLOkyI9Ndf5nXJ6cmd4F/nySVBodn3pWsVWplVolBWuLmvGup9EbzIsNX
         nHzYEq+088acvw+u5MUE2urWWvAUWuEy/vSQ7ZSDciGtd5bfrWDlervtA9SvZra0pjk8
         7mjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ucUtegZe1upQP242hoTwearYM1VQXiCgWhdPoc8C/vc=;
        b=MJ2FOY/fnw8W1e0XmfA9brt2ZFgtoms29ujbTasxtSkG4DxyDUaLoW5+ea40QZMATP
         h5DK2ZwdYdKxd/1e1PKimp9yWcKun1FuBSAH6n6mYilJq4t6dOV6VcruHESL9JUVy4Aa
         Fa/66/djXuNIanNRq6bneEKdKvPUujhYwBgvO+cuo6MrOvBxSu6ylp4QNwgpvhiC3P+L
         jhFDYQAAB2T4cxs36ZRqbLDNugkC+ehZHiqTm2WoIyr0WNS9BHdARdB/xDuV4BF4nYMx
         c0aoim0dovJ37o2Z7LIAVFgUe1GNWXp3W+qe1vTc8koFGrNjYGlVFaeRxojNaOJmBzfc
         v+nQ==
X-Gm-Message-State: AHQUAuZg5Wv8fmdF85xYrzotdcrn2Jdif92/UrPxy9tjXMV/5iz1axlt
        tY22mkL1o5rFfvGoYDmYn08VnA==
X-Google-Smtp-Source: AHgI3IaBIn/hcORf6p6deQhBPw7pET44D7A5ndzRUx91ed321cdRlLTBb04R8XLg/YuoAONNJMtQtA==
X-Received: by 2002:a62:1212:: with SMTP id a18mr38713554pfj.177.1550731452049;
        Wed, 20 Feb 2019 22:44:12 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b4sm22777892pgq.57.2019.02.20.22.44.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 22:44:10 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] RPMPD for QCS404
Date:   Wed, 20 Feb 2019 22:44:31 -0800
Message-Id: <20190221064434.2760-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reworkd the macros of the rpmpd driver and add qcs404 power domains, then add
this to the dts.

Bjorn Andersson (3):
  soc: qcom: rpmpd: Modify corner defining macros
  soc: qcom: rpmpd: Add QCS404 corners
  arm64: dts: qcom: qcs404: Add rpmpd node

 .../devicetree/bindings/power/qcom,rpmpd.txt  |  1 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi          | 35 +++++++++++
 drivers/soc/qcom/rpmpd.c                      | 63 +++++++++++++------
 include/dt-bindings/power/qcom-rpmpd.h        |  9 +++
 4 files changed, 88 insertions(+), 20 deletions(-)

-- 
2.18.0

