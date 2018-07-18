Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35DCECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB972075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB972075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbeGRCBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:01:44 -0400
Received: from mgwym02.jp.fujitsu.com ([211.128.242.41]:16332 "EHLO
        mgwym02.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730055AbeGRCBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:01:44 -0400
X-Greylist: delayed 669 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Jul 2018 22:01:43 EDT
Received: from yt-mxoi1.gw.nic.fujitsu.com (unknown [192.168.229.67]) by mgwym02.jp.fujitsu.com with smtp
         id 0a8b_396e_c9a42b14_808a_4635_af4f_14fec827da07;
        Wed, 18 Jul 2018 10:15:13 +0900
Received: from g01jpfmpwkw01.exch.g01.fujitsu.local (g01jpfmpwkw01.exch.g01.fujitsu.local [10.0.193.38])
        by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id A3930AC0192
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 10:15:12 +0900 (JST)
Received: from G01JPEXCHKW16.g01.fujitsu.local (G01JPEXCHKW16.g01.fujitsu.local [10.0.194.55])
        by g01jpfmpwkw01.exch.g01.fujitsu.local (Postfix) with ESMTP id BA6C9692408;
        Wed, 18 Jul 2018 10:15:11 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw16 ([10.0.194.55]) with mapi id 14.03.0352.000; Wed, 18 Jul 2018
 10:15:11 +0900
From:   "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To:     'Marc Zyngier' <marc.zyngier@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Zhang, Lei" <zhang.lei@jp.fujitsu.com>,
        "Matsuyama, Yoshihiro" <y.matsu@jp.fujitsu.com>
Subject: RE: [PATCH 0/7] irqchip/gic-v3: LPI allocation refactoring
Thread-Topic: [PATCH 0/7] irqchip/gic-v3: LPI allocation refactoring
Thread-Index: AQHUCJ4ENtiIMXLHnEarHLrWvySVcKSUT7ug
Date:   Wed, 18 Jul 2018 01:15:10 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A69F690AF@G01JPEXMBKW03>
References: <20180620135234.32101-1-marc.zyngier@arm.com>
In-Reply-To: <20180620135234.32101-1-marc.zyngier@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.2.3
x-shieldmailcheckerpolicyversion: FJ-ISEC-20140219
x-originating-ip: [10.18.70.198]
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc

This patches is necessary for our device, thanks a lot for your patches.
We have done the tests for your patches on our prototype CPU chip.
All of tests's results are PASSED.

Below is the detail of our tests.
We did tests for 2 points.
point 1: No level down for existing device such as nvme, network interface card.
what we did: iozone benchmark on nvme, ssh command.
point 2: Our original device can work well.
what we did: Test set for our original device.

And we have done the review, we think the patches is no problem.
But we found a spelling mistake in you comments.
> + * The consequence of the above is that allocation is cost is low, but
I propose the following is correct.

+ * The consequence of the above is that allocation cost is low, but

Best Regards,
Lei Zhang

> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier@arm.com]
> Sent: Wednesday, June 20, 2018 10:52 PM
> To: linux-kernel@vger.kernel.org
> Cc: Thomas Gleixner; Ard Biesheuvel; Shanker Donthineni; Shameer
> Kolothum; MaJun; Laurentiu Tudor; Zhang, Lei/張 雷
> Subject: [PATCH 0/7] irqchip/gic-v3: LPI allocation refactoring
> 
> The GICv3 LPI allocator has served us well so far, but a number of new
> use cases have recently showed up:
> 
> - A new extension to the GICv3 architecture allows a hypervisor to
>   dramatically restrict the range of available LPIs. This means that
>   our current policy of allocating LPIs in blocks of 32 may quickly
>   deplete the number of devices that get LPIs
> 
> - New and currently undisclosed busses seem to come with thousands of
>   devices, each requiring a single LPI. Again, our current allocation
>   policy means they quickly run out of LPIs.
> 
> Simply expanding the bitmap doesn't seem to be a great idea, so let's
> change the LPI allocator altogether. This means we can move individual
> busses to a more minimal allocation scheme, though we only do it for
> PCI at the moment (Platform MSI looks like the Far West, and I'm
> clueless about the FSL MC thing).
> 
> This is a pretty invasive change, and I'm thus cc'ing the usual
> suspects that have access to weird and wonderful HW to verify
> everything still works as expected, and let me know if we can relax
> the allocation for their own pet bus implementation.
> 
> Only lightly tested in a KVM guest (PCI).
> 
> 
> Marc Zyngier (7):
>   irqchip/gic-v3-its: Refactor LPI allocator
>   irqchip/gic-v3-its: Use full range of LPIs
>   irqchip/gic-v3-its: Move minimum LPI requirements to individual busses
>   irqchip/gic-v3-its: Drop chunk allocation compatibility
>   irqchip/gic-v3: Expose GICD_TYPER in the rdist structure
>   irqchip/gic-v3-its: Honor hypervisor enforced LPI range
>   irqchip/gic-v3-its: Reduce minimum LPI allocation to 1 for PCI devices
> 
>  drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c   |   3 +
>  drivers/irqchip/irq-gic-v3-its-pci-msi.c      |  16 +-
>  drivers/irqchip/irq-gic-v3-its-platform-msi.c |   2 +
>  drivers/irqchip/irq-gic-v3-its.c              | 225
> ++++++++++++------
>  drivers/irqchip/irq-gic-v3.c                  |   4 +-
>  include/linux/irqchip/arm-gic-v3.h            |   3 +-
>  6 files changed, 169 insertions(+), 84 deletions(-)
> 
> --
> 2.17.1
> 
> 


