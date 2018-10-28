Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F886C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 15:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2164720870
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 15:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzGe7Vt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2164720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeJ1XpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 19:45:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbeJ1XpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 19:45:15 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D80C620831;
        Sun, 28 Oct 2018 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540738824;
        bh=Kh5HTK4RDBNPklPPC92bGMydj7F4ihNcbUsFsZiRjxU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nzGe7Vt1SeYovR6GrcZIsyvwhQokQQ9hBKR9PYPeuRpJNRJWhLZ7bNThQk252ARhx
         csVXRHen3ixDAhW099whatfvMT8Ce8L5rRbOedwEvXsBtvO4b16vVxQpyhfxLArIxY
         YBWUCvwsr/E0alWRrb7ES06jCxtIfxM13oout0CI=
Date:   Sun, 28 Oct 2018 15:00:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Victor Colombo <victorcolombo@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH 1/2] staging: iio: ad5933: Remove unnecessary space on
 casting
Message-ID: <20181028150020.72abc2cf@archlinux>
In-Reply-To: <20181022204025.lhkzj5ynjbfzbbuj@smtp.gmail.com>
References: <20181022204025.lhkzj5ynjbfzbbuj@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2018 17:40:25 -0300
Victor Colombo <victorcolombo@gmail.com> wrote:

> This patch fixes the checkpatch.pl warning:
> 
> WARNING: No space is necessary after a cast
> 
> Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it and see if we are missing something.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 8a920f675b83..7a216ea90784 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -210,7 +210,7 @@ static int ad5933_set_freq(struct ad5933_state *st,
>  		u8 d8[4];
>  	} dat;
>  
> -	freqreg = (u64) freq * (u64) (1 << 27);
> +	freqreg = (u64)freq * (u64)(1 << 27);
>  	do_div(freqreg, st->mclk_hz / 4);
>  
>  	switch (reg) {

