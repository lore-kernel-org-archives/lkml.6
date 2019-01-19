Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8E5C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 11:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BB42084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 11:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lkcl.net header.i=@lkcl.net header.b="EgBpfpRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfASLHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 06:07:04 -0500
Received: from lkcl.net ([217.147.94.29]:36262 "EHLO lkcl.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbfASLHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 06:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lkcl.net; s=201607131;
        h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version; bh=iozwcs/cQO3GQ3kgVLycB5QzCPdQ4YPXoSD0+LwbBLc=;
        b=EgBpfpRDIUPQmN6W5nMcX3gK5WrBC2rt4Zu9LUYpIkJjhVNfofgpTj/svoJdUOQ97qwq1rprDeblbfrceIReqqMsYxt4Q0Qu4WPOEdJwNDquOrBXWpsAWiBhq9FZjGQYh4aDeJVbL6RJi2S2A5HWcvlf9dJtGEE5uRMCbChB8U4=;
Received: from mail-lf1-f44.google.com ([209.85.167.44])
        by lkcl.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <lkcl@lkcl.net>)
        id 1gkoSs-00054E-1i
        for linux-kernel@vger.kernel.org; Sat, 19 Jan 2019 11:07:02 +0000
Received: by mail-lf1-f44.google.com with SMTP id l10so12310687lfh.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 03:06:45 -0800 (PST)
X-Gm-Message-State: AJcUukdRAVl8kiaVOQM3qSqthl/wln2qkE7m6wmHz+ixL55fvOz0um/S
        ptEkhssHA1TG5f7jPhHn5UpVlLDc2+O03eHa7hw=
X-Google-Smtp-Source: ALg8bN5DlI5SPnYLsdcG5q7XTG7oM0Ij5EN80ZN/IKn06yTj5kRGL+LeGCDaP1ErcUjBYVW34Nx/4+WNfYX7epd3oeI=
X-Received: by 2002:a19:e01e:: with SMTP id x30mr14205249lfg.89.1547896000268;
 Sat, 19 Jan 2019 03:06:40 -0800 (PST)
MIME-Version: 1.0
References: <CAPweEDyvUdGvwy4u5qoA2QgDow0npZBMqjeMiU2RqzrJ_q4Omw@mail.gmail.com>
 <CAPweEDyV487=EWqAibc5g_yhtuvy3w2qabCSOqh32q38rrXLSw@mail.gmail.com> <20190118150706.7b1b9e31@alans-desktop>
In-Reply-To: <20190118150706.7b1b9e31@alans-desktop>
From:   Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Date:   Sat, 19 Jan 2019 11:06:28 +0000
X-Gmail-Original-Message-ID: <CAPweEDw34REx15uQ50pRoXZ+FfLxegcvxm8DN7323NrgOCsZKA@mail.gmail.com>
Message-ID: <CAPweEDw34REx15uQ50pRoXZ+FfLxegcvxm8DN7323NrgOCsZKA@mail.gmail.com>
Subject: Re: [RFC] spectre hardware-software cooperative mitigation
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, January 18, 2019, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>
> > This is going to be a mammoth task. The alternatives are to continue
> > as things are, which is a mess that cannot be cleaned up by either of
> > (mutually exclusive) hardware or software alone.
> >
> > Thoughts and feedback appreciated.
>
> You need to be talking to the JIT developers not asking here I think.
> Speculative attacks in JIT environments is a topic an order of magnitude
> or more complex than the kernel cases because there isn't even process
> isolation between the JIT, JIT engin eand support logic.
>

Hi Alan thanks for engaging on this.  Deep breath: it's everything.
OpenSSL, linux kernel, uboot, JIT developers, PAM, system calls,
interrupts, exceptions, everything. Anywhere any time there is a
transition (of any kind, not just JIT environments) from trusted code
to arbitrary untrusted code, whether it be linux kernel, uboot,
applications, BIOSes, literally and absolutely anything and
everything, on every processor that is OoO, regardless of ISA.

In essence our basic fundamental assumptions about security separation
are... gone [for OoO processors].

Since I wrote the OP I found that the RISCV BOOM team had done some
research, and also concluded that explicitly called speculation
"fences" were the sanest solution. Link to discussion:

https://groups.google.com/forum/?nomobile=true#!topic/riscv-boom/yxDwmpjtQrE

Where my expertise runs out is whether it should be libc6 that calls
the firebreak instruction (or if one does not exist, a set of 100 NOPs
or whatever is found to be best suited for a given OoO processor), or
whether it should be the linux kernel that does so, perhaps as part of
the context switch point.

An OoO processor that has since been designed to clear the entire
speculation state on a context switch, interrupt or exception clearly
would not need to call the firebreak (fence) instruction in the linux
kernel context switch (from kernelspace to userspace as you do not
want info to leak from privileged to non-privileged) however those
that do not have such capability just as clearly would need to.

Whether the same fence should be called on the switch from userspace
to kernelspace? Honestly I do not know, I believe it would depend on
the level of paranoia :) Do you trust the linux kernel not to be
compromised, if it is, do you consider it Game Over already, that sort
of thing. Don't know the answer there.

So, yes, JIT definitely more complex, fence will definitely help...
however it is everywhere, *all* software needs to engage on this and
begin the long arduous process of designing, agreeing and then
implementing a sane mitigation strategy.

Yes BIOSes too ( Anyone still think proprietary BIOSes are a good idea? Intel?)

Or, we can all go back to using 25+ year old x86 processors (486s,
yay! Anyone still got an original OLPC, with the Geode LX500, or even
a Vortex86?), or use ARM Cortex A7 32 bit, Cortex A53 64 bit, or
MIPS64, anything that's in-order that can be found... *if* they can be
found... :)

l.
