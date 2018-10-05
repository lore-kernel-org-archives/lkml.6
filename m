Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F088DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC60D20652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC60D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeJEPZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:25:48 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:44239 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbeJEPZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:25:47 -0400
Received: from [192.168.0.66] ([92.154.77.116]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.168]) with ESMTPSA (Nemesis) id
 1McpW6-1fYjjD0lBS-00ZwfS; Fri, 05 Oct 2018 10:27:49 +0200
Received: from [192.168.0.66] ([92.154.77.116]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.168]) with ESMTPSA (Nemesis) id
 1McpW6-1fYjjD0lBS-00ZwfS; Fri, 05 Oct 2018 10:27:49 +0200
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181004162339.19493-1-nicolas.cavallari@green-communications.fr>
 <20181004162339.19493-2-nicolas.cavallari@green-communications.fr>
 <20181004164911.GD30658@n2100.armlinux.org.uk>
From:   Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Openpgp: preference=signencrypt
Autocrypt: addr=Nicolas.Cavallari@green-communications.fr;
 prefer-encrypt=mutual; keydata=
 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
 fPNSEqkwc2RU5Q==
Subject: Re: [RFC 1/2] reboot: Make restart_handler_list a blocking notifier
 chain.
Message-ID: <211e71a4-57ce-2383-c74f-dfbfa053e4b7@green-communications.fr>
Date:   Fri, 5 Oct 2018 10:27:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181004164911.GD30658@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qnLFSOMq5r00x1WVNcDcQl1CgYHporptCIWsYzSrmPphQdQqpyz
 /lk1ZqLzP384JKDf4j9B7Ya2nvLAANVC6jX2L1QGVGg8l/jhmiz1eeCTozeRTCE4IoL4nkF
 DlIJr09QZFbvyke16FGHrlI7DBAaL/zQKiW62rRlC+sCsF1y1t1wm8mv3k1Ai+1V10awHWZ
 heM2/C8mW6q7uQe+w9Kqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zx8Ysy1WF+g=:2g9IUyKa1EBGm06ygvZvTV
 fzkkFrw6Sxb8XuTqad8VuhKUVLtOMc7VLdByE1DHBGPpJMHa25BAHAFW7anCo3Y4FLqJ+VTSi
 PNHfZ0zaYpRUqDnyc8icYoYq7nThvTBONdCisAl1c4ewb7vhr7Df2AlD1014jzeoOQqmDKp+k
 m5sZXLxUGyl5PTVoJilk4XQgYxLtSy2x2ChRZns1Yl0/i1JfR/2ZrM+BTGfUoKswlS8YuPzfg
 jMIvCJGzJ9UZdImPdymUmKQXb3nC3PGd8k+dOv0b12f02axDLPKeqCTx7JAhyMy4Jw3stdMIy
 MKIUHVw8AddXVnGYWoIiQwnr+fCx+zsnlvlS+htXUzmhJBFDv/iho3TWGNaXp9/YHQcSJXAns
 Ze4+BWOMvKpTHu8nUPVbSwY5A6GNzlL0z/2fXw22G9D1+1FYhJntwj/FPsnuAUSSvXYJ9G8Oa
 dC50+rt0o9RK86k64fgPVYlSvVvoujuTpoVHmguLdPwwtcIL+DFCcn4Sdb32YiyTaaklWh/dc
 zSMLxB3vVCPpk73bSFUz/pmpBPIYBYTTsDA2JTZEeoNBS/B+FffNSbAVyeSlqNGS4xerq99dd
 H64ZKlj10B8DwfLIyuiN12bdCOt+EpYo4WJBd3uOA0SkvkiGzOFjSsBvvjK3hUI6GbILO6HLU
 GpV3DOPAI7ogjLNOwULgKvNLOxDVYqywxpMcQbRaTUEgruDB0iCMUwSRbAYzz3t0O2+MpR1nU
 aOIWfB9Jy0BPc2sy
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2018 18:49, Russell King - ARM Linux wrote:
> This isn't going to work.
> 
> For example, sysrq processing (which can happen in IRQ context) calls
> emergency_restart() for the reboot sysrq.  That calls through to
> machine_restart(), which then calls do_kernel_restart().
>
> If do_kernel_restart() sleeps, then we're trying to sleep in IRQ
> context, and that's a no no.  I'm afraid you can't just add an irq
> enable and change the notifier list to be atomic - and, as you're
> making the change in generic code, this affects everyone, not just the
> architecture that happens to be in front of you (so if it were merged,
> you're likely to get a lot of bug reports!)

I don't get it.

Many implementations of machine_restart() sleeps or do an infinite loop.
Almost half of the restart_handler users sleeps or do an infinite loop.

I understand that sleeping in IRQ context is bad, but the kernel does it anyway.
And it seems nobody have noticed any problem with this.

The rn5t618 driver already does two I2C transfers in its restart handler.
Haven't anyone reported any problem about it ?

> It gets worse, because (eg) a panic() or IRQ can happen with any locks
> held - and if the I2C device's locks are held when one of those events
> happen, you have a deadlock situation (hence you won't reboot!)
> 
> I suppose a good first step would be for us to have our own
> machine_emergency_restart() on ARM, to separate the atomic paths
> from the non-atomic paths, so that those who need to talk to an I2C,
> that can happen from the non-atomic path (which means things like
> /sbin/reboot will work) but other stuff (eg, restart on panic, sysrq,
> soft-watchdog) will fail.

That would fix my use case, but not the existing code ?
