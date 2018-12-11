Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419F2C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0234B20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PTw5svSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0234B20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeLKJh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:37:27 -0500
Received: from mail-ua1-f49.google.com ([209.85.222.49]:39790 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeLKJh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:37:27 -0500
Received: by mail-ua1-f49.google.com with SMTP id k10so4886265ual.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vbHq3ZU5O0zSsOk9+qs5YV5fDY0hFbDQVm66zCxAcso=;
        b=PTw5svSck91ci6DP129BaEaQlfaNaeOrjEymxWqVlJKyTOSOnT/hBELe2cXJrZ4yAW
         Z3Fx9DCoQyMVvPFEs/bmKKFYDQ3qmfwtS/424U2T1VhBhJigXM/U914CpuIcz6z9TQSj
         jlYy8n8PU9bNCa7xbdtFO+ZDVfAECx1U6j4S4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vbHq3ZU5O0zSsOk9+qs5YV5fDY0hFbDQVm66zCxAcso=;
        b=FXOqqI6w90iimlie6gXn2nauCWgfEs+mMycr4Zb6ubw1jV+5HUX2tJsaJO/1RJ05Cb
         RFRrLS+jQJrvy/Ksv54QEvygg7Lw2QV9NeErqNz9b9sYEgIpq3oyoD4IGiXratQ7d95r
         hAu2cd8V018ksLZ2t/xYk7VPxfwPPO2ML6WUR33vPYa4E/7H9e6FYPidF4de1NoSVYK3
         eXhUucsNocebf4fEbXwKvBYb+rEs/eI1TWOcPePzoYYYcAiJeFbGWJyQQhebCY0Oz/bE
         xZW3xDZZAk4AYaV2In9FhenflXb2Dt4Pj8Obir9FOYGgFhmRqDpWna8tSIl5wJu7yBOp
         qisA==
X-Gm-Message-State: AA+aEWZoS3POaVOm7XTsomnPxdhuwdoylkBUDmjWbEhumHzmoG4jQpnS
        KzI0FsrqWalWUGMzQCQ3Oo3II5F9n7zvbZ8kJWfbRQ==
X-Google-Smtp-Source: AFSGD/Xrav3ghc98z4WCCPia3HdIK/YMAranr3CAvYq4zN0nVPCSSZ1slDB/ykdDy8ZoB1UKcM4gQRAQM2WYrn1L9+w=
X-Received: by 2002:a9f:2476:: with SMTP id 109mr6551953uaq.77.1544521046252;
 Tue, 11 Dec 2018 01:37:26 -0800 (PST)
MIME-Version: 1.0
References: <20181206091936.11871-1-colin.king@canonical.com>
In-Reply-To: <20181206091936.11871-1-colin.king@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Dec 2018 10:36:50 +0100
Message-ID: <CAPDyKFrNYYvYYBaA_S+=RYkp5QfEHA3-Vy7GS4nCZ9_ic87tFQ@mail.gmail.com>
Subject: Re: [PATCH][misc-next] misc: cardreader: fix spelling mistake
 "invailid" -> "invalid"
To:     Colin King <colin.king@canonical.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 at 10:19, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are spelling mistakes in a couple of dev_dbg messages, fix these.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied for next (in my mmc tree), thanks!

Kind regards
Uffe

> ---
>  drivers/misc/cardreader/alcor_pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
> index 6872b8e29b4d..bcb10fa4bc3a 100644
> --- a/drivers/misc/cardreader/alcor_pci.c
> +++ b/drivers/misc/cardreader/alcor_pci.c
> @@ -105,7 +105,7 @@ static int alcor_pci_find_cap_offset(struct alcor_pci_priv *priv,
>         while (1) {
>                 pci_read_config_dword(pci, where, &val32);
>                 if (val32 == 0xffffffff) {
> -                       dev_dbg(priv->dev, "find_cap_offset invailid value %x.\n",
> +                       dev_dbg(priv->dev, "find_cap_offset invalid value %x.\n",
>                                 val32);
>                         return 0;
>                 }
> @@ -116,7 +116,7 @@ static int alcor_pci_find_cap_offset(struct alcor_pci_priv *priv,
>                 }
>
>                 if ((val32 & 0xff00) == 0x00) {
> -                       dev_dbg(priv->dev, "pci_find_cap_offset invailid value %x.\n",
> +                       dev_dbg(priv->dev, "pci_find_cap_offset invalid value %x.\n",
>                                 val32);
>                         break;
>                 }
> --
> 2.19.1
>
