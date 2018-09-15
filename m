Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E527ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 19:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E593208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 19:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z08rjGbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E593208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeIPAY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 20:24:26 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38591 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbeIPAY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 20:24:26 -0400
Received: by mail-io1-f67.google.com with SMTP id y3-v6so8536177ioc.5;
        Sat, 15 Sep 2018 12:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0j8KMasfVu627z7xA+dcCLDd9YgQc//1YMbQpger1YM=;
        b=Z08rjGbTHAroGa5KNmUao6YqAgX1UIklTs+WfbAP0x8PB/LgS4DwJPeHRT4BNgQnTQ
         V0PbMt0/8MIbQ29VRrtkujR88qIjNfQ7+MIBH55QkeQIEy+pNI2m25wBaM7eP3YpRSxs
         HMb5HQm0u/ClVAgimUaKEyIq2wnPNV7e7wUVZGs8yopLQQ2OuEMci84MeYvrV4zeliaC
         HpfrpEGSjbG1K5NL7c/Gw6YdlIOgnOb4D2Y+rOAd4YDwh2aKDm3VG7MGifwpzhVYhQsE
         VhsYsFWkGyS0JEUNXHXAS4gnS66YUkO9jtbPBdsrjAX7FEhss7t7BVHKduOD4yiVsD1U
         J8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0j8KMasfVu627z7xA+dcCLDd9YgQc//1YMbQpger1YM=;
        b=TNQ068LVk+fwFoUoQyikNx8UDQd/SthjM1NoBFRSxa2rrxF14phNbWsoPqS5pF0SXO
         ulshTTQBiuiY9bkeNEgtcReGF5m2cFfVmYGmXWj+VRm+kcL+T/+xS/ckJ1fnP+bo1fb/
         VlrjdkH5GyEBy4BqJ0773EcahcAEOnTvNKGabSzeSNb3J+nzezttYW0YihuqPM9a3623
         mLMsx+DCYi36bq/+KyJUgVDy6v6iyBQGSIdUQuhHtCIjVxDh+Iu1/7FfpOBt3+GAmI2n
         wHtx05+EOaCqrROwDnP1KO4/mMTzhtxcjlSdalQ5IZCE8UfbTPcHpJ6l/LPx3TvXnpj0
         MM+Q==
X-Gm-Message-State: APzg51CPPHTyxGgpjmayAnpjrWzQOl7x51OAUzbZGF3OOcia/9D9iMBL
        dnLG3fF6hMgzQUwv8lze41emQHBz/NZ+65zQD9Y=
X-Google-Smtp-Source: ANB0VdaEyD9rluwX0NfvE2ShNCNOqlJ1PnKfZS9FDWxzUeGvRpLAr+D+rZVlUXaDrOP2TFCHhXDUjW2Om9skgIUGqfc=
X-Received: by 2002:a6b:e05:: with SMTP id 5-v6mr14646750ioo.141.1537038265712;
 Sat, 15 Sep 2018 12:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180915050843.19183-1-deepa.kernel@gmail.com>
 <20180915050843.19183-5-deepa.kernel@gmail.com> <CAK8P3a2Kkm2ubg_MVN_BJL=s7qpUB1-np=9zVpcJ2U-aPAJswg@mail.gmail.com>
 <CABeXuvoOEW9+5BPiDN+2S1boyMSg+csvSAd4ue03TB+yEO6dLg@mail.gmail.com> <alpine.DEB.2.21.1809152039440.1650@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809152039440.1650@nanos.tec.linutronix.de>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 15 Sep 2018 12:04:11 -0700
Message-ID: <CABeXuvrU_B0gFhdHiYvEAUgDMso_94=M8iPJj+w7N1LnGMrKAw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] pselect6: use __kernel_timespec
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 11:42 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, 15 Sep 2018, Deepa Dinamani wrote:
>
> > On Sat, Sep 15, 2018 at 8:28 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Sat, Sep 15, 2018 at 7:09 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> > >
> > > > +#if defined(CONFIG_64BIT_TIME)
> > > > +
> > > > +COMPAT_SYSCALL_DEFINE6(pselect6_time64, int, n, compat_ulong_t __user *, inp,
> > > > +       compat_ulong_t __user *, outp, compat_ulong_t __user *, exp,
> > > > +       struct __kernel_timespec __user *, tsp, void __user *, sig)
> > >
> > > I got a link error here since compat_sys_pselect6_time64 and
> > > compat_sys_ppoll_time64 are only defined when CONFIG_64BIT_TIME
> > > is set.
> > >
> > > I did not think we would select this symbol on arm64, is that a mistake
> > > on my side, or should the #ifdef check be removed?
> >
> > But, this is a compat syscall.
> > When we introduced this CONFIG_64BIT_TIME we planned to use it for
> > compat syscalls also is my understanding.
> >
> > config 64BIT_TIME
> >          def_bool ARCH_HAS_64BIT_TIME
> >          help
> >           This should be selected by all architectures that need to support
> >            new system calls with a 64-bit time_t. This is relevant on all 32-bit
> >            architectures, and 64-bit architectures as part of compat syscall
> >            handling.
> >
> > This means it should be set on 64 bit architechtures also right?
>
> It's only set when 32bit compat mode is enabled on the 64bit kernel.

Ok, then we could delete the #ifdef like Arnd suggested. So this will
be defined for all architectures that enable CONFIG_COMPAT
unconditionally.
I will post an updated version.

Thanks,
Deepa
