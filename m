Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B047C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82692154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=profitbricks-com.20150623.gappssmtp.com header.i=@profitbricks-com.20150623.gappssmtp.com header.b="M/CcnVQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82692154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=profitbricks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeHTQg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:36:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50324 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbeHTQgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:36:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so14299836wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 06:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profitbricks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JsLiieC+cQBLTw5SD8oL1Qgnwzz8SoYUOjzsMtdxQck=;
        b=M/CcnVQLPigWG5dWcw7Ywpd3mu+mUU+uoLvHjr+S/mCuXhX7eOX27DlmgmIEUiHYtr
         llzNmA6LdzxT8hdceVDS8EPtldxC5t8jO0lXZN799yQHDqpLlPwxrZB1iJ3hF2v6yCjX
         Bl/QdIVBlUhG2yKoHwquqj1CcYhE5Id8PGULCMNF8aq+v0Usiee8VKBmZf4wFSTJloMa
         VjX+U2DjgvN/ueVCWsNvH8QoS8IvZTsGQQ1XLXbqb5jPBBDyV2L2bY97XAlq1UsZOhh7
         HZ1dYw11gfl2x+lsbz1VpriG3K+qyzlF6khfjcN6vcbZhHKK1zwqzhPpAqcnZOmPGg7v
         7Ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JsLiieC+cQBLTw5SD8oL1Qgnwzz8SoYUOjzsMtdxQck=;
        b=NLBjUSNbNKtj9c3nXmNxdLb4WN3tsWogKDrgyOYB/pHkwvamOvggEMAKv8XcJoLl3/
         yLgISb9SqA93XndCXQWVIixnJqvDxOHSCzykrSNBegEDHHoR4/DIgWEyeMsPvlpGjiJK
         3Pffr62opxDm/ZIZvLn/BB1YUU3A3v5B0wBHZlN8bNhMM+v+enveBhbsq84OcVXfqufq
         8Lu0CZqCalNYiit8Vr7Q+YLbgXR8/7bQyE5n+0DFF1zXKGliT0wuHEiQiUOs+UCv5iOO
         0sQWXcg/yuU3ozPbGkWKjRaddMvf4c56Zv1+zeUlj4SO8UYhcbEx/I5Hhx3FiUqMHpoR
         3FDw==
X-Gm-Message-State: AOUpUlFCnfc+rLaLCKjLEhVdYTWRDkxhui0LJsPb1bn6CgVBVOqFA8Ul
        G40cCJAlYG0FaGqYVgfMw5DpJrYAKZUIbgWZCfGY/g==
X-Google-Smtp-Source: AA+uWPxK+duOu+xBkEUWycUvW1KumZQU1XEUbpALOYlAw0ajCj2L5ZXowXfykJI/VsCZs/HpWl7xXQ+6KS5wr48sJiI=
X-Received: by 2002:a1c:ea17:: with SMTP id i23-v6mr26432602wmh.29.1534771246010;
 Mon, 20 Aug 2018 06:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAMGffEnzVo5VVSVBjCOBMhcoV1qXf0XXqJqr3C01xQn-aUiZFQ@mail.gmail.com>
 <20180816155126.GA18296@kroah.com> <CAMGffEmJR310NKHO1JpwE8yTg1Oeu_oaTaJ1D2_T_UHKCnHwKA@mail.gmail.com>
 <20180816163937.GA5105@kroah.com> <CAMGffEk2FqRn0av7T-aF-TKvRAKeinm96NYjJju_T4CmUrYPkQ@mail.gmail.com>
 <CAMGffEnKt0xcc6LhNdZQGRmckJ3qCFxCOnQ3owZmWWiaKYdYuw@mail.gmail.com>
 <20180817170129.GE24945@kroah.com> <alpine.DEB.2.21.1808181330380.2151@nanos.tec.linutronix.de>
 <CAMGffEk=6eVgB=A--FyooDoVPY4mEiOdf=yNnqdX4cF6Ud_NuA@mail.gmail.com> <alpine.DEB.2.21.1808201500590.1551@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1808201500590.1551@nanos.tec.linutronix.de>
From:   Jinpu Wang <jinpu.wang@profitbricks.com>
Date:   Mon, 20 Aug 2018 15:20:33 +0200
Message-ID: <CAMGffEnmp3zOXYb2cpHdLgeb0LAUac5umhK3OMUBFiJ1+7ce6w@mail.gmail.com>
Subject: Re: [BUG]smt sysfs dir missing on 4.4.148 and 4.14.63
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, konrad.wilk@oracle.com,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 3:02 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, 20 Aug 2018, Jinpu Wang wrote:
>
> > On Sat, Aug 18, 2018 at 2:50 PM Thomas Gleixner <tglx@linutronix.de> wr=
ote:
> > >
> > > On Fri, 17 Aug 2018, Greg Kroah-Hartman wrote:
> > > > On Fri, Aug 17, 2018 at 02:39:00PM +0200, Jinpu Wang wrote:
> > > > >
> > > > > I found the problem, CONFIG_HOTPLUG_SMT is enable due to CONFIG_S=
MP,
> > > > > but I did explicitly enable CONFIG_HOTPLUG_CPU.
> > > > >
> > > > > That's why the smt dir is missing, and kernel panic when I boot w=
ith
> > > > > 'nosmt' or 'l1tf=3Dfull' probably also other combination.
> > > > >
> > > > > With CONFIG_HOTPLUG_CPU=3Dy, it works fine so far.
> > > >
> > > > So do we need a new configuration dependancy here to resolve this
> > > > problem?  Why is this not an issue in Linus's tree?
> > >
> > > That's probably the same problem on Linus tree. Have not tested it ye=
t
> > > though. I'll have a look.
> > >
> > > Thanks,
> > >
> > >         tglx
> > >
> > Yeah, it's the same problem on Linus tree.
> >
> > Probably makes sense to do the following, I can sent a formal patch if
> > you think it's right thing to do:
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index b0312f8..8a52f0b 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -188,7 +188,7 @@ config X86
> >         select HAVE_SYSCALL_TRACEPOINTS
> >         select HAVE_UNSTABLE_SCHED_CLOCK
> >         select HAVE_USER_RETURN_NOTIFIER
> > -       select HOTPLUG_SMT                      if SMP
> > +       select HOTPLUG_SMT                      if SMP && HOTPLUG_CPU
>
> That works, but we might as well force 'select HOTPLUG_CPU if SMP' so the
> L1TF mitigations are functional. Sigh....
>
> Thanks,
>
>         tglx
right, sth like?
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b0312f8..5852948 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -188,7 +188,8 @@ config X86
        select HAVE_SYSCALL_TRACEPOINTS
        select HAVE_UNSTABLE_SCHED_CLOCK
        select HAVE_USER_RETURN_NOTIFIER
-       select HOTPLUG_SMT                      if SMP
+       select HOTPLUG_CPU                      if SMP
+       select HOTPLUG_SMT                      if SMP && HOTPLUG_CPU
        select IRQ_FORCED_THREADING
        select NEED_SG_DMA_LENGTH
        select PCI_LOCKLESS_CONFIG



--=20
Thanks,

Jack Wang
Linux Kernel Developer

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Tel:       +49 30 577 008  042
Fax:      +49 30 577 008 299
Email:    jinpu.wang@profitbricks.com
URL:      https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Gesch=C3=A4ftsf=C3=BChrer: Achim Weiss, Matthias Steinberg, Christoph Steff=
ens
