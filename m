Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA26C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20EC21523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20EC21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388333AbeIUAwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:52:17 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43286 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbeIUAwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:52:16 -0400
Received: by mail-ot1-f66.google.com with SMTP id u20-v6so10521393otk.10;
        Thu, 20 Sep 2018 12:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eeb08svpxj+/0Ppk65lKZJrhyLEVSoirv+f26Cea7WI=;
        b=SSFcZm/HvPDBLMbHbNGDrsGoW04grIjp6ubfYHYpdNy5cGr9K4ZYlqyc1KoAUxN6KP
         xilJbEzqDNxI4mlddcQtMIlTqX7NADaH14lXYtP6k9EHlbb6HuZTV/RVrMRYWGEnHvpS
         Q9mQy0I45HdAjuXvE+reSbvFhwQSfGTm6hewhmJgXorew1+a0kHrdpm3Bm1taT6DMDf3
         Zs3T50cxPNSJjhDmaiEX2PKdkSnQnDc7YnmXR839Sxg6NqY7MdXI7a1t0/oQHthU8WnC
         q3zZBfKTQgIXdO3e7wPqbjNT4CPBX3QCB++mNzPnySGIgu1e0eB559mic4sEkKdlMKEG
         j87g==
X-Gm-Message-State: APzg51CnOVX8kXflfHFOAVYiMwa9pMVaPO4sjwpK5167M8KEn2bSDc01
        TGde3pCX0mfksg5NSfRKvAArusE8LKE=
X-Google-Smtp-Source: ANB0Vdb169rN3lH9KpYiS2xRsgqlbitqkc7QXGoUOB249PIn0tVmEwH15wzazLTPgvrt9YEmkg3gWQ==
X-Received: by 2002:a9d:7281:: with SMTP id t1-v6mr24282730otj.345.1537470439694;
        Thu, 20 Sep 2018 12:07:19 -0700 (PDT)
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id g5-v6sm8052534otb.65.2018.09.20.12.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 12:07:18 -0700 (PDT)
Received: by mail-oi0-f45.google.com with SMTP id v198-v6so9323287oif.9;
        Thu, 20 Sep 2018 12:07:18 -0700 (PDT)
X-Received: by 2002:aca:50cf:: with SMTP id e198-v6mr101049oib.332.1537470438279;
 Thu, 20 Sep 2018 12:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180919123613.15092-1-laurentiu.tudor@nxp.com>
 <7d7646dc-9d0b-013d-75d7-a6cb4453f41f@arm.com> <fd8ab351-46aa-f73e-593b-502a57de1975@nxp.com>
 <39211e7a-034b-cdca-f182-1b6f6e5fbc53@arm.com> <33eac426-cbb7-f899-5a35-aea28f8e5dc4@nxp.com>
In-Reply-To: <33eac426-cbb7-f899-5a35-aea28f8e5dc4@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 20 Sep 2018 14:07:07 -0500
X-Gmail-Original-Message-ID: <CADRPPNTot7U6vARqtrRrw4XqhDQPSXP1QO9ZbGpNQByJPcU37Q@mail.gmail.com>
Message-ID: <CADRPPNTot7U6vARqtrRrw4XqhDQPSXP1QO9ZbGpNQByJPcU37Q@mail.gmail.com>
Subject: Re: [PATCH 00/21] SMMU enablement for NXP LS1043A and LS1046A
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     robin.murphy@arm.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, madalin.bucur@nxp.com,
        Roy Pledge <roy.pledge@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 5:39 AM Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
>
>
>
> On 19.09.2018 17:37, Robin Murphy wrote:
> > On 19/09/18 15:18, Laurentiu Tudor wrote:
> >> Hi Robin,
> >>
> >> On 19.09.2018 16:25, Robin Murphy wrote:
> >>> Hi Laurentiu,
> >>>
> >>> On 19/09/18 13:35, laurentiu.tudor@nxp.com wrote:
> >>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>>>
> >>>> This patch series adds SMMU support for NXP LS1043A and LS1046A chips
> >>>> and consists mostly in important driver fixes and the required device
> >>>> tree updates. It touches several subsystems and consists of three main
> >>>> parts:
> >>>>    - changes in soc/drivers/fsl/qbman drivers adding iommu mapping of
> >>>>      reserved memory areas, fixes and defered probe support
> >>>>    - changes in drivers/net/ethernet/freescale/dpaa_eth drivers
> >>>>      consisting in misc dma mapping related fixes and probe ordering
> >>>>    - addition of the actual arm smmu device tree node together with
> >>>>      various adjustments to the device trees
> >>>>
> >>>> Performance impact
> >>>>
> >>>>       Running iperf benchmarks in a back-to-back setup (both sides
> >>>>       having smmu enabled) on a 10GBps port show an important
> >>>>       networking performance degradation of around %40 (9.48Gbps
> >>>>       linerate vs 5.45Gbps). If you need performance but without
> >>>>       SMMU support you can use "iommu.passthrough=1" to disable
> >>>>       SMMU.
> >>>>
> >>>> USB issue and workaround
> >>>>
> >>>>       There's a problem with the usb controllers in these chips
> >>>>       generating smaller, 40-bit wide dma addresses instead of the
> >>>> 48-bit
> >>>>       supported at the smmu input. So you end up in a situation
> >>>> where the
> >>>>       smmu is mapped with 48-bit address translations, but the device
> >>>>       generates transactions with clipped 40-bit addresses, thus smmu
> >>>>       context faults are triggered. I encountered a similar
> >>>> situation for
> >>>>       mmc that I  managed to fix in software [1] however for USB I
> >>>> did not
> >>>>       find a proper place in the code to add a similar fix. The only
> >>>>       workaround I found was to add this kernel parameter which
> >>>> limits the
> >>>>       usb dma to 32-bit size: "xhci-hcd.quirks=0x800000".
> >>>>       This workaround if far from ideal, so any suggestions for a code
> >>>>       based workaround in this area would be greatly appreciated.
> >>>
> >>> If you have a nominally-64-bit device with a
> >>> narrower-than-the-main-interconnect link in front of it, that should
> >>> already be fixed in 4.19-rc by bus_dma_mask picking up DT dma-ranges,
> >>> provided the interconnect hierarchy can be described appropriately (or
> >>> at least massaged sufficiently to satisfy the binding), e.g.:
> >>>
> >>> / {
> >>>       ...
> >>>
> >>>       soc {
> >>>           ranges;
> >>>           dma-ranges = <0 0 10000 0>;
> >>>
> >>>           dev_48bit { ... };
> >>>
> >>>           periph_bus {
> >>>               ranges;
> >>>               dma-ranges = <0 0 100 0>;
> >>>
> >>>               dev_40bit { ... };
> >>>           };
> >>>       };
> >>> };
> >>>
> >>> and if that fails to work as expected (except for PCI hosts where
> >>> handling dma-ranges properly still needs sorting out), please do let us
> >>> know ;)
> >>>
> >>
> >> Just to confirm, Is this [1] the change I was supposed to test?
> >
> > Not quite - dma-ranges is only valid for nodes representing a bus, so
> > putting it directly in the USB device nodes doesn't work (FWIW that's
> > why PCI is broken, because the parser doesn't expect the
> > bus-as-leaf-node case). That's teh point of that intermediate simple-bus
> > node represented by "periph_bus" in my example (sorry, I should have put
> > compatibles in to make it clearer) - often that's actually true to life
> > (i.e. "soc" is something like a CCI and "periph_bus" is something like
> > an AXI NIC gluing a bunch of lower-bandwidth DMA masters to one of the
> > CCI ports) but at worst it's just a necessary evil to make the binding
> > happy (if it literally only represents the point-to-point link between
> > the device master port and interconnect slave port).
> >
>
> Quick update: so I adjusted to device tree according to your example and
> it works so now I can get rid of that nasty kernel arg based workaround,
> yey! :-)

Great that we have a generic solution like I hoped for!  So you will
submit a new revision of the series to include these dts updates,
right?

Regards,
Leo
