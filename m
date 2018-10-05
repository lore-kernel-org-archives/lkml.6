Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE21C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B3C2087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CouUZTEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B3C2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbeJEUxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:53:43 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40913 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbeJEUxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:53:43 -0400
Received: by mail-io1-f68.google.com with SMTP id w16-v6so10709403iom.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 06:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Na4gJXF9mMWnHRV7NpWOYDFyuxFeP31mxB7IHgorBnY=;
        b=CouUZTEj0hCH4wyE3G6mCylFn0gUx5ADUn1hAfTsDnIOep7v4ByFwxPqukTC3OJVoO
         jp3CXw+rpeAvg6EBjyxVZku8UhX6qynFrXbuwjwUjJ2zJ9yU4DTZ2dD2qVPqQt9KjA3u
         PYyRwvvKwKwNBOyszz+eNBfrMoU4W/QYD23xU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Na4gJXF9mMWnHRV7NpWOYDFyuxFeP31mxB7IHgorBnY=;
        b=cDgnApj14Aj6ch54ODiPXbWftd919pj30F7o/ZcNZn7DZEMeBmXfP4ZQpYSnccEFzJ
         bmHB2Ck6BOcRrZhhIyAn9Z2FKhjyZCjVvSi42j+dHzTTHn0OTV6K6Kexuv0AxDUpz1eg
         jmraA7NaJZRnYdQ2QAAbH1ThP6QarlKu3xIK2oltgCC4w5G3VFJgR8gV0UJtPu2EtXlB
         sO1/Z2/dFaDLMasbCTiJXWJiHSaB/Z0rsJfO5hm82uEMjUJrAtCXkd78Cztc3pKCghq7
         vxDys432VuIBU5MZL3TjLOdHpxtn/pSeIhZ3BxZSP2L9DmAkH13KBdKf76oq5zKjEuWH
         cI+A==
X-Gm-Message-State: ABuFfohAVEWnXKY3dCa4zByFGb+hCdjlOtRj3PymhvfrFDOyVSw+io0z
        IMyvNeD3ghwFtzrWEU0acBBK2j2eznIEUi9Uad8oZQ==
X-Google-Smtp-Source: ACcGV60TeUyzJ9b6TlE5mISeaZSsmvpKFSGlrxFvGGc7XfUM5KXCNvACZ/V6zj772JQkKFxDNc/5wz29b+/NcFqkYMw=
X-Received: by 2002:a6b:9cc8:: with SMTP id f191-v6mr8328005ioe.266.1538747692587;
 Fri, 05 Oct 2018 06:54:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Fri, 5 Oct 2018 06:54:12 -0700 (PDT)
In-Reply-To: <20181005095457.GA21116@embeddedor.com>
References: <20181005095457.GA21116@embeddedor.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 5 Oct 2018 15:54:12 +0200
Message-ID: <CAPDyKFprMFWxRbx-fpo9M4J_Q=z8kZNqMsna-FjR54cyBYE96A@mail.gmail.com>
Subject: Re: [PATCH] mmc: tifm_sd: Mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Alex Dubov <oakad@yahoo.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 October 2018 at 11:54, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Notice that in this particular case, I replaced the
> "deliberate fall-through" comment with a proper "fall through"
> at the bottom of the case, which is what GCC is expecting to find.
>
> Addresses-Coverity-ID: 1373887 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>


Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/tifm_sd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
> index a3d8380..b6644ce 100644
> --- a/drivers/mmc/host/tifm_sd.c
> +++ b/drivers/mmc/host/tifm_sd.c
> @@ -336,7 +336,8 @@ static unsigned int tifm_sd_op_flags(struct mmc_command *cmd)
>                 rc |= TIFM_MMCSD_RSP_R0;
>                 break;
>         case MMC_RSP_R1B:
> -               rc |= TIFM_MMCSD_RSP_BUSY; // deliberate fall-through
> +               rc |= TIFM_MMCSD_RSP_BUSY;
> +               /* fall-through */
>         case MMC_RSP_R1:
>                 rc |= TIFM_MMCSD_RSP_R1;
>                 break;
> --
> 2.7.4
>
