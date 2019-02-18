Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91339C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CA820838
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfBRJ5z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:57:55 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32894 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727414AbfBRJ5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:57:55 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id B13B1C14A11B53AB07AF;
        Mon, 18 Feb 2019 09:57:53 +0000 (GMT)
Received: from LHREML524-MBB.china.huawei.com ([169.254.3.86]) by
 LHREML713-CAH.china.huawei.com ([10.201.108.36]) with mapi id 14.03.0415.000;
 Mon, 18 Feb 2019 09:57:45 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        John Garry <john.garry@huawei.com>,
        "pabba@codeaurora.org" <pabba@codeaurora.org>,
        "vkilari@codeaurora.org" <vkilari@codeaurora.org>,
        "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>
Subject: RE: [PATCH v6 1/4] acpi: arm64: add iort support for PMCG
Thread-Topic: [PATCH v6 1/4] acpi: arm64: add iort support for PMCG
Thread-Index: AQHUvIOBcTrq4FzrZ0KMa4a+1vXOg6XgzTaAgASYgDA=
Date:   Mon, 18 Feb 2019 09:57:44 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8392C2FA3@lhreml524-mbb.china.huawei.com>
References: <20190204121324.11460-1-shameerali.kolothum.thodi@huawei.com>
 <20190204121324.11460-2-shameerali.kolothum.thodi@huawei.com>
 <20190215113933.GB27700@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190215113933.GB27700@e107981-ln.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> Sent: 15 February 2019 11:40
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: robin.murphy@arm.com; andrew.murray@arm.com;
> jean-philippe.brucker@arm.com; will.deacon@arm.com;
> mark.rutland@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> John Garry <john.garry@huawei.com>; pabba@codeaurora.org;
> vkilari@codeaurora.org; rruigrok@codeaurora.org; linux-acpi@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Linuxarm
> <linuxarm@huawei.com>; neil.m.leeder@gmail.com
> Subject: Re: [PATCH v6 1/4] acpi: arm64: add iort support for PMCG
> 
[...]

> > +/*
> > + * PMCG model identifiers for use in smmu pmu driver. Please note
> > + * that, this is not part of the IORT specification.
> 
> And it is a Linux internal tag that has nothing to do with HW, it is just fabricated
> for matching a driver, I would like to have this clarified in the comment please.
> 
> I would have avoided adding another hook to differentiate platform data but
> given that it is self-contained in IORT code that should be fine for the sake of
> making progress:
> 
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Thanks. I will wait for review of main driver patches and then will sent out a
revised one incorporating your comments on this.

Thanks,
Shameer

> > + */
> > +#define IORT_SMMU_V3_PMCG_GENERIC        0x00000000 /* Generic
> SMMUv3 PMCG */
> > +
> >  int iort_register_domain_token(int trans_id, phys_addr_t base,
> >  			       struct fwnode_handle *fw_node);  void
> > iort_deregister_domain_token(int trans_id);
> > --
> > 2.7.4
> >
> >
