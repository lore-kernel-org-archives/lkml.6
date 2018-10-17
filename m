Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E779ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EA921527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U76jYh2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8EA921527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeJQWjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:39:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35215 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbeJQWjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:39:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id f8-v6so12823220plb.2;
        Wed, 17 Oct 2018 07:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ugnJjiKfZK3agtZoV4CiPR2kBiUowgxXQRYPO1qID6Y=;
        b=U76jYh2FDwf4pl5v/8CDnYRDeheD6i5fEbxsw3ksmh2gBtXaByO8Q8B18rwGnQF6SM
         8Hc/QUtyuWTgeh03Q8QwRdO9FLnXQVcKgSHotsAI+Pb+zxL116WKeAe94wKdzFwejBHN
         mVICPOEl2LBMaJMvZizsaqJCtvHsVSpMCp2yndHCcNKpyLwSXaHbNWBDnlEmyLPqBAXp
         8zxuHG/iJLpKj0K9pLgQcxFLI8uBScSN5lgWK7MkHFklRK5C9SosbjoGiOPE4bMM7dQZ
         UAh+aUNbEK48OvMDtlGQnH7sdJHZoKtWWJKQOU76R2BG0VMWbvrSuIVHH39PDEdEkOsG
         DmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ugnJjiKfZK3agtZoV4CiPR2kBiUowgxXQRYPO1qID6Y=;
        b=IEkbK7t9Hlpd1JIeg1+qgfOOvrptAaoQ93ef3XrxRl3Cdn9/55UWjyrvwvpA9RWb96
         Iwn7CnA16fj3Tv9Pa63Vao3bA1xTpAEg+gjefeVIjQjiQNN8tf8y5FxoXt5zw+D7Ou2R
         kpx4okFwI4jiUxjnLRvt68QZMReOOHTZyf53W5mg0nLmx1/CjH2a9XZ5NU48aa7h8jjt
         7Q/iFDX1jaU6H1iigqRzgwQHSWhYNPMobTSsW0nug/TYBaYLr5QkaTLvXlIr5ie/S6U3
         XP7xYBBfQbuM31em6KxJAvWblaff/Qw9zBvSUCoDJkTe4V7FO44lzOMViMGlPWkg90Sm
         mO/w==
X-Gm-Message-State: ABuFfojZaDTxineDn3BJRIqGUfX5CV5MCRzeDVeS1GNadJOj4sMzcb+9
        2u3axQCNauqQ8sSr69Ds494=
X-Google-Smtp-Source: ACcGV614uZiXTVMRkeAAyEZGApnxsX3gi0rcyLFeCxoMOp3JPCeEFVK418xGcrancmAOjpB0WGDKWg==
X-Received: by 2002:a17:902:32a4:: with SMTP id z33-v6mr15481121plb.85.1539787397328;
        Wed, 17 Oct 2018 07:43:17 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id k24-v6sm22362336pfi.11.2018.10.17.07.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 07:43:16 -0700 (PDT)
Date:   Wed, 17 Oct 2018 20:13:09 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [PATCH] staging: iio: ad7816: Switch to the gpio descriptor
 interface
Message-ID: <20181017144307.GA11244@nishad>
References: <20181016144623.GA9890@nishad>
 <929c42b8-34e7-60bb-5bd4-31faf53d62c2@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <929c42b8-34e7-60bb-5bd4-31faf53d62c2@metafoo.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 05:10:14PM +0200, Lars-Peter Clausen wrote:
> On 10/16/2018 04:46 PM, Nishad Kamdar wrote:
> > Use the gpiod interface for rdwr_pin, convert_pin and busy_pin
> > instead of the deprecated old non-descriptor interface.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> 
> Hi,
> 
> Thanks for the patch, this looks good.
> 
> One thing about the error messages though.
> 
> > +	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_IN);
> > +	if (IS_ERR(chip->rdwr_pin)) {
> > +		ret = PTR_ERR(chip->rdwr_pin);
> >  		dev_err(&spi_dev->dev, "Fail to request rdwr gpio PIN %d.\n",
> > -			chip->rdwr_pin);
> > +			ret);
> 
> This previously showed the pin number which has now been replaced with the
> error code. The message doesn't make that much sense semantically anymore.
> Maybe replace it with something like
> 
> 	"Failed to request rdwr GPIO: %d\n", ret
> 
> >  		return ret;

Hello,

Ok, I'll do that.

Thanks for the review.

regards,
Nishad
