Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsgVEkzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B61A6037B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932167AbeFFG2f (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:28:35 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:39328 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932097AbeFFG2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:28:33 -0400
X-Google-Smtp-Source: ADUXVKIT+fECegZOosT4RnG2ucwoVIvZmyitFQMFBA1bEFgEVNyML+joc8U3IEMxHZzHkWV6pGL62GuK2WuAWcSGf1k=
MIME-Version: 1.0
In-Reply-To: <20180605231013.1803-4-marek.vasut+renesas@gmail.com>
References: <20180605231013.1803-1-marek.vasut+renesas@gmail.com> <20180605231013.1803-4-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Jun 2018 08:28:32 +0200
X-Google-Sender-Auth: tc94Vrmp48Hz-0hdKZv9sp5CwCs
Message-ID: <CAMuHMdVTNv8WufhX4E-aae2G5EOMhQcCjtzsQB+c-c8-MQ8dNQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/12] mfd: da9063: Replace DA9063_NUM_IRQ with ARRAY_SIZE
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Wed, Jun 6, 2018 at 1:10 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Replace DA9063_NUM_IRQ macro which is not used anywhere with
> plain ARRAY_SIZE().

Thanks for your patch!

> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

With the issue below fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/include/linux/mfd/da9063/core.h
> +++ b/include/linux/mfd/da9063/core.h
> @@ -73,7 +73,6 @@ enum da9063_irqs {
>  };
>
>  #define DA9063_IRQ_BASE_OFFSET 0

DA9063_IRQ_BASE_OFFSET is now unused, so please remove it
(before someone starts using it, and makes it non-zero ;-)

> -#define DA9063_NUM_IRQ         (DA9063_IRQ_GPI15 + 1 - DA9063_IRQ_BASE_OFFSET)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
