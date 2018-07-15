Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E4AECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 08:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8645920870
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 08:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlR8BRy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8645920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbeGOJAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 05:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbeGOJAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 05:00:37 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 556B920870;
        Sun, 15 Jul 2018 08:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531643907;
        bh=eNVLrZTloHwUVPQiZjtnfVIKrHdMUE6Qj5rHy4GIirg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZlR8BRy2Oofee1Pfb18SADqVRRJFcizDgjbW9eMQwGA5WSQglyQhGQcmCGxn28WGa
         0+9q46oKKZgfMn74m4Vdjnv0G2ekSiBzp1UsDZcKCTCUousL3r85YYroAcEakLanhG
         2l3WnkBF1L/a2Ud4g4LnbrCkpsfn9Q5hnubhHZOw=
Date:   Sun, 15 Jul 2018 09:38:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Andreas Klinger <ak@it-klinger.de>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] iio: hx711: add clock-frequency property in DT
Message-ID: <20180715093821.50824bd2@archlinux>
In-Reply-To: <20180711135400.GA14723@rob-hp-laptop>
References: <20180710181831.GA5374@arbeit>
        <20180711135400.GA14723@rob-hp-laptop>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 07:54:00 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, Jul 10, 2018 at 08:18:31PM +0200, Andreas Klinger wrote:
> > Add clock-frequency property for hx711 ADC. This is the frequency of
> > PD_SCK.
> > 
> > After PD_SCK goes high DOUT is read just before PD_SCK goes down again.
> > This is necessary because of parasitic capacitance on the wiring.
> > 
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 6 ++++++
> >  1 file changed, 6 insertions(+)  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

