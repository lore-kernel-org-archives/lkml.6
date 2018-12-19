Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323B4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00AE20874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZvHch7Rs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbeLSWM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:12:59 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37510 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbeLSWM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:12:59 -0500
Received: by mail-lf1-f65.google.com with SMTP id y11so16236557lfj.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 14:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m5rJxqh3NKb11NTYYJMYdcB5gjjb8mA7s1SGkQtQT9c=;
        b=ZvHch7RsvRgSvIqjgIjBKCPbkGVUn8uwKgocMIVdWiqujKR2R01J1E3vk14PhsIWit
         fZUQrttWets3uSKBzhczVotiUi/LH+Sdy9t7geyYOYeC1Wkl5xWpECad2FwmglZkVggq
         M0lh8npltzay7yWzRxYxlzPJ5c+W5m7y7MG7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m5rJxqh3NKb11NTYYJMYdcB5gjjb8mA7s1SGkQtQT9c=;
        b=Bn5Mej3ifSH1lWBJuWsOk0vTgxSVkfTLR6MufxTS9kOzpG3eDJSU0GvpplDs55Nn+m
         FJ4CoWMoZ7hmGPhl0Dsv1UlMYPcARBH7cRIMWhrCPUCP6xRfkTFM/+Dz5PFDZq4yTLNF
         a4PyjCvRRhyHx/CKjii69BK75conLUAMOtaKxmqnGLl4qqln3PZbuYDa0PXldRmg+pax
         u0bKEfV6gHN9s9Cb6IfQ4apObWK16PBTDQp0gd3RDiwd4POvMBSkQB8r5EKvPHZUXI8y
         4q2g4pV8KptSwr26QNCDrJnY4bp182Nh5YyOEJn/oNrh+d35kT9higj9dG3AOfx69/ys
         Ohqw==
X-Gm-Message-State: AA+aEWYBKzXf6OUJt9w+cekvlX7nFkh62uPwS58WxFyGFflKW6hLvS79
        jRItjqxDgM9ifinUAfpGtEFzGa/mCeM=
X-Google-Smtp-Source: AFSGD/XAFJZVFbIvJm171MwsJXUAuAA9TBTqMwp2rJi9sjKvheHdmPlbfuV8/HS1i79GLQGdI3Jg2Q==
X-Received: by 2002:a19:a84e:: with SMTP id r75mr14149665lfe.45.1545257576920;
        Wed, 19 Dec 2018 14:12:56 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id t18sm3984668lft.93.2018.12.19.14.12.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 14:12:56 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id l15-v6so18761149lja.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 14:12:56 -0800 (PST)
X-Received: by 2002:a2e:9d17:: with SMTP id t23-v6mr13563042lji.57.1545257575738;
 Wed, 19 Dec 2018 14:12:55 -0800 (PST)
MIME-Version: 1.0
References: <20181219203353.172335-1-ryandcase@chromium.org>
In-Reply-To: <20181219203353.172335-1-ryandcase@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 19 Dec 2018 14:12:19 -0800
X-Gmail-Original-Message-ID: <CAE=gft4=gK5Ge_BOMN4dov=b978dXbTBZ2KPDuGxCP=CvgLd2A@mail.gmail.com>
Message-ID: <CAE=gft4=gK5Ge_BOMN4dov=b978dXbTBZ2KPDuGxCP=CvgLd2A@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Fix UART hang
To:     ryandcase@chromium.org
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 12:34 PM Ryan Case <ryandcase@chromium.org> wrote:
>
> If a serial console write occured while a UART transmit command was
> waiting for a done signal then no further data would be sent until
> something new kicked the system into gear. If there is already data
> waiting in the circular buffer we must re-enable the tx watermark so we
> receive the expected interrupts.
>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
>  drivers/tty/serial/qcom_geni_serial.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 0c93beb69e73..a694a47747c7 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -442,6 +442,7 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
>         bool locked = true;
>         unsigned long flags;
>         u32 geni_status;
> +       u32 irq_en;
>
>         WARN_ON(co->index < 0 || co->index >= GENI_UART_CONS_PORTS);
>
> @@ -476,6 +477,13 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
>                  * has been sent, in which case we need to look for done first.
>                  */
>                 qcom_geni_serial_poll_tx_done(uport);
> +
> +               if (uart_circ_chars_pending(&uport->state->xmit)) {
> +                       irq_en = readl_relaxed(uport->membase +
> +                                       SE_GENI_M_IRQ_EN);
> +                       writel_relaxed(irq_en | M_TX_FIFO_WATERMARK_EN,
> +                                       uport->membase + SE_GENI_M_IRQ_EN);

The _relaxed part of it has always been weird to me, but I guess we
fought that battle awhile ago with this driver and lost.

I suppose the only real danger with relaxed would be if you could get
yourself into some sort of tight loop or idle where the CPU's write
queue never flushes, but you needed it to in order to proceed. This
probably could never happen, especially with locks around consoles and
uart ports that act as barriers.

Reviewed-by: Evan Green <evgreen@chromium.org>
