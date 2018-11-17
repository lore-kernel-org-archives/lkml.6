Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19629C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD13C20817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkECIxmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD13C20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeKRC5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:57:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbeKRC5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:57:16 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43B6420815;
        Sat, 17 Nov 2018 16:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542472802;
        bh=GvoXVrDhQ7pxMoZNDV5yBaG0/1BeD/3AK5PmITrQ1dk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PkECIxmANm4DDREWGpWgAC5NOhb0G/3I38FzL8ciJ/5vJ0/PtqRbWghLvhlg7tym0
         xcdNhrhSjb4YckwtBz9jbn9lf6iBgGIAIORQL6kKUAusx0YGyzVBe3AfiltdTOZ/2I
         NteSw/EyhHMlLARG44Zr7J536YD3/WcjP6u2ZqsM=
Date:   Sat, 17 Nov 2018 16:39:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Stefan Popa <stefan.popa@analog.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] dt-bindings: iio: adc: Add common ADCs
 properties to a separate file
Message-ID: <20181117163957.475ca71b@archlinux>
In-Reply-To: <20181116225319.GA26554@bogus>
References: <1542108061-3471-1-git-send-email-stefan.popa@analog.com>
        <20181116225319.GA26554@bogus>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018 16:53:19 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, 13 Nov 2018 13:21:01 +0200, Stefan Popa wrote:
> > There are several ADC drivers that depend on the same device tree
> > bindings. Rather than continue to duplicate the properties, this patch
> > adds a common adc binding document that can be referenced. For beginning,
> > only two properties are documented.
> > 
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > ---
> > Changes in v2, v3:
> > 	- N/A.
> > Changes in v4:
> > 	- Added this commit.
> > Changes in v5:
> > 	- Nothing changed.
> > 
> >  Documentation/devicetree/bindings/iio/adc/adc.txt | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adc.txt
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
