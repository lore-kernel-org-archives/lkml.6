Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DBCC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 22:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3926925348
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 22:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLpmI0z2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3926925348
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbeFXWk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 18:40:27 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34087 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbeFXWkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 18:40:24 -0400
Received: by mail-it0-f68.google.com with SMTP id y127-v6so10511169itd.1;
        Sun, 24 Jun 2018 15:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/dmAH43kyX4umm/xRhYyqJXINAz95gfLlRxOCncoMkg=;
        b=kLpmI0z2TCJWRI09ltCrLDLp3vgMsuiw/WP3aPZFPZ1n+KwReQjXHpTmaapEKg7HjH
         bu9J2komdWTxPsLpiphDKBiZ9JW3zpmbXVsR1tH+1zF7+HbUU4qRoVmim9ekMecHy8Tv
         p8OlK27FW9r5QJxXeY0sPS7+WKaw1v9WTQMiKVkMmP2jg4YjtPpp9o1hSh8tGOg3Wn45
         /mzIlZCvBSTp0ROiMDaPwPc66KUMgI8NbbR5AAujW4gY6HLsoJ8pM8spygDNzVpWseOb
         hCFxJ09552opR/PdFD+ZkhVreaK1Jc9VCFOsrpQ7aGmYJo8ignzufdYCsmyCIvu3b/Ht
         soSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/dmAH43kyX4umm/xRhYyqJXINAz95gfLlRxOCncoMkg=;
        b=m8XveFu+qrwT7l+7FWFuEnfDS0t97A5tBTn4dGQHOgiIpPMpzhTvTRvIk4xxJ3b+wM
         zvSc3ELHMLOpX/MBX54U7PYGeURoqsTmv7U5Tk/WtaFBbn+bo8aX9esV3rn703v7kEKO
         Yyeqsz2F/iWXGc0adM1YMO3sVve1hSdg4KNlTOd5P0+/tuZ91lJ45I/H3wFMlytV4xES
         IotKq8fwQKcXi1aqUwQvg5+YkmcVz1+siU+Jtn2cmZcTeNpThSL5IyGWoFBDhSphKCzS
         Wu8MIQLRLLgEQxyb2GHaY9xhxh4YaHXymdLpo29t7q7OT15evDYlHVFjiDBxnbTFUnk5
         XZeg==
X-Gm-Message-State: APt69E2ZvWfhvNPruvOxtWklRja04WB+Zu5K9XruJh1za74rjHRGvpv1
        BzHhUevGTIfdfnm8/ly9dIfx68HqUoyWDVVoYbdbhTgv
X-Google-Smtp-Source: ADUXVKItmvFHsrcn1ewpDukkFzt3iOahy1U1CmctzWLzpJLfs1wzTgkY24bpn5buuZyhAaxp9Dqpp/aEBbR7xjr9u1Y=
X-Received: by 2002:a24:a501:: with SMTP id k1-v6mr8037223itf.79.1529880023075;
 Sun, 24 Jun 2018 15:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
 <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
 <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
 <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
 <CAOMZO5B98O9XA8GhdWxJZ6DFgS=O+smHURm8v5jEirj31tuUhg@mail.gmail.com>
 <CAHQ1cqELs4LaQkmPiPjXQuF17+7PBsEtbmSt8iveLqRv+4bgfQ@mail.gmail.com> <CAOMZO5CumdNSP6iTfgXPdmpcZwh7YmBstUpAmb3A1QAf1UWJdw@mail.gmail.com>
In-Reply-To: <CAOMZO5CumdNSP6iTfgXPdmpcZwh7YmBstUpAmb3A1QAf1UWJdw@mail.gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Sun, 24 Jun 2018 15:40:11 -0700
Message-ID: <CAHQ1cqHpNvZGAfFKrp-OiZevsha5CBwJsw8GT+uhgNSfEUejkw@mail.gmail.com>
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

On Fri, Jun 22, 2018 at 9:27 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Andrey,
>
> On Thu, Jun 21, 2018 at 6:44 PM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
>
> > I just finished experimenting with it on RDU1 and Babbage boards and I
> > can't reproduce the hang that you describe against 4.18-rc1. At this
> > point I wonder if it's the bootloader that is a variable that plays
> > into this. I was booting both boards with 2018.06.0 version of barebox
> > + the custom patches that can be found here
> > https://github.com/ndreys/barebox/commits/rdu1-netboot. Note that the
> > last patch in that branch/stack was added as a part of this
> > investigation, but even before it, I was able to boot Linux just fine,
> > albeit without working USB.
>
> Thanks for investigating this issue.
>
> Yes, t is possible that the difference in behaviour that we see could
> be related to the fact we use different bootloaders.
>
> In order to make things easier, I am sharing a Buildroot image for
> imx51-babbage that contains U-Boot 2018.05 + kernel 4.17.2:
> https://www.dropbox.com/s/yevnu4y1zdchnbt/sdcard.img?dl=0
>
> Please flash it directly to the SD card via dd and boot it.
>
> You will notice that it will boot normally. Then please copy a
> 4.18-rc1 zImage into the first SD card partition and you will notice
> the hang.
>

It's definitely the bootloader, or more specifically whether or not it
initialized/used USB before booting the kernel. Some interesting
highlights:

 - On your "good" 4.17.2 based image, if you interrupt U-Boot, do "usb
start" (optionally "usb stop") and then "boot", you'll get the hang
that I was trying to fix with my patch.

 - Things are exact opposite with 4.18-rc1 and doing the above would
_prevent_ the hang and the image would boot fine.

 - Disabling USB in Barebox based boot "stack" gets it to behave the
same way as U-boot from your image (hanging when booting 4.18-rc1)

Digging more into code it seems that the reason for 4.18-rc1's
behavior is the fact that it's missing a call hw_phymode_configure()
after usb_phy_init() and, AFAICT, the only reason it is not happening
is because default image is being built without
CONFIG_USB_CHIPIDEA_ULPI and CONFIG_USB_ULPI_BUS. Enabling those two
options on 4.18-rc1, seem to fix the problem on both your U-Boot based
image and my "special" Barebox setup.

So AFAICT, this patch still fixes a valid issue (my use-case was net
booting via USB-Ethernet dongle), but an additional patch enabling
those two configuration options might be needed. Thoughts?

Also, I don't have any i.MX53 HW, so I wasn't able to test the effects
of enabling those two options there.

Thanks,
Andrey Smirnov
