Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0066AC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C2F20817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2pOFqWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C2F20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeKRDQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 22:16:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbeKRDQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 22:16:38 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0D752080D;
        Sat, 17 Nov 2018 16:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542473961;
        bh=SRrGRcU4dbNPF/YADzpYx7eMbyfbPqTlN2DMSku0URU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g2pOFqWzu9hdnYBV0pF9nzuXqfH67odRTpF+tEUfas+ODSW6oY8Ti9YPw68L51eAm
         TLMkPepW6TQ2QuyJ8w2Q9P9R+Kk5R+ckqqOCteda+zGYiFHiJ2VAKqdhK4TrlltgTb
         pSmUEs+jI1t1XirKYEwGo9ep3GnBcbhRWDBnRFAQ=
Date:   Sat, 17 Nov 2018 16:59:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] Staging: iio: adt7316: Set the data field
Message-ID: <20181117165916.1ceac301@archlinux>
In-Reply-To: <20181116224907.24376-1-shreeya.patel23498@gmail.com>
References: <20181116224907.24376-1-shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Nov 2018 04:19:07 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> adt7316_i2c_read function nowhere sets the data field.
> It is necessary to have an appropriate value for it.
> Hence, assign the value stored in 'ret' variable to data field.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
I have amended the description slightly to make it clear this
is a fix and that it has been broken so long we aren't that
bothered about it going into stable!

Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316-i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
> index f66dd3ebbab1..856bcfa60c6c 100644
> --- a/drivers/staging/iio/addac/adt7316-i2c.c
> +++ b/drivers/staging/iio/addac/adt7316-i2c.c
> @@ -35,6 +35,8 @@ static int adt7316_i2c_read(void *client, u8 reg, u8 *data)
>  		return ret;
>  	}
>  
> +	*data = ret;
> +
>  	return 0;
>  }
>  

