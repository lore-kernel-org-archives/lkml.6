Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE34C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC89D21E17
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbNulIfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC89D21E17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbeGCUKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:10:22 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40002 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeGCUKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:10:20 -0400
Received: by mail-oi0-f67.google.com with SMTP id w126-v6so6324853oie.7;
        Tue, 03 Jul 2018 13:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IXvYPAnlLB1ngAoz0Ak6DTuBNYHJX+WSuncYxPBbxqs=;
        b=CbNulIfS32GAS92j+zkj+nWRIL5PNbRqZdVQI4+PLZOAfkKAO4gwxU3qjJnPKykXYU
         VW9rVdz1nvEIchBYWSNA5b0U5tDZ5tuX8JpuYDUe302jDlo7tWRuxQnu9jSDaNwIoTNn
         GcPxppJGwU8Zqp/gHodEZg1aIKOc4BNlG7jBRqT+c3fu8UVSxc5xGDcX9+IMxQHzx8O/
         06JD2BEBYw4gUD4RwclauK6dhAeOs0EwqDB0Ox0cNiuGSTXjt8OJ2uZf3dQMPw+vkTIr
         DTb/HwAVClpWPXA+6osHsYyrE+PzSxUDc2QVgdxAziwrHSvpWiez+wcyu0HeJlZRFp7+
         Ab+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IXvYPAnlLB1ngAoz0Ak6DTuBNYHJX+WSuncYxPBbxqs=;
        b=IamU/Ownc+f4xGNKeRLFM6ncW3ethPF4y7iATnr/0ZIEuiYQrMlQrBj2rePlk7s14M
         AavNQxcMDc7yvYmguHh5Vm1gmJUXIVOfqOIqh94JOcU0sgRgmd+WVrr6mA5qprmi29cQ
         tz+7sGtCv1gC+TTy4mQgknV8r7J5EML2zGfRkGHCQheNLsYj4ggTBG78+IvV+WX9GAXO
         XB4JboasbpI9sjB0YJ5mMCVFkM3QVI/dgZAiKq7A0PNRXoTmLhO6AggqK5vvTbteQemw
         Q8oz6rKJCNG4HXjlcYu/2S8PP7kKNU4HVOkug5kxU4Iy0ffWuNqCWzPFCtia05LAycGC
         YCCg==
X-Gm-Message-State: APt69E3hb/6WnGlxovCWgiw1aOC7+TiZHK4tqbXU5F8vngL6gH1Z2DT/
        JoQ6+faCleG/PN88KsFiT0jE5gqPIHMnvG3u4iU=
X-Google-Smtp-Source: AAOMgpfw3lbAmKPLD+RTM6Cvjw/OMQf5UJoodJ3J/z1x3fXIWfifNDt7DFWlBISfXsHPSxRsEOs+im27PCk1Ywy8+sI=
X-Received: by 2002:aca:400b:: with SMTP id n11-v6mr23833140oia.44.1530648619495;
 Tue, 03 Jul 2018 13:10:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 13:10:18 -0700 (PDT)
In-Reply-To: <CAHp75VefGpNkF0ANA_wBm627aZXS60NPZ9VAdOYqr_iZ8Hvpzw@mail.gmail.com>
References: <20180622194752.11221-1-logang@deltatee.com> <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
 <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
 <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com> <CAOMZO5CfUfNZd0kG=VVnH4BjP+XMpGh3bPCUrTwi_4w6YEGX7g@mail.gmail.com>
 <CAHp75VcDudrwV4kRnVR+vtddFhxHsU672YqOJgPPchuLvPV3nA@mail.gmail.com>
 <CAOMZO5A4bsu9dXCPb4QeSbnnLi=pr1=WYWn8p2AfU3rEG=RWXg@mail.gmail.com>
 <6e5224b9-343f-990c-19bd-fe37c6fbdc9b@deltatee.com> <CAOMZO5CJ_iG=p_+xL=Q_Rv3F5vtGggsgatar4XVTL+UFVnHBTA@mail.gmail.com>
 <CAHp75VefGpNkF0ANA_wBm627aZXS60NPZ9VAdOYqr_iZ8Hvpzw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 3 Jul 2018 17:10:18 -0300
Message-ID: <CAOMZO5Ayn4ik4F3sWhTo9Q5DGHG6nuf71M3DLsM+heMi0TFjVg@mail.gmail.com>
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Tue, Jul 3, 2018 at 4:58 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> By the way, is there any URL which contains dmesg out of kernel with
> this commit reverted?

Yes, here is the linux-next 20180626 dmesg (which is the last
linux-next that does not contain 46e4bf08f63 and it boots fine) :
https://storage.kernelci.org/next/master/next-20180626/arm/imx_v6_v7_defconfig/lab-baylibre-seattle/boot-imx6q-wandboard.html

Thanks
