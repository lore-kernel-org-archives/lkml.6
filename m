Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF7EC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A931A22448
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjelmCo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A931A22448
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeHJUYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:24:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40177 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbeHJUYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:24:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id e13-v6so4862714pff.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eOKITYYyBKfjvWxhtw3mxaz+PtO2bGe2d00HA3KA3ao=;
        b=EjelmCo8ZIVMTVReQ/Ejg4N1LEMlYuDGqlP37R4FYmLyhvw/gg3T1aQZsNU6uWYiEB
         kX7Phny4TWdtiQpzcwF5ikUrLjeoaGecrzI34fc2kSxzL10LmGXEct6dwp+OlAwo2ahY
         nidXRxszAFe22hmohRT468uluEyIrg2v67Juk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eOKITYYyBKfjvWxhtw3mxaz+PtO2bGe2d00HA3KA3ao=;
        b=VPkY3e9McprW13EoGg6UvumNCTJUer5gSbFe2b6m50n7Ol9aG+N5xTyxWWZ3BJqs8Q
         ahpFHtVejwQOqIbK5wWovpq0FwQisakTMVskBPbFQ8L70Jg/a6/U4B1Yy2deFWqA2tsl
         +qQn30+mn1H9dI59ce41jDJJx8ShYkSw4dEc7rOVfJopJm6LPwYmtqEbIkBxj+TzMqrE
         x7aGinjr/rRXoRu5189WgqP+1JWDN/8p0w/sw5DgEIY5mENS8IertYuop2tFKZGgTvz6
         Eomnz9gvRLdFNTSHX03Mi8VcahzWqpJqxS+rVwYQWO4X7ZEXAiy+LL21l/7dRKTOQMja
         btIA==
X-Gm-Message-State: AOUpUlFYOfAymlC0J6ssWhKHdfkJ9lJj+nCZLwErSb0evgDsbD/Xw4c8
        o5jXNY6z4znTcvy6RBnI2xwl
X-Google-Smtp-Source: AA+uWPztGs1Uv0OXZ9h4ZQ5K3L0S8YB8LWAUUwPdmOge/BQt0pZyT1Y7FNuqZ/yKhSMITc28rFBgAg==
X-Received: by 2002:a63:b256:: with SMTP id t22-v6mr7536257pgo.101.1533923639040;
        Fri, 10 Aug 2018 10:53:59 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6391:e983:9562:f5f7:1a60:4363])
        by smtp.gmail.com with ESMTPSA id l127-v6sm16981262pfc.55.2018.08.10.10.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 10:53:58 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     xuwei5@hisilicon.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
        guodong.xu@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/4] Add HiSilicon Hi3670 SoC and HiKey970 board
Date:   Fri, 10 Aug 2018 23:23:35 +0530
Message-Id: <20180810175339.25421-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for Hi3670 SoC and HiKey970 board. Hi3670 SoC
is very similar to the Hi3660 SoC with additional NPU support. For now,
only UART6 has been enabled which is configured by the bootloader for
console support.

HiKey970 board is one of the 96Boards Consumer Edition and AI platform
based on the Hi3670 SoC.

With this patchset, the Hikey970 board is able to boot into ramdisk with
8 cores.

Thanks,
Mani

Manivannan Sadhasivam (4):
  dt-bindings: arm: hisilicon: Add binding for Hi3670 SoC
  arm64: dts: Add devicetree for Hisilicon Hi3670 SoC
  dt-bindings: arm: hisilicon: Add binding for HiKey970 board
  arm64: dts: Add devicetree support for HiKey970 board

 .../bindings/arm/hisilicon/hisilicon.txt      |   8 +
 arch/arm64/boot/dts/hisilicon/Makefile        |   1 +
 .../boot/dts/hisilicon/hi3670-hikey970.dts    |  35 ++++
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     | 162 ++++++++++++++++++
 4 files changed, 206 insertions(+)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi3670.dtsi

-- 
2.17.1

