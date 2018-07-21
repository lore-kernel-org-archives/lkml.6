Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8ECECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 15:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9476A20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 15:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYj1XXyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9476A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeGUQpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 12:45:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46731 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbeGUQpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 12:45:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id p23-v6so9204286pgv.13;
        Sat, 21 Jul 2018 08:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KTHvqFH3AZz5r4pe5oAfdbCuDGKY5xOHOj6DZzoRwzg=;
        b=YYj1XXyC50d4Ps80Ej4ntejXCt0XTXaLIUYhiUjbuVE5Qu6Zb1mw7miBVVSvoxNhnD
         we2U85F1nj+3nJwgPf+tpedAdTUPLIs3+Gq8LbmioJ3jez7FIXjIEcJzy6LT4spJqpcO
         bi6EUQO/vpZup3t2wMm56Rz3f/jUKtkHDMFkCCElId1kaEsN9vwqG3MoWlmgDdp8mMmw
         NHDR29Ncabf6FxJx0qJYcKqE7mcCktn9+WRZTmcAlhUIHAuLRbLIIHH9ZHlWAT/x3Dj6
         GzdaSzt6nPOP7ggBciXwskYkPasaEsIVTriKI1XgadJMhBsd9Y/elPZmLCFvSuwwWIb5
         63DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KTHvqFH3AZz5r4pe5oAfdbCuDGKY5xOHOj6DZzoRwzg=;
        b=QHAqE9SaR2tfr7ezARgzL973sIWhDe6j2wkfCgV7855htP/QYg4XJx8A//+8vDSfYJ
         twT5z1V45Xwf4lRVqsLgpnoUaZhK+GvzSaMrc4m+FX/k7aR4jxXBQ1dZITtA4HvBXPTH
         v4lNHGGF5wVX2Lw8wItXDvwAUGcCNLjz70b3H/rLR/zY1o7gZR6506QFrfbgXmBy4YJ8
         wBkHjFXt8mPUvhAiBNOk/A/az1w+uKvOy74oxJ3xr91PrUGjH8KNNfmrw5C3jonXTNnk
         xGlVcG+3a+XX7n99AC+rqCGZ9QyxISMjytw0SOmfd/sYS0T92q1WVAdJDD+9WcYBF256
         wIrw==
X-Gm-Message-State: AOUpUlFtiDbUuyzRZgDnDxM2RzPKkfC5I/mSYu8ynHVzsKr5y7Z47kYp
        bvDolv/8og7Rbgu64VFB4XW+r+TH
X-Google-Smtp-Source: AAOMgpfmWGGe61pM3INEq8vPOC+B9cDevbebX4aCUv2r6m6ryyDRMd6+ISkVW6jeSW4FAfBjUQUkdQ==
X-Received: by 2002:a63:844:: with SMTP id 65-v6mr6210173pgi.406.1532188357814;
        Sat, 21 Jul 2018 08:52:37 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id 8-v6sm7056251pfk.132.2018.07.21.08.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 08:52:37 -0700 (PDT)
Date:   Sat, 21 Jul 2018 21:22:30 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v4] iio: chemical: Add support for Bosch BME680 sensor
Message-ID: <20180721155230.GB11127@himanshu-Vostro-3559>
References: <1532122284-19602-1-git-send-email-himanshujha199640@gmail.com>
 <20180721161934.75066d97@archlinux>
 <20180721153607.GA11127@himanshu-Vostro-3559>
 <CAHp75VegzWr8Q2idzAWpc5Nw3T5n=vWkMvspe0YGRwEQ_h0p+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VegzWr8Q2idzAWpc5Nw3T5n=vWkMvspe0YGRwEQ_h0p+A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 06:43:51PM +0300, Andy Shevchenko wrote:
> On Sat, Jul 21, 2018 at 6:36 PM, Himanshu Jha
> <himanshujha199640@gmail.com> wrote:
> 
> >> > +   /* Look up table 1 for the possible gas range values */
> >> > +   u32 lookupTable1[16] = {2147483647u, 2147483647u, 2147483647u,
> >> > +                           2147483647u, 2147483647u, 2126008810u,
> >> > +                           2147483647u, 2130303777u, 2147483647u,
> >> > +                           2147483647u, 2143188679u, 2136746228u,
> >> > +                           2147483647u, 2126008810u, 2147483647u,
> >> > +                           2147483647u};
> 
> This one needs perhaps a bit of though, but...
> 
> >> > +   /* Look up table 2 for the possible gas range values */
> >> > +   u32 lookupTable2[16] = {4096000000u, 2048000000u, 1024000000u,
> >> > +                           512000000u, 255744255u, 127110228u, 64000000u,
> >> > +                           32258064u, 16016016u, 8000000u, 4000000u,
> >> > +                           2000000u, 1000000u, 500000u, 250000u, 125000u};
> 
> ...this one obviously just a not needed one. You may replace it with a
> one constant and simple calculation to get either value (index from
> value, or value from index).

Not sure to understand your opinion!?

Anything related to increase to .ro segment ?

I think adding is better to let compiler optimise the code a bit
further.

> -- 
> With Best Regards,
> Andy Shevchenko

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
