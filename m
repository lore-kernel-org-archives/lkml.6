Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B6BC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 05:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C4424B32
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 05:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b+1+EBws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C4424B32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751506AbeFWFAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 01:00:34 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36440 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeFWFAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 01:00:30 -0400
Received: by mail-pf0-f194.google.com with SMTP id u16-v6so332655pfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 22:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eCGpJN+Du2K06bSnc1x9wpfp8uLy1lBlRT3RJhDL9yc=;
        b=b+1+EBws9kcF+NRXDbNQJbAylaYtNyBnLOgfICtWlq3WjC/WUSMrSsu5SRliaE4VhZ
         Ty81kFCWB1VHY7rRfVNgz/1PZYJ/16LycDgcMnyDNATRnqfxLiUm+Lmwj4t6ck8WZG3h
         3zsbEuxPla7V4XF3SCHJaO0R0atyfPPjimGJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eCGpJN+Du2K06bSnc1x9wpfp8uLy1lBlRT3RJhDL9yc=;
        b=uXUl+ZwrJFa82JCEshb/o8Y+nl0DJzFrbOcW+EPOsrjRxeLJfk+ifu8vKG/qHI9Ybh
         pM0QHY/0O/PnLWU/gEJOPQjHNBxJ2XI2kNxo16O69nbv2PAJ9fsu8W7f+1UzJBVoCpkh
         E02qD6g0hqblK+XQ/nlChik83QutL6/1jI3AsfyGHtrXZIZOoL4X4JGxX+dWCoYB9xEf
         nQDAOBAkrhZEaSddCJrgqMvpADZXeirnxPTcEs3eB4/XjMIPnKs4w+H4aApBX1JHa6rZ
         T5/nYENBZ8kLL91n52LYvskJGceIkn/34yDDziU+XRQk/Rx17bmR0a0YQjWYE08bhWHa
         HAsA==
X-Gm-Message-State: APt69E1oUCQiPYYNXwx37ZHN73vtg5wgY3CP5K3eU3VKl1HWjQdNs1HB
        Zpkje5KTTBoa7IyxIVe/8fB6
X-Google-Smtp-Source: ADUXVKK4esSdEILkP6rIxVj6QKrD/rigzO7LMjbA7ipQutIiybTC7vZtCyArce7DtH75R57Yb/XJ3w==
X-Received: by 2002:a62:4d01:: with SMTP id a1-v6mr4440836pfb.144.1529730029606;
        Fri, 22 Jun 2018 22:00:29 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:70c3:aca:6549:5166:32c7:2dab])
        by smtp.gmail.com with ESMTPSA id y14-v6sm10787603pgv.37.2018.06.22.22.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 22:00:29 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc:     liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: pinctrl: Add gpio interrupt bindings for Actions S900 SoC
Date:   Sat, 23 Jun 2018 10:29:52 +0530
Message-Id: <20180623045954.6729-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180623045954.6729-1-manivannan.sadhasivam@linaro.org>
References: <20180623045954.6729-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio interrupt bindings for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/actions,s900-pinctrl.txt          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
index 8fb5a53775e8..81b58dddd3ed 100644
--- a/Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
@@ -19,6 +19,10 @@ Required Properties:
                     defines the interrupt number, the second encodes
                     the trigger flags described in
                     bindings/interrupt-controller/interrupts.txt
+- interrupts: The interrupt outputs from the controller. There is one GPIO
+              interrupt per GPIO bank. The number of interrupts listed depends
+              on the number of GPIO banks on the SoC. The interrupts must be
+              ordered by bank, starting with bank 0.
 
 Please refer to pinctrl-bindings.txt in this directory for details of the
 common pinctrl bindings used by client devices, including the meaning of the
@@ -180,6 +184,12 @@ Example:
                   #gpio-cells = <2>;
                   interrupt-controller;
                   #interrupt-cells = <2>;
+                  interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+                               <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+                               <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+                               <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+                               <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+                               <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 
                   uart2-default: uart2-default {
                           pinmux {
-- 
2.17.1

