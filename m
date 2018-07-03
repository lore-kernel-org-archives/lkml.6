Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9466AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB3320871
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px/y857I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB3320871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeGCWVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:21:07 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:39297 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753179AbeGCWVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:21:05 -0400
Received: by mail-ua0-f194.google.com with SMTP id n4-v6so2232112uad.6;
        Tue, 03 Jul 2018 15:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h3mKhskRCaw1EX84Uk6YynL5hDLKGgJkZVGW1kHIBEw=;
        b=Px/y857IF3oLbOBdeNYLe9jqxDqNNaLQr+uA+xHQAQxsCU6QWvaRjB+jQU861q1t/l
         N1kre3nBRKgvpFW9QTOik9T1S+rP8ijVWemraECMsPat61XwLx058rUjGyG2FMWGrqkf
         sGhhq16e4kFdL8PJvKHo1aJXjQZGo2yjOmvpdZIjfEKwOkBVzWDucVhIuDBH/2eG+KES
         QczeDVMjfwlvrohGb4zz2XwAZ2EN4e1sZxmZHhFhiTIgnGjEtAgHTdxWWF/ocJ7ZK/ZS
         eVS+i9OdCN/8NZ/LLX5wT75lTfubpklXOGRsR76wOKXDZNoZ+WHyXR083nHjlp79PVcW
         IBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h3mKhskRCaw1EX84Uk6YynL5hDLKGgJkZVGW1kHIBEw=;
        b=k4X+23eQQS+52ZjsJKZyMBeP7fi5GyYCZlJAqkI0v3zCbhB+DAchDgk7xlsrRH7sAG
         Ku1Ph9ddnHHMWdGgo8gTiYBb7bM//Vy1TFVRWe05SWAobC3gyEBH89lzqpqbm0obYFME
         wx6CQGBVdBTwzTr52yWuNZJF8Pi4nai/0heVAgX+EEi1P1bZ/57a7v3xEPgQiuv9459V
         mpk5m5NA/qQVD753QPSWnyWmaGyAx5NffoJaHVJjc+5eujkzitwNQQLJ6a9joII8GFby
         lSha/kNs2u5ksWf1bLJ+/ClR1sec7ckdLAxinjiqjqu3i3+e8AilVfeZJEfoEa4DNNCU
         8cKQ==
X-Gm-Message-State: APt69E2RQvm9aDneADY8BiTzvB9KYsaNFKEUCYRrym5Am8Bqd546GMl1
        TeA0tHBltOUvPsMtC63C/poGTqnHxfkrhtqq50g=
X-Google-Smtp-Source: AAOMgpcw0C4PmSHwx+yuQCvdPvPzeedIqpjTseu+JC3VYSjy9F2cdRRtMTkE3oY+dDW+e8TZXuNJ96B8v/9pk+knIvA=
X-Received: by 2002:ab0:6037:: with SMTP id n23-v6mr18816796ual.28.1530656464884;
 Tue, 03 Jul 2018 15:21:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 15:21:03 -0700 (PDT)
In-Reply-To: <7ddda181-6337-32cc-7a0d-43fc6a7ba78b@deltatee.com>
References: <20180622194752.11221-1-logang@deltatee.com> <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
 <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
 <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com> <CAOMZO5CfUfNZd0kG=VVnH4BjP+XMpGh3bPCUrTwi_4w6YEGX7g@mail.gmail.com>
 <CAHp75VcDudrwV4kRnVR+vtddFhxHsU672YqOJgPPchuLvPV3nA@mail.gmail.com>
 <CAOMZO5A4bsu9dXCPb4QeSbnnLi=pr1=WYWn8p2AfU3rEG=RWXg@mail.gmail.com>
 <6e5224b9-343f-990c-19bd-fe37c6fbdc9b@deltatee.com> <CAOMZO5CJ_iG=p_+xL=Q_Rv3F5vtGggsgatar4XVTL+UFVnHBTA@mail.gmail.com>
 <7ddda181-6337-32cc-7a0d-43fc6a7ba78b@deltatee.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 01:21:03 +0300
Message-ID: <CAHp75VcN=pUkFK6=_7yErMRGNS3WsgBhkWMSwP0Cw_ZmGR=RJg@mail.gmail.com>
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-ntb@googlegroups.com,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 12:20 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
> On 7/3/2018 1:40 PM, Fabio Estevam wrote:

> Also, it could be helpful if you can compile with CONFIG_DEBUG_INFO and
> use gdb to find out what line "caam_jr_interrupt+0x120" points to in
> your image.

It is an explicit call to BUG().
That's why we see wrong instruction trap.

-- 
With Best Regards,
Andy Shevchenko
