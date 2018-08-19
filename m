Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6714CC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FB72145D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOY7IIM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FB72145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeHSTeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 15:34:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbeHSTeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 15:34:08 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08C9420779;
        Sun, 19 Aug 2018 16:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534695728;
        bh=r4ZAJqIqe+xfwHC2CTz+i9Yi0rARQch8bWYcjOel72E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NOY7IIM2Iq/DnlkjHU1YXUdt9foeCDuz6GGM74zJJq+S8zVi0yZHYy/LJvd31vUC/
         zs0kdVXDXVvygkBoqGQDI3Hvsjr8EmYuAeLSHP06mELx0wn9hr2JNymDke+T40T9ZR
         82iqYOvq6Gb+rPN92aIRWj9tI1ntHsVeApSJ5Mxc=
Date:   Sun, 19 Aug 2018 17:22:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: health: max30102: Mark expected switch
 fall-throughs
Message-ID: <20180819172204.29754098@archlinux>
In-Reply-To: <20180815162349.GA3458@embeddedor.com>
References: <20180815162349.GA3458@embeddedor.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2018 11:23:49 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case, I placed the "fall through"
> annotation at the bottom of the case, which is what GCC is expecting
> to find.
> 
> Addresses-Coverity-ID: 1458342 ("Missing break in switch")
> Addresses-Coverity-ID: 1458345 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/health/max30102.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> index 15ccadc..3e29562 100644
> --- a/drivers/iio/health/max30102.c
> +++ b/drivers/iio/health/max30102.c
> @@ -282,9 +282,11 @@ static int max30102_read_measurement(struct max30102_data *data,
>  	switch (measurements) {
>  	case 3:
>  		MAX30102_COPY_DATA(2);
> -	case 2: /* fall-through */
> +		/* fall through */
> +	case 2:
>  		MAX30102_COPY_DATA(1);
> -	case 1: /* fall-through */
> +		/* fall through */
> +	case 1:
>  		MAX30102_COPY_DATA(0);
>  		break;
>  	default:

