Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351FCC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D146F23C6A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+tbJn1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D146F23C6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752921AbeGDRWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:22:03 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:34106 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752251AbeGDRWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:22:00 -0400
Received: by mail-ua0-f195.google.com with SMTP id r10-v6so3857833uao.1;
        Wed, 04 Jul 2018 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j+6Sp+K9kUz8dK1lUhikjijSH30SNgaMDD/lO178fiM=;
        b=Q+tbJn1vzAw8F3IPO7Nfi8w4AjPZ/3aZHzzkpEg+ScHXDO2lC3z1ZaLOG4YhhGrltv
         m2xjFdHtjO3Z2NnYAXZKvMsgUxN7L39WZYIae97sSjer6PKYwN1nQDNh0HXKQ12HBuaT
         7BCzCW0hy9pcPFMOtsk248Okc8drbo+lf1jgqoqSElIDdKMGXXZ8rjvaNZCkpmIQ3OSI
         XWthsq05vNNSFUaE08w91gEywCzdf9/5jysRvo8Q7qmdwBuraY0uzWnHh/Jn76ZVW2Wy
         LURKhynQRotMm3BbOh/cmUFJS23ebYhvF/8L5Z7Fjot99LJtTQViJfBqJSwYduHsS67O
         IqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j+6Sp+K9kUz8dK1lUhikjijSH30SNgaMDD/lO178fiM=;
        b=inmQKAeWy4BV5ZOQZ1wz8HcjvW4qZmZUVZVL4yeNuqj7S+193+FUkKf3EWrdyMiBdZ
         FEy4E7DxpD7P4UviiVfVR7PJqqXFLXE4eiNTpRUGSZi3B5C8hCdwDeEzLhqD8+Dsah/F
         tkjzGU6+C4DT0xLd2wMDm43VS4QmQLJvIUmw7Cyveh+Rx96mlsr+0EV+TzGJaT1wmKiv
         lkwZIISR3WUn4VlXoAZJy8mOaT6t6dJpE9ow8zS0B8ZAPRUS5faoxUU1z3nSN+52DM5o
         F/nSuleojgQXkrf29mJBwoqI8TxoAQ8XE06AENEsZjvvBTRcS4SmStPVMQd22QumzruK
         3Apw==
X-Gm-Message-State: APt69E1KifUwK1Phyk5DPoomtARPobS07bWVSuSl9ztSjJADb5ja9YAu
        nmcN41z/2huRVip/zQOLHrsoEBBEkGmizM9hJ0RY2GKo
X-Google-Smtp-Source: AAOMgpcT0CW/ErcN5yM9kdppTDhw4fXmpnqvBvD+tD3zYiTRXHqmixpGlK6hWjE+aYke0udBHFMW6ESk8yuyz2aMznI=
X-Received: by 2002:ab0:1a23:: with SMTP id a35-v6mr1700047uai.47.1530724919164;
 Wed, 04 Jul 2018 10:21:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 10:21:58 -0700 (PDT)
In-Reply-To: <CAHp75VdtkYRWyKnD+wXo_Z_t=EK9dAOTFzbnHmraSt80sAmyHA@mail.gmail.com>
References: <20180622194752.11221-1-logang@deltatee.com> <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
 <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com> <CAOMZO5CfUfNZd0kG=VVnH4BjP+XMpGh3bPCUrTwi_4w6YEGX7g@mail.gmail.com>
 <CAHp75VcDudrwV4kRnVR+vtddFhxHsU672YqOJgPPchuLvPV3nA@mail.gmail.com>
 <CAOMZO5A4bsu9dXCPb4QeSbnnLi=pr1=WYWn8p2AfU3rEG=RWXg@mail.gmail.com>
 <6e5224b9-343f-990c-19bd-fe37c6fbdc9b@deltatee.com> <CAOMZO5CJ_iG=p_+xL=Q_Rv3F5vtGggsgatar4XVTL+UFVnHBTA@mail.gmail.com>
 <7ddda181-6337-32cc-7a0d-43fc6a7ba78b@deltatee.com> <CAHp75VcN=pUkFK6=_7yErMRGNS3WsgBhkWMSwP0Cw_ZmGR=RJg@mail.gmail.com>
 <991b2298-bb3f-dad3-c93b-b43ee5f372de@deltatee.com> <VI1PR0402MB3485F76DD56D221EB256B4F698410@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <CAOMZO5C7V4_SpXOcAz0KbGYScpos0HRD-aa-Zh_6M3p9EqLsLQ@mail.gmail.com>
 <55236e2b-a2a5-493a-5696-19c5926885b3@deltatee.com> <CAHp75VfCFdFh3eMpdpNYdNtbuVKG60PbUnYVsEbCrxP5pUZwMQ@mail.gmail.com>
 <bf8df451-ddda-8c6f-ad0a-bda7f7905f69@deltatee.com> <CAHp75VdtkYRWyKnD+wXo_Z_t=EK9dAOTFzbnHmraSt80sAmyHA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 20:21:58 +0300
Message-ID: <CAHp75Vfd2wcUV_dY5ns28+9aC32=OiVExuxOFu7ZjMU2dYuA4Q@mail.gmail.com>
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Douglass <dan.douglass@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 8:16 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Jul 4, 2018 at 8:13 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>> On 7/4/2018 11:10 AM, Andy Shevchenko wrote:
>>> We have an iDMA 32-bit hardware (see drivers/dma/dw/) which has an
>>> extension 64-bit registers where only one of them has a specific bit
>>> to "commit" the changes written to all of them. And by some very
>>> unknown reason that bit is in lo part which automatically means we
>>> must to write it last.
>>
>> And it supports both BE and LE? And in both cases it's the lo part?
>
> It's only LE for now.
>
> P.S. If you more interested in code in kernel look for idma32_fifo_partition()
> (While the bit is set in each of 32-bit part, it's actually present in
> only one place)

I think it doesn't contradict with what you are saying rather supports it.

I would expect to have lo-hi and hi-lo semantics done according to the
data flow, not to the address.

-- 
With Best Regards,
Andy Shevchenko
