Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE847C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7223320872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIDfgAtl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbfAKDyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 22:54:10 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46618 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbfAKDyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 22:54:09 -0500
Received: by mail-ot1-f66.google.com with SMTP id w25so11974797otm.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 19:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mh8Y13SDTRaV+A1oBQTFShssINOe7TO814WDWYQK8PQ=;
        b=eIDfgAtldZAUkxiAEktyusIxFrSMYnws+/L0hQWS//wF4Y0HA+7ZIl+Mmdy+qfeAVo
         iHks2mCHLn6TkXfgMTIOT97fyZ7rPdCdyx6+U/HG4f7f/fwXu8UnYY5LMvCN+lf2m0T8
         Cs7HBAjdcNi5IxDxypz7by0O0/0/iIzJNs/YnIQ0St2g2op8hLI3WyX+JJHUz70JhGgp
         fhHC2xCsL0VWsuQWKpNUF3DxamDenll90bycc6Ts1C3I44Y7jQQhSdN0IbXHzZak+cEt
         WpxUrf4/FOX0HspiJ2k/bIUBF2tONoocrXF65kL5E32PP0E9nl4Nn4M+zpQqZeYVadi2
         6LpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mh8Y13SDTRaV+A1oBQTFShssINOe7TO814WDWYQK8PQ=;
        b=gf/rSdNOIPwsKHrfP2ti6h6GBwOalKTdt1K7sVNVxHPWqeMLnp4H40kLASFNNMh4Dv
         dqF7A0YUi1nhJT3F9VmYIM/nrS6381dSPf6M8OP88d2HeiGFivezkf29D0/Sa5szbfa+
         krl1/1wdgPDLHUr8TXqXgLeOWkEB7DSdNBgsoQdwX1tmrOb+OiUizTIuV4YieVBamGZR
         h8c7zqM5VRqocEjjrjcKc+FHCodttnZ7OOYyMcbS4Nz0Mu+/ZKgzQoo4g9pald1WoPiu
         LIZ8RwLoJv5BkNLzIgMPVNWAnm4bScQhQ2iHo6hu6mxHb4xwDRJBl0bkIlS5wGXttgES
         V7qw==
X-Gm-Message-State: AJcUukc9Se+BasfRHDT5thcT+E5NwsiWaOj5pNWSMdBIzdlwYyYZrjmS
        uuNG8Md1ttuD1MPIMEJ0qVRFsBqsgPa3WXyI2cX95ZS/
X-Google-Smtp-Source: ALg8bN7hsagFfq3/jS6BnlhjYPEH2g975gQQp87jMZLAaKlMNd7J10IBYEAW9Il2b9e1Gya9AB8OfdyhxPF6D2gJzpw=
X-Received: by 2002:a9d:14e:: with SMTP id 72mr8898399otu.54.1547178848846;
 Thu, 10 Jan 2019 19:54:08 -0800 (PST)
MIME-Version: 1.0
References: <20181213105924.30384-1-shameerali.kolothum.thodi@huawei.com> <4fe81519-1ddc-1d73-8c7a-cd0865299b53@arm.com>
In-Reply-To: <4fe81519-1ddc-1d73-8c7a-cd0865299b53@arm.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Fri, 11 Jan 2019 09:23:57 +0530
Message-ID: <CAKTKpr4uvQtYKrcAMSoaA-sYv2MNCqZgRb2KQhYa23KaYptaUA@mail.gmail.com>
Subject: Re: [PATCH v3] irqchip: gicv3-its: Use NUMA aware memory allocation
 for ITS tables
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, shankerd@codeaurora.org,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Robert Richter <Robert.Richter@cavium.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        John Garry <john.garry@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        Linuxarm <linuxarm@huawei.com>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        gkulkarni@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shameer,

Patch looks OK to me, please feel free to add,
Reviewed-by: Ganapatrao Kulkarni <gkulkarni@marvell.com>

On Thu, Dec 13, 2018 at 5:25 PM Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> On 13/12/2018 10:59, Shameer Kolothum wrote:
> > From: Shanker Donthineni <shankerd@codeaurora.org>
> >
> > The NUMA node information is visible to ITS driver but not being used
> > other than handling hardware errata. ITS/GICR hardware accesses to the
> > local NUMA node is usually quicker than the remote NUMA node. How slow
> > the remote NUMA accesses are depends on the implementation details.
> >
> > This patch allocates memory for ITS management tables and command
> > queue from the corresponding NUMA node using the appropriate NUMA
> > aware functions. This change improves the performance of the ITS
> > tables read latency on systems where it has more than one ITS block,
> > and with the slower inter node accesses.
> >
> > Apache Web server benchmarking using ab tool on a HiSilicon D06
> > board with multiple numa mem nodes shows Time per request and
> > Transfer rate improvements of ~3.6% with this patch.
> >
> > Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> > Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >
> > This is to revive the patch originally sent by Shanker[1] and
> > to back it up with a benchmark test. Any further testing of
> > this is most welcome.
> >
> > v2-->v3
> >  -Addressed comments to use page_address().
> >  -Added Benchmark results to commit log.
> >  -Removed T-by from Ganapatrao for now.
> >
> > v1-->v2
> >  -Edited commit text.
> >  -Added Ganapatrao's tested-by.
> >
> > Benchmark test details:
> > --------------------------------
> > Test Setup:
> > -D06 with dimm on node 0(Sock#0) and 3 (Sock#1).
> > -ITS belongs to numa node 0.
> > -Filesystem mounted on a PCIe NVMe based disk.
> > -Apache server installed on D06.
> > -Running ab benchmark test in concurrency mode from a remote m/c
> >  connected to D06 via  hns3(PCIe) n/w port.
> >  "ab -k -c 750 -n 2000000 http://10.202.225.188/"
> >
> > Test results are avg. of 15 runs.
> >
> > For 4.20-rc1  Kernel,
> > ----------------------------
> > Time per request(mean, concurrent)  = 0.02753[ms]
> > Transfer Rate = 416501[Kbytes/sec]
> >
> > For 4.20-rc1 +  this patch,
> > ----------------------------------
> > Time per request(mean, concurrent)  = 0.02653[ms]
> > Transfer Rate = 431954[Kbytes/sec]
> >
> > % improvement ~3.6%
> >
> > vmstat shows around 170K-200K interrupts per second.
> >
> > ~# vmstat 1 -w
> > procs -----------------------memory-- -  -system--
> >  r  b         swpd         free            in
> >  5  0            0     30166724          102794
> >  9  0            0     30141828          171148
> >  5  0            0     30150160          207185
> > 13  0            0     30145924          175691
> > 15  0            0     30140792          145250
> > 13  0            0     30135556          201879
> > 13  0            0     30134864          192391
> > 10  0            0     30133632          168880
> > ....
> >
> > [1] https://patchwork.kernel.org/patch/9833339/
>
> The figures certainly look convincing. I'd need someone from Cavium to
> benchmark it on their hardware and come back with results so that we can
> make a decision on this.

Hi Marc,
My setup got altered during Lab migration from Cavium to Marvell office.
I don't think, i will have same setup anytime soon.

>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...

Thanks,
Ganapat
