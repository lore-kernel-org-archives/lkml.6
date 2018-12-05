Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8ADC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF0D2081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGYmAkKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF0D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeLEOU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:20:57 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37449 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeLEOU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:20:56 -0500
Received: by mail-vk1-f196.google.com with SMTP id 197so4678507vkf.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 06:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6D362eDda6foS8CcwHb3MK1gNW0Ywp7obeQefyX2JGM=;
        b=kGYmAkKlWQEXoFzfkSylSFouZUt0eD3Nyg+1sTBmEdrNQqU7Bwvi9OijDSXBXALFNv
         vWGI6jVlSNddSDSn0tNB7dftqOKs9L7pGzdoxdqFHmo6qehsHZOFWW9NY0QipQVPOgk4
         tlq1/hUdyAweOoyEIqVfCq9FxB0soAiAFvd8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6D362eDda6foS8CcwHb3MK1gNW0Ywp7obeQefyX2JGM=;
        b=BXra+KG/LqHHnWaESBDzPXlwNQ67AjwxLX6lSDni5P7Wwvx+4J291YL9b9KcrIIKZV
         PSbDcJx4GmQv0/nt2HhDmTs6J8KYiPuRmC2gi6js2ZvWbxScrUBQXWzZ736690qj9bpS
         cmq16YZ9+4WXq+coNHCRp80GVCQKKoLP46kPBIdZGdeL/eJ8gUsMCVLPGIGct1jPuZhl
         YxfERdF3wh34GXUGWc684T7dMBDh9GqZZ2kx9OsxolB3yuJ+AMcRY1WHe/9gxJ4lYG5Y
         GKtFGb5ZyhGDWOImTtBh44xLdZEeZ7w4QN0wCf6b6GtXtS9j4mKePeghhr2BgWaXSsma
         88pA==
X-Gm-Message-State: AA+aEWYnSgfOG83yOO3os65+t137hN+d5+nqPHvtV0yJ6DEhmOiBMTvg
        vZ1s8JTq9SAtzN7s8i9Gg2ERwjTIglnHFcqiitX85w==
X-Google-Smtp-Source: AFSGD/XMLdkCw+pFPVOQg4uzwD9Z+G86VkaE49HjCxDyD219JPrCZT1kB7/RMcNR9cq649TzdOJxEV/TSgzpZH+eiHU=
X-Received: by 2002:a1f:4982:: with SMTP id w124mr10608753vka.4.1544019655082;
 Wed, 05 Dec 2018 06:20:55 -0800 (PST)
MIME-Version: 1.0
References: <20181130150028.732896d8@xdu1-mobl> <81ba3745-8277-d16e-3aad-48324f51dc8a@intel.com>
 <20181130221300.4ef2956c@xdu1-mobl> <c580be57-8a49-59f3-791e-c605d892266b@intel.com>
 <20181201134251.26573207@xdu1-mobl> <20181204090120.63b5f0a4@xdu1-mobl>
 <229dc468-1155-b81f-9fda-b71402387e3f@intel.com> <20181205111450.300e0478@xdu1-mobl>
In-Reply-To: <20181205111450.300e0478@xdu1-mobl>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Dec 2018 15:20:19 +0100
Message-ID: <CAPDyKFot12Fc83R5wNsHYSu1-5mopNauYusu0RTQ9bjcUere5w@mail.gmail.com>
Subject: Re: [PATCH V3] sdhci: fix the timeout check window for clock and reset
To:     alek.du@intel.com
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018 at 04:14, Du, Alek <alek.du@intel.com> wrote:
>
> From bcb38577961823b4f8f2cc0aec7dd450a81b6ddc Mon Sep 17 00:00:00 2001
> From: Alek Du <alek.du@intel.com>
> Date: Fri, 30 Nov 2018 14:02:28 +0800
> Subject: [PATCH] sdhci: fix the timeout check window for clock and reset

Please change the prefix to: "mmc: sdhci".

>
> We observed some premature timeouts on a virtualization platform, the log
> is like this:
>
> case 1:
> [159525.255629] mmc1: Internal clock never stabilised.
> [159525.255818] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> [159525.256049] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
> ...
> [159525.257205] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa03
> From the clock control register dump, we are pretty sure the clock was
> stablized.
>
> case 2:
> [  914.550127] mmc1: Reset 0x2 never completed.
> [  914.550321] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> [  914.550608] mmc1: sdhci: Sys addr:  0x00000010 | Version:  0x00001002
>
> After checking the sdhci code, we found the timeout check actually has a
> little window that the CPU can be scheduled out and when it comes back,
> the original time set or check is not valid.
>
> Fixes: 5a436cc0af62 ("mmc: sdhci: Optimize delay loops")
> Signed-off-by: Alek Du <alek.du@intel.com>
> Cc: stable@vger.kernel.org      # v4.12+

I intended to queue this up as fix, but couldn't apply it. Can you
please re-base this on top of v4.20-rc5 or later?

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 99bdae53fa2e..451b08a818a9 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -216,8 +216,12 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
>         timeout = ktime_add_ms(ktime_get(), 100);
>
>         /* hw clears the bit when it's done */
> -       while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
> -               if (ktime_after(ktime_get(), timeout)) {
> +       while (1) {
> +               bool timedout = ktime_after(ktime_get(), timeout);
> +
> +               if (!(sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask))
> +                       break;
> +               if (timedout) {
>                         pr_err("%s: Reset 0x%x never completed.\n",
>                                 mmc_hostname(host->mmc), (int)mask);
>                         sdhci_dumpregs(host);
> @@ -1608,9 +1612,13 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
>
>         /* Wait max 20 ms */
>         timeout = ktime_add_ms(ktime_get(), 20);
> -       while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> -               & SDHCI_CLOCK_INT_STABLE)) {
> -               if (ktime_after(ktime_get(), timeout)) {
> +       while (1) {
> +               bool timedout = ktime_after(ktime_get(), timeout);
> +
> +               clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +               if (clk & SDHCI_CLOCK_INT_STABLE)
> +                       break;
> +               if (timedout) {
>                         pr_err("%s: Internal clock never stabilised.\n",
>                                mmc_hostname(host->mmc));
>                         sdhci_dumpregs(host);
> --
> 2.17.1
