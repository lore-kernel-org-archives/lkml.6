Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250D3ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6B82098A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6B82098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbeGPK3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:29:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57486 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbeGPK3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:29:12 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 94240C22;
        Mon, 16 Jul 2018 10:02:32 +0000 (UTC)
Date:   Mon, 16 Jul 2018 12:02:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     RAGHU Halharvi <raghuhack78@gmail.com>
Cc:     devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, wsa@the-dreams.de
Subject: Re: [PATCH] staging: ks7010_sdio:Fix checkpatch out of memory warning
Message-ID: <20180716100230.GA30655@kroah.com>
References: <20180713160636.8017-1-raghuhack78@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713160636.8017-1-raghuhack78@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 09:36:36PM +0530, RAGHU Halharvi wrote:
> * Patch fixes checkpatch warning "Possible unnecessary 'out of memory'
> 	message"
> 
> Signed-off-by: RAGHU Halharvi <raghuhack78@gmail.com>
> ---
>  drivers/staging/ks7010/ks7010_sdio.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
> index b8f55a11ee1c..972b01a0257d 100644
> --- a/drivers/staging/ks7010/ks7010_sdio.c
> +++ b/drivers/staging/ks7010/ks7010_sdio.c
> @@ -957,10 +957,8 @@ static int send_stop_request(struct sdio_func *func)
>  	card = sdio_get_drvdata(func);
>  
>  	pp = kzalloc(hif_align_size(sizeof(*pp)), GFP_KERNEL);
> -	if (!pp) {
> -		netdev_err(card->priv->net_dev, "allocate memory failed..\n");
> +	if (!pp)
>  		return -ENOMEM;
> -	}

This change has already been done in my tree, please always work against
linux-next at the least, and ideally staging.git, so that you do not
duplicate work others have already done.

thanks,

greg k-h
