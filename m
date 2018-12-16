Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171CEC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 11:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3DB21836
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 11:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544959159;
	bh=yxRw3KTplIiiwFXbygJ3CU7wmNQ9uT5AznvadSmYd7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=r5mJsKxWA8qHzfC2U+fHHzxpD1s3TZaMBOq2Rd6PrO4uoF/AwE7lELKlj10cu8Dne
	 oExLNRFeoq3WVmGsQMw3C3PnAVzfcjIyrUZzLDqo01zh9ZqzvjuEzE41ZKitwDDbav
	 l5R/k0Jgxp2253O1Z1EPMztDjNbSzKycy3E4JJJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbeLPLTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 06:19:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729821AbeLPLTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 06:19:16 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67388217FA;
        Sun, 16 Dec 2018 11:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544959156;
        bh=yxRw3KTplIiiwFXbygJ3CU7wmNQ9uT5AznvadSmYd7E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZHimcCWVO/IVFUDkdpmgaVBfO1kDbZYuIG7dFhG44SQ5Z9OSKCLm6PR5n1VXMMhpR
         GeeuBloZnhqLS8sL9vo0wAbWuoDRTEvAoal9kEk1+7OKEIX+gDMvnFrIxlupU5Oc1J
         FuSb6ejtHF1cO77B6A0eKjhzB1Itz69xeGMTYJ9o=
Date:   Sun, 16 Dec 2018 11:19:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] staging: iio: adt7316: fix register and bit
 definitions
Message-ID: <20181216111911.149d466b@archlinux>
In-Reply-To: <20181212005503.28054-2-jeremyfertic@gmail.com>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
        <20181212005503.28054-2-jeremyfertic@gmail.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 17:54:53 -0700
Jeremy Fertic <jeremyfertic@gmail.com> wrote:

> Change two register addresses and one bit definition to match the
> datasheet.
> 
> Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
One comment inline.  I added a fixes tag but also a note saying I would
not suggest backporting to stable.

There are too many things wrong with this driver for any backports
to really be worthwhile.  It didn't work at all for i2c until last cycle
for example!

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index dc93e85808e0..1fa4a4c2b4f3 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -59,8 +59,8 @@
>  #define ADT7316_CONFIG1			0x18
>  #define ADT7316_CONFIG2			0x19
>  #define ADT7316_CONFIG3			0x1A
> -#define ADT7316_LDAC_CONFIG		0x1B
> -#define ADT7316_DAC_CONFIG		0x1C
> +#define ADT7316_DAC_CONFIG		0x1B
> +#define ADT7316_LDAC_CONFIG		0x1C
>  #define ADT7316_INT_MASK1		0x1D
>  #define ADT7316_INT_MASK2		0x1E
>  #define ADT7316_IN_TEMP_OFFSET		0x1F
> @@ -117,7 +117,7 @@
>   */
>  #define ADT7316_ADCLK_22_5		0x1
>  #define ADT7316_DA_HIGH_RESOLUTION	0x2
> -#define ADT7316_DA_EN_VIA_DAC_LDCA	0x4
> +#define ADT7316_DA_EN_VIA_DAC_LDCA	0x8
This looks to be called LDAC not LDCA?  

Different error so I don't mind that being fixed later!

Jonathan
>  #define ADT7516_AIN_IN_VREF		0x10
>  #define ADT7316_EN_IN_TEMP_PROP_DACA	0x20
>  #define ADT7316_EN_EX_TEMP_PROP_DACB	0x40

