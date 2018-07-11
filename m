Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9C3C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 00:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACFF208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 00:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="E+Dr+98I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TdFwdBC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACFF208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbeGKAxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 20:53:42 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35130 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732263AbeGKAxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 20:53:41 -0400
Received: by mail-yw0-f196.google.com with SMTP id t18-v6so8556777ywg.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 17:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rQNkK2euIJPwF7BL7Vlmy5MsHJgcq4rywadMFS7vafU=;
        b=E+Dr+98I65HtMIFNGeZG6N4sHVplBSADU38AVk1mTPvVHlzlggtT2afubRI6+q3l+g
         txVJjgN86/Mog1BGg91CLbJ8FUcponUOLC0kj5JyqPrN+vDoxQpBvFyIYWz6hkaMK3RP
         rC4BXQRqjktBLMiCtMxhk49gBF7s8gHrwB39zeYQgjDrbreJErXXAH3oWYqOJuNvwyDF
         2+i1phKQSZBkrU7qi1ZT+2Xv3i9IS+iKzmFqm85JEs8FUcrpeC3sUX7lucEVKfzhMLii
         +QPmPksODEHvsOiZN5nxNEIYJBXHeDVWFdvzGrE1WMURmpcouQzN2RT0JqmPuxtpvvOP
         W9yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rQNkK2euIJPwF7BL7Vlmy5MsHJgcq4rywadMFS7vafU=;
        b=TdFwdBC5n+DU0eSXMnw3DQSFh6h1otiUFQj3EPVqsOQsWFsJY5bE9F7cK5VcOfHswE
         /OWpeGL1vz0cZDQt7aYo6nXNpzAROfeehgV9r5PF5o5+tHr1TOf974XLrTBoT31+jAxS
         CB1lRwNZMzhwEqqJKhplTUGTGQzwTIyuM0CVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=rQNkK2euIJPwF7BL7Vlmy5MsHJgcq4rywadMFS7vafU=;
        b=TC5G2TNKnvK3J1chRtGfX5rHSo5Wce6s4zRxS5Rnz5P4ZSnbRr59AO2sBhsYuXez4c
         HfT0Dcy8acq3aPSjgUrq8bp9T4jBtR3nbkXLbL554Kg2MgvCV0mD9qkBR0VCQKrzuEqk
         40Z5QdSXSLbkHR7OV6GUgGBVQG4Yvb3IZyuiJhJ+rGfJs29SJwTcZ7Q0COtNBa2ZoTWR
         2KpI64dwNZgAO7m4EgqodebZ4Qz1fk/KYIOOY0YDuno7XwznRkPZf4COZgxRwlD8Buz0
         CTG54M6bOBLSJqK2y7qr7la7M6IZPD+1RjxXAJkU+2rgkjYPkyLzowt3g8QvAsZagXs1
         Hnew==
X-Gm-Message-State: APt69E34I4dRr+74GJPFunV+f8K/1xmtpFzESjuHL3uEBNDk/FQKRXUK
        rGL4ZRpRG3Y7cVB+wdjJIIw6R3Clyc6CEnYOXIAt+Q==
X-Google-Smtp-Source: AAOMgpefgPTKZzoESL9p2O0xLO9cI/OLw/Ri4wxDKDM6ix58BDIpKJeTcgdQPIjuOOImEYLY/Fy2N9hvJe8RQR91m5s=
X-Received: by 2002:a0d:fa42:: with SMTP id k63-v6mr11218411ywf.53.1531270322619;
 Tue, 10 Jul 2018 17:52:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 17:52:01
 -0700 (PDT)
In-Reply-To: <20180627035642.8561-2-nicolas.pitre@linaro.org>
References: <20180627035642.8561-1-nicolas.pitre@linaro.org> <20180627035642.8561-2-nicolas.pitre@linaro.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 10 Jul 2018 17:52:01 -0700
X-Google-Sender-Auth: GHFFSOyqngg2t5JsXSoh4_Xa9RU
Message-ID: <CAGXu5j+KLvJ-n_QRrfq15E8iO_rqfpp+K7PDAZHZMHcemy9y7g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] vt: preserve unicode values corresponding to
 screen characters
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-console@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 8:56 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> The vt code translates UTF-8 strings into glyph index values and stores
> those glyph values directly in the screen buffer. Because there can only
> be at most 512 glyphs, it is impossible to represent most unicode
> characters, in which case a default glyph (often '?') is displayed
> instead. The original unicode value is then lost.
>
> This patch implements the basic screen buffer handling to preserve unicode
> values alongside corresponding display glyphs.  It is not activated by
> default, meaning that people not relying on that functionality won't get
> the implied overhead.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> Tested-by: Dave Mielke <Dave@mielke.cc>
> Acked-by: Adam Borowski <kilobyte@angband.pl>
> ---
>  drivers/tty/vt/vt.c            | 220 +++++++++++++++++++++++++++++++--
>  include/linux/console_struct.h |   2 +
>  2 files changed, 211 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 1eb1a376a0..7b636638b3 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> [...]
> +static void vc_uniscr_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
> +                            enum con_scroll dir, unsigned int nr)
> +{
> +       struct uni_screen *uniscr = get_vc_uniscr(vc);
> +
> +       if (uniscr) {
> +               unsigned int s, d, rescue, clear;
> +               char32_t *save[nr];

Can you adjust this to avoid the VLA here? I've almost gotten all VLAs
removed from the kernel[1], and this is introducing a new one. :)

Thanks!

-Kees

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

> +
> +               s = clear = t;
> +               d = t + nr;
> +               rescue = b - nr;
> +               if (dir == SM_UP) {
> +                       swap(s, d);
> +                       swap(clear, rescue);
> +               }
> +               memcpy(save, uniscr->lines + rescue, nr * sizeof(*save));
> +               memmove(uniscr->lines + d, uniscr->lines + s,
> +                       (b - t - nr) * sizeof(*uniscr->lines));
> +               memcpy(uniscr->lines + clear, save, nr * sizeof(*save));
> +               vc_uniscr_clear_lines(vc, clear, nr);
> +       }
> +}


-- 
Kees Cook
Pixel Security
