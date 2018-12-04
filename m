Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E202EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19F920851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S0yHUTLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19F920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbeLDOU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:20:27 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44570 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbeLDOU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:20:26 -0500
Received: by mail-ua1-f66.google.com with SMTP id d19so5807929uaq.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 06:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HAOz37Zy1sG6FReaAnpmdWLSFulPqs4JVrBMAsBYt6M=;
        b=S0yHUTLL6A6lSCr/Z9RFKauRN++8MedauuZBnkgI5e7+vfqcToToj75M3HMpH28gFf
         RV1hHCDYpNbwu9oIe96x03Ihws+NI1ermJ9HdJuLhnGY9XJZ8qm6OgUA+zz3Oh6Up+Km
         YeMwgHc8/2e2uELSwaSYt1+vzF1TpWOiIpFCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HAOz37Zy1sG6FReaAnpmdWLSFulPqs4JVrBMAsBYt6M=;
        b=Ba0hS30rHzaMKeUbkiqmInhB0A1xAF0vnQMwklxky0UscxJBCLQnVUvsddpuR4A+5n
         NWbdA6ub+6rDkWoTaTUxHk6J9y8GsWd4PZ+RSb+kGXK02zWWYCtKopoqplw5IIZoiOqJ
         +AqaptDs0UC4uYajHUF5u3hLgmMxIFUMG3qYOO/aBREZFqfKQZy0YKsx0U/vf/BIaQxZ
         muy+YiIWrkMCS8BwhxaEEW/mmmNY2PJ9yAjbySFhayvKz5iBF8BrTiKuUkMmHO3j8pda
         tGyiLes9BQzD8J2NFkw1F1cav4u+gMrkbI1ZTPydqUqECcG+gcUqPwKyuO+jxfr//xHF
         Jw4A==
X-Gm-Message-State: AA+aEWbf1fLvOQFoWO8KPPJQo4nOMNTPtJVTu9CctVBhb0KHzH1xGFag
        LG7db4Dp0MAcQ3AuTWT3DVbJ+fCz+B7hwUl0aMSdGg==
X-Google-Smtp-Source: AFSGD/WM6Wqo6jSZtrJrEXppwsH70Sh5wkg7YNUR6lbJ6PicUDNWEDdl+j4GqVlUQ0Tsaa73qxBCkmARHlxBanou1Nc=
X-Received: by 2002:ab0:31d5:: with SMTP id e21mr9490411uan.107.1543933224364;
 Tue, 04 Dec 2018 06:20:24 -0800 (PST)
MIME-Version: 1.0
References: <c0e11e0a23fbb6b9867963c4b143fcb1c60b403c.1542744186.git.lsun@mellanox.com>
In-Reply-To: <c0e11e0a23fbb6b9867963c4b143fcb1c60b403c.1542744186.git.lsun@mellanox.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Dec 2018 15:19:48 +0100
Message-ID: <CAPDyKFrrxQOz89kW9rXNRFoeVmw7r0=94Yo4-Dq9W8VEdRtLvg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: core: control EXT_CSD_CACHE_CTRL from device tree
To:     Liming Sun <lsun@mellanox.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        David Woods <dwoods@mellanox.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018 at 21:06, Liming Sun <lsun@mellanox.com> wrote:
>
> Currently the EXT_CSD_CACHE_CTRL register is controlled by API
> mmc_card_broken_hpi(), which only works for the quirks settings.
> This commit enhances it to use card->ext_csd.hpi instead. This
> flag works for both the quirks and the broken-hpi configuration
> in the device tree.
>
> Signed-off-by: Liming Sun <lsun@mellanox.com>

I realize that the code around the HPI support needs some additional
love. Let me post some patches in a day or two, then you can have a
look a let me know your thoughts.

> ---
>  drivers/mmc/core/mmc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index bc1bd2c..2f2b65c 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1791,8 +1791,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>          * If cache size is higher than 0, this indicates
>          * the existence of cache and it can be turned on.
>          */
> -       if (!mmc_card_broken_hpi(card) &&
> -           card->ext_csd.cache_size > 0) {
> +       if (card->ext_csd.hpi && card->ext_csd.cache_size > 0) {

Actually, I don't see a reason to why we should limit to use the
cache, to whether HPI is supported or not.

I guess the thinking behind this, was that we wanted an option to
abort the cache flush as there is no timeout available for that
operation. However, I don't see whenever we should allow a cache flush
to be aborted, as it would introduce a potential option of getting
corrupt data on the flash.

>                 err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                                 EXT_CSD_CACHE_CTRL, 1,
>                                 card->ext_csd.generic_cmd6_time);
> --
> 1.8.3.1
>

Kind regards
Uffe
