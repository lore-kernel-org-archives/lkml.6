Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECEEC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4816A25D57
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4xqT7sz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4816A25D57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbeGBMq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:46:59 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38856 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752873AbeGBMo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:44:29 -0400
Received: by mail-pl0-f67.google.com with SMTP id d10-v6so7911102plo.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 05:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=D291gaejtIl2creVuc3NXahXRTkldLGc9ZtgwAjGAws=;
        b=U4xqT7sz8/i00vW7ZN9zV4C4AFfKw9d4xKlp1kXcQ5i+GAr58QKuQ8P+0zo+TbHZeQ
         bQtu6xu4HrhRLPjEndKv2Qm6ojQM+SZkfYFO4DtbLeCR3hFVnYcMSwP3WrAQIgahXeOq
         7Kl3vubrdN6yGE2NYlvarV1MIHEChH83xZFBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D291gaejtIl2creVuc3NXahXRTkldLGc9ZtgwAjGAws=;
        b=bsMEAJkBRT1ncxyPpg3MkdGeIo3RXM4wQK/G2eh65rYbIDNFIfYrLqOVsBT/YecFUk
         fEhi0qT8i57UIDeYgb49ZdjycsdJ292Svz/IXx/736wV5IKh0FW+YgGp7J6OfAtv98ju
         aE8XAdhqerhzaXcpRcMudp1lWpXZy4ouN9dHQDbiuyHRjsVuDuGZhczAatNyYCCzXZLE
         TfQizgA4GjWXf+qduX1vvMMivXDqk0hayXnPw/P671qj7fxp3Rebt4QmVbXATmr8vHeU
         wRYsdv9mrjG+j7fYE74JejCnBCbZfADFRsPfiavtLCBcIMBe07b/AvUnzzQe5TRbN00s
         rh+g==
X-Gm-Message-State: APt69E0iYE3nLfnA6BVSsC8Ni+irZgEfO/ozwJS3BDuJfHWnns/PWgOl
        0vPbbbN2+bJ52KZD6aLijgs7R7hYr0o=
X-Google-Smtp-Source: ADUXVKLeVLItPQEexUyDRfX5goXCtbBGJIgadJzu0dtdNSyyfKy5Tt2KeAJwTCacaYnxirN22lsSmA==
X-Received: by 2002:a17:902:9344:: with SMTP id g4-v6mr25810646plp.10.1530535468244;
        Mon, 02 Jul 2018 05:44:28 -0700 (PDT)
Received: from localhost ([49.248.63.129])
        by smtp.gmail.com with ESMTPSA id n6-v6sm52782591pfk.36.2018.07.02.05.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 05:44:27 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-soc@vger.kernel.org
Subject: [PATCH v4 0/6] thermal: tsens: Refactoring for TSENSv2 IP
Date:   Mon,  2 Jul 2018 18:14:03 +0530
Message-Id: <cover.1530533998.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a mixed bag:
- Some code moves to allow code sharing between various v2.x.y versions of
  the TSENS IP,
- new qcom,tsens-v2.4.0 DT property for SDM845 and a generic qcom,tsens-v2
  property as a fallback compatible for all v2.x.y platforms,
- new platform support (sdm845)
- a cleanup patch and
- a DT change to have a common way to deal with the SROT and TM registers
  despite slightly different features across the IP family and different
  register offsets.

Rob mentioned offline that we should expose the full version string of the
TSENS IP (x.y.z) and have a fallback compatible. I hope patch 4 does what
you were looking for.

Regards,
Amit

Amit Kucheria (6):
  thermal: tsens: Get rid of unused fields in structure
  dt: qcom: 8996: thermal: Move to DT initialisation
  thermal: tsens: Rename tsens-8996 to tsens-v2 for reuse
  thermal: tsens: Add support for SDM845
  thermal: tsens: Check if we have valid data before reading
  arm64: dts: sdm845: Add tsens nodes

 .../devicetree/bindings/thermal/qcom-tsens.txt     |  2 ++
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 12 ++++++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 16 +++++++++
 drivers/thermal/qcom/Makefile                      |  2 +-
 drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c}  | 39 ++++++++++++----------
 drivers/thermal/qcom/tsens.c                       |  6 ++++
 drivers/thermal/qcom/tsens.h                       |  7 ++--
 7 files changed, 62 insertions(+), 22 deletions(-)
 rename drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} (66%)

-- 
2.7.4

