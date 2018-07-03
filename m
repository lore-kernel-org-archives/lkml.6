Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750D4C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2565B24687
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHeb9YmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2565B24687
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934413AbeGCSJd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:09:33 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:37297 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934195AbeGCSJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:09:31 -0400
Received: by mail-vk0-f66.google.com with SMTP id h22-v6so1650355vke.4;
        Tue, 03 Jul 2018 11:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U7SgZgDV5yVqZ4CgRB/awCFM2H6ibs3uFrqaI8KvcI4=;
        b=SHeb9YmDaMHBZJHvR+CSQUbOuZTCfUY9INTRuIQrbRYeNzPfgKIMA/1iaX8VaEcMI+
         KdeDjfl+BHHS64o9CcVRO6QpIXF5T7iaX+mJC5i0HfSSxE2Ms9H6sW7K61PHQVMf43TE
         D7jRDrtDg0XHz/BB6MRCInQyf6o0n83U/fjfhYsxJwG2vwzJQR1Ikg0QpVdavF7drUIo
         nPSQ+OHt1n/hT4y3C0uGS955Vtud5+bFgaSXapr0pKA9t2HXMZ7AUP9IkQIRGI7CSBPa
         gEYohnOk6l1SyQVNtSK4igAu6blYkHtHb6Kftx8c5Wx1tXMh7Ss1OP0eOFec944N3trV
         J62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U7SgZgDV5yVqZ4CgRB/awCFM2H6ibs3uFrqaI8KvcI4=;
        b=m6Ue7Jgo1GRUFxpGLgBuVtccsHwJxLCzod5Y9CBc52N5kODFIpQlO+IIxgRx+AQavW
         f8LsmWLK98Tx749zwxziVY+AVJjjjLWAe7M0xgWYWHRkKiU7+w2O0FkdTuZgdgzsZcoR
         kg3Yroj1Rm4RcLoaKIgShjIABQt52c94UChBArW7I0MAF3exZRSyS+YZ1/ZYYqSshz9d
         2Fd5qugvVXA/z93Yu5DVaqeMvLflPWf5TwjSAaSoASbqBF1XxRcthstORQpOJzY42WjS
         A/mBMNmcVdK4G3qEpmnzK0z9YHrV9lAqYqysXMxS/IevzbrBd1lWqJIieg6/HKeq5br0
         gTOQ==
X-Gm-Message-State: APt69E3opOhT/PAlKt6H1qyQ/SpHeZDMAEhXE5U+M6Un7/vZe6lCTJt9
        5ge1dONIPV3/y1CIRF6EXV6h3Er46nCF39kGuXA=
X-Google-Smtp-Source: AAOMgpfN2SmxT83GrGaVeDmMLCfoSGW8fuGxIntEbs83g481zHzNBnnLzz8wShw6RfZBwsvQ1SH23FDGANA1LzA7vHQ=
X-Received: by 2002:a1f:50c:: with SMTP id 12-v6mr17829127vkf.26.1530641370646;
 Tue, 03 Jul 2018 11:09:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 11:09:30 -0700 (PDT)
In-Reply-To: <CAOMZO5CfUfNZd0kG=VVnH4BjP+XMpGh3bPCUrTwi_4w6YEGX7g@mail.gmail.com>
References: <20180622194752.11221-1-logang@deltatee.com> <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
 <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
 <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com> <CAOMZO5CfUfNZd0kG=VVnH4BjP+XMpGh3bPCUrTwi_4w6YEGX7g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Jul 2018 21:09:30 +0300
Message-ID: <CAHp75VcDudrwV4kRnVR+vtddFhxHsU672YqOJgPPchuLvPV3nA@mail.gmail.com>
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

On Tue, Jul 3, 2018 at 9:06 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Logan,
>
> On Tue, Jul 3, 2018 at 3:01 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>> Besides that, it looks like we are hitting an undefined instruction. So
>> my best guess is that we are somehow now calling a proper 64bit read
>> when we should be calling two 32-bit reads.
>
> Yes, it seems that's the case.
>
>> Fabio, can you send your configuration?
>
> This is a imx6 board built with arch/arm/configs/imx_v6_v7_defconfig

Btw, what is the environment did you use to build it?
and what is the environment / make variable you supply (like ARCH,
CROSS_COMPILE, etc)?

-- 
With Best Regards,
Andy Shevchenko
