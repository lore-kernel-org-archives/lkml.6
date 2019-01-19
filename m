Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBA2C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 17:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DC320883
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 17:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547919899;
	bh=jFkBs6YaPqO2lrs2z6SdXt4+SuPAqhzx4zURpPfALP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JXVO2EvwzqPvRP4++TRBo9ZtTtDbBGWHX/Tv0qCx8UP4OLRu3qwWm7qCE4pbTZiEJ
	 pBpXQZVk51n+pw8fTSiYVjUvr+hoY5aNsPy5kNAq2vQT1ZsnWGudUzrVgTn0W2zd7u
	 Mnb+1LtnEwDWb+e621GEWwiSNaKcE+qEhAggg3AA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfASRo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 12:44:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:58286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728658AbfASRo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 12:44:57 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C154E2084F;
        Sat, 19 Jan 2019 17:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547919897;
        bh=jFkBs6YaPqO2lrs2z6SdXt4+SuPAqhzx4zURpPfALP0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vD3jEIeXwgNnzJr87JElCmhKt2gs6hkwSGRn4jyLx0UbIQJkzpWq3XY3bfADZZXcY
         oP9/rphxMZcJ4USWsEXcTkQHhi4KWwoXX++PpkhOqQzECrjz20rfHyn1a14/2b7kti
         gbI1PXhhAUJljSjTlnRh5vBUpwwrVnaOuPq24HWo=
Date:   Sat, 19 Jan 2019 17:44:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Sebastien Bourdelin <sebastien.bourdelin@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, himanshujha199640@gmail.com,
        mark.rutland@arm.com, robh+dt@kernel.org, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: chemical: Add bindings for
 bme680
Message-ID: <20190119174451.2528072a@archlinux>
In-Reply-To: <20190115202802.GA26149@bogus>
References: <20190114201914.24572-1-sebastien.bourdelin@gmail.com>
        <20190114201914.24572-2-sebastien.bourdelin@gmail.com>
        <20190115202802.GA26149@bogus>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019 14:28:02 -0600
Rob Herring <robh@kernel.org> wrote:

> On Mon, 14 Jan 2019 15:19:14 -0500, Sebastien Bourdelin wrote:
> > BME680 is a pressure/temperature/humidity/voc sensor.
> > 
> > Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
> > ---
> > v2 -> v3:
> >   - change i2c address to 0x76 as it seems more reliable: Suggested by Himanshu Jha <himanshujha199640@gmail.com>
> >   - rebase on master
> > ---
> >  .../devicetree/bindings/iio/chemical/bme680.txt       | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/bme680.txt
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
