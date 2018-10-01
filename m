Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9CEC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32EC20840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32EC20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbeJAGhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 02:37:45 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:42762 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbeJAGhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 02:37:45 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1248914|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03309;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.Cy1CQdb_1538352128;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.Cy1CQdb_1538352128)
          by smtp.aliyun-inc.com(10.147.42.135);
          Mon, 01 Oct 2018 08:02:08 +0800
Date:   Mon, 1 Oct 2018 08:02:08 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, anurup.m@huawei.com,
        Jonathan.Cameron@huawei.com, will.deacon@arm.com,
        zhangshaokun@hisilicon.com, jhogan@kernel.org,
        paul.burton@mips.com, peterz@infradead.org, f.fainelli@gmail.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V7 3/8] clocksource: add C-SKY SMP timer
Message-ID: <20181001000207.GA2131@guoren-Inspiron-7460>
References: <9d68bdd87a8c91f4ee35ff4311e273ea81ab9eb4.1538323894.git.ren_guo@c-sky.com>
 <eee964dd57d12bc630280ab84235b5356799b1fb.1538323894.git.ren_guo@c-sky.com>
 <a15b5e43-0721-8638-f5d2-8bb72df87f4d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a15b5e43-0721-8638-f5d2-8bb72df87f4d@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 09:22:30PM +0200, Daniel Lezcano wrote:
> On 30/09/2018 18:18, Guo Ren wrote:
> > This timer is used by SMP system and use mfcr/mtcr instruction
> > to access the regs.
> > 
> > Changelog:
> >  - Remove #define CPUHP_AP_CSKY_TIMER_STARTING
> >  - Add CPUHP_AP_CSKY_TIMER_STARTING in cpuhotplug.h
> >  - Support csky mp timer alpha version.
> >  - Just use low-counter with 32bit width as clocksource.
> >  - Coding convention with upstream feed-back.
> > 
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > ---
> 
> 
> Guo,
> 
> what is the flow of your patches ?
> 
> You sent me a V8 with two patches and those timers which I commented.
> 
> And now there is this V7 with the patches previously sent as V8 without
> the comments take into account.
> 
> I'm a bit lost. Can you clarify ?
Opps ... I should send the "V9 C-SKY(csky) Linux Drivers". It's a wrong
patchset from "V6 C-SKY(csky) Linux Kernel Port".

The patchset didn't include your comment in V8:
 - Add COMIPLE_TEST in Kconfig
 - no cast is needed for "struct clock_event_device *ce = dev"
 - remove: extra space after (u64).

I'm sorry about it, I'll send "V9 C-SKY(csky) Linux Drivers". My fault.

Best Regards
 Guo Ren
