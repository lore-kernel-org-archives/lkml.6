Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497B2C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E80A21855
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSRqbbJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfAGVP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:15:57 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45406 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfAGVP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:15:57 -0500
Received: by mail-oi1-f193.google.com with SMTP id y1so1541944oie.12;
        Mon, 07 Jan 2019 13:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sRmuTc+Q8QTezs6E65fSI39xViVpSu9NSinUik62B9w=;
        b=oSRqbbJFXbjEuT6yPOdC9/a3xPcRnojaY7xaa3aVN3LlePGTdaSG54pWQBm/oQrZgJ
         4QvxeU251SVk1Vo52xHymXv8uFR16m5X+g1AbXvr0hYZcROUfKxlJ5GxEZcIkQLsFhVY
         8O+Svgra2Du3wajiS78jfN/qEOr3Uj22OXr4IHZSsfEa/Cf9wjcjHfJ3nTsFyLM3wRxv
         eo6y/AdFd1VNCHx7Oy8ktgQXbMAyf2GJUtt50SgY23y9oAilalWpkr4Yd5MCKoQU49Dx
         daYIGjWGJYsc52e3T9XK0wfFz3ystf2BsVuNUXaRW4ZcuqwAgSk0Cadmmf/lqOtEkET7
         9AUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sRmuTc+Q8QTezs6E65fSI39xViVpSu9NSinUik62B9w=;
        b=qepQKEYemVw8T7ZDKZRUACIre7H8E0FZjC796mBfvneYsih0aHhOy7A8eRVSVs6RrT
         hn+5cJa0UknnQmgoMynCbZEjKfrn+o5kaZ0KHlAgrHakvHM2ySKY9UKIdrb0KFRYLW/I
         ChjimxSM0GVfCkx5lOE+dZIuyvU19U1pfkNZBLq6dLOMGs0d+SrmP1nauGhcLSikseiT
         RFtAqROn37cVsJsqBbFpI7Mlviv8Bx+s7PzLr/AJ798bjVjifAQ5zUlr5QvOs2J7XE2w
         d9/i34jXW5pvobnE5qOQhoL5a+31UZB5XlNBEBpjTJBw1K3RpBv+Afe988NePN1emoTL
         Rguw==
X-Gm-Message-State: AJcUukcRwzc0PSXbX+HiwLHcuzpngZVHcInEde4K7Ij5LANjk1OpBqOX
        lv4PeD51dXw3TweFCX9ssaoc1nsgyfjI3j3cjtA=
X-Google-Smtp-Source: ALg8bN6fGlCfKszXv9C7G3jNY0EfpdTpjBIxOi6zzcuyThESah/oZK6JCowE0eJKU5SQ0adNewVCZ+BvS2pjn80Zpcs=
X-Received: by 2002:aca:3345:: with SMTP id z66mr9446112oiz.91.1546895756370;
 Mon, 07 Jan 2019 13:15:56 -0800 (PST)
MIME-Version: 1.0
References: <20190107105330.372621917@linuxfoundation.org> <20190107105336.765968953@linuxfoundation.org>
In-Reply-To: <20190107105336.765968953@linuxfoundation.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 7 Jan 2019 21:15:20 +0000
Message-ID: <CADVatmNmc1mkcaJ4wKjufFcTwE_6=iMUTR811Gdcop9y0_LLVg@mail.gmail.com>
Subject: Re: [PATCH 4.14 069/101] spi: bcm2835: Fix race on DMA termination
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Frank Pavlic <f.pavlic@kunbus.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Greg,

On Mon, Jan 7, 2019 at 1:15 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Lukas Wunner <lukas@wunner.de>
>
> commit e82b0b3828451c1cd331d9f304c6078fcd43b62e upstream.

This has been fixed later by 29bdedfd9cf4 ("spi: bcm2835: Unbreak the
build of esoteric configs")


-- 
Regards
Sudip
