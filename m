Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B066AC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE2B20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k57XhAor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE2B20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbeGYVCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729921AbeGYVCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:02:04 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 768C620844;
        Wed, 25 Jul 2018 19:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532548134;
        bh=GB2KuYHDmdzu1xC8Wh3XECR3bwYoSb9g+8FV3J4rhGw=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=k57XhAorPd1wQdOHvxihapwCo4z7+MQkp8Uk59Po9fvjvdzAnjWg8u5mT9bsG7zyN
         UZlNNE5QGFL6hmdAZJi1lNv9ZFEcFRfGyJtQE4YlnxFMVU/HIbMvFeYQKFsOdo0RB8
         GlEncVhaclk/dZG7qTG04D8hiFh2cdy6I8N959G4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Jolly Shah <JOLLYS@xilinx.com>,
        Michal Simek <michals@xilinx.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <SN1PR02MB37589FF7DBAFBD0C070F690EB85C0@SN1PR02MB3758.namprd02.prod.outlook.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Tejas Patel <TEJASP@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
 <1529516435-7315-11-git-send-email-jollys@xilinx.com>
 <153111401693.143105.16925315512459949259@swboyd.mtv.corp.google.com>
 <SN1PR02MB37589FF7DBAFBD0C070F690EB85C0@SN1PR02MB3758.namprd02.prod.outlook.com>
Message-ID: <153254813376.48062.5902552373363371978@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH v9 10/10] drivers: clk: Add ZynqMP clock driver
Date:   Wed, 25 Jul 2018 12:48:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jolly Shah (2018-07-17 13:09:01)
> Hi Stephen,
> =

> Thanks for the review,
> =

> > -----Original Message-----
> > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > Sent: Sunday, July 08, 2018 10:27 PM
> > To: Jolly Shah <JOLLYS@xilinx.com>; ard.biesheuvel@linaro.org;
> > dmitry.torokhov@gmail.com; gregkh@linuxfoundation.org;
> > hkallweit1@gmail.com; keescook@chromium.org; linux-clk@vger.kernel.org;
> > mark.rutland@arm.com; matt@codeblueprint.co.uk; Michal Simek
> > <michals@xilinx.com>; mingo@kernel.org; mturquette@baylibre.com;
> > robh+dt@kernel.org; sboyd@codeaurora.org; sudeep.holla@arm.com
> > Cc: Rajan Vaja <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.or=
g;
> > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Jolly Shah
> > <JOLLYS@xilinx.com>; Tejas Patel <TEJASP@xilinx.com>; Shubhrajyoti Datta
> > <shubhraj@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>
> > Subject: Re: [PATCH v9 10/10] drivers: clk: Add ZynqMP clock driver
> > =

> > > +/**
> > > + * zynqmp_pm_clock_get_parents() - Get the first 3 parents of clock =
for given
> > id
> > > + * @clock_id:  Clock ID
> > > + * @index:     Parent index
> > > + * @parents:   3 parents of the given clock
> > > + *
> > > + * This function is used to get 3 parents for the clock specified by
> > > + * given clock ID.
> > > + *
> > > + * This API will return 3 parents with a single response. To get
> > > + * other parents, master should call same API in loop with new
> > > + * parent index till error is returned. E.g First call should have
> > > + * index 0 which will return parents 0,1 and 2. Next call, index
> > > + * should be 3 which will return parent 3,4 and 5 and so on.
> > > + *
> > > + * Return: Returns status, either success or error+reason
> > > + */
> > > +static int zynqmp_pm_clock_get_parents(u32 clock_id, u32 index, u32
> > *parents)
> > > +{
> > > +       struct zynqmp_pm_query_data qdata =3D {0};
> > > +       u32 ret_payload[PAYLOAD_ARG_CNT];
> > =

> > What's the endianness of this payload? Is it little endian? Or do the
> > eemi_ops convert to CPU native endianness?
> =

> Its little endian

Is it CPU native? This might need to be marked as __le32 for proper
endianess code.

> =

> > > +
> > > +/**
> > > + * zynqmp_clock_init() - Initialize zynqmp clocks
> > > + *
> > > + * Return: 0 on success else error code
> > > + */
> > > +static int __init zynqmp_clock_init(void)
> > > +{
> > > +       int ret;
> > > +       struct device_node *np;
> > > +
> > > +       np =3D of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
> > > +       if (!np)
> > > +               return -ENOENT;
> > > +       of_node_put(np);
> > > +
> > > +       np =3D of_find_compatible_node(NULL, NULL, "xlnx,zynqmp-clk");
> > =

> > Why can't this be a platform device driver?
> =

> Platform driver may probe later(an actually probing later in our case). T=
his will results in clock get failure in clock consumer peripherals. So clo=
ck registration needs to be done earlier.

That's fine though? If a clk_get() fails because the provider isn't
registered yet the consumer will see -EPROBE_DEFER and try again later.

