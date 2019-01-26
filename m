Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A02C282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94CA21903
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDVJFcQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfAZBWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 20:22:51 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35416 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAZBWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 20:22:51 -0500
Received: by mail-it1-f195.google.com with SMTP id p197so12368427itp.0;
        Fri, 25 Jan 2019 17:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4duhNk+tNEwcTFis0uSjbAvx5kQ0UnlzAsLkrgG7FmY=;
        b=fDVJFcQ+bASWiUChwgQxfczPrx0R3VJgREmILqK/GkUSWz9/EflriTHieqxbU0v39J
         OxiTM7MhaCUd1vuUNu9PKYZ0SQEUM5pyVafrlwolRNMtZ5JOQzs1aZB1e2KVIoSqmMmp
         O/ydYwF8+DHruH8j8XVaPP4Az8XBXnfbHR02O3J1znZAUf56Esvyx/1pEodNhWNdTQRF
         S+N3lHLKkvRrdabLqw1qfJ+PidqXnqWNf+vShfxWGeoSwuZ/igINV1a1u8qj1uGozDRP
         OrDqSqRvBCv/ot43AYb4bp8QapQYKZ5M4FbH5Rm8KPUT0jT+Q7a9PT16CDvPxIwFYj2s
         NLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4duhNk+tNEwcTFis0uSjbAvx5kQ0UnlzAsLkrgG7FmY=;
        b=ix7rCUkOZ2bPiLdCa6w8ardKmZSOcC2tkb+5mGjQwyf4LjdHoeyDJF+Y/cWxC4I4Ng
         KlSEbMIXeOzRbJAnuBP2CLbIwjyxfSrS7xZFmRQ8dpPMwsF4KmbytDYOoklXMdSFwNoj
         2W43/kgoD/s1dJADXPQFBn2GpWlZftOfWqd8wpUqitOhIs1oxwZUzkNgG95Ztvh5pfR6
         Lu7/EbMcW8kTa73KRx9/vJndsUisxgcTsD9uherUBCoRJcoilJuRf2QBAhcGvlXMFffV
         P3utRzx9am2WCDhgnH3PnMk46JoMmY7Q1wSpfHi7MSMA0tO+L42fC28NHU0Iq3C2wUpR
         7S2g==
X-Gm-Message-State: AHQUAuZC68RGOOhvF6brkSCNHrEQ51UtVhWFFeWGwcJ4p43AQveSCUSx
        KjXnaGohN2vZnsRtaZwDRA4=
X-Google-Smtp-Source: AHgI3IaikGc4/BKKf6K2TafRXWDfwaPhhL5c1Jch+sT4NentSx4B0uhcLMQL/q7vZdGtwliRmKsZCg==
X-Received: by 2002:a24:f607:: with SMTP id u7mr5547001ith.89.1548465770141;
        Fri, 25 Jan 2019 17:22:50 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id m10sm10584589ioq.25.2019.01.25.17.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 17:22:49 -0800 (PST)
Date:   Fri, 25 Jan 2019 18:22:43 -0700
From:   Jeremy Fertic <jeremyfertic@gmail.com>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] adt7316 regmap implementation
Message-ID: <20190126012243.GA4762@r2700x.localdomain>
References: <20190120153633.18231-1-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190120153633.18231-1-shreeya.patel23498@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 09:06:30PM +0530, Shreeya Patel wrote:
> This patchset consist of some initial patches for heading
> towards the regmap implementation and also the final patch
> which enables the driver to use regmap API thus removing
> the redundant and common code.
> 
> Changes in v3
>   -Fetch the changes from remote and rebase to have it in
> the current working directory.
> 
> Changes in v2
>   -Change the val_bits to 8 and add two more patches
> having a different change before the final implemetation
> of regmap.
> 
> Shreeya Patel (3):
>   Staging: iio: adt7316: Remove irq from bus structure
>   Staging: iio: adt7316: Remove multi read and write functions
>   Staging: iio: adt7316: Add regmap support
> 
>  drivers/staging/iio/addac/adt7316-i2c.c |  97 ++--------------
>  drivers/staging/iio/addac/adt7316-spi.c |  95 +++------------
>  drivers/staging/iio/addac/adt7316.c     | 147 ++++++++++++------------
>  drivers/staging/iio/addac/adt7316.h     |  15 +--
>  4 files changed, 103 insertions(+), 251 deletions(-)
> 
> -- 
> 2.17.1
> 

The series doesn't apply to the current iio testing branch. If there's any
value in a quick sanity testing, I can do that after a rebase. I wasn't
planning to test everything the patch touches, but thought I could at
least test a few register reads and writes to make sure we haven't missed
anything obvious in the regmap implementation.

Jeremy

