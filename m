Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A3AC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A30120817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KthpXpzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A30120817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeKRDAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 22:00:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbeKRDAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 22:00:10 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5523E20815;
        Sat, 17 Nov 2018 16:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542472975;
        bh=IUC/Ou74dj94jzpAr1sRCDtxmzYxblXhoAmcQG6c4Xo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KthpXpzI8E6o8CTPmENkBNsFGss71B4ABiMV7PmUA1THsdsZFIGpw76fuGGhmW9sy
         rQAgCagv0zv1MKsB5//cyKkWVMBeGSliMVQSSiORAZVHH801yhSUmjPl+3fkeKN3z3
         feJKEbz1sK+OgnBBd+zQIMVsNQNHbjfnLxeMwjCM=
Date:   Sat, 17 Nov 2018 16:42:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Stefan Popa <stefan.popa@analog.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] dt-bindings: iio: adc: Add docs for ad7124
Message-ID: <20181117164250.1fb5e80e@archlinux>
In-Reply-To: <20181116225431.GA28284@bogus>
References: <1542108138-3711-1-git-send-email-stefan.popa@analog.com>
        <20181116225431.GA28284@bogus>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018 16:54:31 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, 13 Nov 2018 13:22:18 +0200, Stefan Popa wrote:
> > Add support for Analog Devices AD7124 4-channels and 8-channels ADC.
> > 
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > ---
> > Changes in v2:
> > 	- Nothing changed.
> > Changes in v3:
> > 	- Removed the "adi,channels" property.
> > 	- Used the "reg" property to get the channel number and "adi,diff-channels"
> > 	  for the differential pins. The "adi,channel-number" property was removed.
> > 	- adi,bipolar is of boolean type.
> > Changes in v4:
> > 	- Used the bipolar and diff-channels properties defined in the new adc.txt doc.
> > Changes in v5:
> > 	- Removed the gain and odr properties from the example.
> > 
> >  .../devicetree/bindings/iio/adc/adi,ad7124.txt     | 75 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 76 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan


