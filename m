Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032D3C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F7C20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb94SRN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F7C20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933191AbeFUMrj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:47:39 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:38149 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932858AbeFUMri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:47:38 -0400
Received: by mail-io0-f195.google.com with SMTP id l19-v6so2858297ioj.5;
        Thu, 21 Jun 2018 05:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hvzDsKxin4vnkbTjTGy6XIx+pGZpsF4YJVBlda2P6c=;
        b=jb94SRN0NjnXBz/20B1f++MQfvk9lMEYDGvEXTD8OwsJmzSOGyVP82t5qAgkhNgjd1
         SjoWOPaAXm/S1v02DJ+rzRrSRLtrPvShcdB1ITJMl8qqcWRUYjq4D9GwWX1pK0MuGgUv
         XuhAhzLJgy7JPO2/qkE9H1EEiLqdGURQN6o7CY4D6sdZdoqyibArd6Efg5sQmGDKzJLt
         saE5+2zmxz2SgPRldGElcorIMYJgNJvUBJYvPG114fceMZhVKCUyXnShNVwRLZsYcJFX
         5q815yXINlDrdSvmbOW/aGdh9zEnxtGipMv3iPEmzIuV0MJCzaIyZOQjrZN+SJMxDC4C
         t2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hvzDsKxin4vnkbTjTGy6XIx+pGZpsF4YJVBlda2P6c=;
        b=OlEapcKtUmXbdEpKAFQR4F2tgKOwe+OY+PqqdWXEbjHgplYAncs0IXG33pxLbf8hER
         NrVciZy+jTofBkA4ocvEoAlhJ7y3I43ztS77bYZDj9lfdApoUZcXnvNsNTHpb/VKQ1+u
         s3jFyVy9QQ4ywbGFhlh5UHjpCp1+6F5Igi0qE+xYKbdcsLTKuWpa0KBXfCNXS7lGKzRO
         W1xcwx49A7wevh9KnGAKN44th9VTYu9bekd+7JAP7Ez7dQu2d7TsADiMVI6Vz7y2qqnV
         UXS2Fs1+HRTKc5+7o4eojVOznldWQLAh1VhebiryEDld5q9F0smFfADjhRkXJBEgWZFN
         4/sQ==
X-Gm-Message-State: APt69E3p8x8RJmEc3ItlEC0uNVsNxzk18jTsjpdUN9du51FMoEiIkggL
        7ftpDu9zRCHV5S+/0K6zBfJFHzZWKL2AWbIW3Bw=
X-Google-Smtp-Source: ADUXVKKAYahJBPtFC0xAuMOmp8Vq90hMHteNyIP6u+gfksgIuW1ViDRG0plSEsmI7FOiFJA4u6or0cxbnocc1diRSu0=
X-Received: by 2002:a6b:e4a:: with SMTP id 71-v6mr19874626ioo.83.1529585257209;
 Thu, 21 Jun 2018 05:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
 <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com> <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
In-Reply-To: <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 21 Jun 2018 05:47:25 -0700
Message-ID: <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
Subject: Re: [PATCH] usb: chipidea: Fix ULPI on imx51
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Peter Chen <peter.chen@nxp.com>, linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 3:22 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Wed, Jun 20, 2018 at 7:07 PM, Fabio Estevam <festevam@gmail.com> wrote:
>
> > This patches causes a regression on a imx51-babbage running 4.18-rc1:
> > I get a kernel hang.
> >
> > If I revert it on top of 4.18-rc1, then it boots fine and USB host is
> > functional.
> >
> > I understand this patch fixes a kernel hang for you, so which commit
> > is responsible for the hang you observe?
> >

I never assumed it was a regression and that USB worked on RDU1 board
before, so I never tried to see if this was a regression. I can only
tell you that it hangs as soon as any PORTSC registers are accessed.

> > It seems this commit fixes a hang for you and causes another hang for me :-)
> >
> > Any ideas?
>

RDU1 design is based heavily on Babbage board, moreso USB1/ULPI
portion of it is an exact copy (it does use different GPIO for PHY
reset, but that's irrelevant), so I am surprised that it breaks in
your case.

However looking at imx51-babbage.dts, I am suspicious of it's USB1
setup. There we have usbh1phy node that references <&gpio2 5
GPIO_ACTIVE_LOW> as reset, but corresponding pinmux, pinctrl_usbh1reg,
is not being used anywhere. Cold that be that the problem you are
seeing is due to USB PHY not being properly reset?

> I am able to boot again if I skip passing the CI_HDRC_OVERRIDE_PHY_CONTROL flag:
>

Yeah, IMHO if you are dropping that flag, you may as well revert the
whole patch :-). The path that make the kernel hang in my case would
be taken if that flag is dropped.

Thanks,
Andrey Smirnov
