Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01B6C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B068206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFiCRi7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B068206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeIDXkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:40:09 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46493 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeIDXkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:40:08 -0400
Received: by mail-qt0-f196.google.com with SMTP id d4-v6so5258073qtn.13;
        Tue, 04 Sep 2018 12:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrZdGzLPH5mBKUfddqlukNyOO8LIcMikIV/ZtArR3Iw=;
        b=dFiCRi7Xqni3+D5/Y20jbAzvVC12zbhZ8Ug1vS3s03B1ErZTds4qM6A8zxHB0GDLE6
         s1KZH5/9L7txrXvaZeUh5xfkwLU1CBCAJlsSG5zlPj8QS36Lqhkeg0ohdaGs1y6AOoKH
         nrykxz3NoAdhB6155MXTKxIOQOVO/D8n8SoGBJhuAwULR2HXrTupyle1qMDrlzBIz67b
         0Qch/GfHP9CVAbIhqSbyTHSpzS1K8MKK3nPsTOLnIvZvurquv0vQ/zMw+33msIq+k5kb
         kWWvZgZTnRivLzvjqwURQmwSVPZAP/qG8phia1oTQi0ZL47k/hBR4a0olFgDqm8UCjOJ
         ExBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrZdGzLPH5mBKUfddqlukNyOO8LIcMikIV/ZtArR3Iw=;
        b=V1vDvMvEc49IkUYZupgH+b83gPQVMPJPgD510z9QQhpaxTmponWcLL1ImY7mpKYn0v
         3zm/zp3WxWF7zF7arTgwk3oRYBVy6kZOB/Dp7/D4HS3YOpUuT5Gl19dPrWkt0Hm8QfAv
         BN3jx0H7QPoWjf6dJVLBOpGGk9pFzmJvMIQIu9fNiEgQNIcTPwA+O8I/WjZNNdpNfLGF
         BX0ZZ5lSu0O1zlSjAnMPxcsicsJd3ht+ePxlkajuv4n0RCSguWGHrmpcwiLZOM0DQLkL
         9qXV0TvCjZ5kxo6Dy0h9r8pghXfauBZZFpz0P39wv068xewUOVE0qpVkPqou5WcMd3Df
         4a0A==
X-Gm-Message-State: APzg51AqWxoDICPUzAVSZLpNGPJStOJvlxCrJCOIewUQ1pF98j0tZXAP
        MaEDc0BbDXNd47H7wduQnnjWztzB0eGDlBDvO3mPt+D4
X-Google-Smtp-Source: ANB0VdYHZgdpv5yaDQbMDMFZ3cIbG3xjFZdg4q9QuvjbGOO2A7sw2VBeQv8SUZJd/M0jbWDs4h0/SlcZoHhPwsRTamo=
X-Received: by 2002:ac8:35b7:: with SMTP id k52-v6mr31820456qtb.141.1536088420005;
 Tue, 04 Sep 2018 12:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180904200434.10442-1-afonsobordado@az8.co> <20180904200434.10442-2-afonsobordado@az8.co>
In-Reply-To: <20180904200434.10442-2-afonsobordado@az8.co>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Sep 2018 22:13:28 +0300
Message-ID: <CAHp75Vcki7T4d00CFGDSvkAg27wxAO5xnXaX7g9V-N3MzxNrSg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] iio: gyro: add device tree support for fxas21002c
To:     afonsobordado@az8.co
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 10:06 PM Afonso Bordado <afonsobordado@az8.co> wrote:
>
> This patch adds device tree support for the fxas21002c driver, including
> bindings.
>
> Signed-off-by: Afonso Bordado <afonsobordado@az8.co>

> +#ifdef CONFIG_OF

> +#endif

Please, remove this ifdef...

> +               .of_match_table = of_match_ptr(fxas21002c_of_ids),

...and do not use of_match_ptr() macro.

This prevents to use device on embedded ACPI enabled devices,

>         },
>         .probe          = fxas21002c_probe,
>         .id_table       = fxas21002c_id,
> --
> 2.18.0
>
>


-- 
With Best Regards,
Andy Shevchenko
