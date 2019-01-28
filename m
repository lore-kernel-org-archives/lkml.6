Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66110C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3423720870
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdkhnjE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfA1Lix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:38:53 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41233 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfA1Liw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:38:52 -0500
Received: by mail-vs1-f68.google.com with SMTP id t17so9516608vsc.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 03:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jrJ9A+4uQg9pZ/cAuQuFHXOTGj2SGlckdsMejCo/OQc=;
        b=gdkhnjE9DHl+fVWdKRpIt+vKSkYWiJCvU5dNEneCkShLu45M9Rs/Re22eaD30dmTeA
         E+n+XA13l1ou1nREQco3rjPfFeGNaMD+BDvP/LAK6Puh0fSJCZ2jNZfoT8L/LSBP60HG
         soTAibv+8NTdkMj3huc2mphPNnkjyQsSu4lHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jrJ9A+4uQg9pZ/cAuQuFHXOTGj2SGlckdsMejCo/OQc=;
        b=oIssXo5cXdowvtWMv3LGi1uXoWFR5LIQGjW2vxc947AfdzSTCdfhmPJPcB6WJ3lBt9
         an2LjM1MbLbTlbc80Nq3mtnUzbLIJ+2p1Q7I5OuWGlSxpM8pOxODBrv4uMepndHnlIqp
         v4zW7OQt1OHhSKIIvlAA7pKxYNCDcd+C8+AC82qwAsesLIhUZ/zO2G9H0mMsD7c1OA/p
         CE8cGZbDBP+2wH49XvTetyNoEnc4Yy0bJ9ppGJe6r3gipZYJUgaFC5MurAYcMnFeTGcv
         VIiLZNbTYmnjMYA6FM7Hn75MgY8VzXL3LDY3FzGECg2KLd8GLh4JI09/Q2Vk+1yGwFc7
         rSxA==
X-Gm-Message-State: AJcUukftyJx2p0PaAbvYryNiir9KOl+p6Gb/vafAuHeN7y7Et3W3qaO+
        aGHHl4JNPPdLeadG9FSIvEqJsaPF5mYYpJKiDdPWnQ==
X-Google-Smtp-Source: ALg8bN4pJA9PbOf9JJmCq8c/vLBhJnTqRuXXfqeRceYFiv8QHaOjx29cLDXBV1CoOfuNHkSlz8qRtT9PzaM24CrKGUo=
X-Received: by 2002:a67:74c2:: with SMTP id p185mr5082574vsc.34.1548675531900;
 Mon, 28 Jan 2019 03:38:51 -0800 (PST)
MIME-Version: 1.0
References: <20190114191724.29960-1-alamy.liu@gmail.com>
In-Reply-To: <20190114191724.29960-1-alamy.liu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Jan 2019 12:38:16 +0100
Message-ID: <CAPDyKFp1fAJK3_XWcwcC4oLAJWvXnt=MvHcZz4X2PMojWPDmWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: cqhci: replace NUM_SLOTS with cq_host->num_slots
To:     Alamy Liu <alamy.liu@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Adrian (the SDHCI maintainer)

On Mon, 14 Jan 2019 at 20:17, Alamy Liu <alamy.liu@gmail.com> wrote:
>
> Prevent to use fixed value (NUM_SLOTS) after it had been determined
> and saved in a variable (cq_host->num_slots).
>
> Signed-off-by: Alamy Liu <alamy.liu@gmail.com>
> ---
>  drivers/mmc/host/cqhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index 159270e947..26d63594b7 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -699,7 +699,7 @@ static void cqhci_error_irq(struct mmc_host *mmc, u32 status, int cmd_error,
>                  * The only way to guarantee forward progress is to mark at
>                  * least one task in error, so if none is indicated, pick one.
>                  */
> -               for (tag = 0; tag < NUM_SLOTS; tag++) {
> +               for (tag = 0; tag < cq_host->num_slots; tag++) {
>                         slot = &cq_host->slot[tag];
>                         if (!slot->mrq)
>                                 continue;
> --
> 2.17.1
>

Alamy, I realized that you haven't included Adrian when posted your
recent sdhci patches. Please re-post all of them so we can get
Adrian's input.

Kind regards
Uffe
