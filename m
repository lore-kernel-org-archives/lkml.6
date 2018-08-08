Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A452C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B711E2174A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLQ3E5JD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B711E2174A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeHHOS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:18:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32875 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbeHHOS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:18:28 -0400
Received: by mail-lj1-f194.google.com with SMTP id s12-v6so1519169ljj.0;
        Wed, 08 Aug 2018 04:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nY4S1fLrXBXnN/L/BkGkAvPh7zunDZ9Nidc5Hkaw5PY=;
        b=ZLQ3E5JDYn6mvBiX7ACtST/ug+ek+7WJEzgeFsS20OHXxBy5cVau0dGXB+lEJeR7KP
         u9qpZVA2ITs5DJgyrshsEGD8kLhJqGH9LOKIq0rB5CiMi8zGLcsK43o+1feJREY5FowM
         Qsz1wV3uqV/xbr/Hu0hL0RBCWjbPDx7mAzdQUU39FNyK8xHkFyPSJ3rwRuAKCjF3VA0L
         iIQO3yxpJGMlwbSe31yJ2kVXLnA376OInviukw7Gp+fH41apUyVJAS0EIpdk1K3zN05p
         njho3UTeqNMTME5PZtXwTZVPKyOpvxIyBX9XBmYhCVBnnYR8kBHG2fF+Ge8hJqPtM2Xv
         ZWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nY4S1fLrXBXnN/L/BkGkAvPh7zunDZ9Nidc5Hkaw5PY=;
        b=FG5ACPDqhZDqN3peiWlGGHWOrQVPFWEh3c/S4d+IOWcanC9jedRjDzFSIWyEzsiu0o
         EVuc09vZxjcTunvUOlOVItdfOnzy1iF0KnlYX9pzi6kb4w22I5IyftZtR/DlKnouxj/X
         jW9ptDUZe+bzsB3/6/7xvJZmagr6Uf8Gybo7Jjy8BwoW3gbAqDPyUy/JA32JUX/5JeXZ
         5D/V9gZtyYDnDRve17z1o/Etet3UAQkR6nLQmfUa6VlBpM7M791ljrtrGe+F7jc0fpUo
         bjuUKHVdeX+ScZUsR2xw9GQx/4vidC5ECGnZuMoaZKYWW4hrXi30Dn9xWzhTTsKariZQ
         f3/w==
X-Gm-Message-State: AOUpUlE/aHddpqZFLfTPCiL6ZZxxc4xL2x/X9fAQtBqv/Jky5BXrgIVJ
        P9U5LIFapa4/pAHHwnmywWyyLuDa0mzXIiXyG0E=
X-Google-Smtp-Source: AA+uWPzqjTqOLjsM1PVr/0mXs+GOJtkNhpxXprfjUwCgLV+n4H+8RVMRoY7oLvpb4ZkAJ1TlPlEfvNZeVKV9aS+ohFM=
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr2006106lji.17.1533729544509;
 Wed, 08 Aug 2018 04:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180808071421.32707-1-simon.k.r.goldschmidt@gmail.com> <CAHp75VdmrwZ4P0xrOOqpJaU7iuKS8zXGcRTg4zLrofZLdcb=8Q@mail.gmail.com>
In-Reply-To: <CAHp75VdmrwZ4P0xrOOqpJaU7iuKS8zXGcRTg4zLrofZLdcb=8Q@mail.gmail.com>
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Date:   Wed, 8 Aug 2018 13:58:35 +0200
Message-ID: <CAAh8qswXPmcT94x69qDmf8RumT4+uRBwQEvJSu9agaq_e7FH-Q@mail.gmail.com>
Subject: Re: [PATCH] spi: dw: support 4-16 bits per word
To:     andy.shevchenko@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 11:45 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Aug 8, 2018 at 10:14 AM, Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com> wrote:
> > The spi-dw driver currently only supports 8 or 16 bits per word.
> >
> > Since the hardware supports 4-16 bits per word, adapt the driver
> > to also support this.
> >
> > Tested on socfpga cyclone5 with a 9-bit SPI display.
>
> > +       if ((transfer->bits_per_word < 4) || (transfer->bits_per_word > 16))
> > +               return -EINVAL;
>
> > +       if (transfer->bits_per_word <= 8) {
> >                 dws->n_bytes = 1;
> >                 dws->dma_width = 1;
> > -       } else if (transfer->bits_per_word == 16) {
> > +       } else {
> >                 dws->n_bytes = 2;
> >                 dws->dma_width = 2;
> >         }
>
> Now these can be just
>
> n_bytes = round_up(8);
> dma_width = round_up(8);

I guess you mean:

n_bytes = round_up(transfer->bits_per_word, 8);

But that would yield 8 or 16 where we need 1 or 2.

Reading spi-imx.c, this might work:

n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);


Simon
