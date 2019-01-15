Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA87C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7277A20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKZjzM8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfAOIDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 03:03:40 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36003 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfAOIDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 03:03:40 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so3240640itj.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 00:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=diiEWDX44BOe4NT7RrmIC7ycUWFcVVb8CxAufP2VRlg=;
        b=JKZjzM8xGwApm57TTGagZoIwst51XSkiODfSpafNraXFr63NGkQNpKDUH+ObUmLtH5
         noPURbG2Kf32zt5pow8QtiBAzUVxykLDiSRWbfyPN0gOEebtXm0fqJj4Qn8L653dRC3G
         1GQD+HTSjyAuJbZVtmX9ruJCa5i5asEQlL+5PNAMGk2WoWggJIG+E3Fj6mdH+/uQOz/B
         jSoFB0SnDpTrdMNTp13PcdYpBmrf9WrLqTIUnI1w709uFu3yAmOBGVXHPRhoVZEkciSN
         9hcWqXheD9+GgnOH5WO0tLJqL76uXOYP6I6c/X/WElp3Q6Zc1h5ejFbOZ5FEE3h8xIYT
         tilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=diiEWDX44BOe4NT7RrmIC7ycUWFcVVb8CxAufP2VRlg=;
        b=KHe37/qRaVisEq9RP1X42/WT7g5pFdLERsYj1dScBEvfTMv85QOgpuTZbCKDWUwjIb
         XwRcc/zt/aKKMB6Pda7EylcaHvfUX9VYSHOmSPTMpNKHSiPNc0iR0toy0eUuixXNNyUw
         iwYmZzdyh1mvKkOS7WBbckYffrV/XreMuuG23DFt9aO/nt1b8kkiNwiFifxmLKX6j8Wz
         cN3BT+whLNo9+3T4lCShtzpLPO86EW8yvgXDmXfw9+IvSHG6OXpsW1dzd59xq2HdEF1C
         18CXk6Je+Zj9JXm105ZKe4ccGahOdfwM+SW4TMffcUPn+38dOwjPcoSLbyxKF2blUmiU
         djrg==
X-Gm-Message-State: AJcUukd1hYzk9e2UcyOP8PyQAjcyV1G62kCFY1sYgWAJdMpfh91OGGFU
        B+Ze6dRdVv6keO7ymiRg76VoU0PLDDXqA2tIJ3Xxm7lu6Q==
X-Google-Smtp-Source: ALg8bN6IP/ruYTFt1mmMcC0QZOtbH6j/kFLqmbbs707ESbj/CGpi1P2Vg+5CQGk5vAM+yxTG6cmUX8IwPO/eaM9bcz4=
X-Received: by 2002:a24:7a94:: with SMTP id a142mr1487881itc.88.1547539419157;
 Tue, 15 Jan 2019 00:03:39 -0800 (PST)
MIME-Version: 1.0
References: <1547435711-5786-1-git-send-email-kernelfans@gmail.com> <8206281c-c4e6-278a-899b-27cf9affd0da@infradead.org>
In-Reply-To: <8206281c-c4e6-278a-899b-27cf9affd0da@infradead.org>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 15 Jan 2019 16:03:28 +0800
Message-ID: <CAFgQCTv2P7vPDweK=yj3M2o-vV8x_CMdzASKHV60uioz9A-mKg@mail.gmail.com>
Subject: Re: [PATCHv6] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 12:24 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi,
>
> Just fix a few of the commit log comments...
>
> On 1/13/19 7:15 PM, Pingfan Liu wrote:
> > People reported a bug on a high end server with many pcie devices, where
> > kernel bootup with crashkernel=384M, and kaslr is enabled. Even
> > though we still see much memory under 896 MB, the finding still failed
> > intermittently. Because currently we can only find region under 896 MB,
> > if w/0 ',high' specified. Then KASLR breaks 896 MB into several parts
>
>   if w/o
> or preferably:
>   if without
>
> > randomly, and crashkernel reservation need be aligned to 128 MB, that's
> > why failure is found. It raises confusion to the end user that sometimes
> > crashkernel=X works while sometimes fails.
> > If want to make it succeed, customer can change kernel option to
> > "crashkernel=384M, high". Just this give "crashkernel=xx@yy" a very
>
> no space?  just
>   "crashkernel=384M,high"
>
> > limited space to behave even though its grammer looks more generic.
>
>                                           grammar
>
Thanks for your review, will cc you in next version.

Regards,
Pingfan
> > And we can't answer questions raised from customer that confidently:
> > 1) why it doesn't succeed to reserve 896 MB;
> > 2) what's wrong with memory region under 4G;
> > 3) why I have to add ',high', I only require 384 MB, not 3840 MB.
> > This patch tries to get memory region from 896 MB firstly, then [896MB,4G],
> > finally above 4G.
> > Dave Young sent the original post, and I just re-post it with commit log
> > improvement as his requirement.
> > http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
> > There was an old discussion below (previously posted by Chao Wang):
> > https://lkml.org/lkml/2013/10/15/601
> >
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > Cc: yinghai@kernel.org,
> > Cc: vgoyal@redhat.com
> > ---
> > v5 -> v6
> >   discard bottom-up allocation, just repost dyoung's original patch with commit log improved
> > ---
> >  arch/x86/kernel/setup.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index 3d872a5..fa62c81 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -551,6 +551,22 @@ static void __init reserve_crashkernel(void)
> >                                                   high ? CRASH_ADDR_HIGH_MAX
> >                                                        : CRASH_ADDR_LOW_MAX,
> >                                                   crash_size, CRASH_ALIGN);
> > +#ifdef CONFIG_X86_64
> > +             /*
> > +              * crashkernel=X reserve below 896M fails? Try below 4G
> > +              */
> > +             if (!high && !crash_base)
> > +                     crash_base = memblock_find_in_range(CRASH_ALIGN,
> > +                                             (1ULL << 32),
> > +                                             crash_size, CRASH_ALIGN);
> > +             /*
> > +              * crashkernel=X reserve below 4G fails? Try MAXMEM
> > +              */
> > +             if (!high && !crash_base)
> > +                     crash_base = memblock_find_in_range(CRASH_ALIGN,
> > +                                             CRASH_ADDR_HIGH_MAX,
> > +                                             crash_size, CRASH_ALIGN);
> > +#endif
> >               if (!crash_base) {
> >                       pr_info("crashkernel reservation failed - No suitable area found.\n");
> >                       return;
> >
>
> ciao.
> --
> ~Randy
