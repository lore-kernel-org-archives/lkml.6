Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7090CC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18DC020834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WxC6anMe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UF2LEdJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18DC020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeJEMWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 08:22:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36890 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbeJEMWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 08:22:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 45C58607F4; Fri,  5 Oct 2018 05:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538717146;
        bh=iUhEDU8CDkYVB2t6Yu1mUh7WPFZZWZCq0pVFNzGNp0g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WxC6anMeAKKwYubMExK2ce0NkzcNE32yv8giK6tTzwROiuOcRUxSKMB1cBzb8vk/L
         HG+k2SuC9DJvMCHqHgPLPQpaw5Ty1JuM3VNqnMt0dSvxI5WpmVhF1z2CMj3eDQgO8z
         3QFDhMET1ZnzlVO3jB/khHUVrfT5aee4lEOY6D4o=
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 881F760B0D;
        Fri,  5 Oct 2018 05:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538717145;
        bh=iUhEDU8CDkYVB2t6Yu1mUh7WPFZZWZCq0pVFNzGNp0g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UF2LEdJio09SEFHnVU+EMX1iwd/b91bud3g4SfJANphvJIfwquFa35WIp3rdZG5+t
         QNk86Ip3WQjPh8uRPbvJQM/3ZKOR2cUfhNtZ7mh8C5ZuBvdSLc/3b9x2Y3HjqmU96Q
         NJibi7czCskYb1OOUkPL0EJKqIkc8/kOvzpPLhlQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 881F760B0D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f173.google.com with SMTP id u34-v6so12592578qth.3;
        Thu, 04 Oct 2018 22:25:45 -0700 (PDT)
X-Gm-Message-State: ABuFfojjGxYMoxVIzqXxNeilkVrYHXu75W8adTrtDYG1TrXqRZZA1z5K
        XnlGgcSqJ2Cd27GADwFvdO5ABMjLmAgK7JjaX1Y=
X-Google-Smtp-Source: ACcGV61fXTgZbkLysAP1JtVrtttuIoTrCLYtbzemx1l3rognyUGYNtC7yd3zKwdry750H45a+cQUu/ddqN4lGDNlQ9c=
X-Received: by 2002:ac8:592:: with SMTP id a18-v6mr8282001qth.184.1538717144771;
 Thu, 04 Oct 2018 22:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180615105329.26800-1-vivek.gautam@codeaurora.org>
 <20180615165232.GE2202@arm.com> <CAFp+6iFm29ufb2Pr7Gb-2O_aN3GQLH4rcyWhbQGZ3QiwCC8vPg@mail.gmail.com>
 <20180627163749.GA8729@arm.com> <CAFp+6iFNhk7xZRHp0hNb2S7Cdn3muvsWqTEX-vjPGmxM8TNM9A@mail.gmail.com>
 <20180928131935.GE1577@brain-police>
In-Reply-To: <20180928131935.GE1577@brain-police>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Fri, 5 Oct 2018 10:55:32 +0530
X-Gmail-Original-Message-ID: <CAFp+6iERHTqwurj0y4PVkmVEdSZHqEVUqsgy-ry-ua7-_XAVRg@mail.gmail.com>
Message-ID: <CAFp+6iERHTqwurj0y4PVkmVEdSZHqEVUqsgy-ry-ua7-_XAVRg@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add support to use Last level cache
To:     Will Deacon <will.deacon@arm.com>
Cc:     pdaly@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        pratikp@codeaurora.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Fri, Sep 28, 2018 at 6:49 PM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Vivek,
>
> On Thu, Sep 20, 2018 at 05:11:53PM +0530, Vivek Gautam wrote:
> > On Wed, Jun 27, 2018 at 10:07 PM Will Deacon <will.deacon@arm.com> wrote:
> > > On Tue, Jun 19, 2018 at 02:04:44PM +0530, Vivek Gautam wrote:
> > > > On Fri, Jun 15, 2018 at 10:22 PM, Will Deacon <will.deacon@arm.com> wrote:
> > > > > On Fri, Jun 15, 2018 at 04:23:29PM +0530, Vivek Gautam wrote:
> > > > >> Qualcomm SoCs have an additional level of cache called as
> > > > >> System cache or Last level cache[1]. This cache sits right
> > > > >> before the DDR, and is tightly coupled with the memory
> > > > >> controller.
> > > > >> The cache is available to all the clients present in the
> > > > >> SoC system. The clients request their slices from this system
> > > > >> cache, make it active, and can then start using it. For these
> > > > >> clients with smmu, to start using the system cache for
> > > > >> dma buffers and related page tables [2], few of the memory
> > > > >> attributes need to be set accordingly.
> > > > >> This change makes the related memory Outer-Shareable, and
> > > > >> updates the MAIR with necessary protection.
> > > > >>
> > > > >> The MAIR attribute requirements are:
> > > > >>     Inner Cacheablity = 0
> > > > >>     Outer Cacheablity = 1, Write-Back Write Allocate
> > > > >>     Outer Shareablity = 1
> > > > >
> > > > > Hmm, so is this cache coherent with the CPU or not?
> > > >
> > > > Thanks for reviewing.
> > > > Yes, this LLC is cache coherent with CPU, so we mark for Outer-cacheable.
> > > > The different masters such as GPU as able to allocated and activate a slice
> > > > in this Last Level Cache.
> > >
> > > What I mean is, for example, if the CPU writes some data using Normal, Inner
> > > Shareable, Inner/Outer Cacheable, Inner/Outer Write-back, Non-transient
> > > Read/Write-allocate and a device reads that data using your MAIR encoding
> > > above, is the device guaranteed to see the CPU writes after the CPU has
> > > executed a DSB instruction?
> >
> > No, these MAIR configurations don't guarantee that devices will have
> > coherent view
> > of what CPU writes. Not all devices can snoop into CPU caches (only IO-Coherent
> > devices can).
> > So a normal cached memory configuration in CPU MMU tables, and SMMU page tables
> > is valid only for few devices that are IO-coherent.
> >
> > Moreover, CPU can lookup in system cache, and so do all devices;
> > allocation will depend on h/w configurations and memory attributes.
> > So anything that CPU caches in system cache will be coherently visible
> > to devices.
> >
> > >
> > > I don't think so, because the ARM ARM would say that there's a mismatch on
> > > the Inner Cacheability attribute.
> > >
> > > > > Why don't normal
> > > > > non-cacheable mappings allocated in the LLC by default?
> > > >
> > > > Sorry, I couldn't fully understand your question here.
> > > > Few of the masters on qcom socs are not io-coherent, so for them
> > > > the IC has to be marked as 0.
> > >
> > > By IC you mean Inner Cacheability? In your MAIR encoding above, it is zero
> > > so I don't understand the problem. What goes wrong if non-coherent devices
> > > use your MAIR encoding for their DMA buffers?
> > >
> > > > But they are able to use the LLC with OC marked as 1.
> > >
> > > The issue here is that whatever attributes we put in the SMMU need to align
> > > with the attributes used by the CPU in order to avoid introducing mismatched
> > > aliases.
> >
> > Not really, right?
> > Devices can use Inner non-Cacheable, Outer-cacheable (IC=0, OC=1) to allocate
> > into the system cache (as these devices don't want to allocate in
> > their inner caches),
> > and the CPU will have a coherent view of these buffers/page-tables.
> > This should be
> > a normal cached non-IO-Coherent memory.
> >
> > But anything that CPU writes using Normal, Inner Shareable,
> > Inner/Outer Cacheable,
> > Inner/Outer Write-back, Non-transient Read/Write-allocate, may not be visible
> > to the device.
> >
> > Also added Jordan, and Pratik to this thread.
>
> Sorry, but I'm still completely confused.
>
> If you only end up with mismatched memory attributes in the non-coherent
> case, then why can't you just follow my suggestion to override the
> attributes for non-coherent mappings on your SoC?

As seen in downstream kernels there are few non-coherent devices which
would not want to allocate in system cache, and therefore would want
Inner/Outer non-cached memory.
So, we may want to either override the attributes per-device, or as
you suggested
we may want to introduce another memory type 'sys-cached' that can be
added with its separate infra.
Thanks.

[...]

Best regards
Vivek


--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
