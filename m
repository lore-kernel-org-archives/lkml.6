Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AC3C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3102192C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfAYIJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:09:50 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45013 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfAYIJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:09:50 -0500
Received: by mail-ot1-f65.google.com with SMTP id g16so3762388otg.11;
        Fri, 25 Jan 2019 00:09:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=djPbkyd1+SDPYk6mxzOjNnM2qu3TJB1XOhWLX2r26UY=;
        b=lCU6NQaIA8SuIm9EqDBlh2kX1j6AhBAh238qY7kmJxDGJuwAegkCvfuc7gIsFpAJO1
         T9dpZTZHal98cO3wXTGUO451YZnQ7nUtX3Disv7kPh+Bz6pgCDTGsT9hJq0rcn+fyD1D
         Oy1e44lAMvas0Rg/OTPbe+ELRjGDD//ZOwhp07MUEDKiCwxo8XKlWeODYHvqpNzSfia+
         QNDdaWDq2Y+DyPZh3FjEYxaUAtKZPGBQ0xZdPi//Qm/HXr/Hr+sFhIDKTPo6Zx4yv3Lk
         jW5kzg8Iyx83x1WRRFxgMWMh7+DeCiQaGTd1MzmK5qpmg006+PUSi75ZwDHHK6Ug4hUw
         v1yA==
X-Gm-Message-State: AJcUukeKxGM/PhQobcXld03NBAFFh1wihP6iDg9mBuIVQfwAdCI+ex1/
        yBKI7FIP+2lzy/44Ai0P7Pyg825byq4/MBehJmg=
X-Google-Smtp-Source: ALg8bN7qcPzB4rpapIl9bmuXZJ56NoyU3NH3MkcQD7LOJr7UNBzc3HjyajJjtO5+FDeLAQrv4FoTQKXvFFXn6LYVPaU=
X-Received: by 2002:a9d:3d24:: with SMTP id a33mr7164512otc.365.1548403788902;
 Fri, 25 Jan 2019 00:09:48 -0800 (PST)
MIME-Version: 1.0
References: <20190124180724.20910-1-malat@debian.org> <20190124180724.20910-2-malat@debian.org>
In-Reply-To: <20190124180724.20910-2-malat@debian.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 25 Jan 2019 09:09:38 +0100
Message-ID: <CA+7wUswNMgZZYpLokyv0DXqf7jemw2rhJ5uB1mGrccjmPgzAjg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Correctly annotate implicit fall through
 in __rfcomm_dlc_close
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Peter Hurley <peter@hurleysoftware.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 7:07 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> this place in the code produced a warning (W=1).
>
> In this particular case put the fall through comment on a separate line so
> as to match the regular expression expected by GCC.
>
> This commit removes the following warning:
>
>   net/bluetooth/rfcomm/core.c:479:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Please discard, already fixed by :

6317950c1b9c Bluetooth: Mark expected switch fall-throughs

> Cc: Peter Hurley <peter@hurleysoftware.com>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  net/bluetooth/rfcomm/core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index 1a635df80643..caaae6accafa 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -480,9 +480,8 @@ static int __rfcomm_dlc_close(struct rfcomm_dlc *d, int err)
>                         __rfcomm_dlc_disconn(d);
>                         break;
>                 }
> -               /* if closing a dlc in a session that hasn't been started,
> -                * just close and unlink the dlc
> -                */
> +               /* fall through - if closing a dlc in a session that hasn't */
> +               /* been started, just close and unlink the dlc */
>
>         default:
>                 rfcomm_dlc_clear_timer(d);
> --
> 2.19.2
>
