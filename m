Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1457237-1521023760-2-16139424123718155720
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521023759; b=fCH4MJyLRoZQSY0x7iQgv/FHYKkI9EtNfnNs464Tn6MAJDJ
    6GwfnWmEKvJ8G9WdjaF2LdDM8fxLhoWp63NY3cPs6Ym0TT5gZb6rAuvr7rU9WVRb
    EmjeXJ2XXhUZxLh1fywzPgcfuGas6RhhwDp6qQSUhO+9B/VRl2inb1eBOio/ykCz
    OlUIqfYmQl7ZBGOQ1DNs3KhzCfrtH1ftBjPbOcYNWndoS0XlbDJY30BsKuZ0vbgo
    eo912DmpPxLURKZ2jZ1MSBjPnU1oFSeJOyHyNxJfoVJ7iysya0iTz0PyxnKMMpYT
    evtGq2wU0XKaqXs2MPzB3ysFGAYLXNZzpmP3RDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521023759; bh=+e6P42WigS0vKaLoaGZVg75F98O4ZdN6XqTLta
    ErX1s=; b=AFqoAxfntgRi5F+SZb6zJyvIsL7+n0FkahB8a7T1rTCk6LDLbKNBIc
    y9q+hAHH+jNRMTpbsAY823XPau6cvTrETwnAWtMYUmAgxPVhyEsO3w6/D7oSeelQ
    bnufpBzlD+Xkb+ygn8rPOX/hjoUz9Dd+LUPByQhfSraW3tpid7/M3cChk80tFJ5i
    4Qxb5A7qBFIIIkLG+I8/r1CAi53mg2B0Q5YQ72MrqpvtmIfqZdm1oFyw1G+okl3u
    tP+eA4ozNazACXy7nNeVT5jAf7+1wo3tADeJRpP2yag33c4Bqu8UTLTKqWyT0/Ol
    BUkHoco2pvZZCT4NHVqZ79ttelLUg39Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=WhVD9h2x x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QIUAHCik;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=WhVD9h2x x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QIUAHCik;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbeCNKf5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 06:35:57 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33762 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeCNKf4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Mar 2018 06:35:56 -0400
X-Google-Smtp-Source: AG47ELvaN5OO/IplZOYUOtsznjQsJecC9h6QUCcocB/6GeaNE5Jg03qEhoESog/xBID9XK5mIMr+zj+DQBzlBWe4pYw=
MIME-Version: 1.0
In-Reply-To: <20180314003655.12141-2-djkurtz@chromium.org>
References: <20180314003655.12141-1-djkurtz@chromium.org> <20180314003655.12141-2-djkurtz@chromium.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Mar 2018 12:35:55 +0200
Message-ID: <CAHp75VcipTDS30CxJ+BEcidaCJAbuDTzsG3q8xZK-h6HCN5McA@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial: 8250_early: Add earlycon support for AMD
 Carrizo / Stoneyridge
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Aaron Durbin <adurbin@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 2:36 AM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> AMD Carrizo / Stoneyridge use a DesignWare 8250 UART that uses a 48 MHz
> input clock.
>
> Allow these platforms to set up this clock by specifying a kernel command
> line like:
> earlycon=amdcz,mmio32,0xfedc6000,115200
>

Thanks, this is what I meant.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Suggested-by: ?

> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
>  drivers/tty/serial/8250/8250_early.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
> index ae6a256524d8..c6bf971a6038 100644
> --- a/drivers/tty/serial/8250/8250_early.c
> +++ b/drivers/tty/serial/8250/8250_early.c
> @@ -195,3 +195,18 @@ static int __init early_au_setup(struct earlycon_device *dev, const char *opt)
>  OF_EARLYCON_DECLARE(palmchip, "ralink,rt2880-uart", early_au_setup);
>
>  #endif
> +
> +#ifdef CONFIG_SERIAL_8250_DW
> +static int __init early_amdcz_setup(struct earlycon_device *dev,
> +                                   const char *opt)
> +{
> +       struct uart_port *port = &dev->port;
> +
> +       port->uartclk = 48000000;
> +
> +       return early_serial8250_setup(dev, opt);
> +}
> +
> +EARLYCON_DECLARE(amdcz, early_amdcz_setup);
> +
> +#endif
> --
> 2.16.2.804.g6dcf76e118-goog
>



-- 
With Best Regards,
Andy Shevchenko
