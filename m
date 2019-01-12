Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964C7C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BAC720870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547320000;
	bh=xqVbFf8I/nl3cs1heK2SgnTo230H8NAU2zn8MCLRDh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lQ16sbU7ARVGh5lyLbtZpaF1GL+/iD3eSVA52EnBSfqA2sJpyaBOWYua0Zx5fmNX5
	 F6Hzt9FyRQ8v09N6G3jEi9dXmQV7oJdGfLHvVE6S052aL4wOKLBLGNFokVNbdDhDqW
	 fHHS7+JULm94HdCMXGemZTUwarNEWchLhesOarTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfALTGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 14:06:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:42186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfALTGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 14:06:39 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB4E120835;
        Sat, 12 Jan 2019 19:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547319998;
        bh=xqVbFf8I/nl3cs1heK2SgnTo230H8NAU2zn8MCLRDh4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZwsDkddb7xniV0yjGrrVAPR99Qd+xGh4f9aQxX05VZrxqY3a1mtttKmtJVUcXiKia
         nU/mLK3IxwRTcbeEWROYk3Z2EHYlyYuRLDalOJPptnWLDIiGQw2Q4+KzD9Om0529UA
         /B6KaN5dyWkslABykyRPoJZGD7EYbAWDLx/XXNEg=
Date:   Sat, 12 Jan 2019 19:06:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Anson Huang <anson.huang@nxp.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V7 1/2] dt-bindings: iio: accel: mma8452: add power
 supplies  property
Message-ID: <20190112190632.09399dfd@archlinux>
In-Reply-To: <20190111143219.GA8867@bogus>
References: <1546938556-26969-1-git-send-email-Anson.Huang@nxp.com>
        <20190111143219.GA8867@bogus>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 08:32:19 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, 8 Jan 2019 09:14:01 +0000, Anson Huang wrote:
> > The accelerometer's power supplies could be controllable on some
> > platforms, add property "vdd/vddio" power supply to let device tree
> > to pass phandles to the regulators to driver.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/iio/accel/mma8452.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> >   
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.

On this occasion I've gone back and found Rob's Ack. On future occasions
I might just ignore a patch where Rob or someone else has pointed out
there previous tag / explanation for dropping it is missing.
Depends what mood I'm in :) (also Rob had pointed this out on v6 as well
so you should have been extra careful).

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
