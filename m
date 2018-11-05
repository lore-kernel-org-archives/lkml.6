Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB52C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E34320862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lZqaDchr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E34320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387686AbeKFD4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:56:12 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42188 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbeKFD4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KovmXzU93o/7B/WWqEJJ/1B6jrdexPPkyfreb+7T+1s=; b=lZqaDchr8I/5Pefm0BTV5vw5l7
        6qbT1/Z/iK9jedG7LbjlByeQH1/E0ZUpA7m85ukkMUZ/3tME6qy0a1C9AHCq0ef1Md1YWhC/PT8Ma
        PiFgnIxRzplsyvfuyNLO9hGJT1Vfk8AOOO7P9UhWO0NOcnvRiYcvoB4LXbwSuEMDlemQhnu4eG1+Q
        UhknNGz8teoBlwGJANbHqOcMHdIJplqM4oYLddC8eG7jaBS3+a6fhKbxSJxEEoK23Rj8Jb/4PNBvg
        WkIwmEaEY481I9qRop6qUyRexR1p6rGg6Vr/6j4l0sqvUR8BYw2/obMuNpx2Mq/TjhCbCzUPOmVTx
        O9/b0r4Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJjiT-0008AP-3j; Mon, 05 Nov 2018 18:35:13 +0000
Subject: Re: [PATCH 1/2] firmware: add nowarn variant of
 request_firmware_nowait()
To:     Lucas Stach <l.stach@pengutronix.de>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        patchwork-lst@pengutronix.de, kernel@pengutronix.de
References: <20181105170232.28777-1-l.stach@pengutronix.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <60bfe247-12ca-5b1e-5b34-1f7b45ccb761@infradead.org>
Date:   Mon, 5 Nov 2018 10:35:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105170232.28777-1-l.stach@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

typo below:

On 11/5/18 9:02 AM, Lucas Stach wrote:
> Device drivers with optional firmware may still want to use the
> asynchronous firmware loading interface. To avoid printing a
> warning into the kernel log when the optional firmware is
> absent, add a nowarn variant of this interface.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/base/firmware_loader/main.c | 85 ++++++++++++++++++++---------
>  include/linux/firmware.h            | 12 ++++
>  2 files changed, 70 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 8e9213b36e31..81f4a5f6aa5b 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c


> +/**
> + * request_firmware_nowait_nowarn() - async version of request_firmware_nowarn
> + *
> + * Similar in fucntion to request_firmware_nowait(), but doesn't print a warning

                 function

> + * when the firmware file could not be found.
> + */
> +int
> +request_firmware_nowait_nowarn(
> +	struct module *module, bool uevent,
> +	const char *name, struct device *device, gfp_t gfp, void *context,
> +	void (*cont)(const struct firmware *fw, void *context))
> +{
> +	return _request_firmware_nowait(module, uevent, name, device, gfp,
> +					context, cont, true);
> +
> +}
> +EXPORT_SYMBOL(request_firmware_nowait_nowarn);
> +
>  #ifdef CONFIG_PM_SLEEP
>  static ASYNC_DOMAIN_EXCLUSIVE(fw_cache_domain);
>  



-- 
~Randy
