Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FB9C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A052146F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogb+wUJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A052146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeLBCQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:16:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:42152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbeLBCQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:16:46 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4E6D2146D;
        Sat,  1 Dec 2018 15:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543676644;
        bh=J85stcoPFM2krqR1tC/s3HX6StrE7fD5vRWamL+247M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ogb+wUJXEXjH+In/fJ8YKKxG8WxLjiuwxTCcYRQuG52ZuZ+pPjswAQmKikPmhRd/Y
         0ZsRkHBy3Gt6t0rWJBwQC/mojsFrP3sM/9+oZua1/SmGXDINjCkz6SjaS2ESw9ARRG
         eAPCCPbhbkKElwY2tJxGkl3lGDxiO3uoN4/Ac/48=
Date:   Sat, 1 Dec 2018 15:04:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Vignesh R <vigneshr@ti.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti_am335x_tscadc: Improve accuracy of
 measurement
Message-ID: <20181201150400.09706f47@archlinux>
In-Reply-To: <20181128091432.GT4272@dell>
References: <20181119064236.28902-1-vigneshr@ti.com>
        <20181119064236.28902-3-vigneshr@ti.com>
        <20181128091432.GT4272@dell>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 09:14:32 +0000
Lee Jones <lee.jones@linaro.org> wrote:

> On Mon, 19 Nov 2018, Vignesh R wrote:
> 
> > When performing single ended measurements with TSCADC, its recommended
> > to set negative input (SEL_INM_SWC_3_0) of ADC step to ADC's VREFN in the
> > corresponding STEP_CONFIGx register.
> > Also, the positive(SEL_RFP_SWC_2_0) and negative(SEL_RFM_SWC_1_0)
> > reference voltage for ADC step needs to be set to VREFP and VREFN
> > respectively in STEP_CONFIGx register.
> > Without these changes, there may be variation of as much as ~2% in the
> > ADC's digital output which is bad for precise measurement.
> > 
> > Signed-off-by: Vignesh R <vigneshr@ti.com>
> > ---
> >  drivers/iio/adc/ti_am335x_adc.c      | 5 ++++-  
> 
> >  include/linux/mfd/ti_am335x_tscadc.h | 4 ++++  
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> 
I'll leave this for v2 given changes in the first patch.

My assumption is at the moment that both will go through mfd.
Shout Lee if you have other plans.

Jonathan

