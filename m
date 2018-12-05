Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48953C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB6D20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QtD8Rd2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB6D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbeLEOjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:39:05 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35069 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeLEOjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:39:05 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so20508731itp.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 06:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AfOXIV3kOI3qtxrhTm2J4J0qZ9v3UgAv110TtUIKBK4=;
        b=QtD8Rd2zj0IAApCVU7eiDP1BuRKtvm5cySoRhLQjvSw/QmyHd7A76dG2yEvoB01yL0
         MBhP96q2b37n/JVf1ABMGJJ9IrrhUK6wX0+pEFg2Eccs5i2m/Wxv+oSTewhoJE7L5yWy
         4Hk7uFAFncsqVn408dX+9BTfxO1V8nSLQfeV1+R2wAMdFrDNkRIKZx9YIuEGU52+NVh9
         vgeKjqow1QXohGlgGIn/Uzm60ClLuG/v+aQUSDj6f3KYar02Y9p0sn+Q56Vhf7bnEqCK
         ebTm9n93DcQQp/p8XraFhz5uBuVCBOs3hmlVjXgD0v4maDImC3YIeoCfD1BkS1QmR+O4
         ZwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AfOXIV3kOI3qtxrhTm2J4J0qZ9v3UgAv110TtUIKBK4=;
        b=plVAKm164NtODJlwdkSWRLr++f1az+qpGrQLYu8BfpMbPstnWHVe+t2f1h1KlW4vY5
         JUcXw7bqePyj4YvEaMlU8xzwumPHpYyDob5Fssrmo3Z/WIjxQqTASXJ2G2Wx789+zSCe
         31vYI9tve7HX84kaKPxYjTOBJdp6gBlrMpDrqzvWU+K/Y0lMK/EfMLGjSMgDm2UtFwdz
         PbFqOY1YBO3s4u8cHTDo5RMssiXr5QVmpoITKXJAXEedGu9hD0vzee2rp4e0XJKIUl4Q
         s8IE6U0pMTXuCqY4AsK8JbqTQEG/XXKt5dYN2QmTxq92I9TFEzOH6IrqRAQ2pfMTl9wE
         4KOw==
X-Gm-Message-State: AA+aEWZgAzOY5oB+7us1IYqsqywU0mQe0c0+b+3+ZdO1gMfr4Zo8Hpal
        A27L+nd0MjUolMD8ZK++kax//tEV4WJwC0vPsys1Ww==
X-Google-Smtp-Source: AFSGD/WiNRIrELB1ZSvPl8zS/QoprC/hMVq/xFwOtxQU5U8nRgWkPK+Cvg/bkZPyeVHuXu/3X3PV6qyAB0VTZ4CXmxI=
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr13815032itl.144.1544020743940;
 Wed, 05 Dec 2018 06:39:03 -0800 (PST)
MIME-Version: 1.0
References: <1541712198.12945.12.camel@gmx.us> <D7C9EA14-C812-406F-9570-CFF36F4C3983@gmx.us>
 <20181110165938.lbt6dfamk2ljafcv@localhost> <a2a9180f-32cf-a0fa-3829-f36133e3b924@gmx.us>
In-Reply-To: <a2a9180f-32cf-a0fa-3829-f36133e3b924@gmx.us>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 5 Dec 2018 15:38:51 +0100
Message-ID: <CACT4Y+ZXHgvHdZc=VDsiTSBCkG3FomEC3TAhZgw9-_L4RBukjQ@mail.gmail.com>
Subject: Re: kmemleak: Early log buffer exceeded (525980) during boot
To:     cai@gmx.us
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 5:21 AM Qian Cai <cai@gmx.us> wrote:
> On 11/10/18 11:59 AM, Catalin Marinas wrote:
> > On Sat, Nov 10, 2018 at 10:08:10AM -0500, Qian Cai wrote:
> >> On Nov 8, 2018, at 4:23 PM, Qian Cai <cai@gmx.us> wrote:
> >>> The maximum value for DEBUG_KMEMLEAK_EARLY_LOG_SIZE is only 40000, so it
> >>> disables kmemleak every time on this aarch64 server running the latest mainline
> >>> (b00d209).
> >>>
> >>> # echo scan > /sys/kernel/debug/kmemleak
> >>> -bash: echo: write error: Device or resource busy
> >>>
> >>> Any idea on how to enable kmemleak there?
> >>
> >> I have managed to hard-code DEBUG_KMEMLEAK_EARLY_LOG_SIZE to 600000,
> >
> > That's quite a high number, I wouldn't have thought it is needed.
> > Basically the early log buffer is only used until the slub allocator
> > gets initialised and kmemleak_init() is called from start_kernel(). I
> > don't know what allocates that much memory so early.
> >
>
> It turned out that kmemleak does not play well with KASAN on those aarch64 (HPE
> Apollo 70 and Huawei TaiShan 2280) servers.
>
> After calling start_kernel()->setup_arch()->kasan_init(), kmemleak early log
> buffer went from something like from 280 to 260000. The multitude of
> kmemleak_alloc() calls is,
>
> for_each_memblock(memory, reg) x \
> while (pgdp++, addr = next, addr != end) x \
> while (ptep++, addr = next, addr != end && \ pte_none(READ_ONCE(*ptep)))
>
> Is this expected?


FTR, this should be resolved by (if put pieces together correctly):
https://lkml.org/lkml/2018/11/29/191
