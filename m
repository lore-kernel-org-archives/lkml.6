Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13218C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C758421902
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550674953;
	bh=F2+HoL9sMN276Yv/gLLCV537MpubgEZHu/3E3qU7V2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KbEhIfa4ALukNSEsb/bKLR3mXFm5wqXdJMFyscIARNGdMl68JhhKRduqiuTOP6xfQ
	 ZhWh8CouWdkkRjAeV3wiWZz+7JMzIoDyvV2sCXujNBa7FqrPQ4wwdOZ3qAK61spGiC
	 wCNmB+NCkwUf0wDBbcPes8KP8ENsENQgVPrgU7XU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfBTPCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:02:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:55022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfBTPCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:02:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A46052147A;
        Wed, 20 Feb 2019 15:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550674951;
        bh=F2+HoL9sMN276Yv/gLLCV537MpubgEZHu/3E3qU7V2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1oYMAWF1ZcJSXgubvf8HHjyMNeTVKtsILJzBnxterXPt+SgRX1M8GefBBh/IzXMxK
         AV1iYZjCX3WSm4DJPInmGLTxHGa68UmpS2KRpCaTXcCOJyGRsUIfimdAi0izuSY1AT
         QE3WQonpJf3DtZu1YXq/xRtatX+onx28N4Jt5ECw=
Date:   Wed, 20 Feb 2019 16:02:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nikolaus Voss <nv@vosn.de>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, nikolaus.voss@loewensteinmedical.de
Subject: Re: [PATCHv2] usb: typec: tps6598x: handle block writes separately
 with plain-I2C adapters
Message-ID: <20190220150227.GA17103@kroah.com>
References: <20180425142209.30745-1-heikki.krogerus@linux.intel.com>
 <20190220110017.BFA344CE86@mail.steuer-voss.de>
 <20190220125731.02E274CFE0@mail.steuer-voss.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220125731.02E274CFE0@mail.steuer-voss.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 01:57:30PM +0100, Nikolaus Voss wrote:
> Commit 1a2f474d328f handles block _reads_ separately with plain-I2C
> adapters, but the problem described with regmap-i2c not handling
> SMBus block transfers (i.e. read and writes) correctly also exists
> with writes.
> 
> As workaround, this patch adds a block write function the same way
> 1a2f474d328f adds a block read function.
> 
> Fixes: 1a2f474d328f ("usb: typec: tps6598x: handle block reads separately with plain-I2C adapters")
> Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> ---

As was pointed out, you have to have a From: that matches a
signed-off-by somewhere here.  If your company email systems is horrid
and can not handle patches, then put the correct from: line as the first
line of the commit message as the documentation says and all will be
good.



> v2: fix tps6598x_exec_cmd also
> ---
>  drivers/usb/typec/tps6598x.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
> index c84c8c189e90..c54b73fb2a2f 100644
> --- a/drivers/usb/typec/tps6598x.c
> +++ b/drivers/usb/typec/tps6598x.c
> @@ -110,6 +110,20 @@ tps6598x_block_read(struct tps6598x *tps, u8 reg, void *val, size_t len)
>  	return 0;
>  }
>  
> +static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
> +				void *val, size_t len)
> +{
> +	u8 data[len + 1];

I thought the build system now warned when you did this :(

thanks,

greg k-h
