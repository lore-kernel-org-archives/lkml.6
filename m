Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1A7C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 02:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEE420659
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 02:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEE420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbeJOKP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 06:15:57 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:32804 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726498AbeJOKP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 06:15:56 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07707593|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03298;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.D28d4N6_1539570755;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.D28d4N6_1539570755)
          by smtp.aliyun-inc.com(10.147.44.145);
          Mon, 15 Oct 2018 10:32:36 +0800
Date:   Mon, 15 Oct 2018 10:32:34 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, will.deacon@arm.com,
        jhogan@kernel.org, paul.burton@mips.com, peterz@infradead.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V12 0/8] C-SKY(csky) Linux Kernel Driver
Message-ID: <20181015023234.GA24121@guoren-Inspiron-7460>
References: <cover.1539315341.git.ren_guo@c-sky.com>
 <dfe56d38-cfa5-2be1-114e-c6721d6c92a3@linaro.org>
 <20181014162631.GA13374@guoren-Inspiron-7460>
 <36e2cb6d-6d9e-4764-a6dd-a5f74cab5a09@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36e2cb6d-6d9e-4764-a6dd-a5f74cab5a09@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Sun, Oct 14, 2018 at 10:38:36PM +0200, Daniel Lezcano wrote:
> On 14/10/2018 18:26, Guo Ren wrote:
> Thanks Guo,
> 
> the descriptions look ok for the timer part. Can you resend the DT
> bindings + timers patches separately with the commit log updated ?
Ok, immediately.

> 
> When you add the Changelog you have to insert it *after* the first
> '---', so when the patch is git applied, the change log will be
> discarded and won't appear in git.
Ok, thx for the tips.

> 
> eg.
> 
> commit 6b465856936cb8f7eda31b20eb59fb5c8a19d468
> Author: Guo Ren <ren_guo@c-sky.com>
> Date:   Tue Oct 2 16:43:18 2018 +0800
> 
> clocksource: add gx6605s SOC system timer
> 
> The driver is for gx6605s SOC system timer and there are two
> same timers in gx6605s. We use one for clkevt and another one for
> clksrc.
> 
> The timer is mmio map to access, so we need give mmio address in dts.
> The counter at 0x0  offset is clock event. The counter at 0x40 offset is
> clock source.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
> Changelog:
>      - pass checkpatch.pl
>      - Add COMIPLE_TEST in Kconfig
>      - no cast is needed for "struct clock_event_device *ce = dev"
>      - remove: extra space after (u64)
>      - Add License and Copyright
>      - Use timer-of framework
>      - Change name with upstream feedback
>      - Use clksource_mmio framework
> ---

Best Regards
 Guo Ren
