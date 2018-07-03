Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B27C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB6921EF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPFbYZf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB6921EF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753271AbeGCT7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:59:03 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:39254 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753048AbeGCT6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:58:54 -0400
Received: by mail-ua0-f195.google.com with SMTP id n4-v6so2013693uad.6;
        Tue, 03 Jul 2018 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OID+ZJRnIcyuzBVy+2MTTcNqwPvJS0+F7EfZHVQTp8s=;
        b=VPFbYZf5WSIE8RPqWLgUVo3MgnNce4CA/Fp98XfjFCfk/4muLpLXYsg5xD9kbosk1t
         ojnYDkKtGGe2AAYvc6FDYeOJvq0eZbTeLlZi0CjEGzJ+W2pRujYq7pa4HiD7hMk2G8A4
         hCfAN5JNiGtblQ4Jz/BwBnaNSiCAN5mxfp7vNTf3016VIdEYOHBDeM541dDywNl3+10Z
         wgSZ3yLESBdw46qEnk7oUVvKLhHQlSDFB7LBt+bUvoUCpefXj/wju0WRA0pK+hJ8iDat
         FVMplEiC4NjXTwNeLCUV29SK0wVDQDe0F4nYNbvn6QpnIlcDLqpujFxSbH/CaAHdEZgo
         Xu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OID+ZJRnIcyuzBVy+2MTTcNqwPvJS0+F7EfZHVQTp8s=;
        b=BzF7eijCNXM207KBDArHv2Awwfcms4W+ZBztGJLb0k2q2qJ+n6QFz6Esrovs4k+OUz
         /b+63Eo4roiBJj0XzjhVv01nwGMI1acCwr9JOq4RWioIZWd99gKrInwEjiRMDc78hz9L
         NM5XMYcUILkkBx59PD/SqA+z/IT1aXKkBexM5XnBcikinQ9HQnQXKxEQLu9miQJCxYyv
         rKQfmDQZxmOhtT7UVYvDXH0i8sSR8agTcIft5CQxmnC6qI9M5DIBtRQ4AxfYiczQoxZZ
         RM81oAIbwNrib2/hj4njqQzVFKupTar25//CXgRIfrzz5sm+OP7lJJ1TnB/N6vuoVJjD
         2zrw==
X-Gm-Message-State: APt69E2xw9q2RF44NWJkSwgjUUsKALwYb2GR4oywbUWOKCfVKR4eTW0j
        fCGO1YF/xnaNuYCUVpqaKE+CrcTu+cy4eb5SfnY=
X-Google-Smtp-Source: AAOMgpeLYgzrpUhRToJXUkdeFGAdIEYE4o/1NFgxBT9FoMf8Bn1SscYvu1Ic+zcp/F6dgvhZLHbDMYgQn8wbcypD57Q=
X-Received: by 2002:ab0:6037:: with SMTP id n23-v6mr18528048ual.28.1530647933803;
 Tue, 03 Jul 2018 12:58:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 12:58:52 -0700 (PDT)
In-Reply-To: <CAOMZO5CJ_iG=p_+xL=Q_Rv3F5vtGggsgatar4XVTL+UFVnHBTA@mail.gmail.com>
References: <20180622194752.11221-1-logang@deltatee.com> <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
 <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
 <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com> <CAOMZO5CfUfNZd0kG=VVnH4BjP+XMpGh3bPCUrTwi_4w6YEGX7g@mail.gmail.com>
 <CAHp75VcDudrwV4kRnVR+vtddFhxHsU672YqOJgPPchuLvPV3nA@mail.gmail.com>
 <CAOMZO5A4bsu9dXCPb4QeSbnnLi=pr1=WYWn8p2AfU3rEG=RWXg@mail.gmail.com>
 <6e5224b9-343f-990c-19bd-fe37c6fbdc9b@deltatee.com> <CAOMZO5CJ_iG=p_+xL=Q_Rv3F5vtGggsgatar4XVTL+UFVnHBTA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Jul 2018 22:58:52 +0300
Message-ID: <CAHp75VefGpNkF0ANA_wBm627aZXS60NPZ9VAdOYqr_iZ8Hvpzw@mail.gmail.com>
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

On Tue, Jul 3, 2018 at 10:40 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Tue, Jul 3, 2018 at 3:47 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>> Ok, I'm at a bit of a loss... When I look at the assembly before and
>> after the patch, it looks pretty much the same. Additionally, the
>> function where the undefined exception occurs (caam_jr_interrupt())
>> doesn't make any use of wr_reg64 or rd_reg64 which is the only thing the
>> patch changes...
>>
>> Also, it looks like the nonatomic headers are doing what they are
>> supposed to on this arch and generating two 32-bit ios and not a 64 bit one.
>>
>> So I have no idea what's going on here... Are we sure this is the patch
>> causing the problem? Did you bisect?
>
> Yes, I am sure that 46e4bf08f6388ba748 is the one causing the kernel boot issue.
>
> If I revert 46e4bf08f6388ba748 in linux-next then I can boot mx6 just fine.
>

Interesting...

> kernelci.org reports also confirm the same:
>
> https://storage.kernelci.org/next/master/next-20180629/arm/imx_v6_v7_defconfig/lab-baylibre-seattle/boot-imx6q-wandboard.html

By the way, is there any URL which contains dmesg out of kernel with
this commit reverted?
(It would be even better if we would have 'ignore_loglevel ' there
when CONFIG_CRYPTO_DEV_FSL_CAAM_DEBUG=y)

-- 
With Best Regards,
Andy Shevchenko
