Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84572ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 06:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C732084A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 06:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C732084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbeGUHj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 03:39:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46968 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbeGUHj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 03:39:57 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 89D3A707;
        Sat, 21 Jul 2018 06:48:19 +0000 (UTC)
Date:   Sat, 21 Jul 2018 08:48:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        Zhongze Hu <frankhu@chromium.org>,
        linux-kernel@vger.kernel.org, Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH 02/20] staging: gasket: gasket_enable_dev remove
 unnecessary variable
Message-ID: <20180721064817.GA4771@kroah.com>
References: <20180720034920.77320-1-toddpoynor@gmail.com>
 <20180720034920.77320-3-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720034920.77320-3-toddpoynor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 08:49:02PM -0700, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Remove unnecessary variable, pass constant param instead.
> 
> Reported-by: Dmitry Torokhov <dtor@chromium.org>
> Signed-off-by: Zhongze Hu <frankhu@chromium.org>
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
>  drivers/staging/gasket/gasket_core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
> index 0d5ba7359af73..f327c9d7f90a3 100644
> --- a/drivers/staging/gasket/gasket_core.c
> +++ b/drivers/staging/gasket/gasket_core.c
> @@ -898,7 +898,6 @@ static int gasket_enable_dev(
>  {
>  	int tbl_idx;
>  	int ret;
> -	bool has_dma_ops;
>  	struct device *ddev;
>  	const struct gasket_driver_desc *driver_desc =
>  		internal_desc->driver_desc;
> @@ -917,8 +916,6 @@ static int gasket_enable_dev(
>  		return ret;
>  	}
>  
> -	has_dma_ops = true;
> -
>  	for (tbl_idx = 0; tbl_idx < driver_desc->num_page_tables; tbl_idx++) {
>  		gasket_log_debug(
>  			gasket_dev, "Initializing page table %d.", tbl_idx);
> @@ -936,7 +933,7 @@ static int gasket_enable_dev(
>  			&gasket_dev->bar_data[
>  				driver_desc->page_table_bar_index],
>  			&driver_desc->page_table_configs[tbl_idx],
> -			ddev, gasket_dev->pci_dev, has_dma_ops);
> +			ddev, gasket_dev->pci_dev, true);

As the only call for this function now hard-codes this last parameter,
perhaps that parameter should just be removed now?

Something for a later patch.

thanks,

greg k-h
