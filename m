Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817E9C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E23C2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SG73Ziw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E23C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbeIDLUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:20:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45973 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeIDLUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:20:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id u83-v6so2158816lje.12;
        Mon, 03 Sep 2018 23:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tddmK5W1j5mT1TV0jUB4z+lTf81cEpiHD7TnNuQAKrY=;
        b=SG73Ziw+AxjYVM0gQ0DcsrYgtqGOmplP1nBZiKUJVwXIHr962pbumYeDX0lPNCK28g
         0TPs72uMJVIHEhlnpnoPhGhCS5HnnBYR4wfImlvVakxQa0G39U7L22ZeaVFpBBlcXlkA
         ZmAEnUh28YZBYIF/uiXn3N+bDzC3maFR9u9iBixfEIdsKPZ9Ml4IKS+n6czSqH5pGPuM
         1Io2iNqx7sFPMutA0Z8sXE5VpR+5zkDQa06QT3i9NQDXivMCj1fUpt3mHPYtstcnftCe
         LpCAIHWh7J4YijnQOOuzLyayhOlpGlyIg51mnc0tRQOCks6uYeodE/gmTtoUMxWN9t1F
         NZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tddmK5W1j5mT1TV0jUB4z+lTf81cEpiHD7TnNuQAKrY=;
        b=JAqqpUJntpx9Rb1GeaaAYOyYZ3US9HWG1p/R57QRCyi1ZJqmmrTsywRxHk/LB58Z45
         f1X7A+LxcNC1rHtEoewO18WNmY3VkEO83TGbEi/SXyfxz/XRGdKBVk61OZ5sofaDdGuk
         obhxOg58NG0gZfYxv9ZZ27L6l9YE8qAOU0w8VohDPgDkpoPw/CY0lhiWPH8YYvviqAUN
         fgYiIaB0bxEZnkHjya8nFkcRUIXL3UA+zYnQnT0xmw5wBs4VWSTfcyHVA9l7ru9hAfJM
         iAU0y/Pqnjx+OD8knyjEqt1ceNW54yBB4j1InHGXHmEnnph8JuP9ajkyervgkFM2zP8+
         9xEQ==
X-Gm-Message-State: APzg51DGs4boL8s+CCMyw/peyShpbXpXMQOLtyIBiHK7ilVCr4WembEc
        1OT+XTedo6N3Pec9ReKa3zRZtdRBicLNpa+vv6V7jjfo
X-Google-Smtp-Source: ANB0Vdb2VB8eXQw944pDDS5DdmJkd+234Fgl/ZhK03AU8WVT2/9t6+ZXqwSk5HcZYAgh1Px4Egcrgp5YjVDdMbb8JYo=
X-Received: by 2002:a2e:9e55:: with SMTP id g21-v6mr6729261ljk.116.1536044179313;
 Mon, 03 Sep 2018 23:56:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:4c3c:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 23:55:39 -0700 (PDT)
In-Reply-To: <59172367ea674d5d4a3bd7c4d52362445174536e.1533950271.git.baolin.wang@linaro.org>
References: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
 <59172367ea674d5d4a3bd7c4d52362445174536e.1533950271.git.baolin.wang@linaro.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 4 Sep 2018 14:55:39 +0800
Message-ID: <CAAfSe-uuYbF+4cxvJNxsazDVhF4LKFLBCzWzkp6GKjCmyKc80A@mail.gmail.com>
Subject: Re: [PATCH 4/5] serial: sprd: Change 'int' to 'unsigned int'
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 August 2018 at 09:34, Baolin Wang <baolin.wang@linaro.org> wrote:
> The register offset value should be 'unsigned int' type.
>
> Moreover, prefer 'unsigned int' to bare use of 'unsigned'.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>

> ---
>  drivers/tty/serial/sprd_serial.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 03b0cd4..8d5c9cd 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -109,12 +109,14 @@ struct sprd_uart_port {
>  static struct sprd_uart_port *sprd_port[UART_NR_MAX];
>  static int sprd_ports_num;
>
> -static inline unsigned int serial_in(struct uart_port *port, int offset)
> +static inline unsigned int serial_in(struct uart_port *port,
> +                                    unsigned int offset)
>  {
>         return readl_relaxed(port->membase + offset);
>  }
>
> -static inline void serial_out(struct uart_port *port, int offset, int value)
> +static inline void serial_out(struct uart_port *port, unsigned int offset,
> +                             int value)
>  {
>         writel_relaxed(value, port->membase + offset);
>  }
> @@ -598,8 +600,7 @@ static void sprd_putc(struct uart_port *port, int c)
>         writeb(c, port->membase + SPRD_TXD);
>  }
>
> -static void sprd_early_write(struct console *con, const char *s,
> -                                   unsigned n)
> +static void sprd_early_write(struct console *con, const char *s, unsigned int n)
>  {
>         struct earlycon_device *dev = con->data;
>
> --
> 1.9.1
>
