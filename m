Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DD3C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 17:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758E920E20
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 17:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZ4HPdQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758E920E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeHSUlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 16:41:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbeHSUlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 16:41:10 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F309E20C09;
        Sun, 19 Aug 2018 17:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534699738;
        bh=Lx83vle9c8BWhW1/dpugKAwVJhv/R6i6FzaIrwpYNlc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EZ4HPdQ0onNu5cubZkjNhzZCg0D7x2cGJjya7ZWBEV6XAStK8xkRoNWGWWpYojioW
         89sFfTvy30gXeAas+1ADxh10gke8LXCi1VBVr1PC1r/rkZwDdaD+EB7/cifaZm3JrN
         TJf3OMFF40PFZms99KnjCJisbgaWELfFYl4fRC+E=
Date:   Sun, 19 Aug 2018 18:28:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: max44000: remove unused variable
 max44000_alstim_shift
Message-ID: <20180819182853.2eda699d@archlinux>
In-Reply-To: <20180809135338.10868-1-colin.king@canonical.com>
References: <20180809135338.10868-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Aug 2018 14:53:38 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable max44000_alstim_shift is defined but is never used hence it is
> redundant and can be removed. This variable has been like this since
> the driver was added back in 2016.
> 
> Cleans up clang warning:
> warning: 'max44000_alstim_shift' defined but not used [-Wunused-const-variable=]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/light/max44000.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
> index bcdb0eb9e537..b9b0bd341be8 100644
> --- a/drivers/iio/light/max44000.c
> +++ b/drivers/iio/light/max44000.c
> @@ -99,7 +99,6 @@ static const int max44000_alspga_shift[] = {0, 2, 4, 7};
>   * Handling this internally is also required for buffer support because the
>   * channel's scan_type can't be modified dynamically.
>   */
> -static const int max44000_alstim_shift[] = {0, 2, 4, 6};
>  #define MAX44000_ALSTIM_SHIFT(alstim) (2 * (alstim))
>  
>  /* Available integration times with pretty manual alignment: */

