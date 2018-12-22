Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1372C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6C921917
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545498256;
	bh=Vcl0nMfhHiQ8DYKu/IzgWLTukCq4YFYXgFMMOqhqMcE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VmWzTsM6q0naYVQgHQ7T6PFMrFwWtPW7+CCaBCUGfEGHgohvQDxU+c5FnP2ebTVdf
	 t+UjJmqxj/DCUtq86w9ilrXo1l76QiBF0tWQtPWCFgwVmqRHOWg3tj1JzjSVw9nUiA
	 0x1Csib8IpsaFLfvwY47AMNyqXQDfd00EmP1nTic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732977AbeLVREP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:04:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730712AbeLVREP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:04:15 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33F2E2146E;
        Sat, 22 Dec 2018 17:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545498254;
        bh=Vcl0nMfhHiQ8DYKu/IzgWLTukCq4YFYXgFMMOqhqMcE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MetwJoaFcLIqFQgwGJStJxt6Eq6bp4G5C/aNNOgRoe3K4+Nvabslj1emh80Cna/ab
         cWmfwtXsq6p/WNIQcmOiCxgfpfhsMxeSY18hSTCuGRTY8ZZgAg1hFZ75byZUf2r36N
         t/nR0NlSnwuNghq4AEPpslOIjleGpQRZko5LjK54=
Date:   Sat, 22 Dec 2018 17:04:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sergey Efimochkin <sergeyanton2007@gmail.com>
Cc:     dan.carpenter@oracle.com,
        Sergey Efimochkin <efimochkin.sv@phystech.edu>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: adc: ad7280a: fix codestyle in
 ad7280_event_handler
Message-ID: <20181222170407.36530c12@archlinux>
In-Reply-To: <20181217220602.89406-1-efimochkin.sv@phystech.edu>
References: <20181217074540.GC15451@kadam>
        <20181217220602.89406-1-efimochkin.sv@phystech.edu>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 01:06:01 +0300
Sergey Efimochkin <sergeyanton2007@gmail.com> wrote:

> staging: iio: adc: ad7280a: fix codestyle in ad7280_event_handler
> Signed-off-by: Sergey Efimochkin <efimochkin.sv@phystech.edu>
Hi,

I wouldn't say this is a real improvement on readability.
If you are really determined to 'fix it', then I would suggest introducing
local variables, and only having a single call to iio_push_event for all
the deeply nested cases (well one per channel anyway).

Jonathan

> ---
> Changes in v2:
> - changed patch prefix
> - changed patch description
> - removed incorrect fixes to codestyle
>  drivers/staging/iio/adc/ad7280a.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 58420dcb406d..f167ee1b2127 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -725,8 +725,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  		} else {
>  			if (((channels[i] >> 11) & 0xFFF) >= st->aux_threshhigh)
>  				iio_push_event(indio_dev,
> -					       IIO_UNMOD_EVENT_CODE(
> -							IIO_TEMP,
> +					       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
>  							0,
>  							IIO_EV_TYPE_THRESH,
>  							IIO_EV_DIR_RISING),
> @@ -734,8 +733,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  			else if (((channels[i] >> 11) & 0xFFF) <=
>  				st->aux_threshlow)
>  				iio_push_event(indio_dev,
> -					       IIO_UNMOD_EVENT_CODE(
> -							IIO_TEMP,
> +					       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
>  							0,
>  							IIO_EV_TYPE_THRESH,
>  							IIO_EV_DIR_FALLING),

