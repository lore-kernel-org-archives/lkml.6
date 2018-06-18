Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F63C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3842A20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3842A20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030361AbeFRIhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:37:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36670 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030344AbeFRIhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:37:32 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 110C1C49;
        Mon, 18 Jun 2018 08:37:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 173/189] ARM: davinci: board-dm646x-evm: pass correct I2C adapter id for VPIF
Date:   Mon, 18 Jun 2018 10:14:29 +0200
Message-Id: <20180618081216.167913317@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sekhar Nori <nsekhar@ti.com>

[ Upstream commit 7d46899d57f8b61eb28701d9a4043b71e3392c26 ]

commit a16cb91ad9c4 ("[media] media: vpif: use a configurable
i2c_adapter_id for vpif display") removed hardcoded I2C adaptor
setting in VPIF driver, but missed updating platform data passed
from DM646x board.

Fix it.

Fixes: a16cb91ad9c4 ("[media] media: vpif: use a configurable i2c_adapter_id for vpif display")
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-davinci/board-dm646x-evm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -534,6 +534,7 @@ static struct vpif_display_config dm646x
 	.set_clock	= set_vpif_clock,
 	.subdevinfo	= dm646x_vpif_subdev,
 	.subdev_count	= ARRAY_SIZE(dm646x_vpif_subdev),
+	.i2c_adapter_id = 1,
 	.chan_config[0] = {
 		.outputs = dm6467_ch0_outputs,
 		.output_count = ARRAY_SIZE(dm6467_ch0_outputs),
@@ -676,6 +677,7 @@ static struct vpif_capture_config dm646x
 	.setup_input_channel_mode = setup_vpif_input_channel_mode,
 	.subdev_info = vpif_capture_sdev_info,
 	.subdev_count = ARRAY_SIZE(vpif_capture_sdev_info),
+	.i2c_adapter_id = 1,
 	.chan_config[0] = {
 		.inputs = dm6467_ch0_inputs,
 		.input_count = ARRAY_SIZE(dm6467_ch0_inputs),


