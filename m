Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7376BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A9A214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JOy9SsXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfBUJMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:12:19 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46919 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbfBUJMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:12:19 -0500
Received: by mail-pg1-f194.google.com with SMTP id 196so1609025pgf.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 01:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xuxrk96NNHkj3knJVr7wd98x4RZ/O1p0LvlVCD1BNmI=;
        b=JOy9SsXVAGKamrloePCopLWiScADlecxUZxNmDtbxznXEOvWcoxnEI87fqbrA3l+nS
         4rA+9XQn9BuIqfMtFxYCT3B7ge35jvSlyWpGpoFzmesfcI5j5eecs5Q7+7e7DpIYDPIg
         KKCc36DEtaGQuo7x3Pm9LUi8UAt+opDoPJj36CHhm2hicr7fuM4vvwj7qloRb9bcHQIl
         ygMwIZkZuxshAC/nqd0jUcv4plGc0HfAvJvxEFLQRHdcDxVPJu5W2/qbJwG6lEpWsyQz
         MsDd9P3ioZ7YLmD01CEMT500/ro+D3CaJTdZQqV6QJ101R7rSzTrrd9gclr1xEaluyk6
         SGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xuxrk96NNHkj3knJVr7wd98x4RZ/O1p0LvlVCD1BNmI=;
        b=UKTGZJLcoOpaM3lEaeb/ck8797iAV86nPtiHGh/XjuRFGhKU6eGPbs8fjbVhc4VTz4
         gAS/VyUjC/TNfEoYFJXLt5k9DGs9Z4ci97Nkflr+5hrMig9X5FWWGd3FfNdhpaHgNt1r
         Hdj8SOyXi2+WW1rWFRMQWInxUWvys4pX3flUKgL8XmgMwvdXGzyfQaXmbg2lSbGDLmOM
         /3ijBBeHsw1cx1ZR2I0itA4/+RWNXcD9uK9yBBPbKYMuABzJ7PsKrR6P6YHK7/77l0z8
         nMjD+U48Am1mJwWhbY9i4ydxLHu9lKqzdX512sWP8D3ie2LUhLFgmy9DEodTGMMQ1a+X
         fjQA==
X-Gm-Message-State: AHQUAuZ99xrT4DyCDBRNH0J2Cgqty3cYlRy6cpdAGgSuxl4tAAaZlUGt
        kS55jHT77OxHwxjP5XNUL7XuNA==
X-Google-Smtp-Source: AHgI3IYcMuJcsmojQzRSe8wdFjw3NIWIvLMKJ9LNIlfzZsQqhtQg4WKX37Orj5RzJQAi6VqdPBUsgA==
X-Received: by 2002:a63:6ec2:: with SMTP id j185mr37224919pgc.341.1550740338709;
        Thu, 21 Feb 2019 01:12:18 -0800 (PST)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id i71sm66145208pfi.170.2019.02.21.01.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Feb 2019 01:12:17 -0800 (PST)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v7 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
Date:   Thu, 21 Feb 2019 14:41:40 +0530
Message-Id: <1550740301-10097-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550740301-10097-1-git-send-email-yash.shah@sifive.com>
References: <1550740301-10097-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT documentation for PWM controller added.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
[Atish: Compatible string update]
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 .../devicetree/bindings/pwm/pwm-sifive.txt         | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
new file mode 100644
index 0000000..36447e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
@@ -0,0 +1,33 @@
+SiFive PWM controller
+
+Unlike most other PWM controllers, the SiFive PWM controller currently only
+supports one period for all channels in the PWM. All PWMs need to run at
+the same period. The period also has significant restrictions on the values
+it can achieve, which the driver rounds to the nearest achievable period.
+PWM RTL that corresponds to the IP block version numbers can be found
+here:
+
+https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
+
+Required properties:
+- compatible: Should be "sifive,<chip>-pwm" and "sifive,pwm<version>".
+  Supported compatible strings are: "sifive,fu540-c000-pwm" for the SiFive
+  PWM v0 as integrated onto the SiFive FU540 chip, and "sifive,pwm0" for the
+  SiFive PWM v0 IP block with no chip integration tweaks.
+  Please refer to sifive-blocks-ip-versioning.txt for details.
+- reg: physical base address and length of the controller's registers
+- clocks: Should contain a clock identifier for the PWM's parent clock.
+- #pwm-cells: Should be 3. See pwm.txt in this directory
+  for a description of the cell format.
+- interrupts: one interrupt per PWM channel
+
+Examples:
+
+pwm:  pwm@10020000 {
+	compatible = "sifive,fu540-c000-pwm", "sifive,pwm0";
+	reg = <0x0 0x10020000 0x0 0x1000>;
+	clocks = <&tlclk>;
+	interrupt-parent = <&plic>;
+	interrupts = <42 43 44 45>;
+	#pwm-cells = <3>;
+};
-- 
1.9.1

