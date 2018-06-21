Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBA2C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB1020883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8nLz6Qq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB1020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933066AbeFUOIK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:08:10 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43782 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932802AbeFUOII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:08:08 -0400
Received: by mail-oi0-f65.google.com with SMTP id t133-v6so3013621oif.10;
        Thu, 21 Jun 2018 07:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c0fDYFg2ddkCEB8W7WLGxAKTKiNw9xMBMAenzYGp4Yc=;
        b=S8nLz6QqT+JAF65Ut3AyHHvD6FG+/S4eXmw5L+zfulq+VaNPVoeoiaK0HWtwRu3oTr
         vIX2AL1Rh6vC43mWihl0FmOh/EW8njJDhxtJcznAo9BGXusq8qtWZAwTABWWUIl0pBrH
         Kzn2WV7BfNj+sABvlR3WewZQDeh+7pQEYDHUCY1hUS20hoQHsJSIQozpajjbr27WLHqJ
         5Y9ZH5cwca8T1seWe3bVSceRenClr9t32VOmbcNCvFvNxkelRkmk1TmYUEmWxUhGk6Zs
         EbzB65pdKlzxM6RVe1xIS2MJnbvpkQL6uNI4eG7rHyQZvIv6YTXOmA18Slr7yebRKa9H
         mIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c0fDYFg2ddkCEB8W7WLGxAKTKiNw9xMBMAenzYGp4Yc=;
        b=evoBpFyP41Z9gpb450JJL8ZGpy+bOGVeFnWs+8/h+EfqQLqGf3w2EjM1WsnXhU0rxf
         rWpeIAmY4DcohwCvFfBStjDUyCIcQGdSiQc7tPhsOqUMCgkjl/78ehpU2/4lxdP419Ia
         kaI8zc9/5Ami21rPiHiKypMRZYZfl9WXd9XYvw0sDz1D0sTNY0O/ZzSf+wrQQYIJQsMR
         GZI4/fy38P0tVuLWpOSzFZe343K+MRgdcAUtapKUkdh9p9XPdF5HN2yqTEvRDLx2CA/C
         yX7D83wMKGhMJ65fBF3Twrp0TxVeQRBlgp6vjWY0XMJJh484XxXGUeF4rp50SJF/reb0
         L5TA==
X-Gm-Message-State: APt69E17pJOcyCOPPetK0p2uF3kRLHNdp8YxsnKnORp06imJvsb3YBCV
        X06s1Ujx/srqYcPXqnbXTMoVge/kZvaV+OaG0C3pAA==
X-Google-Smtp-Source: ADUXVKKYgvcJApAOyNKTiuWs6eW3R/uvPG7A4W/4Pse5QG5bUC514NUmxlngla/0H1YUivoRM+vVAMqwR9FD3e0a/w4=
X-Received: by 2002:aca:400b:: with SMTP id n11-v6mr15228573oia.44.1529590087670;
 Thu, 21 Jun 2018 07:08:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 07:08:07
 -0700 (PDT)
In-Reply-To: <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
 <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
 <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com> <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 21 Jun 2018 11:08:07 -0300
Message-ID: <CAOMZO5B98O9XA8GhdWxJZ6DFgS=O+smHURm8v5jEirj31tuUhg@mail.gmail.com>
Subject: Re: [PATCH] usb: chipidea: Fix ULPI on imx51
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Peter Chen <peter.chen@nxp.com>,
        USB list <linux-usb@vger.kernel.org>,
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

Hi Andrey,

On Thu, Jun 21, 2018 at 9:47 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:

> I never assumed it was a regression and that USB worked on RDU1 board
> before, so I never tried to see if this was a regression. I can only
> tell you that it hangs as soon as any PORTSC registers are accessed.

I think we need to investigate this portsc register hang further.

> RDU1 design is based heavily on Babbage board, moreso USB1/ULPI
> portion of it is an exact copy (it does use different GPIO for PHY
> reset, but that's irrelevant), so I am surprised that it breaks in
> your case.
>
> However looking at imx51-babbage.dts, I am suspicious of it's USB1
> setup. There we have usbh1phy node that references <&gpio2 5
> GPIO_ACTIVE_LOW> as reset, but corresponding pinmux, pinctrl_usbh1reg,
> is not being used anywhere. Cold that be that the problem you are
> seeing is due to USB PHY not being properly reset?

Yes, this can be improved, but this is not the cause of the issue .

gpio2 5 is passed as the USB PHY reset:

reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;

The default IOMUX setting after power on reset  is GPIO, so not an issue.

> Yeah, IMHO if you are dropping that flag, you may as well revert the
> whole patch :-). The path that make the kernel hang in my case would
> be taken if that flag is dropped.

Yes, it seems we need to revert the full patch and have a proper fix
in place that works for imx51 RDU, imx53-ppd and imx51 babbage.

The USB host 1 on imx51-babbage has been working since kernel 3.19 :-)

Thanks
