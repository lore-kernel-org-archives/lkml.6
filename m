Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A0CC67839
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B192082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="idCAOlDx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Jj708hPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B192082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbeLJXKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:10:20 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60334 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeLJXKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:10:19 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0A69660A31; Mon, 10 Dec 2018 23:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544483418;
        bh=SdPYZLXYF6sL/n21+1M7MyrkeG9wEAeLtNRis04uznE=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=idCAOlDxLzeWST2uRTEPastEXbNg/i/QlAtTWSNhdK8+i3StKyzthdxWM1rCPVRY+
         Tw9SKZk1kpZyBIoTfNzk0wB4bdorMKsuoZ8yxq/RQn1pc3Ra1/G6q+9Tjoz9O6E/O2
         XG6jGM6S8qj6FvsO5ykSxsnMtDWDPQ+MpvBBuri8=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03377605BD;
        Mon, 10 Dec 2018 23:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544483416;
        bh=SdPYZLXYF6sL/n21+1M7MyrkeG9wEAeLtNRis04uznE=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=Jj708hPtEhFiXMkEFc579aN3UgSVEf33kZo8IB1lZhJ2OcG+KNkYMpiqZDxwCbeoO
         tQhaf8d2vznPAVw8S/Yl+sY+xjFjq1oyUPHgNva3EFCVIPiwD5oKxkqkicE4UpfD8n
         l4gblgg8fVHFS7G9TZyhZlQN7WYRR5G1WrgxfRkQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03377605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v2] clk: qcom: smd: Add support for MSM8998 rpm clocks
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1544134310-10227-1-git-send-email-jhugo@codeaurora.org>
 <84c0fd53-98e9-ac41-f1ca-68ad6d676e9a@free.fr>
 <8b3702e8-3779-db5c-1777-94a6d97c1080@codeaurora.org>
Message-ID: <4cb40564-a542-d86e-6887-9e3dbfb0fe49@codeaurora.org>
Date:   Mon, 10 Dec 2018 16:10:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <8b3702e8-3779-db5c-1777-94a6d97c1080@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/2018 8:13 AM, Jeffrey Hugo wrote:
> On 12/7/2018 7:23 AM, Marc Gonzalez wrote:
>> On 06/12/2018 23:11, Jeffrey Hugo wrote:
>>
>>> Add rpm smd clocks, PMIC and bus clocks which are required on MSM8998
>>> for clients to vote on.
>>>
>>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>>> ---
>>> v2
>>> -fix compatible ordering nits per Stephen
>>>
>>>   .../devicetree/bindings/clock/qcom,rpmcc.txt       |  1 +
>>>   drivers/clk/qcom/clk-smd-rpm.c                     | 62 
>>> ++++++++++++++++++++++
>>>   include/dt-bindings/clock/qcom,rpmcc.h             |  6 +++
>>>   3 files changed, 69 insertions(+)
>>
>> Hmmm, my board seems to dislike this patch... it locks up for a while,
>> then reboots.
>>
>> [    6.957289] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: Sending 
>> flag query for idn 1 failed, err = -11
>> [    6.961233] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag_retry: 
>> failed with error -11, retries 2
>> [    6.970782] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag_retry: 
>> query attribute, opcode 6, idn 1, failed with error -11 after 3 retires
>> [    6.979576] ufshcd-qcom 1da4000.ufshc: ufshcd_complete_dev_init 
>> setting fDeviceInit flag failed with error -11
>> [   23.432798] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>> [   23.432884] rcu:     7-...0: (1 GPs behind) 
>> idle=6a2/1/0x4000000000000000 softirq=92/93 fqs=2626
>> [   23.437927] rcu:     (detected by 0, t=5252 jiffies, g=-819, q=112)
>> [   23.446425] Task dump for CPU 7:
>> [   23.452567] swapper/0       R  running task        0     1      0 
>> 0x0000002a
>> [   23.455806] Call trace:
>> [   23.462872]  __switch_to+0x94/0xe0
>> [   23.465009]  _regmap_write+0x58/0xb0
>> [   23.468452]  _regmap_update_bits+0xf0/0x110
>> [   23.472186]  regmap_update_bits_base+0x60/0x90
>> [   23.476110]  clk_disable_regmap+0x34/0x40
>> [   23.480614]  clk_branch_toggle+0x108/0x1b0
>> [   23.484681]  clk_branch2_disable+0x18/0x20
>> [   23.488692]  clk_disable_unused_subtree+0xc4/0xe0
>> [   23.492761]  clk_disable_unused+0x3c/0x130
>> [   23.497535]  do_one_initcall+0x5c/0x180
>> [   23.501557]  kernel_init_freeable+0x198/0x244
>> [   23.505276]  kernel_init+0x10/0x110
>> [   23.509768]  ret_from_fork+0x10/0x20
>>
>> /*** REBOOT ***/
>> Format: Log Type - Time(microsec) - Message - Optional Info
>> Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
>>
>> I need to check the ufs_reset pin and phy init seq before I can 
>> investigate
>> this issue, but I wanted to send a report ASAP.
>>
> 
> Hmm.  I run with clk_ignore_unused.  I'm guessing that something was 
> defined that should be used eventually, but isn't used now, and so its 
> getting turned off when it probably shouldn't be.
> 
> I'll try to repro on my end.
> 

I think I figured this out.

The issue appears to be with the mmssnoc_axi_rpm_clk that this patch 
defines.  Removing that, and I do not observe a crash.  This clock will 
eventually be needed for the multimedia subsystem (camera and the like).

Marc, it would be good if you could comment out this clock to verify my 
observations translate to your setup.

The problem occurs when the rpm driver, during probe, sends the active 
settings to the rpm.  This causes the rpm to try to access the mmss over 
the relevant config noc, and results in an unclocked bus error, which is 
a fatal error.

clk_ignore_unused avoids this issue because it leaves on the config noc 
clock defined in gcc - gcc_mmss_noc_cfg_ahb_clk

I can see 3 workarounds to this issue -

1. comment out mmssnoc_axi_rpm_clk with an explanation to why, and leave 
this problem to whomever needs the clock in the future

2. add the CLK_IGNORE_UNUSED flag to gcc_mmss_noc_cfg_ahb_clk so prevent 
it from being disabled (aka a selective version of clk_ignore_unused)

3. add a prepare_enable call to gcc_mmss_noc_cfg_ahb_clk in the gcc 
probe, so that there is always one active consumer of the clock (this is 
what downstream does)

Stephen, do you have a preference, or an alternative suggestion?

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
