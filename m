Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09624C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65D72087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65D72087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeLCNLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:11:45 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:41654 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbeLCNLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:11:44 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5603D6EBFD4FA;
        Mon,  3 Dec 2018 21:10:42 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Mon, 3 Dec 2018
 21:10:41 +0800
Date:   Mon, 3 Dec 2018 13:10:31 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Tomasz Duszynski <tduszyns@gmail.com>
CC:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 3/3] iio: chemical: sps30: add device tree support
Message-ID: <20181203131031.00006b26@huawei.com>
In-Reply-To: <20181202182943.GA8286@arch>
References: <20181124221415.10081-1-tduszyns@gmail.com>
        <20181124221415.10081-4-tduszyns@gmail.com>
        <20181125085939.421523d6@archlinux>
        <20181202182943.GA8286@arch>
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

On Sun, 2 Dec 2018 19:29:44 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> On Sun, Nov 25, 2018 at 08:59:39AM +0000, Jonathan Cameron wrote:
> > On Sat, 24 Nov 2018 23:14:15 +0100
> > Tomasz Duszynski <tduszyns@gmail.com> wrote:
> >  
> > > Add device tree support for Sensirion SPS30 particulate
> > > matter sensor.
> > >
> > > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>  
> > one comment inine, around the fact we are trying to move
> > to generic names in DT where ever possible.  Now we don't
> > have a suitable one (IIRC) yet so time to make one up ;)
> >
> > +CC Rob for his input on that.  
> > > ---
> > >  .../bindings/iio/chemical/sensirion,sps30.txt        | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
> > > new file mode 100644
> > > index 000000000000..6eee2709b5b6
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
> > > @@ -0,0 +1,12 @@
> > > +* Sensirion SPS30 particulate matter sensor
> > > +
> > > +Required properties:
> > > +- compatible: must be "sensirion,sps30"
> > > +- reg: the I2C address of the sensor
> > > +
> > > +Example:
> > > +
> > > +sps30@69 {  
> > We should define a generic type.  Rob, what would work for this
> > one?
> >
> > particlesensor@69?
> >  
> 
> Wouldn't air-pollution-sensor be somewhat more generic? At least
> wikipedia has some article about that. Various other names like
> particle-sensor, pm-sensor, particulate-matter-sensor,
> air-quality-sensor, tend to return more or less similar number
> of search hits. Which means there's no universal naming convention.

I have not strong feeling in favor of a particular choice. 
Happy with wherever the discussion converges.

Jonathan
> 
> > > +	compatible = "sensirion,sps30";
> > > +	reg = <0x69>;
> > > +};  
> >  


