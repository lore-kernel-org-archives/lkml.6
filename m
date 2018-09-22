Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE27BC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 09:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7646021567
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 09:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqE4AFJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7646021567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeIVPVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 11:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbeIVPVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 11:21:09 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D72D02154C;
        Sat, 22 Sep 2018 09:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537608495;
        bh=CyGgdtu7G1ULIEddWbSkTUE9kGAiHS/RHJGjMhf3iHk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VqE4AFJ1yWprEDavpFDUpL4QzHK6fmAnB9c12mXUtD5VyrlanU6D+MS+tLVZmG2Gj
         aKSxhEknB+MpD0pdzgaeAyTtukwb7LL648VDTMJ1CduS1MbBby5e/6Qn5NRlawjvsx
         KzFWi2PYCuOGxc/z7J4qBTdWXG3j+DQnvXf/3D00=
Date:   Sat, 22 Sep 2018 10:28:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        shubhrajyoti@ti.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: hmc5843: Replace a return value.
Message-ID: <20180922102811.7ad29532@archlinux>
In-Reply-To: <20180920134219.8402-1-songqiang1304521@gmail.com>
References: <20180920134219.8402-1-songqiang1304521@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2018 21:42:19 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> This error apparently is caused by timed out event, so a -ETIMEDOUT
> should be used instead of a -EIO, and it also tells user what happened
> , so this dev_err may not be needed anymore.
> 
> Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> ---
> I used ./scripts/get_maintainer.pl to get maintainers about this file,
> I thought this script searches maintainers with looking up MAINTAINER,
> is that right?
> So I searched MAINTAINER and also found nothing related to hmc5843.
> In the declearation area I can see Shubhrajyoti Datta 
> <shubhrajyoti@ti.com> wroted this driver and several other people
> including Peter Meerwald have contributed. Is this driver now a orphan?
> Or if it is, I think we may also need to add it to the MAINTAINER file.
> I'm also familiar with this device, I think I can add interrupt support
> later.

Those drivers not covered by more explicit MAINTAINER entries are
picked up by the main IIO one.  Of course if you are working in a
significant way with the driver and want to adopt it, then post
a patch adding a MAINTAINERS entry and see if any of the previous
significant contributors mind (or potentially want to co-maintain it).

> 
>  drivers/iio/magnetometer/hmc5843_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
> index ada142fb7aa3..4fb393c3854c 100644
> --- a/drivers/iio/magnetometer/hmc5843_core.c
> +++ b/drivers/iio/magnetometer/hmc5843_core.c
> @@ -170,8 +170,7 @@ static int hmc5843_wait_measurement(struct hmc5843_data *data)
>  	}
>  
>  	if (tries < 0) {
> -		dev_err(data->dev, "data not ready\n");
> -		return -EIO;
> +		return -ETIMEDOUT;

I'd say no on this one as I suspect such a timeout only indicates a
communication problem, not some delay in the hardware managing to
return an answer..

It's certainly not a clear enough reason to my mind to argue for changing
the error code (which it is just possible some less than ideal userspace
code is relying on).

Jonathan

>  	}
>  
>  	return 0;

