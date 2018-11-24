Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DC3C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 08:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5948C20874
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 08:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="PU2GQvRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5948C20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poczta.fm
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbeKXTJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 14:09:05 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.154]:45955 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbeKXTJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 14:09:05 -0500
X-Interia-R: Interia
X-Interia-R-IP: 188.121.17.172
X-Interia-R-Helo: <x220.localdomain>
Received: from x220.localdomain (ipv4-188-121-17-172.net.internetunion.pl [188.121.17.172])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by www.poczta.fm (INTERIA.PL) with ESMTPSA;
        Sat, 24 Nov 2018 09:21:15 +0100 (CET)
Date:   Sat, 24 Nov 2018 09:21:47 +0100
From:   Slawomir Stepien <sst@poczta.fm>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging: iio: ad5933: finalized device-tree support
Message-ID: <20181124082147.GA8213@x220.localdomain>
References: <20181123235159.hh43xnvvwsil4on2@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123235159.hh43xnvvwsil4on2@smtp.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1543047678;
        bh=L1iUpS2Dny8BBvABpkcMc6lqRVqWZgWrk8jZ5TLl2qk=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:Date:From:To:Cc:
         Subject:Message-ID:References:MIME-Version:Content-Type:
         Content-Disposition:In-Reply-To:User-Agent:X-Interia-Antivirus;
        b=PU2GQvRgd5CPDziivLTovDyAks3VPt3NWDQpm5JiRyHJDJF+yj7tvAWBGXOziPyfy
         iiU7Rtxl18fr1dxknv3q7WLRXgMYEI7b+s8+06soYQwGrutOrKC5DWqQafOg40Yv13
         2BWvorSMbdRtCHYc7uDn2dweyABXj0mz/QRUxNkk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On lis 23, 2018 21:51, Marcelo Schmitt wrote:
> Added a of_device_id struct variable and subsequent call to
> MODULE_DEVICE_TABLE macro to complete device-tree support for this
> driver.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index edb8b540bbf1..19e8b6d2865c 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -771,9 +771,18 @@ static const struct i2c_device_id ad5933_id[] = {
>  
>  MODULE_DEVICE_TABLE(i2c, ad5933_id);
>  
> +static const struct of_device_id ad5933_of_match[] = {
> +	{ .compatible = "analog-devices,ad5933" },
> +	{ .compatible = "analog-devices,ad5934" },

Why "analog-devices", rather than "adi"? My understanding is that analog devices
have "adi" as a manufacture part in compatible.

> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, ad5933_of_match);
> +
>  static struct i2c_driver ad5933_driver = {
>  	.driver = {
>  		.name = "ad5933",
> +		.of_match_table = ad5933_of_match,
>  	},
>  	.probe = ad5933_probe,
>  	.remove = ad5933_remove,

-- 
Slawomir Stepien
