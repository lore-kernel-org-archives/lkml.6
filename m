Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 55B16C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD50208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oz0A3mxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD50208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935505AbeFMMgj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:36:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935274AbeFMMgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:36:38 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27E18208B0;
        Wed, 13 Jun 2018 12:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528893397;
        bh=xcx7roBxwLOwFThEyPnjME/oTz2vKc8IIC6HpcyOR3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oz0A3mxSTCUN+PzXDzQG2FbHBaaIIm9lyGimI5u8XXcx+YzBzJ79o/74P8Kyp9G1l
         j4jpb90r3au3+axo0/havuSwUtJ1nwst72P4CalsbXLt4tltbaIjhUdDZbe3Avi+Nf
         l6dOYEwJQwa2Wag0iKoUSMfNdgd1D8M5u++KgMbA=
Date:   Wed, 13 Jun 2018 14:36:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Parth Y Shah <sparth1292@gmail.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed an indentation error
Message-ID: <20180613123615.GA29104@kroah.com>
References: <1528892710-14928-1-git-send-email-sparth1292@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528892710-14928-1-git-send-email-sparth1292@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 05:55:10PM +0530, Parth Y Shah wrote:
> Signed-off-by: Parth Y Shah <sparth1292@gmail.com>
> ---
>  drivers/usb/gadget/configfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
> index efba66c..0675b4a 100644
> --- a/drivers/usb/gadget/configfs.c
> +++ b/drivers/usb/gadget/configfs.c
> @@ -1217,8 +1217,8 @@ static void purge_configs_funcs(struct gadget_info *gi)
>  			list_move_tail(&f->list, &cfg->func_list);
>  			if (f->unbind) {
>  				dev_dbg(&gi->cdev.gadget->dev,
> -				         "unbind function '%s'/%p\n",
> -				         f->name, f);
> +						"unbind function '%s'/%p\n",
> +						f->name, f);

I see no "error" with the original code here, please explain why this
needs to be changed.

thanks,

greg k-h
