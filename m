Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74797C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEB02084D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5rkUI4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEB02084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeGCTkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:40:46 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33914 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbeGCTkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:40:43 -0400
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so6193445ois.1;
        Tue, 03 Jul 2018 12:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oXR9C7GQSrdHoFXBtg7p1TDo7nlCnV5Em+SD8AEnkkE=;
        b=X5rkUI4Xtt+zXXaF8hRHZBtSmPL4tQLSlyvN0FJOdz7BJlZHVJ0kWYPWsF9olfbvu8
         aydIYgbOBYGNBw+gsYMUZDw7PPzwYQ3c0FIQoT57EIEFYRrS33m7O0Blmn0fYnfNP1WD
         MYJE9ktGUqqKUjdpER3HWq7KTcT9zxo2cdNvTF8y0oC+BaLmXR6p1cUzZJAIcwxz4ZJz
         kxKgArfvP3t2dhrpNmAFEZzWRC99Y4EI75E47mem3jYcyO8BJttoW4xcUq4jIWiwsk5A
         YRq2QqynTvgehioUY4HDgU/tgeRFDorvcFkDO52M3n6ajtjp7f3qU/XZ0awHwZB4eAD2
         a0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oXR9C7GQSrdHoFXBtg7p1TDo7nlCnV5Em+SD8AEnkkE=;
        b=RslSj/Ymp3ydZHbDyoClvWbzd6QMNdYIBSyKb+srYm0C/JKldCIjeeOLWWp/doPxsv
         89bo1CvhlFQUQqrpufZe/fl1QjlW5YaYOQ7/8A/akhILGtLt6UNebdggvNRatU53HqV9
         PHXLV9Pb+BAQIgnNG6yMHAcjflFfDdjtUxV/lRGa0N/HCvXFVpBBypOghAEgfP4WvB+c
         D9RZ62U8HnS0iO3sNxybw9r0HbY31F++i37pkLY/GKVB5ai14s+8WIbqpjEUJlyvRH76
         jlz+txQgD00VUOqCmFFhUzqD8FV2425SDmGOII6mS37ob3/ZK7VkuqaHCD+ySj2u8xWg
         iPvQ==
X-Gm-Message-State: APt69E2VzpVEr/zzPG1GNo34dnqM8qzYxCiVJPF48IUlufbR08kGg0f4
        wcyyYVaF074ZC7+6kA9OnNMxBid6WoW4tje9t2s=
X-Google-Smtp-Source: AAOMgpcESqIYKzBKFGf4dDt21PihzTLaB59lP2SqthUenjwPBWcjiPuBH+Bs/y2KH1S15mh5zVJLoAvelpG+EqNRns0=
X-Received: by 2002:aca:4b0d:: with SMTP id y13-v6mr4228033oia.198.1530646842868;
 Tue, 03 Jul 2018 12:40:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 12:40:42 -0700 (PDT)
In-Reply-To: <6e5224b9-343f-990c-19bd-fe37c6fbdc9b@deltatee.com>
References: <20180622194752.11221-1-logang@deltatee.com> <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
 <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
 <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com> <CAOMZO5CfUfNZd0kG=VVnH4BjP+XMpGh3bPCUrTwi_4w6YEGX7g@mail.gmail.com>
 <CAHp75VcDudrwV4kRnVR+vtddFhxHsU672YqOJgPPchuLvPV3nA@mail.gmail.com>
 <CAOMZO5A4bsu9dXCPb4QeSbnnLi=pr1=WYWn8p2AfU3rEG=RWXg@mail.gmail.com> <6e5224b9-343f-990c-19bd-fe37c6fbdc9b@deltatee.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 3 Jul 2018 16:40:42 -0300
Message-ID: <CAOMZO5CJ_iG=p_+xL=Q_Rv3F5vtGggsgatar4XVTL+UFVnHBTA@mail.gmail.com>
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
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

On Tue, Jul 3, 2018 at 3:47 PM, Logan Gunthorpe <logang@deltatee.com> wrote:

> Ok, I'm at a bit of a loss... When I look at the assembly before and
> after the patch, it looks pretty much the same. Additionally, the
> function where the undefined exception occurs (caam_jr_interrupt())
> doesn't make any use of wr_reg64 or rd_reg64 which is the only thing the
> patch changes...
>
> Also, it looks like the nonatomic headers are doing what they are
> supposed to on this arch and generating two 32-bit ios and not a 64 bit one.
>
> So I have no idea what's going on here... Are we sure this is the patch
> causing the problem? Did you bisect?

Yes, I am sure that 46e4bf08f6388ba748 is the one causing the kernel boot issue.

If I revert 46e4bf08f6388ba748 in linux-next then I can boot mx6 just fine.

kernelci.org reports also confirm the same:

https://storage.kernelci.org/next/master/next-20180629/arm/imx_v6_v7_defconfig/lab-baylibre-seattle/boot-imx6q-wandboard.html

Thanks
