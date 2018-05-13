Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3117659-1526221014-2-6552991307900805544
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES roenca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526221014; b=XMKzsLeIsMjevllH1EhChEpwZC2f+5f8oNxQBhrylOz9A369+n
    e9vZxpyNQjAS/0P4oTAZ11b2MGNrqCck7TvsP+eHpEeLSIT7XKEZ+7x3KgASDsHX
    iZBIJbtaUdC5Y2PNuF3u0ZQa43dJMKehmZPrN+5TWBn8p37rKd8SkSNBoS14N5J/
    smFRE7f1x5vW5GQqqaxoNUpB/Ah2Eq35+B4VEmYD521Wk/aDRTfvlWwb8e0dw1zc
    mpmEE5dEjv6IhH/BgHiSClF7pGgOJX2GVpx1LI8FwqbkUcdRehhnN/CZXuiN8GfE
    aiYQ1dwSIU9H5EecaM22Nt9+htTJ4sQ3oBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526221014; bh=zZ9EIKWW2meZUKxgQfWpoHUyv4GkaIYB2vyYGWFbUP
    c=; b=UvzQ6Zu9284TlKU4FtZmgD6M1clm7+v3qDSZvO9GypKRrjOHCgFNjBDODi
    h40rx8ruW5t21v96Jr2L/dRbPlthwuCIbOi5rAGiYUGRVI9VPcGc3dWzwNzkuwnP
    60TUyMxegls1L2fZEKTt5FJWkL9NwiGLXlrg3xqWM6Tc9/rrPE4P46mIW7DUdfb+
    lKw9ljDSteotPTFr4GHCPYyOV/ihCxeEREZUX2Q2pQXzf+hwP1yyz9p07P587/9p
    wza0OvJPJCm0gGNqFf9s59ZCWWzvb7y36nWMItJ+dYwrEGO5xVbJXAM8KTqHeJPG
    aGqDJVcwZB5/tIJbKX+iuzQWsyrg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=VybkLJyf x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=qiZPQ3YT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=VybkLJyf x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=qiZPQ3YT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHYLJUHx3SplOXfXoJHo6U7IfHVhcCWDXSKH2w1ghfOniSm74F/UF5s+9Dlp2bCHyCA22/h6YIfFQH80wV6Q8y+LusfAA4wGg1JSAeXP04/MMJ9byDaI
    gG1S6dPD/zSrknq+sbQzbQFWs/ITwhZyqgDAxlNASsmR6ulnefvvCcI0mjyO9C9W5ei4f5QA4sE/adKXz+09uJVm7l14s/4zz8d1AtJGEajm9gpbaldEp3mI
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=fbV3Th2LUxsA:10 a=VUJBJC2UJ8kA:10 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8
    a=2BhvgM1lhYKaxuubGdYA:9 a=CdO5dvL8khfHbho6:21 a=MjiXGEToQtuOHOdd:21
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeEMOQj (ORCPT <rfc822;greg@kroah.com>);
        Sun, 13 May 2018 10:16:39 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33968 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbeEMOQh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 13 May 2018 10:16:37 -0400
X-Google-Smtp-Source: AB8JxZrHzGqBR5dehSBdatsvDrGiqQ9ukPm4BdRP5vdG3jc3gzCXqCY9kATAFQxLjc2I2hYfE45YlR3fRuchpNPq8EE=
MIME-Version: 1.0
In-Reply-To: <20180508114403.14499-7-mperttunen@nvidia.com>
References: <20180508114403.14499-1-mperttunen@nvidia.com> <20180508114403.14499-7-mperttunen@nvidia.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 13 May 2018 17:16:36 +0300
Message-ID: <CAHp75VfYF_u2bZ+temGbReEB9K-t3A75aUNYwffyv9-=zEi0Lw@mail.gmail.com>
Subject: Re: [PATCH 6/8] serial: Add Tegra Combined UART driver
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, araza@nvidia.com,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 8, 2018 at 2:44 PM, Mikko Perttunen <mperttunen@nvidia.com> wrote:
> The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
> multiplexing multiple "virtual UARTs" into a single hardware serial
> port. The TCU is the primary serial port on Tegra194 devices.
>
> Add a TCU driver utilizing the mailbox framework, as the used mailboxes
> are part of Tegra HSP blocks that are already controlled by the Tegra
> HSP mailbox driver.

First question, can it be done utilizing SERDEV framework?

> +static void tegra_tcu_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
> +{

> +       (void)port;
> +       (void)mctrl;

Huh?

> +}

> +static void tegra_tcu_uart_stop_tx(struct uart_port *port)
> +{
> +       (void)port;
> +}

Ditto.

> +               if (written == 3) {
> +                       value |= 3 << 24;
> +                       value |= BIT(26);
> +                       mbox_send_message(tcu->tx, &value);

> +               }

(1)

> +       }
> +
> +       if (written) {
> +               value |= written << 24;
> +               value |= BIT(26);
> +               mbox_send_message(tcu->tx, &value);
> +       }

(2)

These are code duplications.

> +static void tegra_tcu_uart_stop_rx(struct uart_port *port)
> +{
> +       (void)port;
> +}
> +
> +static void tegra_tcu_uart_break_ctl(struct uart_port *port, int ctl)
> +{
> +       (void)port;
> +       (void)ctl;
> +}
> +
> +static int tegra_tcu_uart_startup(struct uart_port *port)
> +{
> +       (void)port;
> +
> +       return 0;
> +}
> +
> +static void tegra_tcu_uart_shutdown(struct uart_port *port)
> +{
> +       (void)port;
> +}
> +
> +static void tegra_tcu_uart_set_termios(struct uart_port *port,
> +                                      struct ktermios *new,
> +                                      struct ktermios *old)
> +{
> +       (void)port;
> +       (void)new;
> +       (void)old;
> +}

Remove those unused stub contents.

> +       return uart_set_options(&tegra_tcu_uart_port, cons,
> +                               115200, 'n', 8, 'n');

Can't it be one line?

> +static void tegra_tcu_receive(struct mbox_client *client, void *msg_p)
> +{
> +       struct tty_port *port = &tegra_tcu_uart_port.state->port;

> +       uint32_t msg = *(uint32_t *)msg_p;

Redundant casting.

> +       unsigned int num_bytes;
> +       int i;
> +

> +       num_bytes = (msg >> 24) & 0x3;

Two magic numbers.

> +       for (i = 0; i < num_bytes; i++)
> +               tty_insert_flip_char(port, (msg >> (i*8)) & 0xff, TTY_NORMAL);
> +
> +       tty_flip_buffer_push(port);
> +}

> +MODULE_AUTHOR("Mikko Perttunen <mperttunen@nvidia.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("NVIDIA Tegra Combined UART driver");
> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index dce5f9dae121..eaf3c303cba6 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -281,4 +281,7 @@
>  /* MediaTek BTIF */
>  #define PORT_MTK_BTIF  117
>
> +/* NVIDIA Tegra Combined UART */
> +#define PORT_TEGRA_TCU 118

Check if there is an unused gap. IIRC we still have one near to 40ish.

-- 
With Best Regards,
Andy Shevchenko
