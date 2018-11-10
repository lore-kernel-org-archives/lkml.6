Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B77CC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA0820854
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA0820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeKKD2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 22:28:02 -0500
Received: from mout.gmx.net ([212.227.17.22]:43545 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbeKKD2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 22:28:01 -0500
Received: from [74.104.183.64] ([74.104.183.64]) by
 msvc-mesg-gmx021.server.lan (via HTTP); Sat, 10 Nov 2018 18:42:12 +0100
MIME-Version: 1.0
Message-ID: <trinity-cbe4d3e0-f780-48ea-af28-ed2813eafaf6-1541871732167@msvc-mesg-gmx021>
From:   "Qian Cai" <cai@gmx.us>
To:     "Catalin Marinas" <catalin.marinas@arm.com>
Cc:     "open list" <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: kmemleak: Early log buffer exceeded (525980) during boot
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 10 Nov 2018 18:42:12 +0100
In-Reply-To: <20181110165938.lbt6dfamk2ljafcv@localhost>
References: <1541712198.12945.12.camel@gmx.us>
 <D7C9EA14-C812-406F-9570-CFF36F4C3983@gmx.us>
 <20181110165938.lbt6dfamk2ljafcv@localhost>
X-Provags-ID: V03:K1:a/ITToIz1siVpz6C4OHsosXAoElTdUiLnpegM2s5P90vJaNITEFZwfS7aKmvF1zPVpa7H
 KPozHNcebPBKgXo925fy5fuSD1yrlaqGBgZDUJVcZ0kdIgEpULIf0P0HNWbzrMI3ZrqdUjsVUC2G
 H6tUiu8kZgafpPx1/xJVzMErKNwZcI/bO4kONzm+9Ai9+WTDEUh/wKnDh4rdeceFgzmTjMwYWaHK
 6/ExTJaTN92KCxCJzO+8xAPJMU/DZEjjMpL8PBo7FU710cGUitMeSuG2q7YZi0hqUggAUkHQRIX7
 y153rr/lXVeFiMuK0rsWZNF
X-UI-Out-Filterresults: notjunk:1;V01:K0:RzBKsLZG3S8=:E2jnOtwI07SXi5reBwmCY+
 jfoMwuDsjpsPb3ZuTAWMRXXgaShKDisSAe5WyAnoPn6dd3hyrFH2iTrTA8/1iDOXEsRUakbCO
 xH0wcUd5hHzpsZJR6b31fuvHjcYqDznNPwud2B7v676gMijrQHYHVap+Lm/4FyojZUl4dpQgE
 uVjX8LdHPQnHuEFV1NhoAPUqZ2ynrtBe4lAyWEWDZJdC8w9ATTuoQztAQkN/f5/yoAElTf9Yl
 fp/fgMZTXKx1IzbH/jMuwQc8vY3Kz6ld2YwlCbC7dN9tT1yfUu7534i3W1VaMkpn2zlQS3Z9T
 LMbD7J9VPzUG6iHuObGKOudVgHzyv4sYtyEuJ+PK2nyOUf+kcXJVnyqyZc2GagT1yTXcCqcKy
 6nkZLtlN6LmwUOuAbgpiFRiJCZeFqUTEuNXYnyHJBhKWhTVMGUwnjbSmK5MqEhsGExiCMOADo
 yeFsiNiDpSvMN3RJLK3rikZaTNVnWqMlDTOIUVJVYiClqxdJ9DcfvSwbMLqFMfXT03F7YkIWH
 5FbhNUdysDzjOAc8xvOyZyMkZZL2TuZHJltoYSXNaXatrfcea82p/tUdC/qfnFO+2bFazfDco
 3c9r/BXBW8gkOu3I+uSXQXiehHviJuqvhj
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/10/18 at 11:59 AM, Catalin Marinas wrote:

> On Sat, Nov 10, 2018 at 10:08:10AM -0500, Qian Cai wrote:
> > On Nov 8, 2018, at 4:23 PM, Qian Cai <cai@gmx.us> wrote:
> > > The maximum value for DEBUG_KMEMLEAK_EARLY_LOG_SIZE is only 40000, so it
> > > disables kmemleak every time on this aarch64 server running the latest mainline
> > > (b00d209).
> > > 
> > > # echo scan > /sys/kernel/debug/kmemleak 
> > > -bash: echo: write error: Device or resource busy
> > > 
> > > Any idea on how to enable kmemleak there?
> > 
> > I have managed to hard-code DEBUG_KMEMLEAK_EARLY_LOG_SIZE to 600000,
> 
> That's quite a high number, I wouldn't have thought it is needed.
> Basically the early log buffer is only used until the slub allocator
> gets initialised and kmemleak_init() is called from start_kernel(). I
> don't know what allocates that much memory so early.
> 
> What else is in your .config?
https://c.gmx.com/@642631272677512867/tqD5eulbQAC-1h-fkVe1Iw

Does the dmesg helps? 
https://paste.ubuntu.com/p/BnhvXXhn7k/
> 
> > diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> > index 877de4fa0720..c10119102c10 100644
> > --- a/mm/kmemleak.c
> > +++ b/mm/kmemleak.c
> > @@ -280,7 +280,7 @@ struct early_log {
> >  
> >  /* early logging buffer and current position */
> >  static struct early_log
> > -       early_log[CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE] __initdata;
> > +       early_log[600000] __initdata;
> 
> You don't need to patch the kernel, the config variable is there to be
> changed.
Right, but the maximum is only 40000 in kconfig, so anything bigger than that will be rejected.

