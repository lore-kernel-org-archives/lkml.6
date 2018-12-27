Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3E7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C5A2148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NBBcG4bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbeL0VA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:00:27 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38452 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730104AbeL0VA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 16:00:26 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so9204065pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 13:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jlMOSTAQF7sg7dUm0vX5Uc3p3AImalzdvneGP4S4Zug=;
        b=NBBcG4bsRLAFeDj23oFgLCuUtNQX0uR8cDEx1OJhK2dZDzflTSA5Kz+J8wU3nQAAuI
         VUWTXcGNztQmj8PrI8ocf22Yutr33CvXhru1689HZc74iBosCzsBIMKOLSCTtkCz+1jl
         LDgVVL0tUd9gT/cnjq3YodPXe8RR69OZK5hq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jlMOSTAQF7sg7dUm0vX5Uc3p3AImalzdvneGP4S4Zug=;
        b=nB5fy9cHZUtK0UmBgQzt+gL5hFq334/1ViRsBDRlRDG38KMhMUUf2yKpApsqOcBWMM
         JRKy4TUJKBJ0NsoFBQ4pWPKLWDfHh6p2Y5VXfE4O41Irgdsl/oJMN8rpYePZpjaAbqcy
         JXXLojL0XqAn7kNWc/EAnRkk0HrWAW8omLED2EErxR7XzV/hvoSZAMj4rGmLZ5Fxs5/d
         DbOTdd25oRTsJ+Ziy3MyGpS8PtSJ7u3jw+ZdKhK0W0bqJjvJKZ764peNuRs7TIMmiqsN
         vEmdeX8Z30O4U7pcfpMfKQ1SlHgdylOGF0k16eIHEpVI3cXphWcsCar1Y9Sx0UwfzCXn
         47ew==
X-Gm-Message-State: AA+aEWY+WTh7dKGuxNxAneHiF4stdu7j+qat24YrHMalILyLg3t2TPfc
        lcto9awaPmEW9mm7dPN1aJBcbA==
X-Google-Smtp-Source: AFSGD/Vre/vkO3+WhnxM/vhkxWJJlXyuv6LqDeccp9BTeKvLebPxMj2guY+GAWiu8uV02jz9GjyBag==
X-Received: by 2002:a62:ea09:: with SMTP id t9mr26733373pfh.228.1545944424432;
        Thu, 27 Dec 2018 13:00:24 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id c67sm48700506pfg.170.2018.12.27.13.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 13:00:23 -0800 (PST)
Date:   Thu, 27 Dec 2018 13:00:23 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 5/6] Bluetooth: hci_qca: Update baudrate change wait
 time for wcn3990
Message-ID: <20181227210023.GL261387@google.com>
References: <20181227073136.8431-1-bgodavar@codeaurora.org>
 <20181227073136.8431-6-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181227073136.8431-6-bgodavar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 01:01:35PM +0530, Balakrishna Godavarthi wrote:
> This patch will update the baudrate change request wait time from
> 300 ms to 100 ms. When host sends the change baudrate request to
> the controller, controller sets its clock and wait until the
> clocks settle down. Here the Wait time is required for both
> host and controller to be on sync.

Ultimately up to you, but I would advise against adding 'improvement'
changes to this series. The scope of the series is already fairly
vague ("Bug fixes for Qualcomm BT chip wcn3990"), with at least some
patches that could be sent individually, which would reduce churn when
respinning.

> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> 
> Changes in v6:
>  * intial patch.
> 
> ---
>  drivers/bluetooth/hci_qca.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 4677a6a2716a..61b0fb1ff32f 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -60,7 +60,8 @@
>  
>  #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
>  #define IBS_TX_IDLE_TIMEOUT_MS		2000
> -#define BAUDRATE_SETTLE_TIMEOUT_MS	300
> +#define ROME_BD_SETTLE_TIMEOUT_MS	300
> +#define WCN3990_BD_SETTLE_TIMEOUT_MS	100

My testing suggests that even the lower 100 ms delay isn't needed, if
different parts that require a delay are addressed more specifically,
instead of using a single long 'settle' delay
(https://lore.kernel.org/patchwork/patch/1026795/#1212816 has some
details).

My idea was to sent a patch after this series has landed to avoid
interfering with it.

Cheers

Matthias
