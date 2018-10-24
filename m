Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CBAC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6A92075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ikWuqt3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6A92075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbeJXT1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:27:53 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35831 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeJXT1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:27:53 -0400
Received: by mail-it1-f195.google.com with SMTP id p64-v6so6020061itp.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 04:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S4ykQxBxfgammuCKpLpHiuFupgumeTsWJCTlk1YJ8nw=;
        b=ikWuqt3xpqn05y5RavVWpIyzO/0Nr+EaShFC7I56F5DoG9Kh/t/VKvKkwOFFwPlO0M
         gC7T0ZjzKcHK78fXVrgSNHZ7fqFOD3KwzEZXwAz5ZBiaRUvWGv2xHkwIJYywTYx4xnPX
         PZrxo7mwpfWxANgmun+aAkyJwNpFWl8aa6w0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S4ykQxBxfgammuCKpLpHiuFupgumeTsWJCTlk1YJ8nw=;
        b=VwUbSTXH9PhEgTO/UHI7Ux5BrqdGxbMRlq3MY3L3m2IEVoWM93ovVfcuSE+acDvmje
         keNKW5ZUYVbSgir06B1sTjkQ38jOzJNrv5HzDV4KXs9K8O2dkF3lOsqCro0Zp7jwR6y0
         ZebwG1F+4asEET6mebUtzkP69xTrZkQsgEt/gKTYq2GxwVLxEW81eF/WF7A68hBPuSX0
         EwTwopGP1dX3gFIUtB7NZFJZA71RbLDc9QAVHEwtaeTtm9JBSR+VQLoFDA4oR//Mpp4F
         2uNY9yGzHD6v2wvRjBrBnn7KVY9sjyqzqeUY7SF0jR6TDIKRCbilrRKCdI3MyNtlMzVK
         4A2Q==
X-Gm-Message-State: AGRZ1gJ+Xwspp8q33gy0dfBPF0ejEvjyoFxBNebDOMtHL8zh6H7m0sm7
        6tY1qeEJeGyIl32xckm2X8jVoRT+52h+gW6OLhVh9RR7
X-Google-Smtp-Source: AJdET5fDZ0dquG3UE3PqbD5CDO16Co+9rNAk5XR1jZdQwsv4STRZdzzdKeL6xhxMU6qMAG+Ix04OyATvSUoxz45y8e0=
X-Received: by 2002:a24:6b4d:: with SMTP id v74-v6mr1096280itc.26.1540378813447;
 Wed, 24 Oct 2018 04:00:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Wed, 24 Oct 2018 03:59:33
 -0700 (PDT)
In-Reply-To: <20181019144024.31077-1-jonas@orbital-systems.com>
References: <20181019144024.31077-1-jonas@orbital-systems.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Oct 2018 12:59:33 +0200
Message-ID: <CAPDyKFoFhd0Snh4=uPaMbEpmVmkm70_ixW85Cufi45t3zXRYmA@mail.gmail.com>
Subject: Re: [PATCH] mmc: atmel-mci: do not assume idle after atmci_request_end
To:     Jonas Danielsson <jonas@orbital-systems.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 October 2018 at 16:40, Jonas Danielsson <jonas@orbital-systems.com> wrote:
> On our AT91SAM9260 board we use the same sdio bus for wifi and for the
> sd card slot. This caused the atmel-mci to give the following splat on
> the serial console:
>
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 538 at drivers/mmc/host/atmel-mci.c:859 atmci_send_command+0x24/0x44
>   Modules linked in:
>   CPU: 0 PID: 538 Comm: mmcqd/0 Not tainted 4.14.76 #14
>   Hardware name: Atmel AT91SAM9
>   [<c000fccc>] (unwind_backtrace) from [<c000d3dc>] (show_stack+0x10/0x14)
>   [<c000d3dc>] (show_stack) from [<c0017644>] (__warn+0xd8/0xf4)
>   [<c0017644>] (__warn) from [<c0017704>] (warn_slowpath_null+0x1c/0x24)
>   [<c0017704>] (warn_slowpath_null) from [<c033bb9c>] (atmci_send_command+0x24/0x44)
>   [<c033bb9c>] (atmci_send_command) from [<c033e984>] (atmci_start_request+0x1f4/0x2dc)
>   [<c033e984>] (atmci_start_request) from [<c033f3b4>] (atmci_request+0xf0/0x164)
>   [<c033f3b4>] (atmci_request) from [<c0327108>] (mmc_start_request+0x280/0x2d0)
>   [<c0327108>] (mmc_start_request) from [<c032800c>] (mmc_start_areq+0x230/0x330)
>   [<c032800c>] (mmc_start_areq) from [<c03366f8>] (mmc_blk_issue_rw_rq+0xc4/0x310)
>   [<c03366f8>] (mmc_blk_issue_rw_rq) from [<c03372c4>] (mmc_blk_issue_rq+0x118/0x5ac)
>   [<c03372c4>] (mmc_blk_issue_rq) from [<c033781c>] (mmc_queue_thread+0xc4/0x118)
>   [<c033781c>] (mmc_queue_thread) from [<c002daf8>] (kthread+0x100/0x118)
>   [<c002daf8>] (kthread) from [<c000a580>] (ret_from_fork+0x14/0x34)
>   ---[ end trace 594371ddfa284bd6 ]---
>
> This is:
>   WARN_ON(host->cmd);
>
> This was fixed on our board by letting atmci_request_end determine what
> state we are in. Instead of unconditionally setting it to STATE_IDLE on
> STATE_END_REQUEST.

I am sure this change is just papering over much more bigger issues
[1], which are present when using one host for multiple slots.

In either case, as it seems to improve things, I have queued it up for
4.21, thanks!

Kind regards
Uffe

[1]
https://www.spinics.net/lists/linux-mmc/msg49815.html

>
> Signed-off-by: Jonas Danielsson <jonas@orbital-systems.com>
> ---
>  drivers/mmc/host/atmel-mci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 0a0ebf3a0..c8a591d8a 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1954,13 +1954,14 @@ static void atmci_tasklet_func(unsigned long priv)
>                         }
>
>                         atmci_request_end(host, host->mrq);
> -                       state = STATE_IDLE;
> +                       goto unlock; /* atmci_request_end() sets host->state */
>                         break;
>                 }
>         } while (state != prev_state);
>
>         host->state = state;
>
> +unlock:
>         spin_unlock(&host->lock);
>  }
>
> --
> 2.17.2
>
