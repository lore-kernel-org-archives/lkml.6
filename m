Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32842C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAF020874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tybwUH4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbeLQRJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:09:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46522 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbeLQRJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:09:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so13035636wrt.13;
        Mon, 17 Dec 2018 09:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+IKEsp2xxvU41NOcoNJwmwkjLFreFgjNvF0b84yITM=;
        b=tybwUH4Y1DZJN86Jd6Q3xN4eEjKEf0eWkaqy5X2PUJBPzCdBqA65Jy9CyFoluonJJU
         5Fpse3vqd+2LhxE6PYO/awALkxofurTS8Mi5GP1liMWRJgZamMk4THpymot2ca79Vmnm
         CMMZtc7OtSlItEZl3tVcJrO+g0wQfSrOvLg3rqFnh6EDuykHs/3dNKOGB6Vc/cV2J0/+
         T6ExpGksDi8jdgQ6JowaAvFjTuv0l/A4Guho+IGkOn/FCG5pMAbLU2yCKU+PEnKltDr2
         ifE9Dx267VoW0tGz/2vJ2aqNoGYp0HCpgHTGJp9AxBU6c+A6roRw6ANSEBSnTMuc7Tb3
         QvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+IKEsp2xxvU41NOcoNJwmwkjLFreFgjNvF0b84yITM=;
        b=M9eXKCvgBl07pjns/vGNLjDx+FCvIG98WPi0cmf5K39E0WASePZftzC/o40qdV7Wj9
         33lWsJIKrhSW4hfFdRTLeXSx+GB3C35CJUzeemu/jQO2OxlcmbUP6Emc/ScmRbGgNf5L
         i1sAPq26kYLto8CFynH5rhNM7acvubvlIKak2fYlAbzbQe7MGI0M6vIDfEq5saHNrw48
         Ag3tQXqDW7IxWkFu5GS6vBPz7aCCaF1bORqPDmkYH2UT9xhSAu08UZbg0pEYapjSVoB5
         jSGskWnyO/F4fmm00kYA4JJJ/BdPWcalLDt1zPt37AEFxCTOKvoeoAkbUlBwBqYnvmYa
         ethQ==
X-Gm-Message-State: AA+aEWZ3R0GJ9PtTmZ6bQqcqGZVc5tnqELKOA2fy4dkhR+e7r20kj2AS
        TDUS1WTQQEH4YTw0x8tGBUWvHHUmaQbLtA9Rcu8=
X-Google-Smtp-Source: AFSGD/U5UoHaJP43vVnrmmVmPmv5MouKvnzxvBKvLmZUH3RjvIkHxf+oYvna2/pSYDj/fYgU6k0oc6AYcHXJHqfLss4=
X-Received: by 2002:a05:6000:51:: with SMTP id k17mr10808219wrx.259.1545066582306;
 Mon, 17 Dec 2018 09:09:42 -0800 (PST)
MIME-Version: 1.0
References: <20181217023827.7947-1-andrew.smirnov@gmail.com>
 <20181217023827.7947-4-andrew.smirnov@gmail.com> <AM0PR04MB42114239FC75F5514554B55280BC0@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB42114239FC75F5514554B55280BC0@AM0PR04MB4211.eurprd04.prod.outlook.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 17 Dec 2018 09:09:31 -0800
Message-ID: <CAHQ1cqGO5bLOXM7sRAOkta3M7gemCDy5MtS3+kzXeLcTamrWWw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] reset: imx7: Add support for i.MX8MQ IP block variant
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "cphealy@gmail.com" <cphealy@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 8:30 PM Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Andrey Smirnov [mailto:andrew.smirnov@gmail.com]
> > Sent: Monday, December 17, 2018 10:38 AM
> > To: linux-kernel@vger.kernel.org
> > Cc: Andrey Smirnov <andrew.smirnov@gmail.com>; p.zabel@pengutronix.de;
> > Fabio Estevam <fabio.estevam@nxp.com>; cphealy@gmail.com;
> > l.stach@pengutronix.de; Leonard Crestez <leonard.crestez@nxp.com>; Aisheng
> > Dong <aisheng.dong@nxp.com>; Richard Zhu <hongxing.zhu@nxp.com>; Rob
> > Herring <robh@kernel.org>; devicetree@vger.kernel.org; dl-linux-imx
> > <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org
> > Subject: [PATCH v3 3/3] reset: imx7: Add support for i.MX8MQ IP block variant
> >
> > Add bits and pieces needed to support IP block variant found on i.MX8MQ
> > SoCs.
> >
> > Cc: p.zabel@pengutronix.de
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: cphealy@gmail.com
> > Cc: l.stach@pengutronix.de
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-imx@nxp.com
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >  drivers/reset/Kconfig      |   2 +-
> >  drivers/reset/reset-imx7.c | 106
> > +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 107 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig index
> > c21da9fe51ec..4909aab7401b 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -50,7 +50,7 @@ config RESET_HSDK
> >  config RESET_IMX7
> >       bool "i.MX7 Reset Driver" if COMPILE_TEST
> >       depends on HAS_IOMEM
> > -     default SOC_IMX7D
> > +     default SOC_IMX7D || SOC_IMX8MQ
>
> SOC_IMX8MQ has been removed in Shawn's tree.
> I'd suggest simply using ARCH_MXC.
>

Oh, that's right, will replace with (ARM64 && ARCH_MXC) in v4.

Thanks,
Andrey Smirnov
