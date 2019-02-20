Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B8CC10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446A821848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfBTKxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:53:02 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:53944 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBTKxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:53:00 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 8370C9E749C;
        Wed, 20 Feb 2019 10:52:58 +0000 (GMT)
Date:   Wed, 20 Feb 2019 10:52:56 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: chemical: pms7003: extend supported sensors
 list
Message-ID: <20190220105256.7eb366a1@archlinux>
In-Reply-To: <20190217192213.15803-2-tduszyns@gmail.com>
References: <20190217192213.15803-1-tduszyns@gmail.com>
        <20190217192213.15803-2-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Feb 2019 20:22:12 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Add other sensors to the compatible list.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/pms7003.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
> index db8e7b2327b3..23c9ab252470 100644
> --- a/drivers/iio/chemical/pms7003.c
> +++ b/drivers/iio/chemical/pms7003.c
> @@ -321,7 +321,12 @@ static int pms7003_probe(struct serdev_device *serdev)
>  }
>  
>  static const struct of_device_id pms7003_of_match[] = {
> +	{ .compatible = "plantower,pms1003" },
> +	{ .compatible = "plantower,pms3003" },
> +	{ .compatible = "plantower,pms5003" },
> +	{ .compatible = "plantower,pms6003" },
>  	{ .compatible = "plantower,pms7003" },
> +	{ .compatible = "plantower,pmsa003" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, pms7003_of_match);

