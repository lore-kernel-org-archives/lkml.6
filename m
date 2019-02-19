Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B50C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4EE2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfBSOmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:42:20 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41239 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfBSOmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:42:20 -0500
Received: by mail-qt1-f193.google.com with SMTP id v10so23341293qtp.8;
        Tue, 19 Feb 2019 06:42:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VV2DLHSJG0WzEiXZTUh22wQH5wNlBSLqE89RN91Csgg=;
        b=h2efei/XKnJ+w0RLheSIiOikViuqY/ZHDehWEpd6m+SayLoeZY8/7+s+SjPJpvcTU+
         yzfkuIJzl6ZJ6C+ibQgsLt1TTYeb5tQOXMJTG7uSyPfTtVSy+Qu2s2JaeVKF5eBVxM6y
         IQddAACDADRZylbZXRJfrfJW906VIgkzIBG/uh6QXq64OMJ5OzHUzw0nLnJSK724PKaO
         F9SUaCx1QxDzqprEfyH4vb3pTlxr/X21ukgD02J2BSB25zmgvlcLlAxSSP7HzcjvdPQc
         W/nINlynIUz+F/sa9yfahDsGfb5vZVY2FHgz3ur6CParOTGS35nbwbJ0fRrUwt2nIy6V
         O6Ww==
X-Gm-Message-State: AHQUAuYncFVYfzOVVgtB9R3oQ+fD/avdL6Jx3nXjNx3X9BOauPgIV52E
        bXg+ERB8qVEmfaYcv6MM10lXK2ZF0NZXnUrnKq6sTw==
X-Google-Smtp-Source: AHgI3IYs2MqftGxmfubP57HFGVgpbDD0MgfaydgkUHAD5NgsatcBHk56kv+D3kcz59vsmpio88UKDWgD6X1fMqj+SjU=
X-Received: by 2002:a0c:d791:: with SMTP id z17mr21343363qvi.149.1550587339200;
 Tue, 19 Feb 2019 06:42:19 -0800 (PST)
MIME-Version: 1.0
References: <20190219173654.47e9bc36@canb.auug.org.au> <20190219074519.GA2294@behemoth.owl.eu.com.local>
 <CAK8P3a0omA-__7MLAw_SKuug_GZ0FfFPVr1Tsnx5Hb0sesv8gw@mail.gmail.com> <20190219111918.GC2294@behemoth.owl.eu.com.local>
In-Reply-To: <20190219111918.GC2294@behemoth.owl.eu.com.local>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Feb 2019 15:42:02 +0100
Message-ID: <CAK8P3a3vVr+nJWuc3tWOcWn55DW6a=YF_OntqwPYnemW_jos6Q@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the asm-generic tree
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 12:19 PM Hugo Lefeuvre <hle@owl.eu.com> wrote:
>
> > I'm not sending a pull request for this if it breaks any architectures,
> > so I think we need to fix them all, and I suppose we also have to
> > change all architectures in the same patch that changes the architecture
> > independent declaration, so it doesn't break intermittently.
> >
> > At this point, I'd probably drop your patches from my asm-generic
> > tree  entirely to avoid the regression, and wait for you to resend
> > them all after 5.1-rc1, for inclusion in 5.2.
> >
> > Can you elaborate on the original problem that you saw? Maybe
> > we can have a different workaround for it in the meantime.
>
> Agree, these two patches should be dropped:
>
> 1. iomap: add missing const to ioread*/iowrite addr arg
>
> since there are incompatible definitions or declarations in
>
> arch/alpha/include/asm/core_apecs.h
> arch/alpha/include/asm/core_cia.h
> arch/alpha/include/asm/core_lca.h
> arch/alpha/include/asm/core_marvel.h
> arch/alpha/include/asm/core_mcpcia.h
> arch/alpha/include/asm/core_t2.h
> arch/alpha/include/asm/io.h
> arch/alpha/include/asm/io_trivial.h
> arch/alpha/include/asm/jensen.h
> arch/alpha/include/asm/machvec.h
> arch/alpha/kernel/core_marvel.c
> arch/alpha/kernel/io.c
> arch/parisc/lib/iomap.c
> arch/powerpc/kernel/iomap.c
> arch/sh/kernel/iomap.c
>
> 2. lib/iomap: add missing const to mmio_ins* addr arg
>
> since there are incompatible definitions or declarations in
>
> arch/sh/kernel/iomap.c
>
> I will resubmit them with all changes required for arch/. The ones for
> alpha, powerpc and sh are already ready and built with cross compiler.
> I still have to setup a cross compiler to build my parisc changes.

I've dropped all your patches for the moment, since one of the remaining
ones had a conflict against changes in the char-misc tree, and the
last one didn't do much by itself.

Please submit the full set again after -rc1.

        Arnd
