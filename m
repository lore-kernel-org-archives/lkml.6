Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9047BC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4562321760
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4562321760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbeHHOhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:37:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41216 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbeHHOhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:37:45 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3E458CC1;
        Wed,  8 Aug 2018 12:18:18 +0000 (UTC)
Date:   Wed, 8 Aug 2018 14:18:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] staging: fbtft: Changes udelay(n) to
 usleep_range(n, n + x). - Style
Message-ID: <20180808121815.GA20272@kroah.com>
References: <cover.1533686201.git.leobras.c@gmail.com>
 <355a96aa9bf3c29bbafc433a1b6e1662588250d8.1533686201.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <355a96aa9bf3c29bbafc433a1b6e1662588250d8.1533686201.git.leobras.c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 09:28:00PM -0300, Leonardo Brás wrote:
> Changes some udelay(n) for n >= 10 to usleep_range(n, n+x) as recommended by checkpatch.pl.

Please properly wrap your changelog lines at 72 columns or close to
that.

> 
> Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
> ---
>  drivers/staging/fbtft/fb_agm1264k-fl.c |  2 +-
>  drivers/staging/fbtft/fb_ra8875.c      |  4 ++--
>  drivers/staging/fbtft/fb_tinylcd.c     |  2 +-
>  drivers/staging/fbtft/fb_upd161704.c   | 19 +++++++++----------
>  drivers/staging/fbtft/fb_watterott.c   |  4 ++--
>  5 files changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
> index f6f30f5bf15a..7a24bde7ca8d 100644
> --- a/drivers/staging/fbtft/fb_agm1264k-fl.c
> +++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
> @@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
>  	dev_dbg(par->info->device, "%s()\n", __func__);
>  
>  	gpio_set_value(par->gpio.reset, 0);
> -	udelay(20);
> +	usleep_range(20, 25);
>  	gpio_set_value(par->gpio.reset, 1);
>  	mdelay(120);
>  }
> diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
> index 5d3b76ca74d8..e2a62677b65b 100644
> --- a/drivers/staging/fbtft/fb_ra8875.c
> +++ b/drivers/staging/fbtft/fb_ra8875.c
> @@ -217,7 +217,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
>  	}
>  	len--;
>  
> -	udelay(100);
> +	usleep_range(100, 101);

No, that's just shutting checkpatch up and not doing the correct thing
here.  This is not ok, you need to provide a valid range that will
actually help.  What you did here is not going to do fix anything.

sorry,

greg k-h
