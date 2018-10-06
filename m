Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F628ECDE43
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 20:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B408208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 20:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="eqiLn1RR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B408208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poczta.fm
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeJGDhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 23:37:33 -0400
Received: from smtpo.poczta.interia.pl ([217.74.65.157]:51010 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeJGDhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 23:37:33 -0400
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Oct 2018 23:37:32 EDT
X-Interia-R: Interia
X-Interia-R-IP: 188.121.17.172
X-Interia-R-Helo: <x220.localdomain>
Received: from x220.localdomain (ipv4-188-121-17-172.net.internetunion.pl [188.121.17.172])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by www.poczta.fm (INTERIA.PL) with ESMTPSA;
        Sat,  6 Oct 2018 22:25:29 +0200 (CEST)
Date:   Sat, 6 Oct 2018 22:25:42 +0200
From:   Slawomir Stepien <sst@poczta.fm>
To:     Gabriel Capella <gabriel@capella.pro>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adc: ad7280a: fix 2 checks
Message-ID: <20181006202542.GC5035@x220.localdomain>
References: <20181006162715.GA8476@mantaray>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181006162715.GA8476@mantaray>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1538857531;
        bh=7Dv+PW3k8iZOHDpuvzSY+t40mqM8A6fuZz02d+C8PZ0=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:Date:From:To:Cc:
         Subject:Message-ID:References:MIME-Version:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         User-Agent:X-Interia-Antivirus;
        b=eqiLn1RReh+WSmOzIU98W0jtgDzz/AUmpBBrJxdKxWWIXEdRe9wHBYsCcbZQTmwsU
         Hh8E93pRlRTZUjDJcXLZBJX69hHSkcQWPE8Oung32+RP1sT+e20nn6gWYsGRq99bu8
         iBLXtx7mp3UkJ8TLsyVs+fJend/rZGjvKMug/DZ0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On paź 06, 2018 13:27, Gabriel Capella wrote:
> This patch does not change the logic, it only
> corrects the checkpatch checks.
> 
> The patch fixes 2 checks of type:
> "CHECK: spaces preferred around that '-'"

I've made the same mistake few days ago. This change is incorrect.
Please see: https://lore.kernel.org/patchwork/patch/635994/.

> Signed-off-by: Gabriel Capella <gabriel@capella.pro>
> ---
>  drivers/staging/iio/adc/ad7280a.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 58420dcb406d..a4b4f8678c56 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -750,14 +750,14 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  }
>  
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> -		in_voltage-voltage_thresh_low_value,
> +		in_voltage - voltage_thresh_low_value,
>  		0644,
>  		ad7280_read_channel_config,
>  		ad7280_write_channel_config,
>  		AD7280A_CELL_UNDERVOLTAGE);
>  
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
> -		in_voltage-voltage_thresh_high_value,
> +		in_voltage - voltage_thresh_high_value,
>  		0644,
>  		ad7280_read_channel_config,
>  		ad7280_write_channel_config,

-- 
Slawomir Stepien
