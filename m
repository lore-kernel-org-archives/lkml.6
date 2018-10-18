Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455C2C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1389C21476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1389C21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeJRQg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:36:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43640 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbeJRQg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:36:57 -0400
Received: by mail-qt1-f195.google.com with SMTP id q41-v6so33282201qtq.10;
        Thu, 18 Oct 2018 01:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TEp5QxBVO7sQiQ59x6yjReEpENZO73u6yBkTFnVrSdI=;
        b=Yqr6TrHru7qRylVBC3FLSEfzQZMi3kbepp5Vm4joeYP8OJE2x1DY4FbB2U3Z1spqlS
         L44v+TI0CEAzdv0Udq9zF6hZrUKc01QJ+7X7EWSMUm0lduSJr2eioLx2ew0CDGP7AgeR
         7j9cXn03KeBHXmEkbWfLCJD7NnTkRzaBXO1rV2CeoKNN7DtkOGCKKpnCaHy9yF2oqt9T
         wSh9p6bIPNriru4ebTJy/42uhkDLtHZ7kawpOyrG2ctdYZ9H0c1zP9etUwQGHHMBiVwx
         2M7WfbxNt7QHWwTH33XsiktpiLaJ2lwJyIKr2aV1uRJ9vBlccmT8OHtyWDENLZghP3kX
         hkWQ==
X-Gm-Message-State: ABuFfoi/VLmsXAgq1IqS8O8NLGHbIT5zTGgx68cSCke6GY/cV3kPvcnh
        TnWNt7liMhykOcYh9PyIc5vYzLt+xQ7bsHktki0=
X-Google-Smtp-Source: ACcGV60s0DDv3+W4Ciqm8+DKQ/rfHgO7NqUu4gq4nIj/rVkvzaxcKzWedqCbwXm7KluIvVCc7W0gr2XJ3bBG7OHAMX4=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr27535463qtd.319.1539851822252;
 Thu, 18 Oct 2018 01:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <CAK8P3a25W5rE093QsmC539d+s038Wv9PmV8Xa76LQzDLk3E8Wg@mail.gmail.com>
 <20181018041038.GB17276@guoren-Inspiron-7460>
In-Reply-To: <20181018041038.GB17276@guoren-Inspiron-7460>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 18 Oct 2018 10:36:45 +0200
Message-ID: <CAK8P3a0wRPfXm3wupQd6RdN6L8CvjD0HX_Bk61VBxOYeNCh+FA@mail.gmail.com>
Subject: Re: [PATCH V9 00/21] C-SKY(csky) Linux Kernel Port
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 6:11 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> On Wed, Oct 17, 2018 at 05:58:46PM +0200, Arnd Bergmann wrote:
> > On Tue, Oct 16, 2018 at 4:58 AM Guo Ren <ren_guo@c-sky.com> wrote:
> > >
> > > This is the 9th version patchset to add the Linux kernel port for
> > > C-SKY(csky) based on linux-4.19-rc3.
> > >
> > > There are only a few changes between V8 patchset. Hope it could be
> > > merged into linux-4.20 and I'm very grateful for any help.
> >
> > I've gone through the entire series once more and saw no show-stoppers.
> > The last patch looked like it introduced a bug, but with that one dropped,
> > I'm happy for the architecture to get merged, unless anyone else
> > has any last-minute concerns. (Alternatively, explain why I'm wrong
> > and the code works correctly, of course).
> Ok and thx for the job of csky subsystem.
>
> >
> > I'd appreciate having someone else take another look at the signal
> > handling code, the atomics, and the DT bindings and provide another
> > Ack for those.
> >
> > The remaining open question is about the 32-bit time_t interfaces.
> > With 4.20, I did not manage to get the required system calls in place
> > for using 64-bit time_t in a new architecture, so you will at least
> > start out using 32-bit time_t and likely have to keep supporting
> > that going forward, unless we decide to break the ABI here later
> > on .This is something we normally don't do, but we might make
> > an exception here, under the assumption that there are no
> > existing users with the ABI. We can debate that once we get there.
> We support uclibc-ng and glibc.
>
> 1. For uclibc-ng, linux-4.20 could run with it.
>
> 2. For glibc, Maybe we could support 32-bit + 64-bit time_t with
> KERNEL_VERSION, or just only 64-bit then linux-4.20 couldn't work with
> the csky first glibc release.

Yes, it is always an option to make glibc more restrictive than the kernel.
We could also just make it a configuration option in the kernel whether
the system calls are provided, so they don't use memory for the
implementation.

You will probably want musl support at some point. musl-1.x always
uses 32-bit time_t today, but musl-2.x will use the 64-bit interfaces,
so just waiting a bit will probably make it work out for you.

        Arnd
