Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64541C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C6A20672
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C6A20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbeLDOiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:38:07 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:32438 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbeLDOiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:38:06 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 9E92D13F7E2;
        Tue,  4 Dec 2018 15:37:43 +0100 (CET)
Subject: Re: [PATCH v2 1/3] clk: qcom: gcc-msm8998: Drop hmss_dvm and lpass_at
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amit.kucheria@linaro.org>
References: <20181203183330.2073-1-bjorn.andersson@linaro.org>
 <20181203183330.2073-2-bjorn.andersson@linaro.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <2f21e657-76f1-a05b-7861-11d7a5f1ea5d@free.fr>
Date:   Tue, 4 Dec 2018 15:37:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181203183330.2073-2-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 19:33, Bjorn Andersson wrote:

> Disabling gcc_hmss_dvm_bus_clk and gcc_lpass_at_clk causes the board to
> lock up, and by that preventing the kernel to boot without
> clk_ignore_unused.
> 
> gcc_hmss_dvm_bus_clk is marked always-on downstream, but not referenced,
> and gcc_lpass_at_clk isn't mentioned. So let's remove them until they
> are needed by some client.

Hello Bjorn,

What about gcc_gpu_bimc_gfx_clk?

AFAICT, it doesn't lock the system up, but the kernel warns:

[    2.171148] ------------[ cut here ]------------
[    2.173740] gcc_gpu_bimc_gfx_clk status stuck at 'on'
[    2.173996] WARNING: CPU: 3 PID: 1 at drivers/clk/qcom/clk-branch.c:92 clk_branch_toggle+0x190/0x1b0
[    2.183475] Modules linked in:
[    2.192554] CPU: 3 PID: 1 Comm: swapper/0 Tainted: G S                4.20.0-rc4 #23
[    2.195509] Hardware name: Qualcomm Technologies, Inc. MSM8998 v1 MTP (DT)
[    2.203389] pstate: 60000085 (nZCv daIf -PAN -UAO)
[    2.210016] pc : clk_branch_toggle+0x190/0x1b0
[    2.214781] lr : clk_branch_toggle+0x190/0x1b0
[    2.219213] sp : ffff00000807bcf0
[    2.223609] x29: ffff00000807bcf0 x28: 0000000000000008 
[    2.227041] x27: ffff0000089db070 x26: ffff000008961378 
[    2.232425] x25: ffff0000088da4b8 x24: 0000000000000000 
[    2.237721] x23: ffff000009138a08 x22: ffff000008414990 
[    2.243016] x21: 0000000000000000 x20: 0000000000000000 
[    2.248312] x19: ffff0000090e9000 x18: ffffffffffffffff 
[    2.253608] x17: 0000000000000000 x16: 0000000000000000 
[    2.258902] x15: ffff0000090e9648 x14: ffff000089193187 
[    2.264197] x13: ffff000009193195 x12: ffff0000090fb000 
[    2.269493] x11: ffff00000807bcf0 x10: ffff00000807bcf0 
[    2.274789] x9 : ffff00000807bcf0 x8 : 6e6f27207461206b 
[    2.280084] x7 : 6375747320737574 x6 : ffff000009192c89 
[    2.285380] x5 : 0000000000000000 x4 : 0000000000000000 
[    2.290676] x3 : ffffffffffffffff x2 : 00008000f5251000 
[    2.295971] x1 : e0dbf26541ede800 x0 : 0000000000000000 
[    2.301272] Call trace:
[    2.306491]  clk_branch_toggle+0x190/0x1b0
[    2.308705]  clk_branch2_disable+0x18/0x20
[    2.312890]  clk_disable_unused_subtree+0xc4/0xe0
[    2.316960]  clk_disable_unused+0x3c/0x130
[    2.321736]  do_one_initcall+0x5c/0x180
[    2.325745]  kernel_init_freeable+0x198/0x244
[    2.329469]  kernel_init+0x10/0x110
[    2.333942]  ret_from_fork+0x10/0x20
[    2.337257] ---[ end trace 57f62b628c127ef8 ]---


Regards.
