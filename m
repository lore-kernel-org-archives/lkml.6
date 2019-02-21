Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F0CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585732148D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bidouilliste.com header.i=@bidouilliste.com header.b="hIgWGRzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfBUKRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:17:00 -0500
Received: from mail.blih.net ([212.83.177.182]:53717 "EHLO mail.blih.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfBUKQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:16:59 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Feb 2019 05:16:58 EST
Received: from mail.blih.net (mail.blih.net [212.83.177.182])
        by mail.blih.net (OpenSMTPD) with ESMTP id 0b330c4b;
        Thu, 21 Feb 2019 11:10:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bidouilliste.com; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mail;
         bh=8yA3uPBAxUDLtORA2o8u5XjRGpQ=; b=hIgWGRzfkrQKS+fhohCpQ2a4K150
        FIhalBWBd8DSrWgrZ3edjSTvh2hWv2OB3HKlNZh7Qc/ZJ4RI9IsZ9Vz+FXUdlI6B
        7FpCz5d7VzOntoqXOK1sktIr7y2wuann1kUT7694COT8ArZXxP9TYp/Htb4xd3cw
        nzYcjOVneArKNdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=bidouilliste.com; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; q=dns; s=
        mail; b=n8biuWE4Ic7RwUXC8QdHKN+0r5bqI73iJdDcyTW/YZJMgB4oHpQe7I0a
        FpnGfhfJR3swnBv4wpQ+OeArTEufFcdPbWNf/DGRTFit6aEVXXqMIV8X8pYJC9yn
        O2COT811qeUfwr7FdwyCE/M0jUpUQGN7eOmeY2t69AxT+ebsGms=
Received: from knuckles.blih.net (ip-9.net-89-3-105.rev.numericable.fr [89.3.105.9])
        by mail.blih.net (OpenSMTPD) with ESMTPSA id ed322229
        TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
        Thu, 21 Feb 2019 11:10:17 +0100 (CET)
Date:   Thu, 21 Feb 2019 11:10:17 +0100
From:   Emmanuel Vadot <manu@bidouilliste.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Philipp Rossak <embed3d@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>, linux-iio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: Allwinner SID THS calibration data cell representation?
Message-Id: <20190221111017.f3be5d56b419d9b90876b4c2@bidouilliste.com>
In-Reply-To: <CAGb2v65p0G83BVODsxxnXmiSCwuuwPFtY2k2ZV1F5xoFKrJjWQ@mail.gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
        <20180830154518.29507-28-embed3d@gmail.com>
        <20180904184623.e4386b8e6b657b1b25e90c09@bidouilliste.com>
        <55579dd6-625d-e71b-1482-4592dccac665@gmail.com>
        <20180906115114.inc6dhqhy47obo25@flea>
        <CAGb2v65p0G83BVODsxxnXmiSCwuuwPFtY2k2ZV1F5xoFKrJjWQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; amd64-portbld-freebsd13.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 15:54:00 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> Sorry for resurrecting an old discussion, but since someone posted patches
> for H5 and H6, I thought we should resolve this. I'm working on patches to
> fix / replace the big-endian issue.
> 
> On Thu, Sep 6, 2018 at 7:51 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Thu, Sep 06, 2018 at 01:47:47PM +0200, Philipp Rossak wrote:
> > > On 04.09.2018 18:46, Emmanuel Vadot wrote:
> > > > > +                 /* Data cells */
> > > > > +                 thermal_calibration: calib@234 {
> > > > > +                         reg = <0x234 0x8>;
> > > > > +                 };
> > > >   You are declaring 8 bytes of calibration data but to my knowledge it's
> > > > only 2 bytes per sensor, so 2 bytes for H3.
> > > >   Am I missing something ?
> > > >
> > > >   Thanks,
> > >
> > > Emmanuel you are right, it is 2 bytes per Sensor and should be 2 bytes for
> > > H3, but the thermal calibration data field is on all chips 64 bit wide - so
> > > 8 bytes. So I'm reading here the complete calibration data field.
> >
> > Having one cell per channel would make more sense I guess.
> 
> Would it? The 2 32-bit words directly map onto the registers 0x74 / 0x78 in
> the THS. As far as the SID is concerned, their is just one consumer for this
> data, the thermal sensor. How the thermal sensor uses that data is really not
> its concern. And the thermal sensor is really just copying the data from the
> e-fuses into its registers. Nothing more.

 If you see this at the controller lever and not at the sensor level it
might make sense to use the full 32bits data even some bits are ignored
I guess.

> Furthermore, with the register access interface, the e-fuses are read/write
> 32 bits at a time. Seems to me it would make more sense to enforce a 32-bit
> word size, so cells should be multiples of 32 bits.

 Ok, honestly at this point I don't really care what choice is done as
long as the dts is updated, I'll deal with the diff for FreeBSD and
ping the others BSD (Net and Open who also have a driver) for this
change.

> Regards
> ChenYu

 Cheers,

-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
