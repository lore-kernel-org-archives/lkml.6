Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE4EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796B220658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ds6bkfLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796B220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeH3Wms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:42:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34455 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbeH3Wmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:42:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id j25-v6so1570828wmc.1;
        Thu, 30 Aug 2018 11:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r/TK9cJYQEjith+IGSroY3ICqS1J8Z5IrwrdPpRNhJ4=;
        b=ds6bkfLwOkmMocuE+lTuLNTZ4Cr6yZlTYCX9PbFTX98FkAJTrRYRKbYS9Jr6dUBUio
         xb2eWiOoKqhTUh2lKyQ+VLs/LeUWyVUUjUVgHOctR15NR1vM6HJ7kCr8ngkaOtV/f+8o
         OkzFaWDruF8Wt2Mbemimx3KzBt03OZ96Dw+GICgzU/DYR5OWzowzzD+Q+E4u3EMdbtRh
         SVFlImFuEDm47BOE5i/PwaJz2C1OpANUAihP232hwgBbTYdKF5806WMpHwn0wRC+xOFM
         P6GtZ4iarL8TCxD3+ZidIpoPhLWtvXPnHahVPQc5Lm9m2+LAG+X0cwBo8zNuIC9Z54Q0
         1BBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r/TK9cJYQEjith+IGSroY3ICqS1J8Z5IrwrdPpRNhJ4=;
        b=S/owJwadWIpYgK7CzV7GECk9mnyDj96JuiCnAt8t4Hcq3Rr0NPDtxwSZ+XEbpd17DY
         2V1Jdn4S3NZ8g17AO6fH4l6h90MRLTkg3F6PQufAVnuP3rH3frBJ2qJH1/ey9R5xLPPN
         Hjo+oYzmlyj7QHEgEEa9IAQxm+K4DJ3aTVVQjSuo7rX03+btN1WsvrMsPCI0a1+KxsXi
         CMhDwdceyxqq6jxo6T0BnSndYvWZo1W2Ajw34rLluMrSapjBGIkPKgDyPsZNgxYBu36q
         K4MOOaJvvCKok75XachgBdDxn6nIhAwEzewMznptvL9cNUUU61IXkMK9LdaV0WQ9Pdrd
         Tucw==
X-Gm-Message-State: APzg51A7YxjNErCJmbsjlIdaGZo97g0qqb3t8Wubcjhwjk4Da4I2XBRZ
        u7kUq8nBwNYIjhuO+aaWbFfOWlXAYdqZNjU8azc=
X-Google-Smtp-Source: ANB0VdZ6FbzIx4fkx1RAaqTJEcIJvClNIpvfTXyJHvBXZVXXWO3izAErEj1YCtyKjmN6BgjLXZvyOeHQcuB06kaRDPw=
X-Received: by 2002:a1c:a386:: with SMTP id m128-v6mr2607103wme.139.1535654356181;
 Thu, 30 Aug 2018 11:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-11-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a1Vdy-VsLWJMer-Z96E4Trhi0WJXJ3fTzyOGny2Mn6RAA@mail.gmail.com>
 <CA+sq2Cf2BLKsV=gY-MPnygV1ufpvmnw6ETh90JX_uKQBk3Sduw@mail.gmail.com>
 <CAK8P3a0+zJRxEYWZpYShRJo-3oqMaC9TJADugaRTiBnjw7ssPA@mail.gmail.com>
 <CA+sq2Cfd_jk=JzcLmPYiW1iGqKrJRrv5vrsmeZfY4W+qi5GLgw@mail.gmail.com> <CAK8P3a1BRvhQ9iQWP2hTrJOu+Z+vmmek-Uobw6zX0dM4zFe_gQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1BRvhQ9iQWP2hTrJOu+Z+vmmek-Uobw6zX0dM4zFe_gQ@mail.gmail.com>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Fri, 31 Aug 2018 00:09:04 +0530
Message-ID: <CA+sq2CepUamZzjc8XS7gPALW3=19W2uv3hq=SUa86+i-oGsGnw@mail.gmail.com>
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

On Thu, Aug 30, 2018 at 7:23 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Aug 28, 2018 at 3:17 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> > On Tue, Aug 28, 2018 at 6:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tue, Aug 28, 2018 at 2:42 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> > > > On Tue, Aug 28, 2018 at 5:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > On Tue, Aug 28, 2018 at 12:58 PM <sunil.kovvuri@gmail.com> wrote:
> > > >
> > > > This admin function is a PCI device which is capable of provisioning
> > > > HW blocks to other PCIe SRIOV devices in the system. Each HW block
> > > > (eg memory buffer pools, NIC dewscriptors, crypto engines e.t.c) needs
> > > > certain no of MSIX vectors. Admin function has a set of 32K MSIX vectors
> > > > in memory (not on-chip) which based on HW block provisioning to a PCI device
> > > > attaches the required number of vectors to that device. Some part of this
> > > > configuration is done by low level firmware.
> > > >
> > > > RVU_AF_MSIXTR_BASE points to the memory region allocated for 32K MSIX
> > > > vectors. If kernel is booted with IOMMU enabled and admin function device
> > > > is attached to SMMU, HW will go through translation to access this MSIX
> > > > vector memory region. Hence the mapping done in this patch.
> > >
> > > Do you mean this is not a regular PCIe MSI-X interrupt to the GIC, but
> > > something internal to your device that gets routed through the IOMMU
> > > back into the device?
> > >
> >
> > This is a regular PCIe MSI-X interrupt, the difference is that the
> > bunch of PCI devices
> > here doesn't have a fixed set of MSIX vectors. Admin function has a
> > memory region with
> > 32K MSIX vectors which it provisions to PCI devices based on the HW
> > functional blocks
> > attached to them. A PCI device which works as a ethernet device needs
> > X number of vectors
> > and a crypto device needs Y number of vectors.
> >
> > Since the admin function owns the whole MSIX vector region, HW uses
> > this device's stream ID
> > to access the vectors. Hence the IOMMU mapping. Once MSIX vectors are
> > provisioned to
> > a PCI device they work as normal MSIX interrupt like any other device.
>
> Ok, I think I got it now, just to confirm: the MSIX vectors you allocate
> in the admin device refer to memory backing the BAR that contains
> the MSI-X entries of the other functions, right?

Yes, that's correct.

>
> I was a bit confused here and assumed that you were mapping
> the MMIO area of an interrupt controller that receives the interupt
> transactions.
>
>          Arnd
