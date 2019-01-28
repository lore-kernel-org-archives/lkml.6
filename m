Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DFFC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C9F2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RYV57oWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731856AbfA1QFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:05:32 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34818 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731833AbfA1QF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:05:29 -0500
Received: by mail-vs1-f67.google.com with SMTP id e7so10042162vsc.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 08:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FrtjpKglw3IQ2GLrKJglnEfBEzM5h+b1At11ioc1kTQ=;
        b=RYV57oWcvkY2U7vRLMhQCE5jUUSoWP2fM7EhYds+v3fBFIqDCKQu0dWa28pC1TlCrF
         YAP3KszADlGAjD7lkQm41zfTNMPK1rxlg6u3nu7+kgdTarYe4j4JzZqieGjcNSsWEsJp
         2d2xPvHbJ42wMSUaZPuF9aXIKepZ5f5pEaPzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FrtjpKglw3IQ2GLrKJglnEfBEzM5h+b1At11ioc1kTQ=;
        b=ZbYxhzmbfAOJfotlnsnL5TD48JZHOX6pazL1Pq+yaBPzo0zIWveqC2dsTGNsDCSZ64
         qxNwSQzq2IUiTGbpvF8LQC7vi+EdMMgpE4IHa8rrNqizmuyBQz4rli87oMp6WN6Fhbb4
         WGkY2Pb4XIAKQPmk5fmNWoITdqw9iMlNqdJ2gqIusXp7mKUMkmhoeekjpGexFKpMG6aY
         pnZmagdijxsrfJkWtqGU5phUTIQIpjngCYPvm8kvMzryGPWSm96OaWd5RqAv59B5CKVA
         PqC5misLp7ZNM0HK18RtQaXtwTPFIWdFpB96pLfAyk5wGc9iyj7uY62x7sROmb6LmowW
         PxHg==
X-Gm-Message-State: AJcUukdsqXTzk1pkzeFfmJ7Ieor7Nm2Q1LNwBX5SrnyWY2HlTANcXLXP
        bQDyHtrT/OMo3vND3Bggqn9GlOKgXTg=
X-Google-Smtp-Source: ALg8bN7Sv8kj/VZ+mT/gpqFIZQ0nnTkOc01aMhIaK/qWEAZ0uNrYNmfRtFvUPLAh1DVUqVFQ6H8/3Q==
X-Received: by 2002:a67:8396:: with SMTP id f144mr9233742vsd.6.1548691527242;
        Mon, 28 Jan 2019 08:05:27 -0800 (PST)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id y20sm7586vsq.16.2019.01.28.08.05.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 08:05:26 -0800 (PST)
Received: by mail-vk1-f173.google.com with SMTP id 197so3782917vkf.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 08:05:25 -0800 (PST)
X-Received: by 2002:a1f:bfd6:: with SMTP id p205mr9160551vkf.70.1548691525478;
 Mon, 28 Jan 2019 08:05:25 -0800 (PST)
MIME-Version: 1.0
References: <20190128154341.47195-1-sashal@kernel.org> <20190128154341.47195-35-sashal@kernel.org>
In-Reply-To: <20190128154341.47195-35-sashal@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 28 Jan 2019 08:05:13 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xm-3wAoQwnKkKNKFxcPgUsYUXHAqonv_BjPSrggkakbA@mail.gmail.com>
Message-ID: <CAD=FV=Xm-3wAoQwnKkKNKFxcPgUsYUXHAqonv_BjPSrggkakbA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.20 035/304] serial: core: Allow processing sysrq
 at port unlock time
To:     Sasha Levin <sashal@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 28, 2019 at 7:44 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Douglas Anderson <dianders@chromium.org>
>
> [ Upstream commit d6e1935819db0c91ce4a5af82466f3ab50d17346 ]
>
> Right now serial drivers process sysrq keys deep in their character
> receiving code.  This means that they've already grabbed their
> port->lock spinlock.  This can end up getting in the way if we've go
> to do serial stuff (especially kgdb) in response to the sysrq.
>
> Serial drivers have various hacks in them to handle this.  Looking at
> '8250_port.c' you can see that the console_write() skips locking if
> we're in the sysrq handler.  Looking at 'msm_serial.c' you can see
> that the port lock is dropped around uart_handle_sysrq_char().
>
> It turns out that these hacks aren't exactly perfect.  If you have
> lockdep turned on and use something like the 8250_port hack you'll get
> a splat that looks like:
>
>   WARNING: possible circular locking dependency detected
>   [...] is trying to acquire lock:
>   ... (console_owner){-.-.}, at: console_unlock+0x2e0/0x5e4
>
>   but task is already holding lock:
>   ... (&port_lock_key){-.-.}, at: serial8250_handle_irq+0x30/0xe4
>
>   which lock already depends on the new lock.
>
>   the existing dependency chain (in reverse order) is:
>
>   -> #1 (&port_lock_key){-.-.}:
>          _raw_spin_lock_irqsave+0x58/0x70
>          serial8250_console_write+0xa8/0x250
>          univ8250_console_write+0x40/0x4c
>          console_unlock+0x528/0x5e4
>          register_console+0x2c4/0x3b0
>          uart_add_one_port+0x350/0x478
>          serial8250_register_8250_port+0x350/0x3a8
>          dw8250_probe+0x67c/0x754
>          platform_drv_probe+0x58/0xa4
>          really_probe+0x150/0x294
>          driver_probe_device+0xac/0xe8
>          __driver_attach+0x98/0xd0
>          bus_for_each_dev+0x84/0xc8
>          driver_attach+0x2c/0x34
>          bus_add_driver+0xf0/0x1ec
>          driver_register+0xb4/0x100
>          __platform_driver_register+0x60/0x6c
>          dw8250_platform_driver_init+0x20/0x28
>          ...
>
>   -> #0 (console_owner){-.-.}:
>          lock_acquire+0x1e8/0x214
>          console_unlock+0x35c/0x5e4
>          vprintk_emit+0x230/0x274
>          vprintk_default+0x7c/0x84
>          vprintk_func+0x190/0x1bc
>          printk+0x80/0xa0
>          __handle_sysrq+0x104/0x21c
>          handle_sysrq+0x30/0x3c
>          serial8250_read_char+0x15c/0x18c
>          serial8250_rx_chars+0x34/0x74
>          serial8250_handle_irq+0x9c/0xe4
>          dw8250_handle_irq+0x98/0xcc
>          serial8250_interrupt+0x50/0xe8
>          ...
>
>   other info that might help us debug this:
>
>    Possible unsafe locking scenario:
>
>          CPU0                    CPU1
>          ----                    ----
>     lock(&port_lock_key);
>                                  lock(console_owner);
>                                  lock(&port_lock_key);
>     lock(console_owner);
>
>    *** DEADLOCK ***
>
> The hack used in 'msm_serial.c' doesn't cause the above splats but it
> seems a bit ugly to unlock / lock our spinlock deep in our irq
> handler.
>
> It seems like we could defer processing the sysrq until the end of the
> interrupt handler right after we've unlocked the port.  With this
> scheme if a whole batch of sysrq characters comes in one irq then we
> won't handle them all, but that seems like it should be a fine
> compromise.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  include/linux/serial_core.h | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)

FWIW this patch shouldn't hurt to be backported (I haven't heard any
problems report with it), but it is effectively a no-op unless you
also pick a patch that uses the new API.  For instance commit
596f63da42b9 ("serial: 8250: Process sysrq at port unlock time").
...and if you want that patch I think you also need commit
3e6f88068314 ("serial: core: Include console.h from serial_core.h").

In theory you could think about adding the "qcom_geni_serial" patches
related to sysrq processing too--dunno if anyone really cares about
those on 4.20 stable...

-Doug
