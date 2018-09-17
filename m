Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4DCECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA1F214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA1F214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbeIQPdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:33:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34269 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726676AbeIQPdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:33:16 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A99FE1EAAC50F;
        Mon, 17 Sep 2018 18:06:31 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Mon, 17 Sep 2018
 18:06:30 +0800
Date:   Mon, 17 Sep 2018 11:06:12 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Michal Simek <michal.simek@xilinx.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <sudeep.holla@arm.com>,
        <amit.kucheria@linaro.org>, <leoyang.li@nxp.com>,
        <broonie@kernel.org>, <arnaud.pouliquen@st.com>,
        <eugen.hristev@microchip.com>, <rdunlap@infradead.org>,
        <geert@linux-m68k.org>, <ak@it-klinger.de>,
        <freeman.liu@spreadtrum.com>, <lukas@wunner.de>,
        <vilhelm.gray@gmail.com>, <gregkh@linuxfoundation.org>,
        <kstewart@linuxfoundation.org>, <sgoud@xilinx.com>,
        <anirudh@xilinx.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] iio: Documentation: Add Xilinx AMS sysfs
 documentation
Message-ID: <20180917110215.00002846@huawei.com>
In-Reply-To: <cf2acc8a-ed2d-27f4-ca58-3e2132e17d2a@xilinx.com>
References: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
        <1536909510-7166-3-git-send-email-manish.narani@xilinx.com>
        <20180916111242.73af71ed@archlinux>
        <cf2acc8a-ed2d-27f4-ca58-3e2132e17d2a@xilinx.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2018 11:56:08 +0200
Michal Simek <michal.simek@xilinx.com> wrote:

> On 16.9.2018 12:12, Jonathan Cameron wrote:
> > On Fri, 14 Sep 2018 12:48:28 +0530
> > Manish Narani <manish.narani@xilinx.com> wrote:
> >   
> >> Add documentation for xilinx-ams driver. This contains information about
> >> various voltages and temperatures on PS (Processing System), PL
> >> (Programmable Logic) and AMS Control Block.
> >>
> >> Signed-off-by: Manish Narani <manish.narani@xilinx.com>  
> > The more I look at this device the more I'm convinced it is very much a dedicated
> > hardware monitoring function, not a generic ADC sensing unit at all.
> > 
> > Hmm.  It is still fine to have it in IIO but you need to think in detail
> > about how you are going to interface this to hwmon via the iio-hwmon bridge.
> > 
> > Some of the interface complexity should only really be apparent when we hit
> > hwmon perhaps rather than having so many different custom interfaces in IIO.
> > 
> > Please also loop in the maintainers and lists for hwmon in the next
> > version so we can get their input.  
> 
> Isn't there iio-hwmon driver for this?
> 
> Thanks,
> Michal

Absolutely.  The interesting bit is that if we are planning to actually expose
the many monitoring channels via iio-hwmon IIRC it won't use the extended names
at all (I may have missremembered this thogh).  As such we may want to reduced
the amount of custom ABI in IIO in favour of a level of opaqueness with the
'real' interface provided by the iio-hwmon bridge driver.  A quick glance
suggested we may need to increase the information exposed by the iio-hwmon
driver to make this work.

When we have run into cases like this (a very much hardware monitoring oriented
device with a few general purpose channels) in the past we have always gotten
agreement from the hwmon maintainers that they are happy with using an IIO provider
and the iio-hwmon driver route. It is just nice to keep everyone in agreement
and have no surprises!

Jonathan

