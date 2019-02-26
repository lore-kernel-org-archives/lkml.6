Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54161C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AAF20651
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCSCszBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfBZNFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:05:34 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40579 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBZNFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:05:34 -0500
Received: by mail-ed1-f65.google.com with SMTP id 10so10640548eds.7;
        Tue, 26 Feb 2019 05:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81RgWyYCtHg0Be6F/oJvEJ6i+v9q+5k0Z8Yu1a/PYIA=;
        b=CCSCszBD/P/4CITusqmG1VEw0yVBGGWFufDeNKhItQkD4ye0Ls+egXVr+pePl9ZrUB
         BeUScdTqo3JOAicb18iJsfkt137USIfJJJEGFDBDgkPyEKf3zSYIqP7Z4OnLAq5OEV1e
         FDJ4lCa5rRMGhlOiqC0F609XLneZMenA7n/Av01idBZTqMB60hFPTO0dQQ6k9wx3qX6E
         Zc/0hdt6MOyuQeJn1YSNKCZrfD+N0fUhRFJdvDWQd/JZl4wNhAGZ87wT4dLFr+VQuUMA
         SN15/rU3HzLXJwl3sZEpZuyEwk+m+fKsh6vv46NmGlGOvBYLz8v2rSQz8RJuYiPS1WKI
         k80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81RgWyYCtHg0Be6F/oJvEJ6i+v9q+5k0Z8Yu1a/PYIA=;
        b=VY8d0jROmEj7K8Z23ouZEYKZ8VD702ZHVjoeiTEMeGZp8YyOzb5yZa21G2j4V4FiPo
         DOmnrbtAN+ZipBa//GNAhL7xJRECh9Fdt3Lu+KaTywGgtl6gIjqq3IYN0JC6aqt99B6j
         ak+UHwFFQP8NMSeL7A8BBcvyUXT4SX8z1qXWDNWkWHJZbWa/Lck4kgCW5qUkXVhP0qQO
         ONLgO4U5w2zW2PF51q18rZw+sfVgsL7p+e668z7XXOjoGRAwSYp0tryeyHYs/DsyJRgI
         qwf5ylCWnhBF/SG0i+iSuv1smLCLl6+oaO5nq7rGjwORpeBe6/TKdV0tqTF+u0mYn64D
         R+Qg==
X-Gm-Message-State: AHQUAubI+T42Hssp65a8RIkQ30ujP28xIww13xrlGWs1l2kyLEKfXjfq
        +2shmyJr2ZbMLPSgOGn90rGPKoteV7NL4QtsiQU=
X-Google-Smtp-Source: AHgI3Iaq6DHWOiVk8whPHGRNeTigjx0cVmfqqdlqaYVS5fZTpHSiUhE0w/GA+DV2LlqopCjoDbcpcF6texwGYD76RNs=
X-Received: by 2002:a17:906:f1d8:: with SMTP id gx24mr16656106ejb.227.1551186332278;
 Tue, 26 Feb 2019 05:05:32 -0800 (PST)
MIME-Version: 1.0
References: <20190226070742.30551-1-daniel.baluta@nxp.com> <CAOMZO5CpefU56xLaOUq0GRwWP9kcMPyZ2PWM38C9FuU-3k1MJA@mail.gmail.com>
In-Reply-To: <CAOMZO5CpefU56xLaOUq0GRwWP9kcMPyZ2PWM38C9FuU-3k1MJA@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 26 Feb 2019 15:05:20 +0200
Message-ID: <CAEnQRZBRG4d59y3kteMaZMjfHWZ=FYL4dP+uRcthvXxqtmH7cw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Enable wm8524 on i.MX8MQ
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 2:53 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Daniel,
>
> On Tue, Feb 26, 2019 at 4:08 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
> >
> > On i.MX8MQ we can start the party using the wm8524 codec
> > which gets it's data through the SAI2 interface.
> >
> > In order to make it work this patch series enables the SDMA nodes,
> > sets the correct pinctrl configuration and uses the simple card
> > machine driver to put everything together.
> >
> > Changes since v2:
> >         - s/QM/MQ after Chris comments
> >
> > Changes since v1:
> >         - added cover letter
> >         - remove "fsl,imx8mq-sdma" compatible for sdma.
>
> Why? It is good practice to add the new compatible entry.

I get your point here. But for the moment it is identical with
"fsl,imx7d-sdma" so there is no need to add it now!

See the discussion here, and comment from Lucas:

https://lkml.org/lkml/2019/1/28/194

So, I prefer to keep it simple.

>
> In case we find out a need for a fix that only affects imx8mq in the
> future we can do that by using the specific compatible and no dts
> change will be needed.
>
> >
> > Daniel Baluta (5):
> >   arm64: dts: imx8mq: Add SDMA nodes
> >   arm64: dts: imx8mq: Add SAI2 node
> >   arm64: dts: imx8mq: Add SAI pinctrl configuration
> >   arm64: dts: imx8mq: Enable SAI2 for wm8524 codec
> >   arm64: dts: imx8mq: Enable wm8524 codec
>
> I would suggest making the last three patches as a single one.

I'm not convinced about this. I try to separate patches like this
in order for people to really understand step by step how
audio is enabled on i.MX board.

I will give a second thought though. Maybe 3/5 and 4/5 could be squashed
together.

>
> Also, please make the Subject as: arm64: dts: imx8mq-evk when a patch
> is specific to the imx8mq-evk dts.

Indeed, will fix in next version.
