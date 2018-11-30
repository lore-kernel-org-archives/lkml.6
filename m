Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4CFC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FD62145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izC5STTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FD62145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeLADva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:51:30 -0500
Received: from mail-vs1-f44.google.com ([209.85.217.44]:37574 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeLADva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:51:30 -0500
Received: by mail-vs1-f44.google.com with SMTP id h18so3701907vsj.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 08:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UonJ2PnWAjB2Lr4NKEazI7qZi6rlUyiK/EF/W9x9mDc=;
        b=izC5STTHUztYtFKMkSv7/wO5b5Tr1Zbfu6oJP7vg4NFAb6p4e1GAi4tXTIMZiGRHH/
         chxM6JrdseicNOaOZA8RvgchVOcmLRW6+bh4B3k5Uit1hDUeX+yLsc8FtqiQRpdFGXDJ
         WPKfP3cT2oVSaoKkLtMtGQPV9naP3JDVlre9cEg4OqE7EN5XAwhqMsj7jD6stXvrntsl
         TG00dW3Uf9zQG91raLg8hVVAI5s3B3KxuCxNJ8duD6dua5fZmh8iu90TgL2Kmjm86qhb
         x9508U4PZAacoJAHSa8zaR8Ev4sGTI2iKfULc/L6K1ZH9TZNoK+R4PCRvUTTWRRlmNjI
         rXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UonJ2PnWAjB2Lr4NKEazI7qZi6rlUyiK/EF/W9x9mDc=;
        b=dWvgRp+eHb1ddX6AgvB2jL5wqVCPOAKfgnGy4hRHB3UrNAcFWyNa3h01Cdn8JzRSga
         rqD87KP1hWo42ibKAW/sSfkKUZJLRYjWguE08B5G2l45g2fCj1L4q8QrOULY+f+Ia8Ot
         5CnqEsRKcwZyQCrIboRm71RGlKej64PuDRePEuyJkNeKn4cR8jp4vJxvYk/mELlaoJEA
         SItwFTKLz2DWWOB/vNEUJqedcyTzeuF+L+0vS2k3riiKhZggvFojPNoLi7khQZiTkF/i
         Of19dJF49+NzByRghsRm/CMeYWvsMI+Qp3R7IEmBNjv9IJlvnnwaXsP9QXkH6aI+y6fk
         cLOg==
X-Gm-Message-State: AA+aEWYd14+UW2CaCL7G8TZXUfYpx4dtAPa2V+K0Mcn1Jl2yXHaR2I74
        eAgLTwPvbtoJfYNMN69/9tWP5evHzsnp1tri+cUUdMO7t/Ys
X-Google-Smtp-Source: AFSGD/WsmY4yrV/82QY40O4D53hrtZYVKpSFfy8oL4vbv0OOPMLVxFT566TTktCGjGesF/XZ3EaxdSYCtIPCy5O/eWA=
X-Received: by 2002:a67:87cf:: with SMTP id j198mr2591475vsd.104.1543596095487;
 Fri, 30 Nov 2018 08:41:35 -0800 (PST)
MIME-Version: 1.0
References: <CALjTZvZzHSZ=s0W0Pd-MVd7OA0hYxu0LzsZ+GxYybXKoUQQR6Q@mail.gmail.com>
 <20181130103222.GA23393@lst.de> <CALjTZvZsk0qA+Yxu7S+8pfa5y6rpihnThrHiAKkZMWsdyC-tVg@mail.gmail.com>
In-Reply-To: <CALjTZvZsk0qA+Yxu7S+8pfa5y6rpihnThrHiAKkZMWsdyC-tVg@mail.gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Fri, 30 Nov 2018 16:41:21 +0000
Message-ID: <CALjTZvbhNbKRZuwoAy5Uons_xfKcxOpA79=GZKsDs-Md8YBwsw@mail.gmail.com>
Subject: Re: use generic DMA mapping code in powerpc V4
To:     hch@lst.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christoph,

Your powerpc-dma.5 branch seems to be working fine on my G5, so

Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>

Thanks again!
Rui
