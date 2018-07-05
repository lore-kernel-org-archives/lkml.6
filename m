Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DF6C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596992403E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFF4Wg0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596992403E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753521AbeGEX4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 19:56:40 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36776 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753254AbeGEX4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 19:56:39 -0400
Received: by mail-io0-f193.google.com with SMTP id k3-v6so9326217iog.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 16:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Jg+kk1sfLejIHm/6mOEyg7g4oShylG2TuEITS9B7/PI=;
        b=jFF4Wg0DGMFcnl0zfc1P+QDOFXibQ0BPjRCAp46A2uaJaaiYqdR4SQjWWXU2ZariLx
         6gp5+ky917KcBVbbI859ofv+Gt67tO+ywRB8L/LmCDZgpCQQHy1CL0yH8AID3YHHYKRh
         d+C7dXLkv19pUGXalsp/iRTsacDkeSRnr+5YzEtae7vdOHlrspZWF0VOR2l3SgJPn8yO
         QLHpOzy9V5I3Gyeb5REPnNy/libkr1MXIjvKq78exFveQys9r8BTk6ym5Ff+/8xIKwSP
         ExDHP+xKWrzIDy5aMlIkxOgNhwEKr9L6+f9NQT5nxZWZk8Y11LD+iP2gI/G3qx3GGK9p
         edPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Jg+kk1sfLejIHm/6mOEyg7g4oShylG2TuEITS9B7/PI=;
        b=XwKUl4VxtAiWqylbGs+f4K2MjtMK9ppWIi/qWomJn8KBrG6gq2zVfxvDcibhT97v86
         K3l++rqAcoIeOCMNNdAunnVl8r+KFeYOVEOWuv5677IkAst6aSGKNLd+qeHuN/Y3pQqD
         OllZiiB8/9C+xNRtWHdkKaPbvImU/23biaVnH/QNyls7KoA+8+et7LQtDLsO1KvDk9Vv
         pmt9Hql8nK+501duD2wNQAP1qj6NuSPeGqBIzC3xfwQEYXn/+g+Z6rScI5MecFwDPOcx
         RZ8F1qiwnYYjndntPp/4KGLevLhs+La0Wl/5qC/5h3WMsbdcsgiBzQEWkyyDXvw32g5y
         8sZA==
X-Gm-Message-State: AOUpUlGr5tonAePyhjNFiqrp+HWN7PHDIEN8D8/uX5qDjvFrv1+130mO
        1Ub9Drg/CXq1RfiJo8tOlwDhhOMwSiWNBFyY0N8=
X-Google-Smtp-Source: AAOMgpeHJuUNzJ0Q67C8kXCkuY/1cRI+N5ZPvSU7JkxziXc48AKZ5CZ8iai/FsxyLK3DjhQd5IOQNAEwhHMzJNVBPM8=
X-Received: by 2002:a6b:e704:: with SMTP id b4-v6mr6978403ioh.239.1530834998498;
 Thu, 05 Jul 2018 16:56:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6801:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 16:56:38 -0700 (PDT)
In-Reply-To: <20180705222110.GA5698@infradead.org>
References: <20180705213604.18883-1-deepa.kernel@gmail.com>
 <20180705213604.18883-4-deepa.kernel@gmail.com> <20180705222110.GA5698@infradead.org>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Thu, 5 Jul 2018 16:56:38 -0700
Message-ID: <CABeXuvoj_WwvnaqY1wao+axx1JLpPte-iXP=Ti7jsT+r6VrVUg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] riscv: Include asm-generic/compat.h
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        linux-riscv@lists.infradead.org, palmer@sifive.com,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 3:21 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Jul 05, 2018 at 02:36:00PM -0700, Deepa Dinamani wrote:
>> defconfig, allmodconfig and nomodconfig.
>> And hence does not inlude definitions for compat data types.
>>
>> Now that time syscalls are being reused in non CONFIG_COMPAT
>> modes, include asm-generic definitions for riscv.
>>
>> Alternative would be to make compat_time.h to be conditional on
>> CONFIG_COMPAT_32BIT_TIME. But, since riscv is already has an
>> asm/compat.h include the generic version instead.
>
> Two comments here:
>
> First I think the current riscv compat.h is completely bogus.
> As you mentioned riscv does not actually have a compat mode, so
> having a compat.h makes no sensse at all, and the COMPAT_UTS_MACHINE
> override which is the only thing implemented is included in that
> statement.

I was leaving the decision on how to clean up compat mode to the
architecture maintainers.
I wasn't sure if they were still in the middle of implementing it.

> Second I think abusing compat.h for old syscall compatibility of any
> form is a really bad idea.  I think you need to split that part out,
> and preferably not using compat in the name, but something like
> old-time.h or time32.h for the name.

Are you talking about just the header file or the way we are reusing
compat syscalls?
Either way, we have merged quite a few patches this way already.
I agree that having something like time32.h might be less confusing.
But, if you are worried about the former, then maybe we should propose
a cleanup after we finish what we are doing or back out the merged
patches.
For instance, posix_clock apis have already been changed this way.

-Deepa
