Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE81FC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD3021AA9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD3021AA9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbeHIANr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 20:13:47 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:39805 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHIANr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 20:13:47 -0400
Received: by mail-qt0-f171.google.com with SMTP id q12-v6so4316719qtp.6;
        Wed, 08 Aug 2018 14:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYKftUCIRQAy6E42xbS6fbgU43o8syOEzEEx1Z5fSfQ=;
        b=jtDDWyHcO54R2xN53OtI1BTx9FtqQIfmOt7igUVpOrPHNW8MWR9Fe3cFUjFnAYERGS
         cEV1PBGnhGlHMgl68HXUaaEKcVq7CpZFku5Xvt+BgMYoPqNxhQwJoD281nonkoRHtFuV
         m3PXdAf5B6GhkPfEiXu21qk8wA/FKRScLtLILx21H3O70y4YNMVsNjZo0cTyc0610KKN
         3f2RHjyjTjAJNPlMUCGXPUjKH7jzcM0U+I8C30jiU4KCcuJf5pdc+AufIEQJQhoXQOyj
         ffWtPrcaW5KbLZw04HQRWxxoa0jb4KJ9y4QPM26gi4ZLIr4JFIwpcVuRhCUEJFU7AjKN
         My8Q==
X-Gm-Message-State: AOUpUlGF3y6t40IqioE98jbgymg4F5VusjdZTpZXzwF2TlDgHLLa8GlR
        0mMiRROC1Nwbf9KpKqUOJpdmZovOBjbUcWPSJZY=
X-Google-Smtp-Source: AA+uWPxeIFXsEMKZqgcySy9lP5rklQDyORAm0mZn/InFYbS7jaw0Po2oOfpKmspBMhXH18C9CrFPWwHMcO9bGlM4JMo=
X-Received: by 2002:a0c:93b3:: with SMTP id f48-v6mr4195966qvf.151.1533765130789;
 Wed, 08 Aug 2018 14:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com> <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <20180808113927.GA24736@iMac.local> <alpine.LRH.2.02.1808081011110.9997@file01.intranet.prod.int.rdu2.redhat.com>
 <b1a0dac5-3cf2-1a7f-ac7f-649126eb7873@arm.com> <20180808151444.GF24736@iMac.local>
 <CAK8P3a2=rVvvW8bBcrPm3nXNNP56Ygxchu4ThD2ZgZ_cVcd8wQ@mail.gmail.com> <alpine.LRH.2.02.1808081347180.18198@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1808081347180.18198@file01.intranet.prod.int.rdu2.redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Aug 2018 23:51:53 +0200
Message-ID: <CAK8P3a1CdL5ZVvWPMriOknTCgkfbR4F-a6dRZ7ap9+NiD8H5cg@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Richard.Earnshaw@arm.com,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        neko@bakuhatsu.net, linux-pci <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 8:25 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
> On Wed, 8 Aug 2018, Arnd Bergmann wrote:
>
> > On Wed, Aug 8, 2018 at 5:15 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > >
> > > On Wed, Aug 08, 2018 at 04:01:12PM +0100, Richard Earnshaw wrote:
> > > > On 08/08/18 15:12, Mikulas Patocka wrote:
> > > > > On Wed, 8 Aug 2018, Catalin Marinas wrote:
> > > > >> On Fri, Aug 03, 2018 at 01:09:02PM -0400, Mikulas Patocka wrote:
> > > - failing to write a few bytes
> > > - writing a few bytes that were written 16 bytes before
> > > - writing a few bytes that were written 16 bytes after
> > >
> > > > The overlapping writes in memcpy never write different values to the
> > > > same location, so I still feel this must be some sort of HW issue, not a
> > > > SW one.
> > >
> > > So do I (my interpretation is that it combines or rather skips some of
> > > the writes to the same 16-byte address as it ignores the data strobes).
> >
> > Maybe it just always writes to the wrong location, 16 bytes apart for one of
> > the stp instructions. Since we are usually dealing with a pair of overlapping
> > 'stp', both unaligned, that could explain both the missing bytes (we write
> > data to the wrong place, but overwrite it with the correct data right away)
> > and the extra copy (we write it to the wrong place, but then write the correct
> > data to the correct place as well).
> >
> > This sounds a bit like what the original ARM CPUs did on unaligned
> > memory access, where a single aligned 4-byte location was accessed,
> > but the bytes swapped around.
> >
> > There may be a few more things worth trying out or analysing from
> > the recorded past failures to understand more about how it goes
> > wrong:
> >
> > - For which data lengths does it fail? Having two overlapping
> >   unaligned stp is something that only happens for 16..96 byte
> >   memcpy.
>
> If you want to research the corruptions in detail, I uploaded a file
> containing 7k corruptions here:
> http://people.redhat.com/~mpatocka/testcases/arm-pcie-corruption/

Nice!

I already found a couple of things:

- Failure to copy always happens at the *end* of a 16 byte aligned
  physical address, it misses between 1 and 6 bytes, never 7 or more,
  and it's more likely to be fewer bytes that are affected.
   279 7
   389 6
   484 5
   683 4
   741 3
   836 2
   946 1

- The first byte that fails to get copied is always 16 bytes after the
  memcpy target. Since we only observe it at the end of the 16 byte
  range, it means this happens specifically for addresses ending in
  0x9 (7 bytes missed) to 0xf (1 byte missed).

- Out of 7445 corruptions, 4358 were of the kind that misses a copy at the
  end of a 16-byte area, they were for copies between 41 and 64 bytes,
  more to the larger end of the scale  (note that with your test program,
  smaller memcpys happen more frequenly than larger ones).
     47 0x29
     36 0x2a
     47 0x2b
     23 0x2c
     29 0x2d
     31 0x2e
     36 0x2f
     46 0x30
     45 0x31
     51 0x32
     62 0x33
     64 0x34
     77 0x35
     91 0x36
     90 0x37
    100 0x38
    100 0x39
    209 0x3a
    279 0x3b
    366 0x3c
    498 0x3d
    602 0x3e
    682 0x3f
    747 0x40

- All corruption with data copied to the wrong place happened for copies
  between 33 and 47 bytes, mostly to the smaller end of the scale:
    391 0x21
    360 0x22
    319 0x23
    273 0x24
    273 0x25
    241 0x26
    224 0x27
    221 0x28
    231 0x29
    208 0x2a
    163 0x2b
     86 0x2c
     63 0x2d
     33 0x2e
      1 0x2f

- One common (but not the only, still investigating) case for data getting
  written to the wrong place is:
   * corruption starts 16 bytes after the memcpy start
   * corrupt bytes are the same as the bytes written to the start
   * start address ends in 0x1 through 0x7
   * length of corruption is at most memcpy length- 32, always
     between 1 and 7.

       Arnd
