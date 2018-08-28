Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F4EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4932087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQawZ6WL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4932087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbeH1RJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:09:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44602 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbeH1RJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:09:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id v16-v6so1547078wro.11;
        Tue, 28 Aug 2018 06:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+hVT2hUpQbelVOqvUGZf1pAu/XKWCfLfn6EsyCLT1u8=;
        b=qQawZ6WLjUykRPMgP73Oc02gxxMHX2qgaTQkuTlyszSlyOW71V7+1i7LAJcUeK5zIj
         df7iLng6dcWN29BJ4ENxMZBArEUzukTRccPl3iiZSmRKdZ+9ioBTMcKVD1R0Ar0N+FUj
         73s8dc4/VG9D623nabElmrMcxQa9PjPhobgA6MPZKS2l3hKZgf13XTKYSy+2sVaQ7o//
         8joGHwhjgQBIMSC1EW/E4Lak8oSuXX0+WhVHRqzaDnKsb+H17SEE1FOFCMtXTGW3P2rj
         RhVw5WWlRwt2r6TUuhaB6e8ppHP2q0iZfFGn+pgdGyAuJQy8EC+7U9TXFCbys+ftzGzm
         k6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+hVT2hUpQbelVOqvUGZf1pAu/XKWCfLfn6EsyCLT1u8=;
        b=KlLQW6wDA2Ww5HHxHtmmTT9fCAFewBL1ufZzl5yGwtg62mp3+sj94oRhvv/lB+o/x5
         0TFTM7JzhV1u5xaA224bwfbwrju3EzbXcb27eSjPqYoY/7hab6vjry9n/i9J49eHD6g7
         vCv9SyHKuAe3fqDKj/ODtFoSyY4qX/rdfP/wXOIqdDyX1+ceaeq0jcWt7RsoNDHgfcq5
         I0n4SsZNogJEazg39Oj4KZ6Bvmd9JVTm3+e6BjZOKfSY+/4YN5VzjTPOgD7DOdKYP5tl
         /slDAWwMsltHOYY2m59bG15G9BImPMR1DZLWLhol1mdN0Ga4CMxqw86aFudKNFwTNcpM
         c5Mw==
X-Gm-Message-State: APzg51D6WiESY5qTuykLyr+kIE7abUZtW4g8mzozmX2MZdBe2hMKSlGT
        7ptJ2wdl6+8j/RC4Tkv7XUFI69zIovniDAcj/6g=
X-Google-Smtp-Source: ANB0VdaDjY6iGaJhNMdpPI0qQ3n8em2uf+cBP1X+lssxHJOMLK4DIc0O9iWPPM3H+ytvj8eW0yjhRajWZUqO1N9qvHk=
X-Received: by 2002:adf:82c3:: with SMTP id 61-v6mr1190360wrc.131.1535462262304;
 Tue, 28 Aug 2018 06:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-11-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a1Vdy-VsLWJMer-Z96E4Trhi0WJXJ3fTzyOGny2Mn6RAA@mail.gmail.com>
 <CA+sq2Cf2BLKsV=gY-MPnygV1ufpvmnw6ETh90JX_uKQBk3Sduw@mail.gmail.com> <CAK8P3a0+zJRxEYWZpYShRJo-3oqMaC9TJADugaRTiBnjw7ssPA@mail.gmail.com>
In-Reply-To: <CAK8P3a0+zJRxEYWZpYShRJo-3oqMaC9TJADugaRTiBnjw7ssPA@mail.gmail.com>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Tue, 28 Aug 2018 18:47:30 +0530
Message-ID: <CA+sq2Cfd_jk=JzcLmPYiW1iGqKrJRrv5vrsmeZfY4W+qi5GLgw@mail.gmail.com>
Subject: Re: [PATCH 10/15] soc: octeontx2: Reconfig MSIX base with IOVA
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, olof@lixom.net,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, Geetha sowjanya <gakula@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>, tglx@linutronix.de,
        Marc Zyngier <marc.zyngier@arm.com>, jason@lakedaemon.net,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 6:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Aug 28, 2018 at 2:42 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> >
> > On Tue, Aug 28, 2018 at 5:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Tue, Aug 28, 2018 at 12:58 PM <sunil.kovvuri@gmail.com> wrote:
> > > >
> > > > From: Geetha sowjanya <gakula@marvell.com>
> > > >
> > > > HW interprets RVU_AF_MSIXTR_BASE address as an IOVA, hence
> > > > create a IOMMU mapping for the physcial address configured by
> > > > firmware and reconfig RVU_AF_MSIXTR_BASE with IOVA.
> > > >
> > > > Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> > > > Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> > >
> > > I think this needs some more explanation. What is the difference between
> > > the MSI-X support in this driver and every other one? Are you working
> > > around a hardware bug, or is there something odd in the implementation
> > > of your irqchip driver? Do you use a GIC to handle the MSI interrupts
> > > or something else?
> >
> > This admin function is a PCI device which is capable of provisioning
> > HW blocks to other PCIe SRIOV devices in the system. Each HW block
> > (eg memory buffer pools, NIC dewscriptors, crypto engines e.t.c) needs
> > certain no of MSIX vectors. Admin function has a set of 32K MSIX vectors
> > in memory (not on-chip) which based on HW block provisioning to a PCI device
> > attaches the required number of vectors to that device. Some part of this
> > configuration is done by low level firmware.
> >
> > RVU_AF_MSIXTR_BASE points to the memory region allocated for 32K MSIX
> > vectors. If kernel is booted with IOMMU enabled and admin function device
> > is attached to SMMU, HW will go through translation to access this MSIX
> > vector memory region. Hence the mapping done in this patch.
>
> Do you mean this is not a regular PCIe MSI-X interrupt to the GIC, but
> something internal to your device that gets routed through the IOMMU
> back into the device?
>
> I'm still confused.
>
>        Arnd

This is a regular PCIe MSI-X interrupt, the difference is that the
bunch of PCI devices
here doesn't have a fixed set of MSIX vectors. Admin function has a
memory region with
32K MSIX vectors which it provisions to PCI devices based on the HW
functional blocks
attached to them. A PCI device which works as a ethernet device needs
X number of vectors
and a crypto device needs Y number of vectors.

Since the admin function owns the whole MSIX vector region, HW uses
this device's stream ID
to access the vectors. Hence the IOMMU mapping. Once MSIX vectors are
provisioned to
a PCI device they work as normal MSIX interrupt like any other device.

Thanks,
Sunil.
