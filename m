Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2266ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 16:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DF320858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 16:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSXqP3el"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DF320858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeGURYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 13:24:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbeGURYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 13:24:53 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5200120849;
        Sat, 21 Jul 2018 16:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532190695;
        bh=DLgY/h6sWsqD8zZ/GyYJPXNGKkVn5luzXAhGMLi1xAQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rSXqP3eltiUJXLoZ/dp8X1miN4HKwFvgpdqVhJ6ZssfC6bL4pczhSGs8RxN2lRUtb
         h5oLpjakVC/Zs21COa+bmOzbhP4U+qnc+oU9/kEtoGx4ihxBVfTrYxKlP3FnRkzgOj
         a68kLNRBKsXx9iC77Pw16qFazFX1VPDyaXh0IWP4=
Date:   Sat, 21 Jul 2018 17:31:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v4] iio: chemical: Add support for Bosch BME680 sensor
Message-ID: <20180721173131.6be1579f@archlinux>
In-Reply-To: <20180721153607.GA11127@himanshu-Vostro-3559>
References: <1532122284-19602-1-git-send-email-himanshujha199640@gmail.com>
        <20180721161934.75066d97@archlinux>
        <20180721153607.GA11127@himanshu-Vostro-3559>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jul 2018 21:06:08 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> > Hi Himanshu,
> > 
> > This was close to the point where I'd take it and make the few remaining
> > fixes myself.  I'm still bothered however by the fact the casts in the
> > various calibration functions are still not all justified so please take
> > another look at that.  Frankly it looks like the original author
> > threw in casts because they didn't want to have to think about which ones
> > actually do anything!  
> 
> Ok. I will remove the ones mentioned below.
> 
> > Few other things to fix up for v5 as well.  
> 
> I will send the fixes in an hour.
> 
> > Jonathan
> > 
> >   
> > > +#define   BME680_NB_CONV_MASK			GENMASK(3, 0)
> > > +#define	    BME680_RUN_GAS_EN_BIT		BIT(4)  
> > 
> > odd looking spacing above.  
> 
> I don't know why this is showing like that in the diff output, but I
> have checked the code by apllying to my test tree(git am <patch>) and
> there was no such spurious spacing!

You have a tab after the #define in this one instance - in the others it's
all spaces (as it should be)

...
