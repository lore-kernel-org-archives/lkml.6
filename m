Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59452C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F4020685
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JM4J2WwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F4020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbeKMBRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:17:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53195 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbeKMBRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:17:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id r11-v6so8879160wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 07:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yyvl64X5FbEhFmlfbNEvG6Iy+6IGW5U2Gxn+yiL2vUg=;
        b=JM4J2WwDaJv7/mGrG8PzE4ZVTExFbQaSrBQ49OkalBJfw7gi0dP1ZomHuuXkm1sY/t
         FvmiGeuE1wY0pyii8aiTC4ZI2xMcG3QN+e+56zyA0/S7NDKWj1WFkoUqq6mbAiaH0peW
         NVr3I46lOOkRyx8FeDgtIaCKBPLUqOeD5pcQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yyvl64X5FbEhFmlfbNEvG6Iy+6IGW5U2Gxn+yiL2vUg=;
        b=I8sn2sSo92CqFbdO1ohZ7n7j79cINJ9H2sbL0ZCp8w9ctf3c76KAdPGqXwEjq6byz1
         K3V1BC5rzJkBog3p9rnmDbFJ3Y3Wfe9tkP0mrx52ImTB0YPhBvxgEhpFtXzZ4ue//0nT
         Po5qKYbO8mgos8EEJTkYUXyfiF2O8jDqtY2l6vhbr54ENyu5ok9GM5Nuz7mRTO2FCVPF
         TUHA2PSIhULUvpD77KezV6qd46UgjTKRqfiiZ7EkSGIH7pwkmgxwO1T3tnrrvJCwKxrs
         QmyGoURfCOeGdvPxRilKJM7CEwFGljxnKHd23JKuoeMjQg681ozLq+BKVW1YNGxuwEgJ
         eCDQ==
X-Gm-Message-State: AGRZ1gJuARGrGAKDAwQrcMR4gnsubpLTd0GlOMftXDdIj73VpRbPh6hd
        5S9qKdPjuFN31giBkn9xzvNqXA==
X-Google-Smtp-Source: AJdET5dwKqifJeOi6AfR1btP9CVim7x33pesNQnj5j/q0N+dOFNVQmj+Lo0Y6ynVtggakHzKBv+0eA==
X-Received: by 2002:a1c:7cc:: with SMTP id 195-v6mr40989wmh.139.1542036228751;
        Mon, 12 Nov 2018 07:23:48 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:105e:a8d5:7c2c:2737:d373:11ee])
        by smtp.gmail.com with ESMTPSA id t82-v6sm11192849wme.30.2018.11.12.07.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 07:23:48 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v3 0/4] Add support of STM32 hwspinlock
Date:   Mon, 12 Nov 2018 16:23:38 +0100
Message-Id: <20181112152342.6561-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie adds the support of the hardware semaphore block for stm32mp1 SoC.

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

