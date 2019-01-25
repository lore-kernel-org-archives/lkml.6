Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FE8C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 00:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F10218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 00:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3pMYRmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfAYAVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 19:21:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55912 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfAYAVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 19:21:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so5031585wmc.5;
        Thu, 24 Jan 2019 16:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4rB9sUXPOkujSSjXj37blp6SmzJRoYTe2XJCSqdXnzE=;
        b=G3pMYRmyMisCgjAj/8Sr+3Onppmzxc9Syj5AbYode3BbpmSfbgoYzmU+K+vCijQEvR
         Hqgn/KwbWm3rafyqS2PbWnYgtnDRAsLeaG/md5fOlGLevSPEy2F4PmvcbQ+3Pn46x5df
         7nuehxljpJ8fivcN2r45jTEjfT38gIltEADEJe+nAbt+h2fR6087Xm9XVmzxKgVZEp66
         BG/YZxM3kbHhLKflrSNZ8VKBadOtx24mPGTvDewRTOuKO5hHs9OHH6T3gpo73D7S+37B
         lRN6B2ScdgrtAeghfnSz8gCjPoVR7TdF9WmSOHi3xHj+ijtJJU4HEghFzuVmCinzbrf4
         7mSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4rB9sUXPOkujSSjXj37blp6SmzJRoYTe2XJCSqdXnzE=;
        b=BvwQeqkLhGKIdGQk1lJ4ByaFBsXtWrOA1ZJ6/l3RAWWzc/WoF/grpMycOP+/7JGu3H
         quw6RUCfwe8RdbOkQXL99fcitWKwiehIZiuOirCEPqDCe6NnfmPgkpS6omiG7s4G3pNG
         oc0S5pn9HgDMiiKcKuRA9byKLVtW9v5hLciFEt/jHa3c4266rUk0JR7If+bnPc+tvVgA
         LaYT3CCGZLF/HF5zD2jrLQbm+a+hAozyvIYq0RIKqSihoP7YsR8W8dTq0SRbINlkoKco
         G5pLb65MblYMygiyfDj2SN2q3qVvb+ruP8TXRqQP59NEu98m1EUItXufwXc4H7b1HOqm
         rveA==
X-Gm-Message-State: AJcUukcAxMPfCZQwAVCBpAHrxpCWAh/nP0lE/YK+hWYSb9CPXKc9gcxL
        4Bfehbsnxopx9IzSEaX3HNvH2Vp1TvQVaYhDmpU=
X-Google-Smtp-Source: ALg8bN6N77DYUVSRPlpBtPOH4st7qTSS19mu3vnh9AYae6Oq/4q3UvJLUKx3ZnTH4oxEYuWQOKlDHo+3DVW0XhtmB5Q=
X-Received: by 2002:a1c:c10f:: with SMTP id r15mr4620332wmf.27.1548375695902;
 Thu, 24 Jan 2019 16:21:35 -0800 (PST)
MIME-Version: 1.0
References: <20190122021043.25449-1-andrew.smirnov@gmail.com>
 <20190122021043.25449-4-andrew.smirnov@gmail.com> <1548240560.3904.6.camel@pengutronix.de>
In-Reply-To: <1548240560.3904.6.camel@pengutronix.de>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 24 Jan 2019 16:21:24 -0800
Message-ID: <CAHQ1cqFx3b2fTy8YbpwC0fGJYpO4BLO4FW9q-Z2Np1tVktrKpg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] reset: imx7: Add support for i.MX8MQ IP block variant
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 2:49 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> Hi Andrey,
>
> On Mon, 2019-01-21 at 18:10 -0800, Andrey Smirnov wrote:
> > Add bits and pieces needed to support IP block variant found on
> > i.MX8MQ SoCs.
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
> [...]
> > +static int imx8mq_reset_assert(struct reset_controller_dev *rcdev,
> > +                          unsigned long id)
>                             ^
> > +{
> > +     return imx8mq_reset_set(rcdev, id, true);
> > +}
> > +
> > +static int imx8mq_reset_deassert(struct reset_controller_dev *rcdev,
> > +                            unsigned long id)
>                               ^
> > +{
> > +     return imx8mq_reset_set(rcdev, id, false);
> > +}
>
> Thank you, applied all three to reset/next with a small whitespace
> alignment fix.
>

Thanks again for applying this stuff. If that's not too much to ask,
would you mind creating an immutable branch, so I could start sending
patches that depend on "dt-bindings/reset/imx8mq-reset.h" to i.MX tree
without waiting for it to trickle down? If not, no worries, I'll wait.

Thanks,
Andrey Smirnov
