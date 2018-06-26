Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45DDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A80E26D49
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kIdFQaol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A80E26D49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752233AbeFZPhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:37:52 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51262 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751945AbeFZPhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TeggSCv2EiXkfNX9AA1WZ/41+hnn7efF7D3hrYIQWNk=; b=kIdFQaolhJBEPJMTZuYE97RbP
        RZ7APoEVFgVn/s5r0JGv2rdhMBJdvk/CMfImI/GfwGisbOqyDO3A++S+X3OPbBgdwwTf6zf9wVjaT
        tNAfEtTlxjmsxaa1Ls/dxznaKrxHmpnbjFZXCkVvcmVC8jUZs2gEnzKjN21TaeR8Nl+rs=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:56254)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fXq2K-0008Mq-B7; Tue, 26 Jun 2018 16:37:44 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fXq2H-0004sB-WC; Tue, 26 Jun 2018 16:37:42 +0100
Date:   Tue, 26 Jun 2018 16:37:40 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] gpu: drm: armada: Adding new typedef vm_fault_t
Message-ID: <20180626153740.GA17271@n2100.armlinux.org.uk>
References: <20180510150448.GA26306@jordon-HP-15-Notebook-PC>
 <20180511092205.GB16141@n2100.armlinux.org.uk>
 <CAFqt6zY2amJC4bkRZJgjs7=wCuTTxZbufk9cXcMZLE8VGh_dww@mail.gmail.com>
 <CAFqt6zYyL6YfvmiX90=Te3PQdcK32irdPPU0awEbp9Q16Bz9=w@mail.gmail.com>
 <CAFqt6zbQxx+20SNT8r1q2ZjtQZLTh=CC50s4LkHExkBju-1KJA@mail.gmail.com>
 <CAFqt6zacTP-HgQzkXS=d2w-+=QbhkPA0oH9X5Py_GJ0+8_PcYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zacTP-HgQzkXS=d2w-+=QbhkPA0oH9X5Py_GJ0+8_PcYQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:42:15AM +0530, Souptick Joarder wrote:
> On Mon, Jun 4, 2018 at 10:46 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > On Wed, May 23, 2018 at 3:09 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >> On Wed, May 16, 2018 at 10:05 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >>> On Fri, May 11, 2018 at 2:52 PM, Russell King - ARM Linux
> >>> <linux@armlinux.org.uk> wrote:
> >>>> On Thu, May 10, 2018 at 08:34:48PM +0530, Souptick Joarder wrote:
> >>>>> Use new return type vm_fault_t for fault handler in
> >>>>> struct vm_operations_struct. For now, this is just
> >>>>> documenting that the function returns a VM_FAULT
> >>>>> value rather than an errno. Once all instances are
> >>>>> converted, vm_fault_t will become a distinct type.
> >>>>>
> >>>>> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
> >>>>>
> >>>>> Previously vm_insert_pfn() returns err which driver
> >>>>> mapped into VM_FAULT_* type. The new function
> >>>>> vmf_insert_pfn() will replace this inefficiency by
> >>>>> returning VM_FAULT_* type.
> >>>>>
> >>>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >>>>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> >>>>
> >>>> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> >>>>
> >>>> Thanks.
> >>>
> >>> If no further comment, we would like to get this patch in queue
> >>> for 4.18.
> >>
> >> We would like to get this patch in queue
> >> for 4.18.
> >
> > We  would like to get this patch in 4.18.
> 
> Russell, This patch is not merged in 4.18-rc-1.

Correct, I wasn't able to add it to my tree because David Airlie hadn't
pulled the previous merge request, so it missed the 4.18 merge window.

The reason for me acking the patch was so that /someone else/ could
pick it up instead, and that obviously also didn't happen - maybe the
drm-misc tree was closed for new work at the point you sent the patch.

I've picked this patch up now, thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
