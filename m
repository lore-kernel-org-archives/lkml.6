Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A2DECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E883120842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hEAT/7VE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E883120842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeIZOLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:11:39 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37438 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIZOLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:11:39 -0400
Received: by mail-it1-f193.google.com with SMTP id m9-v6so1657556ita.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ABsFaoHgt4PlNiB6x3QFwQxhmlzQiyn9hJrKrFvnYOI=;
        b=hEAT/7VEhy9SF27SUTw7rDNsCeL08PgINkQ6nm2qerUxszNfZ8UmLwIppZBas7zpFX
         aETfAaKZeCza5Kmu2IB0Gbhu/ODayKGZyGRxarwmfg/tJEY+BEWTt3r4jMOx28Y42wMx
         291OYBEWKS3iD9UpBorPaRPDHKUoVslm4Lt/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ABsFaoHgt4PlNiB6x3QFwQxhmlzQiyn9hJrKrFvnYOI=;
        b=WmJzSNq2xaPfVGueh1oWwcH+HAzkAc28YzOeLD1fSYNpCGzU4DKz3RIQgyg7R/VaIY
         t/NhJCS3Zni+i1rF8y5H905X/7fUdY/l0Ui/g88I8/PnwtVs+WwPZrDiSxvcDfymS+fm
         exPF8ZgriyNv98Kzx6cdq49nHYWhfE5NOv3t5vfqhSAgBlERvFvcVzqEYfg7aiggvAJm
         HJuQw09IYFWL5pt7QP7yd2vepa4yYMGTnKqwieVM5Et2oCCG5Dxy/0N9vqEZ1/PtdU8+
         XtvpAgobpMqMLgb+M/LIxNygkBzqIpSSFSOGzmd38SvRGuwDQeYGBmpLB0lG+mGTbFQB
         xtTA==
X-Gm-Message-State: ABuFfoizO8PZ0KdX2hBZo0bKEPSmTQFok9KE8qbkQLNCNFVGM7nPoHkE
        H4qt7WjgqvjTHRm1jdwbYL9un/AAw45mbP3yfAGf9g==
X-Google-Smtp-Source: ACcGV623sZAltYwLhrzDPY2eFELOkHf5NbocbuaPVg2qaeQ3VShFBsm8oiPiVRGuMSDKdp2uELagLpFRhleupjP4v6E=
X-Received: by 2002:a02:9b97:: with SMTP id p23-v6mr4581782jak.5.1537948798044;
 Wed, 26 Sep 2018 00:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
 <1537367527-20773-5-git-send-email-jim2101024@gmail.com> <CAKv+Gu_d-r0ubyqZcDzERYd5FVTSpjBk++iACHqVgtHrOK0F7A@mail.gmail.com>
 <7fa897cf-4d58-c63f-afdd-a3ec5a6a56bf@gmail.com> <CAKv+Gu8aJRV4nqq1e-5HRLvbrANQsYuMf-pwWB53BhxLgX7iWg@mail.gmail.com>
 <b74d3c16-a512-73dc-c94a-ef6adde5f757@gmail.com> <CAKv+Gu8ZbN3BDRyuFzt4o--SSUmhuOh+jnpq8ZR-Ay13DJrAqg@mail.gmail.com>
 <fa285694-c3e1-adf8-032a-202e7598de41@gmail.com> <CANCKTBsypcVS_iC1+sbW5fMKfj+tTsxbQv9CvDwcO8GV3a8_Yg@mail.gmail.com>
 <CAKv+Gu-+OjJi8zGLqvnsOJQ9ygMot-O0EbyMKO-yyG-+k-274A@mail.gmail.com>
 <CANCKTBtbwSqfSU0b_d6Yi7TV3R_ijEpPE8a4bpgpkcOxJOa_zQ@mail.gmail.com> <7accc1a7-647b-1f92-13f8-2fab315ddc45@gmail.com>
In-Reply-To: <7accc1a7-647b-1f92-13f8-2fab315ddc45@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 26 Sep 2018 09:59:45 +0200
Message-ID: <CAKv+Gu-h4kjxE-ErthJqWQRh7r1EJhC5Na4n2Ma=foJEtDLdcg@mail.gmail.com>
Subject: Re: [PATCH v5 04/12] PCI: brcmstb: add dma-range mapping for inbound traffic
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 at 04:59, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 9/24/2018 8:01 AM, Jim Quinlan wrote:
> > On Mon, Sep 24, 2018 at 4:25 AM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> >>
> >> On Fri, 21 Sep 2018 at 19:41, Jim Quinlan <jim2101024@gmail.com> wrote:
> >>>
> >>> On Thu, Sep 20, 2018 at 5:39 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>>>
> >>>> On 09/20/2018 02:33 PM, Ard Biesheuvel wrote:
> >>>>> On 20 September 2018 at 14:31, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>>>>> On 09/20/2018 02:04 PM, Ard Biesheuvel wrote:
> >>>>>>> On 20 September 2018 at 13:55, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>>>>>>> On 09/19/2018 07:19 PM, Ard Biesheuvel wrote:
> >>>>>>>>> On 19 September 2018 at 07:31, Jim Quinlan <jim2101024@gmail.com> wrote:
> >>>>>>>>>> The Broadcom STB PCIe host controller is intimately related to the
> >>>>>>>>>> memory subsystem.  This close relationship adds complexity to how cpu
> >>>>>>>>>> system memory is mapped to PCIe memory.  Ideally, this mapping is an
> >>>>>>>>>> identity mapping, or an identity mapping off by a constant.  Not so in
> >>>>>>>>>> this case.
> >>>>>>>>>>
> >>>>>>>>>> Consider the Broadcom reference board BCM97445LCC_4X8 which has 6 GB
> >>>>>>>>>> of system memory.  Here is how the PCIe controller maps the
> >>>>>>>>>> system memory to PCIe memory:
> >>>>>>>>>>
> >>>>>>>>>>    memc0-a@[        0....3fffffff] <=> pci@[        0....3fffffff]
> >>>>>>>>>>    memc0-b@[100000000...13fffffff] <=> pci@[ 40000000....7fffffff]
> >>>>>>>>>>    memc1-a@[ 40000000....7fffffff] <=> pci@[ 80000000....bfffffff]
> >>>>>>>>>>    memc1-b@[300000000...33fffffff] <=> pci@[ c0000000....ffffffff]
> >>>>>>>>>>    memc2-a@[ 80000000....bfffffff] <=> pci@[100000000...13fffffff]
> >>>>>>>>>>    memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> So is describing this as
> >>>>>>>>>
> >>>>>>>>> dma-ranges = <0x0 0x0 0x0 0x0 0x0 0x40000000>,
> >>>>>>>>>               <0x0 0x40000000 0x1 0x0 0x0 0x40000000>,
> >>>>>>>>>               <0x0 0x80000000 0x0 0x40000000 0x0 0x40000000>,
> >>>>>>>>>               <0x0 0xc0000000 0x3 0x0 0x0 0x40000000>,
> >>>>>>>>>               <0x1 0x0 0x0 0x80000000 0x0 0x40000000>,
> >>>>>>>>>               <0x1 0x40000000 0x0 0xc0000000 0x0 0x40000000>;
> >>>>>>>>>
> >>>>>>>>> not working for you? I haven't tried this myself, but since DT permits
> >>>>>>>>> describing the inbound mappings this way, we should fix the code if it
> >>>>>>>>> doesn't work at the moment.
> >>>>>>>>
> >>>>>>>> You mean encoding the memory controller index in the first cell? If that
> >>>>>>>> works, that's indeed a much cleaner solution, though is it standard
> >>>>>>>> compliant in any form?
> >>>>>>>
> >>>>>>> No those are just memory addresses (although I may have screwed up the
> >>>>>>> order). From Documentation/devicetree/booting-without-of.txt:
> >>>>>>>
> >>>>>>> """
> >>>>>>> Optional property:
> >>>>>>> - dma-ranges: <prop-encoded-array> encoded as arbitrary number of triplets of
> >>>>>>>          (child-bus-address, parent-bus-address, length). Each triplet specified
> >>>>>>>          describes a contiguous DMA address range.
> >>>>>>> """
> >>>>>>>
> >>>>>>
> >>>>>> Then I am confused by your comment, that's what this patch does, it adds
> >>>>>> support for reading "dma-ranges" from Device Tree and setting up inbound
> >>>>>> windows using that. The only caveat is that because the PCIe root
> >>>>>> complex has some ties with the memory bus architecture it is connected
> >>>>>> to (SCB in our case) there is still a requirement to know the
> >>>>>> translation between a given physical address and its backing memory
> >>>>>> controller/aperture.
> >>>>>>
> >>>>>
> >>>>> Ah ok, apologies for the noise then.
> >>>>>
> >>>>> I was hoping that having working support for dma-ranges would remove
> >>>>> the need for the special phys<->dma conversion routines.
> >>>>
> >>>> What you describe definitively works with platform devices, but I am not
> >>>> sure this is working for PCIe devices, although, conceptually it should,
> >>>> yes.
> >>> Sorry for my delay in responding.  One problem is that
> >>> of_dma_configure() only looks at the first dma-range given and then
> >>> converts it to dev->dma_pfn_offset which is respected by the DMA API.
> >>> However, we often have multiple dma-ranges, not just one.  This is the
> >>> big issue.
> >>>
> >>
> >> Given the recent attention to getting these APIs in shape, this may be
> >> something Robin or Christoph may care to look into?
> >
> > It looks like this has been brought up before in the "[RFC PATCH] of:
> > Fix DMA configuration for non-DT masters" thread aka
> >
> > https://lists.linuxfoundation.org/pipermail/iommu/2017-April/021325.html
> >
> > In the thread "Oza Oza", a Broadcom coworker probably dealing with the
> > same exact problem as I,  enumerates three problems.   #1 and #2 are
> > the exact same ones I've just given: the "dma-ranges" prop of the RC
> > DT node is "skipped", and of_dma_get_range() only considers the first
> > entry in any "dma-ranges".
>
> Robin, is that something that is expected or should the "dma-ranges"
> somehow propagate from host bridge down the PCIe end-point drivers?
>
> >
> > Thanks, Jim
> >
> >>
> >> In any case, the description of dma-ranges should be in sync with the
> >> way Linux interprets it, so this is either a documentation bug or a
> >> DMA layer bug.
> >>
> >>> There is another issue with of_dma_configure() being invoked by the EP
> >>> driver on "bridge->parent->of_node", which is our RC device,
> >>> Of_dma_configure() calls of_dma_range() on the of_get_next_parent() of
> >>> our RC's device node and this misses the dma-ranges property which is
> >>> contained within the RC.  I think I could workaround this but there is
> >>> no getting around the first problem.
> >>>
> >>
> >> IIUC dma-ranges should be added to the parent bus of a device, which I
> >> guess is slightly ambiguous for a root complex that incorporates a
> >> host bridge.
>
> Humm, why is that ambiguous for a host bridge/root complex?

Well, perhaps I am the only one who is slightly confused by this, but
the fact that the device node describes both the host bridge and the
root port/bridge (which is arguably a device behind the bus) makes it
somewhat non-intuitive to me.
