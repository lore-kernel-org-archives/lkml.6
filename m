Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC08C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBBD20869
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EviRq/yx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cjm0AILl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBBD20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389542AbeKPU6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:58:18 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49278 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbeKPU6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:58:17 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F22416024C; Fri, 16 Nov 2018 10:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542365190;
        bh=KZDdwJansQWtKemCRbRaUQzV7yoBvIux5R+MhFTiRSk=;
        h=From:To:Cc:Subject:Date:From;
        b=EviRq/yxxUeqF2MvP4oRxlcMWS4Xa0YGV6tYWQGZIwNofvZWWkOVmi1z/GrfVJB9L
         t5IwH5Ilv8QvCGfSzHR+mOjYB56X7sytJ1X/c4k8f0Y6Y091mQuMRx8pJHYFM9P4q/
         QpBPkijRVfi8bX07WAKo2x7v8nMvnHssx+wNoOgg=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2B0EE6035F;
        Fri, 16 Nov 2018 10:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542365188;
        bh=KZDdwJansQWtKemCRbRaUQzV7yoBvIux5R+MhFTiRSk=;
        h=From:To:Cc:Subject:Date:From;
        b=cjm0AILloEuF3iYPWlXjJJ7bvNzmU08/fqIdWhMcN5r9kV5fZ7Xi+ecKk2z34AgQd
         KofjgMzzMOyePebuJBWGJx6absCdw7zg+p3W7zbAiEY2tOKmZjOf4EDQFmDRxxakyD
         WULy19HH6b0ERdY8yskzYpSYTMHKa0TmSmMBE0I8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B0EE6035F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Viresh Kumar <vireshk@kernel.org>, srinivas.kandagatla@linaro.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH] boot_constraint: Add constraints for earlycon on dragonboard 410c
Date:   Fri, 16 Nov 2018 16:16:07 +0530
Message-Id: <20181116104607.26671-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iface clock is shared with other drivers, which may reconfigure
this before the serial driver comes up. This may lead to
crashes like the one below where GCC_BLSP1_AHB_CLK is same across
multiple drivers like bam dma.

<0>[    3.164471] Internal error: synchronous external abort: 96000010 [#1] PREEMPT SMP
<4>[    3.164479] Modules linked in:
<4>[    3.164495] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc8-00008-ge033b9909fff-dirty #175
<4>[    3.164501] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
<4>[    3.164508] pstate: 40000085 (nZcv daIf -PAN -UAO)
<4>[    3.164514] pc : msm_read.isra.2+0x20/0x50
<4>[    3.164520] lr : msm_read.isra.2+0x1c/0x50
<4>[    3.164526] sp : ffff000008033a50
<4>[    3.164531] x29: ffff000008033a50 x28: ffff000009486018
<4>[    3.164548] x27: 0000000000000001 x26: ffff7dfffe7ff070
<4>[    3.164565] x25: 0000000000000034 x24: ffff000009486000
<4>[    3.164582] x23: 0000000000000000 x22: ffff00000978e190
<4>[    3.164599] x21: ffff0000095e8228 x20: 0000000000000034
<4>[    3.164616] x19: ffff7dfffe7ff008 x18: ffffffffffffffff
<4>[    3.164632] x17: 0000000000000000 x16: 0000000000000000
<4>[    3.164649] x15: ffff0000094a96c8 x14: ffff00008978e6bf
<4>[    3.164666] x13: ffff00000978e6cd x12: 0000000000000038
<4>[    3.164683] x11: ffff0000094c6000 x10: 0000000000000c24
<4>[    3.164699] x9 : ffff80003c89b400 x8 : ffff000008033970
<4>[    3.164716] x7 : ffff80000eb04100 x6 : 00000000000af304
<4>[    3.164732] x5 : 0000000000000c40 x4 : ffff80003c06f000
<4>[    3.164750] x3 : ffff80003c89b498 x2 : 0000000000000000
<4>[    3.164766] x1 : ffff80003ca68000 x0 : 0000000000000800
<0>[    3.164785] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
<4>[    3.164791] Call trace:
<4>[    3.164797]  msm_read.isra.2+0x20/0x50
<4>[    3.164804]  msm_reset_dm_count+0x44/0x80
<4>[    3.164810]  __msm_console_write+0x1c8/0x1d0
<4>[    3.164816]  msm_serial_early_write_dm+0x3c/0x50
<4>[    3.164823]  console_unlock.part.6+0x468/0x528
<4>[    3.164829]  vprintk_emit+0x210/0x218
<4>[    3.164835]  vprintk_default+0x48/0x58
<4>[    3.164841]  vprintk_func+0xf0/0x1c0
<4>[    3.164847]  printk+0x74/0x94
<4>[    3.164853]  sci_init+0x24/0x3c
<4>[    3.164859]  do_one_initcall+0x54/0x248
<4>[    3.164866]  kernel_init_freeable+0x210/0x378
<4>[    3.164872]  kernel_init+0x18/0x118
<4>[    3.164878]  ret_from_fork+0x10/0x1c
<0>[    3.164884] Code: aa1e03e0 8b214273 97e616f7 d503201f (b9400260)

Link: https://lore.kernel.org/lkml/1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org/
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

---

This is purely dependent on boot constraint subsystem by Viresh.

Link: https://lore.kernel.org/lkml/cover.1519380923.git.viresh.kumar@linaro.org/
---
 drivers/soc/qcom/boot_constraint.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/soc/qcom/boot_constraint.c b/drivers/soc/qcom/boot_constraint.c
index ca01eb50d9a9..c4e580a118f0 100644
--- a/drivers/soc/qcom/boot_constraint.c
+++ b/drivers/soc/qcom/boot_constraint.c
@@ -49,6 +49,10 @@ static struct dev_boot_constraint_supply_info vddio_info = {
 	.name = "vddio"
 };
 
+static struct dev_boot_constraint_clk_info uart_iface_clk_info = {
+	.name = "iface",
+};
+
 static struct dev_boot_constraint constraints_mdss[] = {
 	{
 		.type = DEV_BOOT_CONSTRAINT_PM,
@@ -92,6 +96,13 @@ static struct dev_boot_constraint constraints_dsi[] = {
 	},
 };
 
+static struct dev_boot_constraint constraints_uart[] = {
+	{
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &uart_iface_clk_info,
+	},
+};
+
 static struct dev_boot_constraint_of constraints[] = {
 	{
 		.compat = "qcom,mdss",
@@ -105,6 +116,10 @@ static struct dev_boot_constraint_of constraints[] = {
 		.compat = "qcom,mdss-dsi-ctrl",
 		.constraints = constraints_dsi,
 		.count = ARRAY_SIZE(constraints_dsi),
+	}, {
+		.compat = "qcom,msm-uartdm-v1.4",
+		.constraints = constraints_uart,
+		.count = ARRAY_SIZE(constraints_uart),
 	},
 };
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

