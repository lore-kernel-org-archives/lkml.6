Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623C3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0F6223CB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0F6223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbeKLTfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:35:24 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36444 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeKLTfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:35:24 -0500
Received: by mail-ua1-f66.google.com with SMTP id j3so2812584uap.3;
        Mon, 12 Nov 2018 01:42:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yL4lIIwoehOZCmTS+YcIMJIxIGekmiJLuRWURAF6dC4=;
        b=XQfKoaaAXGUKEnVtFmVO+suZLjdGaf2Uix60gS0oDPUrfktP+1KfEhNulSKGS/P2dW
         humeR5p0hziC9Y6UFEF3j5rIVAjQ3VzAHzGXaf3PAH1g/NeRqz7eFGmIodP1zWdoVRZ7
         wUbVOV+I3JqJAyw567/3j4Gd02vilyv2k0nsx7IYWeaz9jt0NKkpwlLbrn5nWJ21izIa
         lAA28L153YcBgv14ErQs3v2mlh9Biekws1n4kZzDWJSCeZvKZP6514p7oWA9IGY+o+Yu
         cFYM1zBSKYjj8aGYyl+vsQTCTFWkBhAQ/qUV4OYHJO1M1ufTsAoY3GhMgzTEof+QPv9r
         leBw==
X-Gm-Message-State: AGRZ1gKCVeEyP5Mp//2vn9kVLVtVMgpsTebBf/0VVluku1DRBIryGuDh
        rTx8BLPxQxxGXa7ms2xUV8M8UKQ1EmZQTOde18o=
X-Google-Smtp-Source: AJdET5fjynKZfzZcoORQnAJ61VqiHTSSEnIa/bN68opeEsLWoDHgzNJE7VSXmI/E/g5GGsl0QnRoma9/AhCdyOX4qfQ=
X-Received: by 2002:ab0:7251:: with SMTP id d17mr119184uap.0.1542015779233;
 Mon, 12 Nov 2018 01:42:59 -0800 (PST)
MIME-Version: 1.0
References: <1541623464-49041-1-git-send-email-carmeli.tamir@gmail.com> <1541623464-49041-2-git-send-email-carmeli.tamir@gmail.com>
In-Reply-To: <1541623464-49041-2-git-send-email-carmeli.tamir@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Nov 2018 10:42:47 +0100
Message-ID: <CAMuHMdXqAbWHCFKD6L_JqJQ1J17=QtopHFihXnWcWufkUJqrTw@mail.gmail.com>
Subject: Re: [PATCH 1/3] staging: emxx_udc: Added static modifier to udc_controller
To:     carmeli.tamir@gmail.com
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        chrisadr@gentoo.org, areklis909@gmail.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carmeli,

CC Magnus

(staging drivers receive so may janitorial changes that the original author is
 lost in the git shortlog noise)

On Wed, Nov 7, 2018 at 9:46 PM Carmeli Tamir <carmeli.tamir@gmail.com> wrote:
> Added static modifier to the udc_controller, since it's only
> required within emxx_udc.c.
>
> Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>

Thanks for your patch!

> --- a/drivers/staging/emxx_udc/emxx_udc.c
> +++ b/drivers/staging/emxx_udc/emxx_udc.c
> @@ -56,7 +56,7 @@ static void _nbu2ss_fifo_flush(struct nbu2ss_udc *, struct nbu2ss_ep *);
>
>  /*===========================================================================*/
>  /* Global */
> -struct nbu2ss_udc udc_controller;
> +static struct nbu2ss_udc udc_controller;

What about the "Global" comment?
Perhaps this was intentional?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
