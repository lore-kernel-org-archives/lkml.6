Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19BFECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C5720856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMH+Gpi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C5720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388361AbeGWTQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:16:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45380 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387873AbeGWTQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:16:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id f1-v6so933679pgq.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 11:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SWmWTlSHkFdqzXU/8y1HdYi9r7nfcKJn5ub7TzJFIFU=;
        b=XMH+Gpi5NyQBw1DwOHLx5XzRZ+tfEh/2mxm8Ll2v18kQ9ab7PDAJ1TpuKnB3iPHfiX
         MWHxIFNHy83CcRbXWKJvHQc9c/8expWFDapA2+HCaZgCtxEw2+dzQdfzkOESvdbQn1Bc
         Bp/Bd24oYbx0V+uMrSpmmFXLwysFZKNfp44WPfLrAsGNfiP5zziAKoapYl8tF7rSEA0J
         k3BGU8KBTI/2UqqJ3PTrxNPW7J/MMsjbJkiaA65hZ0rj1bWtoTxxSmjaOl3fZcFcgHhe
         SfNEp5Nq2vT7a7MmdsbKJzCb3HsMVZb627lkIXC5hWODUyHGmVZv8d8sMJwks/WstGaO
         0b0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SWmWTlSHkFdqzXU/8y1HdYi9r7nfcKJn5ub7TzJFIFU=;
        b=CWP3OzrTfEQOKKo91yhDAdhQXzfVMGz3ncPMpGtIi3qrld8e/ViqD1DqdbOoW76Cf/
         ITwvOmQllCnRaLrlKzk3sVMctvyVZed6LkSLsfndx/CkXKhb2qaue5Ydjk1hAPLZ2z+8
         Tb+ZCsfiuWS0XSyJQYk3TGaFUfHiGvbVxNkGA7E/wS4AVn2LtXmZSbLwo63G9As7jM8K
         l6zLjNKfEMm0U/hrhN1HiDYWNjlYmVSz/z7O94R5kyLbkWwv2Y8ohv01dIYY5O1TgWTm
         U103zq198P/NXzommaTZNnpUOER8amZPv14HvkEvXk95YHm1pBqRasPnSqXwXcYmhiJH
         w8iQ==
X-Gm-Message-State: AOUpUlHoUyrHldQAbzVj2pqTrfPBypfPGZhEgcnocz9tISlksCuSEs0Q
        NU4RMQb49e4QM2RUf8HQHC4=
X-Google-Smtp-Source: AAOMgpfwP9XzOzsV3uJDjuaHMj0ulYAj2O5BLV/3rzFEp7PQa7jqB4McpaLVB5GOivu48v5E66yquw==
X-Received: by 2002:a63:4e22:: with SMTP id c34-v6mr13242254pgb.6.1532369634749;
        Mon, 23 Jul 2018 11:13:54 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id t21-v6sm16882803pfi.73.2018.07.23.11.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 11:13:53 -0700 (PDT)
Date:   Mon, 23 Jul 2018 11:13:50 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, boris.brezillon@free-electrons.com,
        marek.vasut@gmail.com, richard@nod.at, cyrille.pitchen@wedev4u.fr
Subject: Re: [PATCHv3 2/2] mtd: m25p80: restore the status of SPI flash when
 exiting
Message-ID: <20180723181350.GA58212@ban.mtv.corp.google.com>
References: <20171206025342.7266-1-Zhiqiang.Hou@nxp.com>
 <20171206025342.7266-3-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171206025342.7266-3-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10+33 (2f90ec28cf74) (2018-06-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I noticed this got merged, but I wanted to put my 2 cents in here:

On Wed, Dec 06, 2017 at 10:53:42AM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Restore the status to be compatible with legacy devices.
> Take Freescale eSPI boot for example, it copies (in 3 Byte
> addressing mode) the RCW and bootloader images from SPI flash
> without firing a reset signal previously, so the reboot command
> will fail without reseting the addressing mode of SPI flash.
> This patch implement .shutdown function to restore the status
> in reboot process, and add the same operation to the .remove
> function.

We have previously rejected this patch multiple times, because the above
comment demonstrates a broken product. You cannot guarantee that all
reboots will invoke the .shutdown() method -- what about crashes? What
about watchdog resets? IIUC, those will hit the same broken behavior,
and have unexepcted behavior in your bootloader.

I suppose one could argue for doing this in remove(), but AIUI you're
just papering over system bugs by introducing the shutdown() function
here. Thus, I'd prefer we drop the shutdown() method to avoid misleading
other users of this driver.

Brian

> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V3:
>  - Modified the commit to make this patch specific.
> 
>  drivers/mtd/devices/m25p80.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index dbe6a1de2bb8..a4e18f6aaa33 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -307,10 +307,18 @@ static int m25p_remove(struct spi_device *spi)
>  {
>  	struct m25p	*flash = spi_get_drvdata(spi);
>  
> +	spi_nor_restore(&flash->spi_nor);
> +
>  	/* Clean up MTD stuff. */
>  	return mtd_device_unregister(&flash->spi_nor.mtd);
>  }
>  
> +static void m25p_shutdown(struct spi_device *spi)
> +{
> +	struct m25p *flash = spi_get_drvdata(spi);
> +
> +	spi_nor_restore(&flash->spi_nor);
> +}
>  /*
>   * Do NOT add to this array without reading the following:
>   *
> @@ -386,6 +394,7 @@ static struct spi_driver m25p80_driver = {
>  	.id_table	= m25p_ids,
>  	.probe	= m25p_probe,
>  	.remove	= m25p_remove,
> +	.shutdown	= m25p_shutdown,
>  
>  	/* REVISIT: many of these chips have deep power-down modes, which
>  	 * should clearly be entered on suspend() to minimize power use.
> -- 
> 2.14.1
> 
