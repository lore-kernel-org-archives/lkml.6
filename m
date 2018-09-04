Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D115CC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7474F20652
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUVFqg5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7474F20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbeIDLVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:21:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41127 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbeIDLVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:21:30 -0400
Received: by mail-lf1-f65.google.com with SMTP id l26-v6so2049240lfc.8;
        Mon, 03 Sep 2018 23:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rKeAqxZZIaqOv5BDtqsqQlhfzCze68DUC4jWSbZBe5g=;
        b=TUVFqg5UrVdS/r2A6Yn4TUeCD7uwYXFTTXB8g4CYebpkmvfNKkGET3csjp1FxaLRQU
         2lFkO3gldY5GOOC+c0Aj5phAi39JB4EGvAjYcdpp4Zhmzrc8i0biIkmPh0TrwdUzMjpe
         YCCMdaKzyR0A5gQk2ECaKLYqpJ5EaspL08gIianGni0O9LP8VFmgaovugdEMKuu6mMtq
         vWOH9NCHtIC597aXdc1A5aYdVcnx5SojfiL0E5Fjqq1yfo639WO9YfhslkKYOx/juYEY
         S0zkH4vUrK+twvIgo1lZ8Y4s5WjRf2lCYiLSDGZxdCuvXBX5HxUJ/8P57RIOGZdXUYXT
         EVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rKeAqxZZIaqOv5BDtqsqQlhfzCze68DUC4jWSbZBe5g=;
        b=dmRvcC1sGAH2m38vuAuY+XdXM0shuvwBaTX3sUm+eIecM8374Knoc03q11nMIf3FgO
         qNiyfikpQxasrbPuCQkIZpWiM4amU5jxIcnhGMeewf6iV/bLWVJpLI4EIdo9RdQR8l93
         slGtrxiSjm+f0fgbpjtIyScAHPSk4447EbG9rtSIHZW2LLBJe7bJC6+ETcdSdcSwdKD8
         PmqRSVpway+8uO9gazegu4jRK7Egjg31AGXYJG0/H0IOovZg5rCpYhFgDH/jChXWxErh
         RioBIEX2z9zqN9NpJEXn5vA84IQCgIOoXN/+zeSFjghYHqkqlBA03a9z4qpP1Po0ELQ7
         USVA==
X-Gm-Message-State: APzg51AXUFB1wipow0qnvwZf5tZKTxskMK9yM1BxUE02YvFhc8yvneX8
        tmGp58cksZ7ZTMCX5R1ankYSP63a+2TTm9zDUco=
X-Google-Smtp-Source: ANB0VdZQh6Yf7tTbtWhstPd6QASlsOZY8sFuMsjiJ8Vs/HiPsXLchZqxqtpmNaLppKSkHAW0KHpJAFYyFU1KPcVVTF0=
X-Received: by 2002:a19:e017:: with SMTP id x23-v6mr13885341lfg.14.1536044264938;
 Mon, 03 Sep 2018 23:57:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:4c3c:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 23:57:04 -0700 (PDT)
In-Reply-To: <5952d0e2189677a247a8efabf356347e1e087187.1533950271.git.baolin.wang@linaro.org>
References: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
 <5952d0e2189677a247a8efabf356347e1e087187.1533950271.git.baolin.wang@linaro.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 4 Sep 2018 14:57:04 +0800
Message-ID: <CAAfSe-svdZ2RSSX8+USN-0gJGOPDQktgcvtyHku615_YDoo_3A@mail.gmail.com>
Subject: Re: [PATCH 5/5] serial: sprd: Fix the indentation issue
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
> Make the macros' definition and code have the same correct indentation.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>

> ---
>  drivers/tty/serial/sprd_serial.c | 46 +++++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 8d5c9cd..4287ca3 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -68,24 +68,24 @@
>  #define SPRD_LCR_DATA_LEN6     0x4
>  #define SPRD_LCR_DATA_LEN7     0x8
>  #define SPRD_LCR_DATA_LEN8     0xc
> -#define SPRD_LCR_PARITY        (BIT(0) | BIT(1))
> +#define SPRD_LCR_PARITY                (BIT(0) | BIT(1))
>  #define SPRD_LCR_PARITY_EN     0x2
>  #define SPRD_LCR_EVEN_PAR      0x0
>  #define SPRD_LCR_ODD_PAR       0x1
>
>  /* control register 1 */
> -#define SPRD_CTL1                      0x001C
> +#define SPRD_CTL1              0x001C
>  #define RX_HW_FLOW_CTL_THLD    BIT(6)
>  #define RX_HW_FLOW_CTL_EN      BIT(7)
>  #define TX_HW_FLOW_CTL_EN      BIT(8)
>  #define RX_TOUT_THLD_DEF       0x3E00
> -#define RX_HFC_THLD_DEF        0x40
> +#define RX_HFC_THLD_DEF                0x40
>
>  /* fifo threshold register */
>  #define SPRD_CTL2              0x0020
> -#define THLD_TX_EMPTY  0x40
> +#define THLD_TX_EMPTY          0x40
>  #define THLD_TX_EMPTY_SHIFT    8
> -#define THLD_RX_FULL   0x40
> +#define THLD_RX_FULL           0x40
>
>  /* config baud rate register */
>  #define SPRD_CLKD0             0x0024
> @@ -95,11 +95,11 @@
>  #define SPRD_CLKD1_SHIFT       16
>
>  /* interrupt mask status register */
> -#define SPRD_IMSR                      0x002C
> -#define SPRD_IMSR_RX_FIFO_FULL         BIT(0)
> +#define SPRD_IMSR              0x002C
> +#define SPRD_IMSR_RX_FIFO_FULL BIT(0)
>  #define SPRD_IMSR_TX_FIFO_EMPTY        BIT(1)
> -#define SPRD_IMSR_BREAK_DETECT         BIT(7)
> -#define SPRD_IMSR_TIMEOUT              BIT(13)
> +#define SPRD_IMSR_BREAK_DETECT BIT(7)
> +#define SPRD_IMSR_TIMEOUT      BIT(13)
>
>  struct sprd_uart_port {
>         struct uart_port port;
> @@ -229,7 +229,7 @@ static inline void sprd_rx(struct uart_port *port)
>                 port->icount.rx++;
>
>                 if (lsr & (SPRD_LSR_BI | SPRD_LSR_PE |
> -                       SPRD_LSR_FE | SPRD_LSR_OE))
> +                          SPRD_LSR_FE | SPRD_LSR_OE))
>                         if (handle_lsr_errors(port, &lsr, &flag))
>                                 continue;
>                 if (uart_handle_sysrq_char(port, ch))
> @@ -292,8 +292,8 @@ static irqreturn_t sprd_handle_irq(int irq, void *dev_id)
>         if (ims & SPRD_IMSR_TIMEOUT)
>                 serial_out(port, SPRD_ICLR, SPRD_ICLR_TIMEOUT);
>
> -       if (ims & (SPRD_IMSR_RX_FIFO_FULL |
> -               SPRD_IMSR_BREAK_DETECT | SPRD_IMSR_TIMEOUT))
> +       if (ims & (SPRD_IMSR_RX_FIFO_FULL | SPRD_IMSR_BREAK_DETECT |
> +                  SPRD_IMSR_TIMEOUT))
>                 sprd_rx(port);
>
>         if (ims & SPRD_IMSR_TX_FIFO_EMPTY)
> @@ -333,7 +333,7 @@ static int sprd_startup(struct uart_port *port)
>         sp = container_of(port, struct sprd_uart_port, port);
>         snprintf(sp->name, sizeof(sp->name), "sprd_serial%d", port->line);
>         ret = devm_request_irq(port->dev, port->irq, sprd_handle_irq,
> -                               IRQF_SHARED, sp->name, port);
> +                              IRQF_SHARED, sp->name, port);
>         if (ret) {
>                 dev_err(port->dev, "fail to request serial irq %d, ret=%d\n",
>                         port->irq, ret);
> @@ -361,8 +361,8 @@ static void sprd_shutdown(struct uart_port *port)
>  }
>
>  static void sprd_set_termios(struct uart_port *port,
> -                                   struct ktermios *termios,
> -                                   struct ktermios *old)
> +                            struct ktermios *termios,
> +                            struct ktermios *old)
>  {
>         unsigned int baud, quot;
>         unsigned int lcr = 0, fc;
> @@ -480,8 +480,7 @@ static void sprd_config_port(struct uart_port *port, int flags)
>                 port->type = PORT_SPRD;
>  }
>
> -static int sprd_verify_port(struct uart_port *port,
> -                                  struct serial_struct *ser)
> +static int sprd_verify_port(struct uart_port *port, struct serial_struct *ser)
>  {
>         if (ser->type != PORT_SPRD)
>                 return -EINVAL;
> @@ -531,7 +530,7 @@ static void sprd_console_putchar(struct uart_port *port, int ch)
>  }
>
>  static void sprd_console_write(struct console *co, const char *s,
> -                                     unsigned int count)
> +                              unsigned int count)
>  {
>         struct uart_port *port = &sprd_port[co->index]->port;
>         int locked = 1;
> @@ -594,7 +593,7 @@ static void sprd_putc(struct uart_port *port, int c)
>         unsigned int timeout = SPRD_TIMEOUT;
>
>         while (timeout-- &&
> -                  !(readl(port->membase + SPRD_LSR) & SPRD_LSR_TX_OVER))
> +              !(readl(port->membase + SPRD_LSR) & SPRD_LSR_TX_OVER))
>                 cpu_relax();
>
>         writeb(c, port->membase + SPRD_TXD);
> @@ -607,9 +606,8 @@ static void sprd_early_write(struct console *con, const char *s, unsigned int n)
>         uart_console_write(&dev->port, s, n, sprd_putc);
>  }
>
> -static int __init sprd_early_console_setup(
> -                               struct earlycon_device *device,
> -                               const char *opt)
> +static int __init sprd_early_console_setup(struct earlycon_device *device,
> +                                          const char *opt)
>  {
>         if (!device->port.membase)
>                 return -ENODEV;
> @@ -691,8 +689,8 @@ static int sprd_probe(struct platform_device *pdev)
>
>         index = sprd_probe_dt_alias(index, &pdev->dev);
>
> -       sprd_port[index] = devm_kzalloc(&pdev->dev,
> -               sizeof(*sprd_port[index]), GFP_KERNEL);
> +       sprd_port[index] = devm_kzalloc(&pdev->dev, sizeof(*sprd_port[index]),
> +                                       GFP_KERNEL);
>         if (!sprd_port[index])
>                 return -ENOMEM;
>
> --
> 1.9.1
>
