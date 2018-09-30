Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC5EC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B382075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ml+rpY2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B382075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeI3RDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 13:03:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36432 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeI3RDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 13:03:14 -0400
Received: by mail-ed1-f68.google.com with SMTP id f4-v6so11671164edq.3;
        Sun, 30 Sep 2018 03:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CtDIY6VHEmx10DsPywWZfJFRj2Hwb5YG9AvD3LNPVTM=;
        b=ml+rpY2fKttgGtXoYjd1FlzrxIr1zU9MjWZ11JDoCefq3V9vWYP2295edlH0Gzh7lJ
         RV3kV7eDXD60OAJXjPv9eOBjnfCPxdO4gJ3uG8AvybOfcQ/wMYLEUHeT8I/8DMDMAZlh
         +7AE3Q9CR/2dKln+bHCZOgB7OBsKKwJXb8tTdhwb1Thg/4hxrMVVTXI9m9BdotAHKaxO
         x5DggK0aHzl7PewHU8X+N4HDp6vFYmm5OUs6xDzsE6EN6KJYfeizsh1i3OjgK3o8AOFM
         nALiFPzFa9IO24h/hTZZWxL8KvquLnpoueXcxQi8zhG64tMDADHz/nl2dMBDCOauU+41
         hHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CtDIY6VHEmx10DsPywWZfJFRj2Hwb5YG9AvD3LNPVTM=;
        b=fVZgfqUHzfUTAXLfyo6VnfipM8aV+jLkD6gcLhdjlhXNe5hBxf9d2TRQiu/dbRA/xM
         6TT8awLgy8kY8OAq8rd+P+8vDBwIBGHlyPzw8eaAV+eJTG1WsYV2nVeLXewdaOmR5Vts
         4AyTEWsrK3R/8ApWmEKQIHUo6y+VUFQE+50Wi56Wv+LuaXZiQq9uVCOg0vSAgJkCCbF5
         KXjdR4Lo1OBAlcecRzbHZDBlJm81J5E44L59Q3Kn7tjqGDbUy8YRFtyPXrL0c68GdFbP
         GOJhya/yJ6+LQXAZdJnyd1NWOUeIexwQ9O+ZJZU0ZFJ+jC/4fkvgXICDQC2eqsmi8f9Z
         No1w==
X-Gm-Message-State: ABuFfog6jMd3hf9czu6pPX4qL8/YEJec5E5fGtNA7E+m/iA/Z9mU3MNX
        cJutF8rLe/4Hrr9PN5aP0xU=
X-Google-Smtp-Source: ACcGV63HcorTea4F+VnHHayeq55jEnw8SBg/eAwL4eQyIL+FOkNmlfb1rUMVAxiR8HQWeLc1xhi+yA==
X-Received: by 2002:a50:ac2d:: with SMTP id v42-v6mr12468934edc.119.1538303445374;
        Sun, 30 Sep 2018 03:30:45 -0700 (PDT)
Received: from localhost (87-49-147-65-mobile.dk.customer.tdc.net. [87.49.147.65])
        by smtp.gmail.com with ESMTPSA id i22-v6sm1542889ejz.6.2018.09.30.03.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 03:30:44 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com
Subject: Re: [PATCH v2 3/4] spi: spi-fsl-dspi: Fix cmd_fifo is written before tx_fifo
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
        <20180930092535.24544-3-chuanhua.han@nxp.com>
Date:   Sun, 30 Sep 2018 12:30:43 +0200
In-Reply-To: <20180930092535.24544-3-chuanhua.han@nxp.com> (Chuanhua Han's
        message of "Sun, 30 Sep 2018 17:25:34 +0800")
Message-ID: <87bm8f6zvw.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chuanhua Han <chuanhua.han@nxp.com> writes:

> This patch fixes the problem of invalid data writing during the XSPI
> mode transfer of the dspi controller.
> In XSPI mode,When I executed TX FIFO first and then CMD FIFO for XSPI
> transmission, I found that SPIx_SR[TFIWF]=1(Invalid Data present in TX
> FIFO since CMD FIFO is empty).
> This is the time when no data can be read or written (all the data
> obtained is equal to 0).
>
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> ---
> Changes in v2:
>  -The original patch is divided into multiple patches(the original
> patch theme is "spi: spi-fsl-dspi: Fix support for XSPI transport
> mode"),one of which is segmented.
>
>  drivers/spi/spi-fsl-dspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 4dc1064bf408..96e790e90997 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -590,6 +590,7 @@ static void dspi_tcfq_write(struct fsl_dspi *dspi)
>  		 */
>  		u32 data = dspi_pop_tx(dspi);
>  
> +		cmd_fifo_write(dspi);
>  		if (dspi->cur_chip->ctar_val & SPI_CTAR_LSBFE(1)) {
>  			/* LSB */
>  			tx_fifo_write(dspi, data & 0xFFFF);
> @@ -599,7 +600,6 @@ static void dspi_tcfq_write(struct fsl_dspi *dspi)
>  			tx_fifo_write(dspi, data >> 16);
>  			tx_fifo_write(dspi, data & 0xFFFF);
>  		}
> -		cmd_fifo_write(dspi);
>  	} else {
>  		/* Write one entry to both TX FIFO and CMD FIFO
>  		 * simultaneously.

I will try and find time to test this on our systems at work.

/Esben
