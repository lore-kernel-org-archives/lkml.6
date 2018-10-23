Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEDBC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468972075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PaJON69B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468972075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbeJWVZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 17:25:48 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:50779 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbeJWVZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 17:25:47 -0400
Received: by mail-it1-f193.google.com with SMTP id k206-v6so1787689ite.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 06:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NPIUALSoQMb4v7EO9qELFWSAsHu6NJEZ3OBI9YB6DNw=;
        b=PaJON69BEY/JcNzPagaujT1/j9cStc3mCjB5t4x1X9JwPP2j5M/XNWI5F7V+M1wLZk
         /mt665Cz4XCj54aaha9vA9UHLvlZ8IM5+jtgIQJnTlHPOvdJwcUZ/S4IdmSB8fVWqPgV
         v7gytL5fTelcAUu1ehRbRnOm52vrzky3I1wjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NPIUALSoQMb4v7EO9qELFWSAsHu6NJEZ3OBI9YB6DNw=;
        b=Rc5OYxNCl87IKjHWZDwumZ6Jxn6WiwHRoAqTjVLAVjkN6RT+BacucHV6WsXiqR/4xh
         GtBTokgIq+OmxAXozfwlOVGAKmKt+7d2kkabp0OmWO6QCsRm+8gTsBgtaXJzBzLIysbx
         vcmGvTToxbG/W6qeFjn1r6V2IhQpslS6vkMrAwJU0YcnsKldN2SMetqQLg71J06lqtWM
         qrmstrHILbHl+B65QJ1HIdFhOkPcTpQoRArjaJViJUSF9AuOYZXUuTJxGe/j2Opaerob
         jd1e8h28Cx9eb56YVgZP7eib/m4Q4jnlvNTwyE13acFiKKDAU5AqXeqYTfX4aF9i/DV6
         c7Ww==
X-Gm-Message-State: ABuFfojAHXi/J9k6XNBjK2rDP4TMixDdWndXNGhaqBZyOFyCGwINfrVU
        ZluUTHHmtgGfpJ1Ztv5foUl1Jpp7JBJmdam0w+sOwg==
X-Google-Smtp-Source: ACcGV63zrH6EuBYA8bjdN44pMuNbXhrjHY8fdpGf9ArO1zQ+fTQupxAtdmYyZXjfWIRjFk5P2u37R5zO5RBfHFjavVk=
X-Received: by 2002:a02:2b29:: with SMTP id h41-v6mr12418234jaa.12.1540299743554;
 Tue, 23 Oct 2018 06:02:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Tue, 23 Oct 2018 06:01:43
 -0700 (PDT)
In-Reply-To: <1539677982-13762-1-git-send-email-zhang.chunyan@linaro.org>
References: <1539677982-13762-1-git-send-email-zhang.chunyan@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Oct 2018 15:01:43 +0200
Message-ID: <CAPDyKFrfwJeupJ50smx8Qu5Zpk74ATcQXGVqu5sAsFY2ou3VFw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: use goto rather than return directly
To:     Chunyan Zhang <zhang.chunyan@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 October 2018 at 10:19, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
> The driver should clean resources requested in the function before
> unnormal return.
>
> CC: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> Fixes: bd9b902798ab ("mmc: sdhci: Implement an SDHCI-specific bounce buffer")
> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1b3fbd9..f6b57e1 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3991,7 +3991,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>                 /* This may alter mmc->*_blk_* parameters */
>                 ret = sdhci_allocate_bounce_buffer(host);
>                 if (ret)
> -                       return ret;
> +                       goto unreg;

Instead of making the error path a bit more complicated, I suggest to
convert sdhci_allocate_bounce_buffer() from returning an int to a
void. Simply because it always returns 0 and thus we can remove this
error path altogether.

>         }
>
>         return 0;
> --
> 2.7.4
>

Kind regards
Uffe
