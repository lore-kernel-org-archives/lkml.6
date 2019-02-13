Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A456C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D60222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404027AbfBMLzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:55:12 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:52754 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfBMLzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:55:11 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 827DC13F8B5;
        Wed, 13 Feb 2019 12:55:00 +0100 (CET)
Subject: Re: [PATCH v3 0/6] MSM8998 basic USB support
To:     Jeffrey Hugo <jhugo@codeaurora.org>
References: <1548106307-4762-1-git-send-email-jhugo@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <1fcf1cf6-ea1b-abfb-48d5-7df7d2d23fcc@free.fr>
Date:   Wed, 13 Feb 2019 12:55:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548106307-4762-1-git-send-email-jhugo@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2019 22:31, Jeffrey Hugo wrote:

> This series provides basic USB support for MSM8998.  Currently missing is
> wiring up the Type-C detection logic so that the controller can correctly
> switch between host and peripheral modes.  Work to implement that is
> ongoing, and expected to appear soon in followup patches.  Also missing is
> Display Port (DP) support which apparently is different from sdm845 and
> needs additional investigation.

FTR and FWIW:

_regmap_update_bits: reg=88014 old=3 new=2
[    CLK_BASE + 88014] = 00000002
------------[ cut here ]------------
gcc_rx1_usb2_clkref_clk status stuck at 'on'
WARNING: CPU: 3 PID: 1 at drivers/clk/qcom/clk-branch.c:92 clk_branch_toggle+0x19c/0x1c0
Modules linked in:
CPU: 3 PID: 1 Comm: swapper/0 Tainted: G S      W         5.0.0-rc6 #13
Hardware name: Qualcomm Technologies, Inc. MSM8998 v1 MTP (DT)
pstate: 60000085 (nZCv daIf -PAN -UAO)
pc : clk_branch_toggle+0x19c/0x1c0
lr : clk_branch_toggle+0x19c/0x1c0
sp : ffffff801005bc60
x29: ffffff801005bc60 x28: ffffff8010627464 
x27: ffffff8010c7b000 x26: ffffff80105b06d4 
x25: ffffff801054b1b8 x24: 0000000000000000 
x23: ffffff8010c39c18 x22: ffffff80102bf2f0 
x21: 0000000000000000 x20: ffffff8010c08000 
x19: 0000000000000000 x18: ffffffffffffffff 
x17: 0000000000000000 x16: 0000000000000000 
x15: ffffff8010c08548 x14: ffffff8010c807f0 
x13: ffffff8010c80431 x12: ffffff8010c14000 
x11: ffffff801005bc60 x10: ffffff801005bc60 
x9 : 00000000ffffffc8 x8 : 7320737574617473 
x7 : 206b6c635f666572 x6 : ffffff8010c7fabc 
x5 : 0000000000000000 x4 : 0000000000000000 
x3 : 00000000ffffffff x2 : 00000040ecf69000 
x1 : 59b62fd98d8ce200 x0 : 0000000000000000 
Call trace:
 clk_branch_toggle+0x19c/0x1c0
 clk_branch2_disable+0x2c/0x40
 clk_disable_unused_subtree+0xe8/0x250
 clk_disable_unused_subtree+0x34/0x250
 clk_disable_unused_subtree+0x34/0x250
 clk_disable_unused+0x44/0x140
 do_one_initcall+0x68/0x250
 kernel_init_freeable+0x288/0x32c
 kernel_init+0x18/0x110
 ret_from_fork+0x10/0x1c
---[ end trace d1565111e6d9749a ]---
