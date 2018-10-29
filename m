Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD6FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BB82082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XrIkWIH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BB82082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeJ2VvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:51:01 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:39412 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbeJ2VvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:51:01 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w9TD2LXq017321;
        Mon, 29 Oct 2018 22:02:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w9TD2LXq017321
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540818142;
        bh=YDaCDY8FCsF1f5BGqFmiMZ6mi5NaHAelBARsG0c0M7M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XrIkWIH7w2Jnt+9T2ADANVD/ahXiiD67/2WHs7wgmP03+Z714Old5iwsuZSgyfyUE
         SP3Eqf5CnIq01TujzQQrw7x4fTltjjAvJ7OKAkmIy3Kg2YJ7gBcHyPQTAyEVLMJSAL
         b0TkxAH0JPCuDHwxjRTxOCe3dzx5FFRq1W7ox+nH3LBpGXulvzQGpvmjjh9ajyk9Y3
         4zSz5920xpQVt1/zysZja74awSPlAfuVNMZVW6xooxYyo8r0+/GXX2bOxy1ghqI9gV
         f8sVUtEX3tV/I4ktfN8wKn8PPm0JI8kfDcUsJPJlEq4jrx6XtqUymdR4mo8WAMSVhe
         e76oCNlbmHApA==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id h78so4083600vsi.6;
        Mon, 29 Oct 2018 06:02:22 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKvoGLE9Dc0t3EamKhpCCoZ09oYCkH1/5V3YnpCytD/Y8Q0ydhY
        X7+SD85QCu/gTe7gMUUStuL5wnxAAoz7t+/9yGg=
X-Google-Smtp-Source: AJdET5dakDnC9lpnLskGbKJAazyLHxGf6sqO6DDC3pnuVv5RjJhsy8LeXGuE5HmjKsQkmkVTON45X+7QW5tTI93y+G8=
X-Received: by 2002:a67:a858:: with SMTP id r85mr5821206vse.215.1540818141011;
 Mon, 29 Oct 2018 06:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181019124921.13780-1-changbin.du@gmail.com> <20181019124921.13780-5-changbin.du@gmail.com>
 <CAK7LNARW0=0d7m5DAgZOir=h0Y4tssqZoQRGasnGPNnvNf_+pg@mail.gmail.com>
 <20181028125106.azcn2dxia3snplin@mail.google.com> <CAK7LNARr7bE=DVuzim5771heuN5os0=5-D+jXfUyBb2e1xYoRA@mail.gmail.com>
 <20181028131357.parhzj32feapxncb@mail.google.com>
In-Reply-To: <20181028131357.parhzj32feapxncb@mail.google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 29 Oct 2018 22:01:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ0iZDHP8zQZ_Ws4Wy4H6rwiV5p-A0bM1yVJLP51sqQeg@mail.gmail.com>
Message-ID: <CAK7LNAQ0iZDHP8zQZ_Ws4Wy4H6rwiV5p-A0bM1yVJLP51sqQeg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] kernel hacking: new config CC_OPTIMIZE_FOR_DEBUGGING
 to apply GCC -Og optimization
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


On Sun, Oct 28, 2018 at 10:14 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> On Sun, Oct 28, 2018 at 10:09:21PM +0900, Masahiro Yamada wrote:
> > Hi Changbin,
> >
> > On Sun, Oct 28, 2018 at 9:52 PM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > > >
> > > Thanks for pointing this out and kind suggestions. I have tested with your
> > > modification. Will update patch serias soon.
> >
> >
> > I have one more request.
> >
> > The patch subject
> > "kernel hacking: new config CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og
> > optimization"
> > is too long (83 characters)
> >
> >
> > I'd like the subject to be within 70 columns or so.
> >
> oh, I just sent new version. Could me update the title if there are more
> suggestions then?



How about this?

2/4: kernel hacking: add a config option to disable compiler auto-inlining
3/4: ARM: mm: fix build error in fix_to_virt with -Og optimization level
4/4: kernel hacking: support building kernel with -Og optimization level

(The CONFIG name is so long that the subject
would easily exceeds 80-columns with it.)


I applied this series to linux-kbuild,
and will send another pull request in this MW.


If you come up with better patch titles,
please let me know.
I will fix them up locally.



-- 
Best Regards
Masahiro Yamada
