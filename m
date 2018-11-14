Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B68C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B0822419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ynq4OZFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B0822419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732187AbeKNTDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:03:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36086 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbeKNTC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:02:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id z13-v6so16345148wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 01:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZOwBQshcAUV9PVEubJRR0swJTsYLQ7NnXoIXsmWc1ME=;
        b=Ynq4OZFFUalIB2oPEQzAV3xGL71KB6yOHuyQwYRLGoDd3zWuE7JpgAuM7q52u9DYZv
         NlQurGIk3A2wf3DVs+AauYZbjjY8p0UEBYOs0PcCkxMNHJrWx81395llk210wRKklAFe
         P9leC0jIQgnV3v/RZS98bZG/+GKbtxVqktWGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZOwBQshcAUV9PVEubJRR0swJTsYLQ7NnXoIXsmWc1ME=;
        b=F0BYVReFNvU/cJVnfCm5jjQUa9cR1aDMDKVH/7LnJmCTUzsffzSae4h8BvOxOHAyo0
         O88awnDKVt8zlR1GQ4OXl/W2aQtblY0+ibly+mqyoeS1j4KVn3zGVAAIPois7jAityNs
         hDwS3bXBf/y+Wf0vbPZK7/Blhf8DmBnRy09rlbDE+mf8VXjk1UOZXSyl+BkGTPDHu8q/
         zkjqZBVA+3F/NQmViecMArwulLXOMemI4NEG7QTTbwINFQCKNrKxYgjVkaa0qir1TDR3
         10228TXsHwgmurYqJpnMb2k4NFFq+76Wyh5GlNV1m2+jYQ2lBpxKNlebhpWhFzcbUDFf
         u67g==
X-Gm-Message-State: AGRZ1gIHPOn48g2Jf6cLzf0PAfiM82iFvPcbvWGR4sT5OCdV2xKIdA42
        FAjHJHCNxGi6gPRhhiTCQnDQ3w==
X-Google-Smtp-Source: AJdET5ecglP5umyBoBVddR0y/cyBqdZBGUb34cNKQAHsYbvxh3EUUbQAZDO2zTjl7QPiqK2iGrTPDQ==
X-Received: by 2002:adf:b181:: with SMTP id q1-v6mr990973wra.95.1542186038727;
        Wed, 14 Nov 2018 01:00:38 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1088:2b4c:4d39:8b22:d570:822a])
        by smtp.gmail.com with ESMTPSA id n7-v6sm16951441wrt.60.2018.11.14.01.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 01:00:38 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH v4 0/4] Add support of STM32 hwspinlock
Date:   Wed, 14 Nov 2018 10:00:23 +0100
Message-Id: <20181114090027.7580-1-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie adds the support of the hardware semaphore block for stm32mp1 SoC.

version 4:
- add Linaro SoB

version 3:
- fix clock name in properties description.
- use postcore_initcall() instead of module_platform_driver()

version 2:
- fix comments done by Bjorn about clock naming, license terms in header,
  alphabetic ordering in Makefile and Kconfig and remove function
- Do not push test module in this version while waiting for feedbacks about it

Benjamin Gaignard (4):
  dt-bindings: hwlock: Document STM32 hwspinlock bindings
  hwspinlock: add STM32 hwspinlock device
  ARM: dts: stm32: Add hwspinlock node for stm32mp157 SoC
  ARM: dts: stm32: enable hwspinlock on stm32mp157c-ed1

 .../bindings/hwlock/st,stm32-hwspinlock.txt        |  23 +++
 arch/arm/boot/dts/stm32mp157c-ed1.dts              |   4 +
 arch/arm/boot/dts/stm32mp157c.dtsi                 |   9 ++
 drivers/hwspinlock/Kconfig                         |   9 ++
 drivers/hwspinlock/Makefile                        |   1 +
 drivers/hwspinlock/stm32_hwspinlock.c              | 156 +++++++++++++++++++++
 6 files changed, 202 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
 create mode 100644 drivers/hwspinlock/stm32_hwspinlock.c

-- 
2.15.0

