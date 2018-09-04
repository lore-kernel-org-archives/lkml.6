Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E552FC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E3620652
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4O/m2W5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E3620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeIDLSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:18:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33523 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeIDLSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:18:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id s12-v6so2209078ljj.0;
        Mon, 03 Sep 2018 23:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CEufybvFugj1Vsnk+LYbB/8oolitNzdCvhF1PRSEaEw=;
        b=R4O/m2W5n9LhzLVomNvCPadK1R1FwNS8MzbNGvwC8EnQAb5UDd5uBYdTkYigPpBj+9
         l6kRbni/17Ilnj+ZwP3Rz6VZoFNNSeQuM6+RoFxaJcV7B5fCgPyJaVwL6x8a1n10kfTJ
         QgAYslMuvsrQMNGYRJ5uUkXmuawbdD8idLgSqTLrs/vLkCOhZuWljBEr7OCf61SFVydg
         le8q9/zuTHAcCgPHhzfXlN8j73/61nShUGHH3IE97zTV8B/vVYPysh8/sWphozTh68+Y
         Kl+YX/GAXVjnpFzd41G18tQSCStWCOpXNY20JvMTWDblPjxDZH+NeOTyVuM9Y9lxl75i
         ERjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CEufybvFugj1Vsnk+LYbB/8oolitNzdCvhF1PRSEaEw=;
        b=QaNMKwfXHh38jfIDvP3F/90huh0CAfMpHUl/sTg/3T7UN6AqWvOFHVSW6E5hCOFOwN
         dpFHF5yNysYoU7vMh47H8X/jpsY2rehDF98ggTZcl9XVCgBBQWxdLB1IeLI0bV2aae2g
         BGR7xUo/Pqs1sd4p9BVOl+4JjHKjyWm3IkWTStB/gcKCslsqlzQ/sOwRprNy0u5ie9ep
         7vKlkq7gqiSeYiorLEh6p+uNjaup4kyWiSRGaugdbW0bUxem4cpRw/e1pga3rryUk1Q7
         RTvHb4e61M9ZKRGJsqvSjpY58TMcNxNKNmBgXqOhfCywixk+cC8OgK6vNJnBf7zwJPD+
         n4yQ==
X-Gm-Message-State: APzg51Ady2y/Elf77dMyMm12x1C0rzDc+wT/dcglCOwdvYUw46uvmdXH
        7vd5cnugnPMw5884LziXqNzpoweMHu9VcuP9Q7Q=
X-Google-Smtp-Source: ANB0VdbGs+yzZWuBcPQwLiNjdEBDkdJ3P1OzDlXV2zbqsTrR/HBB8gh304KeyFVeDBk8lOS0IzR4z0E486BzGaYQ6i4=
X-Received: by 2002:a2e:291c:: with SMTP id u28-v6mr19160562lje.70.1536044108831;
 Mon, 03 Sep 2018 23:55:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:4c3c:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 23:54:28 -0700 (PDT)
In-Reply-To: <7b3341ab8778d31bf564bdcbb04b8c6e09fa4d6d.1533950271.git.baolin.wang@linaro.org>
References: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
 <7b3341ab8778d31bf564bdcbb04b8c6e09fa4d6d.1533950271.git.baolin.wang@linaro.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 4 Sep 2018 14:54:28 +0800
Message-ID: <CAAfSe-tQAKN4+cd2uD=KFkt_PPNMdGwZM-3QHBE3x81c5GskMA@mail.gmail.com>
Subject: Re: [PATCH 2/5] serial: sprd: Use readable macros instead of magic number
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
> Define readable macros instead of magic number to make code more readable.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>

> ---
>  drivers/tty/serial/sprd_serial.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 1b0e3fb..e18d8af 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -45,6 +45,8 @@
>
>  /* data number in TX and RX fifo */
>  #define SPRD_STS1              0x000C
> +#define SPRD_RX_FIFO_CNT_MASK  GENMASK(7, 0)
> +#define SPRD_TX_FIFO_CNT_MASK  GENMASK(15, 8)
>
>  /* interrupt enable register and its BITs */
>  #define SPRD_IEN               0x0010
> @@ -82,11 +84,15 @@
>  /* fifo threshold register */
>  #define SPRD_CTL2              0x0020
>  #define THLD_TX_EMPTY  0x40
> +#define THLD_TX_EMPTY_SHIFT    8
>  #define THLD_RX_FULL   0x40
>
>  /* config baud rate register */
>  #define SPRD_CLKD0             0x0024
> +#define SPRD_CLKD0_MASK                GENMASK(15, 0)
>  #define SPRD_CLKD1             0x0028
> +#define SPRD_CLKD1_MASK                GENMASK(20, 16)
> +#define SPRD_CLKD1_SHIFT       16
>
>  /* interrupt mask status register */
>  #define SPRD_IMSR                      0x002C
> @@ -115,7 +121,7 @@ static inline void serial_out(struct uart_port *port, int offset, int value)
>
>  static unsigned int sprd_tx_empty(struct uart_port *port)
>  {
> -       if (serial_in(port, SPRD_STS1) & 0xff00)
> +       if (serial_in(port, SPRD_STS1) & SPRD_TX_FIFO_CNT_MASK)
>                 return 0;
>         else
>                 return TIOCSER_TEMT;
> @@ -213,7 +219,8 @@ static inline void sprd_rx(struct uart_port *port)
>         struct tty_port *tty = &port->state->port;
>         unsigned int ch, flag, lsr, max_count = SPRD_TIMEOUT;
>
> -       while ((serial_in(port, SPRD_STS1) & 0x00ff) && max_count--) {
> +       while ((serial_in(port, SPRD_STS1) & SPRD_RX_FIFO_CNT_MASK) &&
> +              max_count--) {
>                 lsr = serial_in(port, SPRD_LSR);
>                 ch = serial_in(port, SPRD_RXD);
>                 flag = TTY_NORMAL;
> @@ -303,16 +310,17 @@ static int sprd_startup(struct uart_port *port)
>         struct sprd_uart_port *sp;
>         unsigned long flags;
>
> -       serial_out(port, SPRD_CTL2, ((THLD_TX_EMPTY << 8) | THLD_RX_FULL));
> +       serial_out(port, SPRD_CTL2,
> +                  THLD_TX_EMPTY << THLD_TX_EMPTY_SHIFT | THLD_RX_FULL);
>
>         /* clear rx fifo */
>         timeout = SPRD_TIMEOUT;
> -       while (timeout-- && serial_in(port, SPRD_STS1) & 0x00ff)
> +       while (timeout-- && serial_in(port, SPRD_STS1) & SPRD_RX_FIFO_CNT_MASK)
>                 serial_in(port, SPRD_RXD);
>
>         /* clear tx fifo */
>         timeout = SPRD_TIMEOUT;
> -       while (timeout-- && serial_in(port, SPRD_STS1) & 0xff00)
> +       while (timeout-- && serial_in(port, SPRD_STS1) & SPRD_TX_FIFO_CNT_MASK)
>                 cpu_relax();
>
>         /* clear interrupt */
> @@ -433,10 +441,11 @@ static void sprd_set_termios(struct uart_port *port,
>         }
>
>         /* clock divider bit0~bit15 */
> -       serial_out(port, SPRD_CLKD0, quot & 0xffff);
> +       serial_out(port, SPRD_CLKD0, quot & SPRD_CLKD0_MASK);
>
>         /* clock divider bit16~bit20 */
> -       serial_out(port, SPRD_CLKD1, (quot & 0x1f0000) >> 16);
> +       serial_out(port, SPRD_CLKD1,
> +                  (quot & SPRD_CLKD1_MASK) >> SPRD_CLKD1_SHIFT);
>         serial_out(port, SPRD_LCR, lcr);
>         fc |= RX_TOUT_THLD_DEF | RX_HFC_THLD_DEF;
>         serial_out(port, SPRD_CTL1, fc);
> @@ -510,7 +519,7 @@ static void wait_for_xmitr(struct uart_port *port)
>                 if (--tmout == 0)
>                         break;
>                 udelay(1);
> -       } while (status & 0xff00);
> +       } while (status & SPRD_TX_FIFO_CNT_MASK);
>  }
>
>  static void sprd_console_putchar(struct uart_port *port, int ch)
> --
> 1.9.1
>
