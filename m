Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jtfHNUELG1v1XQAAmS7hNA
	; Fri, 08 Jun 2018 23:34:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C85D9608BF; Fri,  8 Jun 2018 23:34:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WfaXmwup"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 359D660590;
	Fri,  8 Jun 2018 23:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 359D660590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbeFHXer (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 19:34:47 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33909 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752910AbeFHXep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 19:34:45 -0400
Received: by mail-pf0-f193.google.com with SMTP id a63-v6so7364062pfl.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 16:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GnMkUpu9zpvlxxu1+8A/sf9YnK/jD4v5jGAYkBfP9AQ=;
        b=WfaXmwuph7ytdTEDzw7i3GSOQcClKwPftKFFsW1ZIT16fjN4vOckzks2EX92HGGg8l
         RA6H3vfUUJgUI1pbC27KSKecFPQZJ0+kjjFXNTaH3Jgk7nNq3jklQW1UiwMIywFIfj0X
         d5/Ow/cbngLm+Lf7NKI0pvFILLZ/VH1CO0ujE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GnMkUpu9zpvlxxu1+8A/sf9YnK/jD4v5jGAYkBfP9AQ=;
        b=J1/tVjOrkrELmvdmJ80G+vogyisma4l0VD8njBRTKYPfWkvUw85kJrz2JTI8TA85kd
         DvGhX1ZHLqc9qgswqE21czmecCTQB+TdNRREGXQ/L4l8y0p/29Wr9yI+zMsvMnWcXumJ
         YQfsdLrC6MC0h3PxIv+pj3fZravttq92ZWI4eY8HYTkYw0efLl2s2tAI6HTnb959NI3c
         AC4Uz2fVM+JRrK2JXyKy3NACZv9A1h4xfBFQZ84D2LeWUtww0H7ZsJWgfgaRdCI9iC9D
         Q6Fl+0R306iLIIG8IhabUGCbii7EhSEak9SYl5wLm1r7IixE3bhgZAeTWhDkpi1SgQM8
         kZug==
X-Gm-Message-State: APt69E32LBtz+csCOhss7jWt4kkoTpOAWAduXinryN2i1AUJ7DL0dJiD
        SfJaq9Miqx7o6RceKzPtO968dg==
X-Google-Smtp-Source: ADUXVKIcrlfl1Z6OqNpYbttAbAMaGjqmX25Zw6J1UT8C6/cwJamt5v0dhqaRa7cFxbBXQT3/WNKK9A==
X-Received: by 2002:a62:a30e:: with SMTP id s14-v6mr8041389pfe.168.1528500884923;
        Fri, 08 Jun 2018 16:34:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id e68-v6sm51294585pfl.65.2018.06.08.16.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 16:34:44 -0700 (PDT)
Date: Fri, 8 Jun 2018 16:34:43 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Girish Mahadevan <girishm@codeaurora.org>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, sdharia@codeaurora.org,
        kramasub@codeaurora.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        amstan@chromium.org
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Message-ID: <20180608233443.GF88063@google.com>
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 03:34:43PM -0600, Girish Mahadevan wrote:
> This driver supports GENI based SPI Controller in the Qualcomm SOCs. The
> Qualcomm Generic Interface (GENI) is a programmable module supporting a
> wide range of serial interfaces including SPI. This driver supports SPI
> operations using FIFO mode of transfer.
> 
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> ---
>  drivers/spi/Kconfig               |  12 +
>  drivers/spi/Makefile              |   1 +
>  drivers/spi/spi-geni-qcom.c       | 766 ++++++++++++++++++++++++++++++++++++++
>  include/linux/spi/spi-geni-qcom.h |  14 +
>  4 files changed, 793 insertions(+)
>  create mode 100644 drivers/spi/spi-geni-qcom.c
>  create mode 100644 include/linux/spi/spi-geni-qcom.h
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> new file mode 100644
> index 0000000..eecc634
> --- /dev/null
> +++ b/drivers/spi/spi-geni-qcom.c
>
> ...
>
> +static irqreturn_t geni_spi_isr(int irq, void *dev)
> +{
> +	struct spi_geni_master *mas = dev;
> +	struct geni_se *se = &mas->se;
> +	u32 m_irq = 0;
> +	irqreturn_t ret = IRQ_HANDLED;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&mas->lock, flags);
> +	if (pm_runtime_status_suspended(dev)) {

kasan is unhappy about geni_spi_isr:

[    3.206593] BUG: KASAN: slab-out-of-bounds in geni_spi_isr+0x978/0xbf4
[    3.213310] Read of size 4 at addr ffffffc0da803b04 by task swapper/0/1
[    3.221664] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.47 #20
[    3.227936] Hardware name: Google Cheza (DT)
[    3.232341] Call trace:
[    3.234884] [<ffffff90080925a4>] dump_backtrace+0x0/0x6d0
[    3.240441] [<ffffff9008092cc8>] show_stack+0x20/0x2c
[    3.245649] [<ffffff90094b53f8>] __dump_stack+0x20/0x28
[    3.251034] [<ffffff90094b53b0>] dump_stack+0xcc/0xf4
[    3.256240] [<ffffff90083cfb58>] print_address_description+0x70/0x238
[    3.262868] [<ffffff90083d00ec>] kasan_report+0x1cc/0x260
[    3.268425] [<ffffff90083d021c>] __asan_report_load4_noabort+0x2c/0x38
[    3.275142] [<ffffff9008ca820c>] geni_spi_isr+0x978/0xbf4
...
[    3.662568] Allocated by task 1:
[    3.665908]  kasan_kmalloc+0xb4/0x174
[    3.669693]  __kmalloc+0x260/0x2f4
[    3.673201]  __spi_alloc_controller+0x38/0x180
[    3.677781]  spi_geni_probe+0x38/0x574
[    3.681647]  platform_drv_probe+0xac/0x134
[    3.685865]  driver_probe_device+0x470/0x4f4
[    3.690268]  __driver_attach+0xe8/0x128
[    3.694228]  bus_for_each_dev+0x104/0x16c
[    3.698356]  driver_attach+0x48/0x54
[    3.702052]  bus_add_driver+0x258/0x3d0
[    3.706010]  driver_register+0x1ac/0x230
[    3.710056]  __platform_driver_register+0xcc/0xdc
[    3.714906]  spi_geni_driver_init+0x1c/0x24
[    3.719220]  do_one_initcall+0x22c/0x3c4
[    3.723266]  kernel_init_freeable+0x31c/0x40c
[    3.727753]  kernel_init+0x14/0x10c
[    3.731349]  ret_from_fork+0x10/0x18

Reason is that 'dev' is passed to pm_runtime_status_suspended(), when
it should be 'mas->dev'.

As this bug indicates kernel developers have strong expectations what
a variable called 'dev' represents, I suggest to change it to
something like 'data'.

Thanks

Matthias
