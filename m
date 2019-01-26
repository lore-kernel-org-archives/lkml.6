Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB227C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA652218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548497176;
	bh=qOVJ0Jo+RKwjH9m0MuM310+kDMy2gAkYgzo5oU6geaw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=E3XPsLGdUHRwN57i9G52CLbrYr4maDI+Bj3ydNRspCBmo6h0SrIBhSzaVVuKZh2j7
	 BSpQCc2UrYs3oZSY9YcYjITNL8f0Liw2rS4VNulsBtkreLskFaGzlO8b2HEOVkUFUe
	 +bHFn7Oarvg0ENtF4roG62CJ1kOkiCsvdBalPCYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfAZKGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:06:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfAZKGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:06:14 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D9FF217D7;
        Sat, 26 Jan 2019 10:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548497173;
        bh=qOVJ0Jo+RKwjH9m0MuM310+kDMy2gAkYgzo5oU6geaw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dAb/O/D0LaSEc3XW+1o/LrX4ko9RXL7vfBhfY/+tJcpDfTzBGPoBtTweyNhhaS+Hs
         iKmtrY8s0MBkKuwYabBMF5NRcVvXkpQVAqPiCx/E0B0OBgX/bUlBZ3pdrxKGoZflfr
         HpEzkzVXMNOT4Uzm1mm03YHeErWTRG6SkkiCNz0w=
Date:   Sat, 26 Jan 2019 11:06:05 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mtd@lists.infradead.org,
        Nguyen An Hoan <na-hoan@jinso.co.jp>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] eeprom: at25: Merge "off" and "offset" in
 at25_ee_write()
Message-ID: <20190126110546.360190cc@bbrezillon>
In-Reply-To: <20190118140525.29189-2-geert+renesas@glider.be>
References: <20190118140525.29189-1-geert+renesas@glider.be>
        <20190118140525.29189-2-geert+renesas@glider.be>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 15:05:24 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> Since commit 01973a01f9ec34b7 ("eeprom: at25: remove nvmem regmap
> dependency") changed the type of "off" from "loff_t" to "unsigned int",
> "off" and "offset" are now the same type, and can be merged into a
> single variable.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
> v2:
>   - Merge "off" and "offset" into a single variable instead of just
>     killing the cast, as suggested by Arnd.
> ---
>  drivers/misc/eeprom/at25.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
> index 99de6939cd5ac2e3..2d8e5388e574710d 100644
> --- a/drivers/misc/eeprom/at25.c
> +++ b/drivers/misc/eeprom/at25.c
> @@ -130,7 +130,8 @@ static int at25_ee_read(void *priv, unsigned int offset,
>  	return status;
>  }
>  
> -static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
> +static int at25_ee_write(void *priv, unsigned int offset, void *val,
> +			 size_t count)
>  {
>  	struct at25_data *at25 = priv;
>  	const char *buf = val;
> @@ -138,10 +139,10 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
>  	unsigned		buf_size;
>  	u8			*bounce;
>  
> -	if (unlikely(off >= at25->chip.byte_len))
> +	if (unlikely(offset >= at25->chip.byte_len))
>  		return -EFBIG;
> -	if ((off + count) > at25->chip.byte_len)
> -		count = at25->chip.byte_len - off;
> +	if ((offset + count) > at25->chip.byte_len)
> +		count = at25->chip.byte_len - offset;
>  	if (unlikely(!count))
>  		return -EINVAL;
>  
> @@ -160,7 +161,6 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
>  	do {
>  		unsigned long	timeout, retries;
>  		unsigned	segment;
> -		unsigned	offset = (unsigned) off;
>  		u8		*cp = bounce;
>  		int		sr;
>  		u8		instr;
> @@ -234,7 +234,7 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
>  			break;
>  		}
>  
> -		off += segment;
> +		offset += segment;
>  		buf += segment;
>  		count -= segment;
>  

