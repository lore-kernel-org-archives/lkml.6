Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8233FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD7A2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XYHfePeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfAGSLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:11:36 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38489 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbfAGSLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:11:36 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so1151004lja.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 10:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LSVPbZOzIpA46DnYKi1N6eMWrOzqy7jhv2n0JH8c99k=;
        b=XYHfePehw8OV8lupdZXORmGANvaBpFRxdfxkkWD9C8fjfaH+7RBST+euXWdAREmSMO
         hUHNf6PVg0DgqNVpALSHiIVK35b+adNxVqpOXDp3zeu6FyjiG6/pWSgvF6uO9C7zhLBR
         mDoOxpz2cIQXFMhSrL6aM2fJqf4ISBY4z+EVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LSVPbZOzIpA46DnYKi1N6eMWrOzqy7jhv2n0JH8c99k=;
        b=Fsf59saNme8/He/EcY1iHDYPTpoN2OPI5KsqKkpvGmeGSpe+uww2jR8LMl9xCTNsyC
         xclKZa55v7ux1LRnCnimNyTuSerQGDlXO1/858+KP2mDRrPTQt3ZHLoxnxMhLpjLnNwq
         kXSn4YNYKD8wUCrvcVqOlSKRfHpXDVuewO8jp6dHvC0CfwcNP4/NwoIUGNQR/jBjyAQ8
         jePg7ZKKCC8ly00YK0pyXXRrhjM3LBbzshd+nfWD+7XgX67PI9ARs6FVjibZi8Fa5RuM
         xvk8HABdaZIwK8xEljCLaN4QqYEvWLD3xz9phlrytzsY/5ObRdHUfl2uKMr+NlcJIZri
         SF3A==
X-Gm-Message-State: AJcUukfsCexWsUfYq4vUmDHIPlBbbwhzWXU8H9albz9P3fdzGpwxnO58
        o7l61pjyYQQSvITA6jP7gVHbMHBBPrk=
X-Google-Smtp-Source: ALg8bN4Rp5343qSsFWaQ9OIbM0a6KWL4oH2pTWiVCvJmtJfAT3jVsMQ4H7W2CnuMIkU8KZ5YFE+VBQ==
X-Received: by 2002:a2e:9e16:: with SMTP id e22-v6mr34436631ljk.4.1546884693435;
        Mon, 07 Jan 2019 10:11:33 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id b25sm12610405lfa.96.2019.01.07.10.11.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 10:11:33 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id v1-v6so1169247ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 10:11:33 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr18524029lji.133.1546884329117;
 Mon, 07 Jan 2019 10:05:29 -0800 (PST)
MIME-Version: 1.0
References: <20190106180927.GA11993@roeck-us.net> <CAHk-=whyNbpBtPyoS=wh4nVgBtUBpihcOT+LFdEw369kYjATaQ@mail.gmail.com>
 <CAHk-=wiSVm6j1Ga8gra6hSQQSK8WF5bW4DtRi4V7mCtCUkTaQw@mail.gmail.com>
 <78e3717b-0604-3d5f-38b8-c523e392fc76@roeck-us.net> <CAHk-=wg45nXe50ORC7reBJqsFGUPELtbk5p7ijkE9=fs1wGLAQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg45nXe50ORC7reBJqsFGUPELtbk5p7ijkE9=fs1wGLAQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Jan 2019 10:05:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgnLcrL8PbS0Dz3nprCXvR5iFCKjVvJmN_EbZW88i4L7w@mail.gmail.com>
Message-ID: <CAHk-=wgnLcrL8PbS0Dz3nprCXvR5iFCKjVvJmN_EbZW88i4L7w@mail.gmail.com>
Subject: Re: [PATCH] make 'user_access_begin()' do 'access_ok()'
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Matt Turner <mattst88@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Paul Burton <paul.burton@mips.com>,
        Greentime Hu <green.hu@gmail.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gaah. Re-sending this for the kernel mailing list just for posterity.
I keep replying to emails that had the mailing list address wrong, and
then my reply will have it wrong too.

I will learn to fix up the address just in time for this thread to die
out, I suspect.

                Linus

On Mon, Jan 7, 2019 at 10:02 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Jan 6, 2019 at 8:05 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Of the above, my test system boots images for the following architectures
> > in qemu.
> >
> > - mips (32/64 bit, big/little endian)
> > - nios2
> > - openrisc
> > - xtensa (mmu and nommu)
>
> So most of those are "only" the "macro arguments used twice" problem
> (although openrisc also does the "arguments not quoted right"). That
> doesn't cause problems with the new commit, it's an independent issue
> that could cause random problems elsewhere
>
> The nios2 access_ok() case is the same bug as alpha has, but it turns
> out to be hidden by the fact that the user/kernel limit is at
> 0x80000000, but nios2 does:
>
>     # define TASK_SIZE           0x7FFF0000UL
>
> so it doesn't actually allow anything close to the top of the user
> address space anyway. So the access_ok() check uses a different limit
> than the TASK_SIZE, which is odd, but does hide the "last byte of the
> user address space" bug.
>
> That may be intentional, and regardless, it's generally a good idea to
> not allow mapping of the last page in the address space, exactly to
> avoid the border conditions.
>
> MIPS has some of the same "saved by mistake" behavior, but in that
> case it really looks to be pure luck, not design. In particular,
> MIPS32 has
>
>   #ifdef CONFIG_32BIT
>   #ifdef CONFIG_KVM_GUEST
>   /* User space process size is limited to 1GB in KVM Guest Mode */
>   #define TASK_SIZE       0x3fff8000UL
>   #else
>   /*
>    * User space process size: 2GB. This is hardcoded into a few places,
>    * so don't change it unless you know what you are doing.
>    */
>   #define TASK_SIZE       0x80000000UL
>   #endif
>
> and I suspect you tested MIPS32 with that KVM_GUEST config option.
>
> Because MIPS32 with TASK_SIZE 0x80000000UL really looks like it has
> the off-by-one error that I think makes access_ok() fail for the "last
> byte of the user address space" case.
>
> HOWEVER. MIPS32 is actually going to boot for that case with the
> recent patches for a simple other accidental reason: despite the
> access_ok() bug, it will never trigger it in strncpy_from_user(). Why?
> Because MIPS doesn't use the generic version, but its own hardcoded
> assembler one.
>
> I suspect the MIPS assembler version is actually *worse* than the
> generic one (it looks like it does things one byte at a time), but it
> hides the bug in access_ok()...
>
> The other architctures you tested only have the "technically wrong,
> but works" bugs that don't matter for the new stricter access_ok()
> tests.
>
>                 Linus
