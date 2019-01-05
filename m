Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB640C43612
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7EB2087F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546706403;
	bh=ySrb+rbphNkf3LVkBFKXb5+bZ+pG16+NCn9BcPz+c0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Fe6Pti1Gb2vwSXPd96hu9KBVeBzV2/ORItKCwWDNbp79dV70BP26rdJ+o7xfgSj6E
	 TiXec2Frd1lyb+GlniVS3SD8UB25SQ+UFdTI1jH8sshXupVYmGYrXg3iV9ShnCwScU
	 tR6tFmT62CAFTnCCtbVLkzRj+L7zESg0smCMW45g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfAEQkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 11:40:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbfAEQkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 11:40:02 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 509102085A;
        Sat,  5 Jan 2019 16:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546706401;
        bh=ySrb+rbphNkf3LVkBFKXb5+bZ+pG16+NCn9BcPz+c0U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hqRt4pednMW15qjLV1NdpZWilBWag6MHnC+FOXqFgx5Fi1p0xkDSipIvAckZ/m3Dz
         cxhT5lbzbpQgJ49R0ERzBb+ectmTp4YkAV8Pv5ggOdYUSv41kTSrph55GnN5so5zUK
         6J8sQ1u5v1bYd8OHD6Ha12Allgv3MYRJJUiV4cRk=
Date:   Sat, 5 Jan 2019 16:39:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, balbes-150@yandex.ru,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: meson-saradc: update
 temperature sensor support
Message-ID: <20190105163956.195752d6@archlinux>
In-Reply-To: <20190103230209.GA21801@bogus>
References: <20181227215020.9803-1-martin.blumenstingl@googlemail.com>
        <20181227215020.9803-2-martin.blumenstingl@googlemail.com>
        <20190103230209.GA21801@bogus>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2019 17:02:09 -0600
Rob Herring <robh@kernel.org> wrote:

> On Thu, 27 Dec 2018 22:50:19 +0100, Martin Blumenstingl wrote:
> > Meson8b and Meson8m2 use a 5-bit wide TSC (temperature sensor
> > coefficient). The SAR ADC registers however can only store (the lower)
> > 4 bits. The fifth (upper-most) bit is stored inside the
> > MESON_HHI_DPLL_TOP_0[9] register from the HHI register area.
> > This adds a syscon property to the HHI register area so a driver can
> > fetch the HHI register map and store the fifth TSC bit in there.
> > 
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  .../devicetree/bindings/iio/adc/amlogic,meson-saradc.txt      | 4 ++++
> >  1 file changed, 4 insertions(+)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

