Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756432AbeDZVXf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:23:35 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34412 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753973AbeDZVXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:23:31 -0400
X-Google-Smtp-Source: AIpwx4+7W0V48GZsnSFZ6HBFHEf7aXiUaJpic1nvqYWQQtcLe2YG6bYu630XTmyOVAx6HPB0oPzqzQ==
Date: Thu, 26 Apr 2018 14:23:27 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Rakesh Iyer <riyer@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 20/61] input: keyboard: simplify getting .drvdata
Message-ID: <20180426212327.GB210716@dtor-ws>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-21-wsa+renesas@sang-engineering.com>
 <20180426191947.GC162443@dtor-ws>
 <20180426200401.lvqiy4gnchkwr4qw@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426200401.lvqiy4gnchkwr4qw@ninjato>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 10:04:01PM +0200, Wolfram Sang wrote:
> Hi Dmitry,
> 
> > > We should get drvdata from struct device directly. Going via
> > > platform_device is an unneeded step back and forth.
> > 
> > I consider the fact that platform device's driver data is accessible via
> > device driver data being implementation detail that may or may not change
> 
> Isn't it actually the other way around? platform_get_drvdata() is a
> convenience function to access driver_data which is embedded in struct
> device?

I guess it depends on how you read it. I always considered it separate
because none (?) of the bus implementation assert this in comments to
XXX_get_drvdata().

> 
> > in the future, so I'd prefer keep using the proper accessors for the
> > objects we are dealing with.
> 
> Exactly. I'd just argue, the object we are dealing with, declared in the
> PM functions, is a struct device.

No, the driver does not create a generic device, it actually creates a
platform device, or i2c client, or spi, or something else. The fact that
suspend and resume routines have generic device as their argument has
more to do with the language limitation rather than reflection of true
type of the objects we are dealing with.

Thanks.

-- 
Dmitry
