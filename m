Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55140C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 06:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA9E217D7
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 06:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfA0GjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 01:39:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726113AbfA0GjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 01:39:22 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0R6d1aS129260
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 01:39:21 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q95fcb19h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 01:39:20 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 27 Jan 2019 06:39:19 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 27 Jan 2019 06:39:18 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0R6dHTq31981742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 27 Jan 2019 06:39:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4620A4C050;
        Sun, 27 Jan 2019 06:39:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD89E4C044;
        Sun, 27 Jan 2019 06:39:16 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.103])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 27 Jan 2019 06:39:16 +0000 (GMT)
Date:   Sun, 27 Jan 2019 08:39:15 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/15] habanalabs: add basic Goya support
References: <20190123000057.31477-1-oded.gabbay@gmail.com>
 <20190123000057.31477-4-oded.gabbay@gmail.com>
 <20190123122817.GB4747@rapoport-lnx>
 <CAFCwf12KD2gynDF2GfXrLF9ivZnWN6QGwdAZryBPupr2=QB8Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf12KD2gynDF2GfXrLF9ivZnWN6QGwdAZryBPupr2=QB8Fw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19012706-0028-0000-0000-0000033EA9C9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012706-0029-0000-0000-000023FBF295
Message-Id: <20190127063914.GA16853@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901270056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 10:32:55PM +0200, Oded Gabbay wrote:
> On Wed, Jan 23, 2019 at 2:28 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Wed, Jan 23, 2019 at 02:00:45AM +0200, Oded Gabbay wrote:
> > > This patch adds a basic support for the Goya device. The code initializes
> > > the device's PCI controller and PCI bars. It also initializes various S/W
> > > structures and adds some basic helper functions.
> > >
> > > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > > ---
> > >  drivers/misc/habanalabs/Makefile            |   5 +-
> > >  drivers/misc/habanalabs/device.c            |  71 +++
> > >  drivers/misc/habanalabs/goya/Makefile       |   3 +
> > >  drivers/misc/habanalabs/goya/goya.c         | 633 ++++++++++++++++++++
> > >  drivers/misc/habanalabs/goya/goyaP.h        | 125 ++++
> > >  drivers/misc/habanalabs/habanalabs.h        | 131 ++++
> > >  drivers/misc/habanalabs/habanalabs_drv.c    |   3 +
> > >  drivers/misc/habanalabs/include/goya/goya.h | 115 ++++
> > >  8 files changed, 1085 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/misc/habanalabs/goya/Makefile
> > >  create mode 100644 drivers/misc/habanalabs/goya/goya.c
> > >  create mode 100644 drivers/misc/habanalabs/goya/goyaP.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/goya.h

[ ... ]

> > > +
> > > +/**
> > > + * goya_sw_init - Goya software initialization code
> > > + *
> > > + * @hdev: pointer to hl_device structure
> > > + *
> > > + */
> > > +static int goya_sw_init(struct hl_device *hdev)
> > > +{
> > > +     struct goya_device *goya;
> > > +     int rc;
> > > +
> > > +     /* Allocate device structure */
> > > +     goya = kzalloc(sizeof(*goya), GFP_KERNEL);
> >
> > Consider using devm_k[mz]alloc() for memory allocations throughout the
> > driver. I didn't check all the spots where it can be applicable.
> I honestly wasn't aware of that. We never used that in AMD drivers
> (which where I spent most of my kernel time).
> I'll look into that offline but for now I don't really want to change
> into it blindly in all locations, unless there is some hard kernel
> rule for using that in drivers.

AFAIK, there's no such rule. It's just supposed to make driver
developer/maintainer life easier ;-)
 
> >
> > > +     if (!goya)
> > > +             return -ENOMEM;
> > > +
> > > +     /* according to goya_init_iatu */
> > > +     goya->ddr_bar_cur_addr = DRAM_PHYS_BASE;
> > > +     hdev->asic_specific = goya;
> > > +
> > > +     /* Create DMA pool for small allocations */
> > > +     hdev->dma_pool = dma_pool_create(dev_name(hdev->dev),
> > > +                     &hdev->pdev->dev, GOYA_DMA_POOL_BLK_SIZE, 8, 0);
> > > +     if (!hdev->dma_pool) {
> > > +             dev_err(hdev->dev, "failed to create DMA pool\n");
> > > +             rc = -ENOMEM;
> > > +             goto free_goya_device;
> > > +     }
> > > +

[ ... ]

> > > +
> > > +static const struct hl_asic_funcs goya_funcs = {
> > > +     .early_init = goya_early_init,
> > > +     .early_fini = goya_early_fini,
> > > +     .sw_init = goya_sw_init,
> > > +     .sw_fini = goya_sw_fini,
> > > +     .suspend = goya_suspend,
> > > +     .resume = goya_resume,
> > > +     .dma_alloc_coherent = goya_dma_alloc_coherent,
> > > +     .dma_free_coherent = goya_dma_free_coherent,
> >
> > Is there any additional functionality that is planned in goya or gaudi in
> > these two functions?
> > It seems like they are not really needed, at least at the moment and for
> > sure that don't need to be part of ASIC ops.
> 
> So this relates to the simulator support, because there the
> implementation of these two functions is totally different as I don't
> have pci device.

Can you please add a comment about it here?
 
-- 
Sincerely yours,
Mike.

