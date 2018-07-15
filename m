Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F9FECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D4F2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ZEf3LBYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D4F2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeGPAPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 20:15:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42402 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbeGPAPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 20:15:08 -0400
Received: by mail-lj1-f196.google.com with SMTP id x12-v6so2758031ljj.9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 16:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=V8a7RIUNxJ6t9LXcvDhVeILFl41NRvi2NsTbJf8Z67E=;
        b=ZEf3LBYo7fjO8kF1Yqt8w0Tw9FEB2IJdxBjbn1cxK7XyKdAf9M7EE5cp/xg93RMVOj
         Tee/Bm7LejBe98b5+uQ/7o20aeDfr3X5x0Jn9+O6OLLEMWFe2vXGb6hWQQ6tWIeutLEJ
         gzDXixtsJLVp5wkQlSe2PPkkoGE3oTTUpi7/DjPGTnsit2utBzPtf0x98y40162Qx4zU
         Fql4ebtl/UFdhaxiaa3yjXkQPofmQmHXlrFIZ3HhzGjJvCWRbmZUPvHICR0SkJFKMgox
         BgHGfezwSndRal0K8+9+K9WyFknknjW7LQh1Us4bEYpH1SMX6T2x4eS2njzUqHFjhCzi
         mGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=V8a7RIUNxJ6t9LXcvDhVeILFl41NRvi2NsTbJf8Z67E=;
        b=nBAlLrMDu5/22ddKp/Zdl40T8T2R4ARGV6oW0ov1/Wa6NnBTTEOf+fRnP6eFv3Knf+
         2qq45EEC+IpnoAtSy3d3fEZnGGLmdnAtG5d1THqVWnBCr7YMjZi2zoX8POrXR3LYIrpE
         gw83SR3sl15HP1c/NTuIcKuaKnmmu/3sHWr3mwYCrh103HFOesRnyl4mRLhdkKBIC/Gk
         kKiL6mwNjv19kUiOb48OUYQJsteinfRjZg3hK7krMfWcIg1xAqgLdKhhEiBFu/Ek0srO
         4HpUpHljbce2Qo8qZ6F1mam1GgSmOkdgaBhqe+Vt4HI4JhNdogy24zmX427Vxs8paORJ
         PwaQ==
X-Gm-Message-State: AOUpUlGPzMpJHtN1CSUs4Te24wmKzJokFUiAq4XyKgqeaLfh6pQVZUAe
        00WwyvhG7LProqsqkBGITnhZ4sI9PJEh2tz66r9inw==
X-Google-Smtp-Source: AAOMgpde05L/IiKwU3FXiTOb4w6rNi+F50RUkE6ddfoWgxmq4xmzRJyUWuuNPV9fFC12FRUP5RP06FSUeg84yX5vTgQ=
X-Received: by 2002:a2e:8346:: with SMTP id l6-v6mr8984095ljh.72.1531698626567;
 Sun, 15 Jul 2018 16:50:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:fc1c:0:0:0:0:0 with HTTP; Sun, 15 Jul 2018 16:50:25
 -0700 (PDT)
X-Originating-IP: [2620:10d:c090:180::1:b025]
In-Reply-To: <20180716091337.6c1b2a4d@canb.auug.org.au>
References: <20180716091337.6c1b2a4d@canb.auug.org.au>
From:   Olof Johansson <olof@lixom.net>
Date:   Sun, 15 Jul 2018 16:50:25 -0700
Message-ID: <CAOesGMgicOOi0Nr+m_UHEGYL+ryRW65YAPwVsN+CZpo6kc2FLA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 4:13 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> After merging the arm-soc tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> sound/arm/pxa2xx-pcm-lib.c: In function '__pxa2xx_pcm_open':
> sound/arm/pxa2xx-pcm-lib.c:129:6: error: 'pxad_filter_fn' undeclared (first use in this function); did you mean 'dma_filter_fn'?
>       pxad_filter_fn,
>       ^~~~~~~~~~~~~~
>       dma_filter_fn
>
> Caused by commit
>
>   0d0b16b8e008 ("dmaengine: pxa: make the filter function internal")
>
> I have used the arm-soc tree from next-20180713 for today.

It's a known issue due to dependencies with a driver tree. :(

Robert, this is unfortunate. What's the dependent patches? We can pick
them up in our tree as duplicates if needed.


-Olof
