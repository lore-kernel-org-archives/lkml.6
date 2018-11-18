Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEE2C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D58D20815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ynES27Hd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D58D20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeKSH7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 02:59:43 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33900 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeKSH7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 02:59:43 -0500
Received: by mail-it1-f195.google.com with SMTP id x124so5781624itd.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 13:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BxQfJW2kQdDn9A8wc85LDvFA3SC8nq6Od4NzrYEAoJQ=;
        b=ynES27HdNbD0PVHV7e69Z6p+PkDuc3Z3O9gikWL42ver/F7A+g6u2hZMRjufdP7dCe
         cs4RL2LRIRynYY4zOPoIo7SU6BFAoFzjR/By2L+BUpgQGqbMVSgiQnNx/3oMWjmZOlzp
         WpDy1x1a45njNNjwaBpgE7n861BD2GhnBQxOGXg6ECn7fKT6X9lamyepvTOji12OxXyU
         Bb0Bwfd6lZB8CZvngiaUbGma6MCc1vgFFiiSMRHh3qFdMGzg737BZUW4M7zjjAFsLGB0
         oH5LRN9QLjL5/jMdFy07SDZK4lB2SCU18Ta09viWiGTchdPY7U6fTMO/7edvQ20jBBmc
         Vx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BxQfJW2kQdDn9A8wc85LDvFA3SC8nq6Od4NzrYEAoJQ=;
        b=e5Xk2sEo0MtrfeQyw+kbgVnLxzWfcejqa2Zb7Iu0GneP/NxW2X1BxUlF3HCubDFJs9
         6hQZEF6OjLviAqeiGk86tDAnox9wIzEe+hascYzdlD74OuFq0BeXmP3NOaqIXFl2Tjvt
         U/Xx3wqqDRRLDp0WJ/9BlKUUSTB7QjmTw9qhIWd+wRK67UHutAFPB5i78Cz6QZUxq4f2
         YNQ7Q264gKhNCVdX/K0He30tlLRxfKe5sCMAsA8FC5unhNglKy0de6+JieFzipTyV1tb
         /A18iMcrWCTG2Yk6OcpxcKPBMHwrAjBBRiVcmuPw2b4LI6TD0CS5ctFxROUzW7aFlTZQ
         TPNQ==
X-Gm-Message-State: AA+aEWbns5yKn31fPc9dqOH0WhT+KJAB/csMhWt2EnCGty1pxV6BovjD
        32BXfBTx4JRiPrUV1a7mkDh9PdVI46sdOySS4Va2/Q==
X-Google-Smtp-Source: AFSGD/VEIjaT9N/As1AsNw4gk8J1eUCLRva679IbhP/2U4zsXGR6nh3xazg3mo0p+3ZqZBKyy+rWtX6gWNN51bkCooo=
X-Received: by 2002:a24:28d2:: with SMTP id h201mr2453929ith.136.1542577096014;
 Sun, 18 Nov 2018 13:38:16 -0800 (PST)
MIME-Version: 1.0
References: <20181118123504.83082-1-tmaimon77@gmail.com> <20181118123504.83082-2-tmaimon77@gmail.com>
In-Reply-To: <20181118123504.83082-2-tmaimon77@gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Sun, 18 Nov 2018 13:38:05 -0800
Message-ID: <CAOesGMjUJ1+qmbPWcVFm1F_F0fcdg-54YY6o4iK=PYWoAuEczA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] spi: npcm: fix uninitialized 'val' warning in
 receive function
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, yuenn@google.com,
        venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, Joel Stanley <joel@jms.id.au>,
        linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 4:36 AM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Fix uninitialized 'val' warning receive function, send function
> has been modify to be aligned with the receive function.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  drivers/spi/spi-npcm-pspi.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
> index 6dae91091143..f75df49ab84e 100644
> --- a/drivers/spi/spi-npcm-pspi.c
> +++ b/drivers/spi/spi-npcm-pspi.c
> @@ -199,11 +199,11 @@ static void npcm_pspi_send(struct npcm_pspi *priv)
>         wsize = min(bytes_per_word(priv->bits_per_word), priv->tx_bytes);
>         priv->tx_bytes -= wsize;
>
> -       if (priv->tx_buf) {
> -               if (wsize == 1)
> -                       iowrite8(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);
> +       if (priv->tx_buf && wsize) {

In general, doing an early:
        if (!condition)
                return;

is a pattern we prefer in the kernel. Setting up the assumptions at
the beginning of the function makes it easier to follow the code flow,
and saves a level of indentation.

It's a matter of taste though, and this function has only one level.
So, either way is OK. Just mentioning it.

>                 if (wsize == 2)
>                         iowrite16(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);
> +               else
> +                       iowrite8(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);

I think this is broken? If wsize is something else than 1 or 2, you'll
do a one-byte write but advance the buffer pointer with a different
amount.

It'll be fairly tricky to debug if this ever happens (it shouldn't,
but still). This is why I added a WARN_ON_ONCE() in my patch instead.


-Olof
