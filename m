Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1D8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622BE217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZjxV36r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeLRXC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:02:27 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43102 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbeLRXC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:02:27 -0500
Received: by mail-ot1-f65.google.com with SMTP id a11so17315031otr.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 15:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HPWfb9iZ8afkmS02Ip8gNHzya4ERG1+2P7nPA00pPFY=;
        b=gZjxV36r5mTa/CGejfjpXjkX7eIGI9EMwlpiFYoM4/hpGUT/rmNd1hyuS/vhgv23XK
         7MKiYsCwKDq+u+KnU2CMRI4XciWsetw9Q8okiItyIa8E7X28yVuZaeRdGkLkh8UIsX6z
         G4jU+q21P51kCy4NIfFR2KaKOI8Lgk0NmdYVNGZNNb9d30V5fu4twxxzAqHyh76Dz3qn
         i+kYiGlh7a7Anvft1nAWKtvPe+9GbWJEm8roG2aTKwj3jkgXpJQBTv4mjVyukctri3SL
         BtXlnAeVURk9rrJXlekur4w+T3SZzfCQps5EM3XW+KXE3xnnf8TJhm1Ms7y+zI0eZ1PA
         RnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPWfb9iZ8afkmS02Ip8gNHzya4ERG1+2P7nPA00pPFY=;
        b=aVTD4pbv7lyPPpyRQebkMYcOFdkmIHc3geg3r04S4YxgOtZ9QDOKuWkEmDc6/syx4W
         THx4H4x8Y9Y4dLV7RSSfXZXxmsNihXLCIbu0ibDgsaPrJrsqe0TU3QuXGbm/ivekWo0i
         AOm7XyVC86Ig6mYY38kPtb5Q2VlB0Zkt43xxvL4LZ6eVMc0fw9VFvYs6RvJJu0UAluLV
         786jfZAJAI0gfRuavBmbROybdMw+Tk99AoT+n05ra7YFcomTLxf/V8vEbP1SSfJL/zXx
         09cHmeXKWDK5QThcOOo+ATyIlNCTrFZYxKO0RagvxIJgAdhjMTrTgIzNUrTPE59nxxgg
         lUog==
X-Gm-Message-State: AA+aEWbrthvQHNfaydEYK0y8Bl+clCoNkychUvNUJslLlDnHZ2d3Nq9U
        sSqFIxnw7W1DhPdzTkmLdkSOPWA8RfMcB4jIWo0jb3k2
X-Google-Smtp-Source: AFSGD/UbIJFTL3tABVg03qPHNft9dPHcxfJSBEMgTb8+PHUIEc2GTcn+xSE1E6krNVkFHvBBNtu2p2D8XP7bXBBnwUQ=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr14700563otp.225.1545174146552;
 Tue, 18 Dec 2018 15:02:26 -0800 (PST)
MIME-Version: 1.0
References: <20181218225824.20974-1-andrew.smirnov@gmail.com>
In-Reply-To: <20181218225824.20974-1-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 18 Dec 2018 21:02:21 -0200
Message-ID: <CAOMZO5DxThsRyT0Bnn8zDSw-yiHT-Bokcf0DcU0mx6gu+VgzJA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: eukrea-tlv320: Do not enable on ARM64
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Tue, Dec 18, 2018 at 8:58 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> ARCH_MXC is also used by i.MX8/AArch64 SoC, building the driver for
> that platform results in:
>
> sound/soc/fsl/eukrea-tlv320.c:28:10: fatal error: asm/mach-types.h: No such file or directory
>  #include <asm/mach-types.h>
>           ^~~~~~~~~~~~~~~~~~
> compilation terminated.
>
> Since the code in question doesn't seem to have any use on i.MX8,
> disable it by adding a !ARM64 as a dependecy.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>
> Sorry for the noise if this is fixed already.

Yes, I sent a fix for this and it is linux-next already:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/sound/soc/fsl/Kconfig?h=next-20181218&id=add6883619a9e3bf9658eaff1a547354131bbcd9
