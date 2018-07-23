Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D228ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35A420854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWPme6y0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35A420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388136AbeGWVu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:50:56 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:42520 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbeGWVu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:50:56 -0400
Received: by mail-ua0-f194.google.com with SMTP id w7-v6so1329171uan.9;
        Mon, 23 Jul 2018 13:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D94UWB+j9CgiHyj082yFXBRGQGYt4DSIPTvE19+6Ork=;
        b=YWPme6y0MmU2k18t+43RFSLcDwvePe5GQIRf0/S86g9ONMgkLzivJV3+58+h+gaL/R
         BzYgspfBbdIewDjGM0CUvDqmLZF3wH66GKO3d17f4VnUmwuejC7RW1RweyASpQW2qL/G
         OQ+/sMoarE4jkqyOMhgWsJDPINQ0qTXBa+PdvGgyY8eQlEZkB5ceyWCnuaW6lCwbMU0H
         pmj64zBc05zXjoJauAtr1vDX8XsRDLBk52i+kOLOLEeojxL5ovpoDBlsK5R2w3HFb4SR
         2n1Hina4/nQgwlOML9niM8SUvJSLx/2m7u4PQeK7FYtL+8LhJbcuCVK9ZP6r1L3xTC3n
         u2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D94UWB+j9CgiHyj082yFXBRGQGYt4DSIPTvE19+6Ork=;
        b=SyQX1ULwdX9CnG9LebBeY+EfaQkL2j6lMK6SteG3mJCDOrqrNBGvOdAqOBKGw5k7ne
         //fEIeJOBhbUsUEt4+k/t/24GIUDZ/oAPrE2jZ6Zgd0xsSCSH27lHeDk0f6mdoRixclk
         O1Dpcm/H9j7zASGsQlQz094XO0N830ZzwsgAwvTUbavfXO2j1J+iS0LVJmd6LMx8XAGM
         N7fMxGfoCK+5+xAujBjW/pZiGi05gekxmiCLD/nbv9gJBxhQjvZNHgBCyIA/M5bNHqz0
         tC4ZfAvX1A7dVOOQGa1MhgjOxlnyXNVlECK5/kRE3NaCTxNgR/jeifBSnfXY3GnQ7Bi/
         plSw==
X-Gm-Message-State: AOUpUlGdYdM6kkf2y7dzm+pI7hAVey/88g6E/hmiI6XYkuhi+2srD5KW
        GQR9cCgxsW0pHW2RAr3YfJo0YcQoGuHEv6TAMjs=
X-Google-Smtp-Source: AAOMgpflOkrpRx8lYrxCRtqL2jadILoPiUo9a6yDc9whaqYF+RtRjp061GCyhqbUcvI4nL1WzEcsglUuiZIzb5Rlld0=
X-Received: by 2002:ab0:13c7:: with SMTP id n7-v6mr9761360uae.47.1532378878442;
 Mon, 23 Jul 2018 13:47:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 13:47:57
 -0700 (PDT)
In-Reply-To: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 23 Jul 2018 23:47:57 +0300
Message-ID: <CAHp75VcAzAtV0+Eu8TGPnrxSpAnPOXU9mvpeO1SaoBO3Rx=wRw@mail.gmail.com>
Subject: Re: [PATCH 00/12] i2c: quirks: add zero length checks and update drivers
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 11:26 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> I had this idea for quite some time on my todo list but a soon to be
> implemented refactoring in the i2c-rcar driver now finally made me do it. Add a
> 'can't do 0 length messages' quirk to the quirk infrastructure for and remove
> the manual handling from the drivers. This makes the quirk much more visible.
> (Quite some prominent vendors in that list) We also have a centralized place to
> handle updates to the quirk detection if that is ever needed.
>
> I have tested this with the i2c-rcar and i2c-sh_mobile driver on a Renesas
> SalvatorXS board equipped with M3-N (r8a77965).
>
> A git branch can be found here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/quirk-no-zero-len
>
> Looking forward to comments, reviews, tests...

Thanks!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

for patches 1 and 2.

>
> Thanks,
>
>    Wolfram
>
> Wolfram Sang (12):
>   i2c: quirks: add zero length checks
>   i2c: designware-master: use core to detect 'no zero length' quirk
>   i2c: mxs: use core to detect 'no zero length' quirk
>   i2c: omap: use core to detect 'no zero length' quirk
>   i2c: pmcmsp: use core to detect 'no zero length' quirk
>   i2c: qup: use core to detect 'no zero length' quirk
>   i2c: stu300: use core to detect 'no zero length' quirk
>   i2c: tegra: use core to detect 'no zero length' quirk
>   i2c: zx2967: use core to detect 'no zero length' quirk
>   i2c: rcar: use core to detect 'no zero length' quirk
>   i2c: xlr: use core to detect 'no zero length' quirk
>   i2c: sh_mobile: use core to detect 'no zero length read' quirk
>
>  drivers/i2c/busses/i2c-designware-master.c | 12 +++++-------
>  drivers/i2c/busses/i2c-mxs.c               |  8 +++++---
>  drivers/i2c/busses/i2c-omap.c              |  8 +++++---
>  drivers/i2c/busses/i2c-pmcmsp.c            | 17 +----------------
>  drivers/i2c/busses/i2c-qup.c               | 14 ++++++--------
>  drivers/i2c/busses/i2c-rcar.c              | 13 ++++++-------
>  drivers/i2c/busses/i2c-sh_mobile.c         | 10 +++++-----
>  drivers/i2c/busses/i2c-stu300.c            | 12 ++++++------
>  drivers/i2c/busses/i2c-tegra.c             |  4 +---
>  drivers/i2c/busses/i2c-xlr.c               | 11 +++++------
>  drivers/i2c/busses/i2c-zx2967.c            |  8 +++++---
>  drivers/i2c/i2c-core-base.c                |  6 ++++++
>  include/linux/i2c.h                        |  4 ++++
>  13 files changed, 60 insertions(+), 67 deletions(-)
>
> --
> 2.11.0
>



-- 
With Best Regards,
Andy Shevchenko
