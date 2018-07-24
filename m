Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4BCECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7473920874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ji8mQrqm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JJtf4xmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7473920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388595AbeGXP5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:57:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34128 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388517AbeGXP5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:57:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 754A860B12; Tue, 24 Jul 2018 14:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532443859;
        bh=VpjCsnV7vsyA0/3k3mfDP1R8/M6WMTOPH66SDQ9FOmI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ji8mQrqm43tTjiE55UB2ShJtMg7P+3JlXcXt9LVsXXRX/UHtlD3o0uigxniAyd7s2
         XkZgOgPmH7WtEpi9zYkR5DJMy6lphv2p8EDLUmBtFH35yvp/pL+7IYlzlnclQsWJVH
         XnM92iy6Q6csRe2/L04u5mLkGCWOcy+Oy4VWltJQ=
Received: from [10.204.79.100] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 022AC605A4;
        Tue, 24 Jul 2018 14:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532443858;
        bh=VpjCsnV7vsyA0/3k3mfDP1R8/M6WMTOPH66SDQ9FOmI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JJtf4xmceMzlpcZmE6hJqysUO+ZmM5l8sJNW45lRXgGfcpf+RUCCHE1Rs047svZkl
         xQDKiTi09E5QoJtTj1tRAhDepIJjFzDeqIPIFELENUTdDpMFepw3/r2iBHF8ODwBDr
         uPYlSkxaxA9xMO8FjOhSrcpx94Eh+I4TWX4gtgT8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 022AC605A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] cpu/hotplug: Fix cpuhp_step name for timers
To:     linux-kernel@vger.kernel.org
Cc:     gkohli@qti.qualcomm.com, neeraju@qti.qualcomm.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Mathieu Malaterre <malat@debian.org>
References: <1532443058-22343-1-git-send-email-mojha@codeaurora.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <bc1f64e0-7840-b5db-c048-ad983a6e48e2@codeaurora.org>
Date:   Tue, 24 Jul 2018 20:20:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532443058-22343-1-git-send-email-mojha@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Please review V2 where i will be updating(minor) commit text.

Thanks.
Mukesh


On 7/24/2018 8:07 PM, Mukesh Ojha wrote:
> After commit 249d4a9b3246 ("timers: Reinitialize per cpu bases
> on hotplug") i.e introduction of state CPUHP_TIMERS_PREPARE
> instead of CPUHP_TIMERS_DEAD the cpuhp_step name "timers:dead"
> for timer looks to invalid. So, better to name it as
> "timers:prepare".
>
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Brendan Jackman <brendan.jackman@arm.com>
> Cc: Mathieu Malaterre <malat@debian.org>
> ---
>   kernel/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 0db8938..8e6606a 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1274,7 +1274,7 @@ static int __init cpu_hotplug_pm_sync_init(void)
>   	 * otherwise a RCU stall occurs.
>   	 */
>   	[CPUHP_TIMERS_PREPARE] = {
> -		.name			= "timers:dead",
> +		.name			= "timers:prepare",
>   		.startup.single		= timers_prepare_cpu,
>   		.teardown.single	= timers_dead_cpu,
>   	},

