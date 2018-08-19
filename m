Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A276C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 17:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DBD20834
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 17:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKOVSbi2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DBD20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeHSUVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 16:21:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeHSUVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 16:21:44 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 342F22087A;
        Sun, 19 Aug 2018 17:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534698576;
        bh=wGsqAk2WgJwCaH87DaoLTDcaKYZbYqlalPLOV7je/T4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SKOVSbi24VAjSqQqgPhaGH/TEFEf14/T4WYdE9y6Lmci0GwiQUtnngy3/LfQzDCn4
         UD0nfH5uSDDlpqJpdYcBxHAk7kVSoDgxCk3hGiIsmd6r5b7MMQ593Qe8FBDl8jJQac
         ZSKtqpVXaPLEDrYRrlS2IafkuggxG3h+90M8Oihs=
Date:   Sun, 19 Aug 2018 18:09:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Stefan Popa <stefan.popa@analog.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [PATCH v6 3/6] regmap: Add regmap_noinc_read API
Message-ID: <20180819180930.18f2dfc1@archlinux>
In-Reply-To: <20180810103856.GB20971@sirena.org.uk>
References: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
        <1533890783-13456-4-git-send-email-stefan.popa@analog.com>
        <20180810103856.GB20971@sirena.org.uk>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2018 11:38:56 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Aug 10, 2018 at 11:46:20AM +0300, Stefan Popa wrote:
> > From: Crestez Dan Leonard <leonard.crestez@intel.com>
> > 
> > The regmap API usually assumes that bulk read operations will read a
> > range of registers but some I2C/SPI devices have certain registers for
> > which a such a read operation will return data from an internal FIFO
> > instead. Add an explicit API to support bulk read without range semantics.  
> 
> Please don't resubmit patches that have already been applied, you should
> submit patches against current code in the tree you're expecting things
> to be applied to.  If any updates are needed to a patch that's already
> been applied you should submit incremental patches which make those
> updates.  This avoids having to change published git commits which could
> cause problems for people working against git.

I've merged the regmap branch in question into iio.git.  To add to Mark's
comment it would have been helpful to have the cover letter mention the
need to do that with a copy of what Mark replied with when he took this
patch (as it gives me the details I need to pick up that branch).

Jonathan
