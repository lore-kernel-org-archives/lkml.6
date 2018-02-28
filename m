Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519832428-2-1149264491547082849
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
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
    t=1519832428; b=muHE6ROZMc37suoEpBj+TROEG6q+QDZLk7r1Y8VXnnjLuKP
    XRLckD+GpyLDGc3Zh2X0M4rxJf6KAzDo3rKht43MwepXJHlXdDII36N43kgnwkbj
    Fmts+OBXYNdteZwAzCBnfMNvcCLzRBQRF8mEcTs7+00BbBxL79ReTmhJbG7YTraA
    B1tyy4SJk7rSkujBsYt4/axFUpRYGpL+EyOcxq6dfQzXUhAm61iBL1XP+xyLOqgK
    lzDUqWJFZzPcMdypvEEYjXV0HeTgyy1Wogxq/d/hzO41WjRmRpMiwrxsCI9IvRqC
    zFwFHy+kJW1qb1P6ky/+TnAmO4t+90Gpw9yFAbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519832428; bh=C8nF6/kSwWE9q0MNPgLIJxym8btccTYEylr+X3
    M1WIE=; b=YcD9VsDt/NcT94Hc8NGP7Ppu8/UOpZFSo+F2kNN+XeKoHabrJkcLB4
    4nPRr8RGbEAMoNQgYT+dVF0g8fcKOur170urv867EgqJrLLqIGNAetfRLQsqwDx0
    la1k0aU+/funArfHfy3CzdWebZJYugx89jdE8CeQ4nY7IHL+JgEvW0IVMbSD84BD
    KCgvf6Pig1NK8tyu35PXf1WOSmBz9BsrK85HfzF3nWGABKhYJas88m1rDW2RxA/w
    lasCd8njqy1J5xda36Gt6mpbB44KGKFtKKXBcoK/VuScMijrhcWmHWmdnL1/BEZn
    zylidRf3JU0kGESlrTiTiQJTWZavjozA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fW5BS4dG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ImXwtaYU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fW5BS4dG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ImXwtaYU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933161AbeB1PkV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:40:21 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:44108 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932131AbeB1PkS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Feb 2018 10:40:18 -0500
X-Google-Smtp-Source: AG47ELsfUaYcE+UtybEYvw3szKORidp5srPx83S60tQghK+JEhRvMw7rb2gQTuvkqkmozQSIVwp3A/8dyknIKhM14zo=
MIME-Version: 1.0
In-Reply-To: <1519815044-22669-3-git-send-email-bich.hemon@st.com>
References: <1519815044-22669-1-git-send-email-bich.hemon@st.com> <1519815044-22669-3-git-send-email-bich.hemon@st.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Feb 2018 17:40:16 +0200
Message-ID: <CAHp75Vd+UcUSG7t6SxzTmUkB6d2TAYVmgO92m9iV0YVJ1=XbzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: stm32: update interrupt initialization
To: Bich HEMON <bich.hemon@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 12:51 PM, Bich HEMON <bich.hemon@st.com> wrote:
> For each port, get each IRQ using its specific name instead of its index.
>
> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> ---
>  drivers/tty/serial/stm32-usart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index 0fa735b..5c85cbc 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -680,8 +680,8 @@ static int stm32_init_port(struct stm32_port *stm32port,
>         port->flags     = UPF_BOOT_AUTOCONF;
>         port->ops       = &stm32_uart_ops;
>         port->dev       = &pdev->dev;
> -       port->irq       = platform_get_irq(pdev, 0);
> -       stm32port->wakeirq = platform_get_irq(pdev, 1);

> +       port->irq       = platform_get_irq_byname(pdev, "event");

This is I have no idea about...

> +       stm32port->wakeirq = platform_get_irq_byname(pdev, "wakeup");

But this one is redundant since Tony's patch:
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=da997b22c40473b7db60bde6ea188d35565d10c8

>         stm32port->fifoen = stm32port->info->cfg.has_fifo;
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> --
> 1.9.1



-- 
With Best Regards,
Andy Shevchenko
