Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE8EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6329423DF1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqCsnaxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6329423DF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753064AbeGCUmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:42:35 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:37375 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbeGCUmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:42:33 -0400
Received: by mail-vk0-f67.google.com with SMTP id h22-v6so1888396vke.4;
        Tue, 03 Jul 2018 13:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nE2VyK+IqCv9plnZ54JuQrbq/Ms6Cbv3w5ceCvxdDq0=;
        b=YqCsnaxVCwrC5HsNkcPJAseekOy4OdHkE+zqn5OF9UIkYn6XxAqIGEHoJDCwwZO1It
         5xM6/7fIhpIXO5M0PuHF1qcp28lyQJHjA/6LhpZueujooHhMfriBlOr5skLK++xcFr7r
         YueSIfdJGef3dNeVhIG8dQNuO9EFZyaExCUxDKX9ZARIllvhY6+tm8cUyv2GBcuwGuIa
         ZJgniTiGHAQXiocMafY6CgPIVLdM4ercUwOgEBiLIFJZzdXnnTvfH7xcUj2YTQgRkWY5
         mL7B4V7EWnRTl38JHGa/YpvhGy4nbyIWiCxligWlIZG9AGscMnQdpe+dyUZcIXork2ye
         eV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nE2VyK+IqCv9plnZ54JuQrbq/Ms6Cbv3w5ceCvxdDq0=;
        b=ABLfSRIxns65TWHg3Neh2cqAjhSlPl60OxZzwXZL2kDXwDUP1Dgf9O6WVKs7kl9PV3
         Wek+tTE5usX/OXEYJmxSP5wEdsTQPZnx+XkUmYof2BaW1+OAU0WYbvnpVS2dvzlvjT9o
         SVVg3N5V/Nx9l3mCXo+BUPzn5yS1SdfQDJyUlExxukfDzE58z+el9t2aAmJ81XIbBq8c
         sFMpLY8/cMMmjCcM1G992cd3Kr+Ic7YPbTXIaA6CbPLyfoPViFUTUMN2QCTu2RzNekP0
         WahllS5ST7nAk4STDzXuq7Www+/jAWM+yNUle2yWecYbFgPLxSJfe+ZZW7Q1PZsJEUfy
         +9Sw==
X-Gm-Message-State: APt69E3t2r0xzYZskHlBdXRLkRdwZwv/vFzuOnarfMPeZbmA2ryrftVw
        hK1Xh8G6OeSVditB7AvtCKHTtBnx1j/+YyTx8P8=
X-Google-Smtp-Source: AAOMgpeVQxM1ZKLB/Z4nvy5EU86n/xVYqNyRVN35dr8A7wfRBHNOkUcAL2pHllNGAYihHjEBxyjGP7A50VZPC3pbbeg=
X-Received: by 2002:a1f:6dc4:: with SMTP id i187-v6mr4010504vkc.131.1530650552590;
 Tue, 03 Jul 2018 13:42:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 13:42:31 -0700 (PDT)
In-Reply-To: <CAHp75VepHb5BaGmB_2eBmMrmyeAAOih9GE4E34s49gDbvKskgA@mail.gmail.com>
References: <20180622194752.11221-1-logang@deltatee.com> <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
 <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
 <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com> <CAOMZO5CfUfNZd0kG=VVnH4BjP+XMpGh3bPCUrTwi_4w6YEGX7g@mail.gmail.com>
 <CAHp75VcDudrwV4kRnVR+vtddFhxHsU672YqOJgPPchuLvPV3nA@mail.gmail.com>
 <CAOMZO5A4bsu9dXCPb4QeSbnnLi=pr1=WYWn8p2AfU3rEG=RWXg@mail.gmail.com>
 <6e5224b9-343f-990c-19bd-fe37c6fbdc9b@deltatee.com> <CAOMZO5CJ_iG=p_+xL=Q_Rv3F5vtGggsgatar4XVTL+UFVnHBTA@mail.gmail.com>
 <CAHp75VefGpNkF0ANA_wBm627aZXS60NPZ9VAdOYqr_iZ8Hvpzw@mail.gmail.com>
 <CAOMZO5Ayn4ik4F3sWhTo9Q5DGHG6nuf71M3DLsM+heMi0TFjVg@mail.gmail.com> <CAHp75VepHb5BaGmB_2eBmMrmyeAAOih9GE4E34s49gDbvKskgA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Jul 2018 23:42:31 +0300
Message-ID: <CAHp75VcRqKhPm-jEVNP5GXAEQ4Z0b1x6rco26-m79WhwzvbFvQ@mail.gmail.com>
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
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

On Tue, Jul 3, 2018 at 11:40 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jul 3, 2018 at 11:10 PM, Fabio Estevam <festevam@gmail.com> wrote:
>> On Tue, Jul 3, 2018 at 4:58 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>
>>> By the way, is there any URL which contains dmesg out of kernel with
>>> this commit reverted?
>>
>> Yes, here is the linux-next 20180626 dmesg (which is the last
>> linux-next that does not contain 46e4bf08f63 and it boots fine) :
>> https://storage.kernelci.org/next/master/next-20180626/arm/imx_v6_v7_defconfig/lab-baylibre-seattle/boot-imx6q-wandboard.html
>
> Thanks.
>
> And here just a wild guess, if you comment out a BUG() in IRQ handler,
> does it boot?

One more thing, on the working version can you print the value of IRQ
status register?

Something like

pr_info_ratelimited("%s %x\n", __func__, irqstatus);

-- 
With Best Regards,
Andy Shevchenko
