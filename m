Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D651C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7E6218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBzI7lL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732574AbfAaMDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:03:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35204 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbfAaMDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:03:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so1384536pfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 04:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hEX6CnUmhXzm1WAUv3bYkGd5wIsrFdEZa5hXRATILmc=;
        b=rBzI7lL3vAy0i+wePiDeA0aOdwl3/iSP+njZghPvB0jCMCzAL/BsfqvHdJXWpPctx8
         2A38x2VJV1o4dI5Uoay60BdYhClgeWree7KC9EJxw9V/3WbGug0EhC0vthcSYME/jJFd
         d6XWYlPN3HSwCi+DljS6Q119o7Vft31QNxPU8KgaEqlL5qV5Q4dZ8OM14cMxHAvJOYlJ
         NNk+FpPIjmdB89Pi9haCsAcJqhsHA88F27jC0lrK26k7lyyKYJDdMFX+4IHpO9w7ve9K
         Zxx6IEzisXx0uXdvdLakV62GNExn9ZuP4Kks8cBIDPPtXJ3Hv6ev8k3zbRrn6Qiu1Ovu
         Iq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hEX6CnUmhXzm1WAUv3bYkGd5wIsrFdEZa5hXRATILmc=;
        b=DiysEtWps9QR9e/jvMw4QXDGF4d1Uxzyoc0GvCQUQ6LdyYvVeM7cjo9DjFFvNsHyfu
         /2a6wfOs/1gbkbL0OEfjuxNBNWxnBMSRkHGB7TnTqn7rd3ul4hfWhCqlOr+FQB+belHM
         quyyYRlMxlzPORwJu+G4Uy/D2gsZrAoPnT3AjNCetP7cvzFwYspOvvw7fvepRol5YQ+d
         DdTog18ANxhDUVIe1+va42BNBFdSRDdrZNWooXhFwiFe8G7e/fMncl54/jZiN3rjoRYh
         ceOEmT4tf+4BL1HYa6u3nwQXO5Zbkn4Zs1EMprtBeSOtAB9JSX8d3HufDsq6OiZ+gf8Q
         9njA==
X-Gm-Message-State: AJcUukfXqqOsdoSU1WGiM4paWxneHraoLzDMGLKF9FdATsiO25ILxTWB
        UCHPbaGKKiQbf2Ref6iN5v4Y1N+7KWlTSGeFezc=
X-Google-Smtp-Source: ALg8bN5I17KLlF3QiG7Px1QRsdxlAypZxbmkpmpA8ix5+rexopSR9tra0eWWTUylx6PK8n0N1nGZQ0buMqpLHyfzkfc=
X-Received: by 2002:a63:6bc1:: with SMTP id g184mr31862428pgc.25.1548936182726;
 Thu, 31 Jan 2019 04:03:02 -0800 (PST)
MIME-Version: 1.0
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1548929853-25877-2-git-send-email-Tianyu.Lan@microsoft.com> <20190131115756.GA19969@kroah.com>
In-Reply-To: <20190131115756.GA19969@kroah.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Thu, 31 Jan 2019 20:02:51 +0800
Message-ID: <CAOLK0py-5AmLwEtLveFAKnM_=hnjsCL18vdAk0n6_NPPyB20bA@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/Hyper-V: Set x2apic destination mode to physical
 when x2apic is available
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, mchehab+samsung@kernel.org,
        sashal@kernel.org, sthemmin@microsoft.com,
        Joerg Roedel <joro@8bytes.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        michael.h.kelley@microsoft.com, Ingo Molnar <mingo@redhat.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>, haiyangz@microsoft.com,
        Alex Williamson <alex.williamson@redhat.com>, bp@alien8.de,
        Thomas Gleixner <tglx@linutronix.de>, vkuznets@redhat.com,
        nicolas.ferre@microchip.com, iommu@lists.linux-foundation.org,
        devel@linuxdriverproject.org, akpm@linux-foundation.org,
        davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg:
             Thanks for your review.

On Thu, Jan 31, 2019 at 7:57 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 31, 2019 at 06:17:31PM +0800, lantianyu1986@gmail.com wrote:
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> >
> > Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
> > set x2apic destination mode to physcial mode when x2apic is available
> > and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs have
> > 8-bit APIC id.
> >
> > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > ---
> >  arch/x86/kernel/cpu/mshyperv.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index e81a2db..9d62f33 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -36,6 +36,8 @@
> >  struct ms_hyperv_info ms_hyperv;
> >  EXPORT_SYMBOL_GPL(ms_hyperv);
> >
> > +extern int x2apic_phys;
>
> Shouldn't this be in a .h file somewhere instead?

You are right. I should use <asm/apic.h> here. Thanks.

> thanks,
>
> greg k-h



-- 
Best regards
Tianyu Lan
