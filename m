Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77437C65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 19:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE3F2088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 19:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMi0f4K4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE3F2088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeJHCcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 22:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbeJHCcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 22:32:21 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BABC02087D;
        Sun,  7 Oct 2018 19:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538940243;
        bh=kN4KxvOFXwjzozgQthP6vVXIpGfSvPT8SvdtXG8VUTY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tMi0f4K4qmiDkxiouhG1P2rIGzS08lC7Cdko/P/RvqgW7n7q2/fQE7yU3GCqH1Ypb
         /sakuKnAsVSFT7kBG88y2GzP6IJk8x59IOmzXUd4y7KEvY384HxjntQNC+6G9aorcz
         FFLTVTn8m6ktVwkhaWT3wOKKtayg/4aGucXuWwLs=
Date:   Sun, 7 Oct 2018 20:23:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     lars@metafoo.de, michael.hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        sonic.zhang@analog.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adt7316: fix parenthesis alignment
Message-ID: <20181007202358.53ed37e8@archlinux>
In-Reply-To: <20181004230651.wcqz4fp2cycyrq6t@renatolg>
References: <20181004230651.wcqz4fp2cycyrq6t@renatolg>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2018 20:06:55 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> This patch fixes all "Alignment should match open parenthesis" check
> warnings found by checkpatch.pl in the addac/adt7316 driver.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
Hi,

Mostly good, but alignment doesn't override other considerations such
as consistency in argument naming.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316.c | 462 ++++++++++++++--------------
>  drivers/staging/iio/addac/adt7316.h |   2 +-
>  2 files changed, 233 insertions(+), 231 deletions(-)
> 
...
> @@ -1363,9 +1365,9 @@ static ssize_t adt7316_show_in_analog_temp_offset(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_in_analog_temp_offset(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +						   struct device_attribute *att,
I wasn't expecting to see a rename in here.  I know it's not a big thing 
as the parameter isn't even used, but it is better to have consistency
of naming than a minor improvement in alignment.

> +						   const char *buf,
> +						   size_t len)
>  {
>  
>  static ssize_t adt7316_store_ex_analog_temp_offset(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +						   struct device_attribute *att,
Same here...

> +						   const char *buf,
> +						   size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);

...
