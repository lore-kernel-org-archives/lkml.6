Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7281CC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B6121747
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B6121747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbeHNHD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 03:03:57 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:38318 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729443AbeHNHD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 03:03:57 -0400
Received: from sapphire.tkos.co.il (unknown [10.0.4.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 54F21440B08;
        Tue, 14 Aug 2018 07:18:36 +0300 (IDT)
Date:   Tue, 14 Aug 2018 07:18:35 +0300
From:   Baruch Siach <baruch@tkos.co.il>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc:rtc-ds1347: Use PTR_ERR_OR_ZERO to replace the
 open code
Message-ID: <20180814041834.2za4nfphklz32rx6@sapphire.tkos.co.il>
References: <1534159885-25364-1-git-send-email-zhongjiang@huawei.com>
 <1534159885-25364-3-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534159885-25364-3-git-send-email-zhongjiang@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhong,

On Mon, Aug 13, 2018 at 07:31:25PM +0800, zhong jiang wrote:
> PTR_ERR_OR_ZERO has implemented the if(IS_ERR(...)) + PTR_ERR, So
> just replace them rather than duplicating its implement.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

> ---
>  drivers/rtc/rtc-ds1347.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1347.c b/drivers/rtc/rtc-ds1347.c
> index 938512c..b97b67f 100644
> --- a/drivers/rtc/rtc-ds1347.c
> +++ b/drivers/rtc/rtc-ds1347.c
> @@ -155,10 +155,7 @@ static int ds1347_probe(struct spi_device *spi)
>  	rtc = devm_rtc_device_register(&spi->dev, "ds1347",
>  				&ds1347_rtc_ops, THIS_MODULE);
>  
> -	if (IS_ERR(rtc))
> -		return PTR_ERR(rtc);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(rtc);
>  }
>  
>  static struct spi_driver ds1347_driver = {

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
