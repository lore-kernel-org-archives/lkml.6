Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E11BC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 09:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23804214AB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 09:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zO6FiFv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23804214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeHYMmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 08:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbeHYMmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 08:42:47 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C468208C3;
        Sat, 25 Aug 2018 09:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535187867;
        bh=hsv1BeIT86yWEO/YdI/Q4/Tf3508C7Pp1qWSDCJHEf8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zO6FiFv0zpo4dE0XeUCQLIbWIPnzs4gZqbkxvj1nI9E7H+GjYZjEtplh7rsPxwyZf
         JpxUqnvlCL8luHv4n337zMPdAzKURGSCOmksVB3CY3FvODYa6+ldKFZbGp/ciSP4iJ
         OU2p6Ujdoctvt9MZ6q7EyNL3AOcKnz4Qhl7/KcQ4=
Date:   Sat, 25 Aug 2018 10:04:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ti-dac5571: provide of_match_table to driver
Message-ID: <20180825100423.779386be@archlinux>
In-Reply-To: <20180824202459.21855-1-marcus.folkesson@gmail.com>
References: <20180824202459.21855-1-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 22:24:59 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Use the created list of of_device_id's as a match table.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Technically this isn't a regression as it will fall back to the oldschool
i2c matching (which hasn't gone away yet).  Hence I don't plan to send it
as a fix during the cycle.

Jonathan

> ---
>  drivers/iio/dac/ti-dac5571.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
> index e39d1e901353..f6dcd8bce2b0 100644
> --- a/drivers/iio/dac/ti-dac5571.c
> +++ b/drivers/iio/dac/ti-dac5571.c
> @@ -421,6 +421,7 @@ MODULE_DEVICE_TABLE(i2c, dac5571_id);
>  static struct i2c_driver dac5571_driver = {
>  	.driver = {
>  		   .name = "ti-dac5571",
> +		   .of_match_table = of_match_ptr(dac5571_of_id),
>  	},
>  	.probe	  = dac5571_probe,
>  	.remove   = dac5571_remove,

