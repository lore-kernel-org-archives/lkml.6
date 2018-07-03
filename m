Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1036FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C2F23DF1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WB2NR+Kq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C2F23DF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbeGCUkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:40:04 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:38191 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbeGCUkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:40:02 -0400
Received: by mail-vk0-f68.google.com with SMTP id b77-v6so1883470vkb.5;
        Tue, 03 Jul 2018 13:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Lkz0lhyO++gyonTUc6mhLRo6vsDFV7xUhH17a3fpTAE=;
        b=WB2NR+Kqh8LrljfxntRw20s05hfrlkKhPDNBgHL5g61j6A/wiwXwMFvBHCw9Dm08iS
         dhBf1k7D4wKokRN+MRcaExXHOvRbIfG88SIMO2OgluI/CPc48UuPB+mfjS/xPr03ZeG+
         lh5gffmuXJlBKqrlU5kJryJSZzpVFD8mTRlThqARTZktweVEUeqF1s3ueZTCn9yssUOq
         VMwhslEXOG8pcLAmY/5FJbbfWP7YHY24gS6tXnmN0E5W5CX7pQHFV7aVKmZ5a44H9yU4
         4JpSRlDS0YeETc8r5l5oNNGt76V7P7sct8B7pBW5P5R2YkpPhCV046FL88Wq72f72d6X
         yfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Lkz0lhyO++gyonTUc6mhLRo6vsDFV7xUhH17a3fpTAE=;
        b=NcaAFTikKISYRt6wbYwCUFjU+PFBavScLIwB00izefbkfEK7XWpvGV3KfRMk2GpDLm
         rPBjyHcG08LMJCujXtT6XblVIhDjOZQ4rrOUjEz1xZk3uNM1bjMrZLxLbavcOB/JwD4d
         eRY0wcUiBzll48IWGQQExKmmOATAa6QmBI7GDp4pVzJiyfa4trhId8Y4UHaXIAScbHkn
         +0z9oR7ippbIGs1g3zunBJp1Oa6FTURCPJL9y3JdKzawNJP1fHWuqbuIlcaLjhuXwYyN
         3El775beiNB3Lo4XqMtT1nEeELcpKn1+q+BCsEygO6Xw0d16NBLUx/S1ug1B5QQ2bZoI
         taDg==
X-Gm-Message-State: APt69E0TYkaIO/PBCzH5aSdpYl1cGy5hgohjE2wxh4UuBSy8H4sbJxgP
        rjwgzNtxFE0P2TCXUEtAMADCECzQyd6AZBci6kA=
X-Google-Smtp-Source: AAOMgpfM6OdhTDipG6e3hmGalFSWhuGBSj5Xm+LngOPDakhq9P30yp2bE59Fo7pToWBHZdjA84AQHc50JnE1wOa+KH4=
X-Received: by 2002:a1f:6dc4:: with SMTP id i187-v6mr4005881vkc.131.1530650401107;
 Tue, 03 Jul 2018 13:40:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 13:40:00 -0700 (PDT)
In-Reply-To: <CAOMZO5Ayn4ik4F3sWhTo9Q5DGHG6nuf71M3DLsM+heMi0TFjVg@mail.gmail.com>
References: <20180622194752.11221-1-logang@deltatee.com> <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
 <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
 <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com> <CAOMZO5CfUfNZd0kG=VVnH4BjP+XMpGh3bPCUrTwi_4w6YEGX7g@mail.gmail.com>
 <CAHp75VcDudrwV4kRnVR+vtddFhxHsU672YqOJgPPchuLvPV3nA@mail.gmail.com>
 <CAOMZO5A4bsu9dXCPb4QeSbnnLi=pr1=WYWn8p2AfU3rEG=RWXg@mail.gmail.com>
 <6e5224b9-343f-990c-19bd-fe37c6fbdc9b@deltatee.com> <CAOMZO5CJ_iG=p_+xL=Q_Rv3F5vtGggsgatar4XVTL+UFVnHBTA@mail.gmail.com>
 <CAHp75VefGpNkF0ANA_wBm627aZXS60NPZ9VAdOYqr_iZ8Hvpzw@mail.gmail.com> <CAOMZO5Ayn4ik4F3sWhTo9Q5DGHG6nuf71M3DLsM+heMi0TFjVg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Jul 2018 23:40:00 +0300
Message-ID: <CAHp75VepHb5BaGmB_2eBmMrmyeAAOih9GE4E34s49gDbvKskgA@mail.gmail.com>
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

On Tue, Jul 3, 2018 at 11:10 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Tue, Jul 3, 2018 at 4:58 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>
>> By the way, is there any URL which contains dmesg out of kernel with
>> this commit reverted?
>
> Yes, here is the linux-next 20180626 dmesg (which is the last
> linux-next that does not contain 46e4bf08f63 and it boots fine) :
> https://storage.kernelci.org/next/master/next-20180626/arm/imx_v6_v7_defconfig/lab-baylibre-seattle/boot-imx6q-wandboard.html

Thanks.

And here just a wild guess, if you comment out a BUG() in IRQ handler,
does it boot?


-- 
With Best Regards,
Andy Shevchenko
