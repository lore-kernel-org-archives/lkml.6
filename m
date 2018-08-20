Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80282C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D28E21570
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=profitbricks-com.20150623.gappssmtp.com header.i=@profitbricks-com.20150623.gappssmtp.com header.b="sxz7uj2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D28E21570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=profitbricks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbeHTSIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:08:52 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:34710 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeHTSIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:08:52 -0400
Received: by mail-wr1-f47.google.com with SMTP id g33-v6so3200227wrd.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profitbricks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ipAt6i3S8f8sadoT0MLOwhFC/s1r406y78AL7L73JWs=;
        b=sxz7uj2XJTWIacNP2GFv+vwq9HceBmZ3M2ImOtclMAOMmZ7BVIrrAgy9sm2MVjBpkb
         EHX/Bv3iMOkvIRoHVC9GSy651lGEl8annAAYP2PNsWj8Jdt0ZbJBrs/bJEiIMopPQuGc
         MxyhA3W2Uxa/BGnGZzaJ5V3HG9jMz47FMrXVZzWJEiusYqQ9hXCue6Px5e9HgmOzWlQd
         wCtOcwrb9oZc9qXTOw9q4P6NK22UBirdMjdrTYAv31ODGxNyP51Mq8FK+NZGlRNztmC7
         xEPBw3/VhRkbaAjPEPBvAJs7OpehTJ+TxZWvK94GB/KsnXf1HT8UkprPAYxOqx0u4zq4
         LuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ipAt6i3S8f8sadoT0MLOwhFC/s1r406y78AL7L73JWs=;
        b=j27GpPx5J+zBleETNHAKzg5cgUx94DeLbmcMjWzc0UpXyGsBQ5uqHMaAatYdOOv+iP
         oi4uD8eoHlvzmWSoPfP62oafd06/N3yW2rCfgSYBjgsyIsu8OEem6M2kUa8W9+yEzYOP
         k5IY62edXzBPgb/tf5SIHQMfgTmo8bDdw8MhHtFqnCpXJ2XlQ+HI1tOzKuLu9WRntoed
         tuhNUZOvfyXAEscbYAFIVMCs0Sf0jJ6WoMdXQNK1OaKFkqf4Wwsd5uZIxD2GVaSiZKzj
         vLXgrENhBlI1drL9KnJSxLeSLgux+k1y16OVzYO9omRFy+3RCSXOWKTsubayDVfzYwL7
         zVgA==
X-Gm-Message-State: AOUpUlFGzN1FWginMtlt+mxk6D3h4wbdEqQ8UF9MVlHaDrDlixh3btGE
        0AkaZJF8C0dj32d7XLcq0pFLn18jIOGOK+YDAd5cVg==
X-Google-Smtp-Source: AA+uWPyFAXTAi6sbE2ZfpcuAXX88BKp4vC3rcSD6l9ZkPz1nra8SPhvXZm06m5q+z3AYa+q+VV2DtLokE/+OgEsoz8M=
X-Received: by 2002:adf:c74e:: with SMTP id b14-v6mr29332844wrh.16.1534776773312;
 Mon, 20 Aug 2018 07:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAMGffEnzVo5VVSVBjCOBMhcoV1qXf0XXqJqr3C01xQn-aUiZFQ@mail.gmail.com>
 <20180816155126.GA18296@kroah.com> <CAMGffEmJR310NKHO1JpwE8yTg1Oeu_oaTaJ1D2_T_UHKCnHwKA@mail.gmail.com>
 <20180816163937.GA5105@kroah.com> <CAMGffEk2FqRn0av7T-aF-TKvRAKeinm96NYjJju_T4CmUrYPkQ@mail.gmail.com>
 <CAMGffEnKt0xcc6LhNdZQGRmckJ3qCFxCOnQ3owZmWWiaKYdYuw@mail.gmail.com>
 <20180817170129.GE24945@kroah.com> <alpine.DEB.2.21.1808181330380.2151@nanos.tec.linutronix.de>
 <CAMGffEk=6eVgB=A--FyooDoVPY4mEiOdf=yNnqdX4cF6Ud_NuA@mail.gmail.com>
 <alpine.DEB.2.21.1808201500590.1551@nanos.tec.linutronix.de>
 <CAMGffEnmp3zOXYb2cpHdLgeb0LAUac5umhK3OMUBFiJ1+7ce6w@mail.gmail.com> <alpine.DEB.2.21.1808201646440.1551@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1808201646440.1551@nanos.tec.linutronix.de>
From:   Jinpu Wang <jinpu.wang@profitbricks.com>
Date:   Mon, 20 Aug 2018 16:52:41 +0200
Message-ID: <CAMGffEnrFu3ve6CbqNX9cRKz_MwH-Ch_QU7zGbYiQ7Hpnv6Yrw@mail.gmail.com>
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

On Mon, Aug 20, 2018 at 4:47 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, 20 Aug 2018, Jinpu Wang wrote:
> > On Mon, Aug 20, 2018 at 3:02 PM Thomas Gleixner <tglx@linutronix.de> wr=
ote:
> > > That works, but we might as well force 'select HOTPLUG_CPU if SMP' so=
 the
> > > L1TF mitigations are functional. Sigh....
> > >
> > > Thanks,
> > >
> > >         tglx
> > right, sth like?
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index b0312f8..5852948 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -188,7 +188,8 @@ config X86
> >         select HAVE_SYSCALL_TRACEPOINTS
> >         select HAVE_UNSTABLE_SCHED_CLOCK
> >         select HAVE_USER_RETURN_NOTIFIER
> > -       select HOTPLUG_SMT                      if SMP
> > +       select HOTPLUG_CPU                      if SMP
> > +       select HOTPLUG_SMT                      if SMP && HOTPLUG_CPU
>
> The && HOTPLUG is pretty pointless now.
Hmm, so this way?
+       select HOTPLUG_CPU                      if SMP
+       select HOTPLUG_SMT                      if HOTPLUG_CPU

thanks!
--=20
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
