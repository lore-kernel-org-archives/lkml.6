Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAC4C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E6E2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETw6/JAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E6E2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeJIAYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:24:48 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35078 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJIAYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:24:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id r191-v6so14482773lff.2;
        Mon, 08 Oct 2018 10:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cKazQ0Pqe6c+DGtZXkqDT7kCtMn3+E8bbGSOPlALkdo=;
        b=ETw6/JAq80FvYJD9E7QKSzSZWdDtNtQLS0kbRPTixorVCf5oD0qekiw2NhVNy/ZkTk
         VLrLiU1YkW3KEtU+PYT9yanD1WcA5LUi7H61g2BcQZLBbD31Kc+PN0FblLcxw3tgiXeG
         XeHl66AKT/jVtUd9tCA6QKEe8LpUUZc9an0KKOzBe4VD5qC+zDeSvs97AtZ8Jm1jsAXG
         Eyw4YJI0j2ZEWuA3Ri21m+63ObF2SBPzhMcIWa+DkfTbwAvz/3A0bBiaYKAxuqqVfoEy
         QaC+KrAabDiaClrahQl6SLxZOfaTi8F8h5YWUdqWhq3IfML8M4DeoWk29Qw/f5PnVJp9
         X8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cKazQ0Pqe6c+DGtZXkqDT7kCtMn3+E8bbGSOPlALkdo=;
        b=A/5X2DtkXi8naLIaMsQtjARJNvPHryqREMRl8+FHBQ9+a0RZmLqro9r/bJDoBC94PX
         Dsf/pJNKSba3WuEAfTV5ue/aKEapyfqDwE37Hqfbka025ro8xEaUBNsPD3dnoJURG47K
         xZnmdJWBw8RFCnIpILtG39ne4MXWnL3eEpdYd9WUttuA6+MR6BnPFRtjlwl4yEBh+Jb7
         nWirPoiAJIZPPhec7DFkMZdB9YOpMgm3Tr3zjiSw/ER1I0CXj+vc6o/3ZiFys7wqCrpZ
         SEIy6qIYLRuhhIbBClKXmdmE5+hnD86N4PqXEsULOYf0iB8lFVs7ZXz11ZviAXGhSMFJ
         nB1Q==
X-Gm-Message-State: ABuFfojjr4X93GoBYLdZrPnuVHU/IyK4DNJej1HUikiIgf7F36HJuONA
        0H5mhBn8ZgCcUyklU6j0W126Bok7kh5z11AD8mY=
X-Google-Smtp-Source: ACcGV61YDXsEV8+59EpCKb9NoJYpkgWs7e8TcWk+6qHx/k1xeEOIMS1pUe+3hZeCsEnqyUlFoJVFmg7L/d80MAbYE5U=
X-Received: by 2002:a19:5a8f:: with SMTP id y15-v6mr12739416lfk.15.1539018724448;
 Mon, 08 Oct 2018 10:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181008152523.70705-1-sashal@kernel.org> <20181008152523.70705-24-sashal@kernel.org>
In-Reply-To: <20181008152523.70705-24-sashal@kernel.org>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Mon, 8 Oct 2018 10:11:53 -0700
Message-ID: <CAKdAkRSoq_U1rkO+6gbautYpS1fFn3icLY3Dtx0geXNC7MwvbA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.18 24/58] Input: atakbd - fix Atari CapsLock behaviour
To:     sashal@kernel.org
Cc:     "3.8+" <stable@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        alexander.levin@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 8:25 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Michael Schmitz <schmitzmic@gmail.com>
>
> [ Upstream commit 52d2c7bf7c90217fbe875d2d76f310979c48eb83 ]
>
> The CapsLock key on Atari keyboards is not a toggle, it does send the
> normal make and break scancodes.
>
> Drop the CapsLock toggle handling code, which did cause the CapsLock
> key to merely act as a Shift key.

This has been broken for 10+ years. Does it really make sense to
promote it to stable?

>
> Tested-by: Michael Schmitz <schmitzmic@gmail.com>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  drivers/input/keyboard/atakbd.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/input/keyboard/atakbd.c b/drivers/input/keyboard/atakbd.c
> index 524a72bee55a..fdeda0b0fbd6 100644
> --- a/drivers/input/keyboard/atakbd.c
> +++ b/drivers/input/keyboard/atakbd.c
> @@ -189,14 +189,8 @@ static void atakbd_interrupt(unsigned char scancode, char down)
>
>                 scancode = atakbd_keycode[scancode];
>
> -               if (scancode == KEY_CAPSLOCK) { /* CapsLock is a toggle switch key on Amiga */
> -                       input_report_key(atakbd_dev, scancode, 1);
> -                       input_report_key(atakbd_dev, scancode, 0);
> -                       input_sync(atakbd_dev);
> -               } else {
> -                       input_report_key(atakbd_dev, scancode, down);
> -                       input_sync(atakbd_dev);
> -               }
> +               input_report_key(atakbd_dev, scancode, down);
> +               input_sync(atakbd_dev);
>         } else                          /* scancodes >= 0xf3 are mouse data, most likely */
>                 printk(KERN_INFO "atakbd: unhandled scancode %x\n", scancode);
>
> --
> 2.17.1
>


-- 
Dmitry
