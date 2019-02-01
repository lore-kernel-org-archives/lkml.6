Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B03C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5917521872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqetOHPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfBAAOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 19:14:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51909 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbfBAAOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 19:14:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so4329907wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 16:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G5dUd1cmXTgOfeTepQdL/ltms5dnxE83Orq8mXBbnPg=;
        b=HqetOHPCIwZNWCjuo05uaE3oQSL9bU7/O08brsk/A+BKBSvys7envQ7jhk66gtAu2B
         jV2F6Gow33S+7XK+oDA/lkQpwczRpNlUdowQwBqRjE/ZgKaxSyguDxJ8N9ussokPQ248
         nxW9UM/8XEQNw3L+X9dZsqI3IryTWC/renkvoyYc3xFjJq4Xr8mhLrVNxETu5vWqpcGS
         s0xeM3hpqvJ3MnrnGhA06jmI5yIT6wDoxWdP0zBmBavCCxt4hROGw2ibBpVukKG7oQGd
         NUYbG8e8ZsbKf8YI2ShDjS4Gjpoby+aMUT3lNweMGcg5w/dFx3rJEAsT3tJGuVKs68qb
         yjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G5dUd1cmXTgOfeTepQdL/ltms5dnxE83Orq8mXBbnPg=;
        b=fSVwQ9WFvweAIf2Sz66KDKm35IGSl4dRtJeJCvxcv/EXPdvNCYJA83ICSsV7pSSs1R
         G0Yj3FFR2M6kDlFVtMlmeGpaASvDBq0IElHGu8qVkANnxuZUZMyQsFXSyXufwt+NndJO
         f42YECeMpG8EfPb7iiNNH1IbxUKY0/A7ThV/LjOXE2XvQHS7HKOamvkLlW56++fay3UG
         kEdsjDsVIWjZdMPR07hvxU5Kz/Y0Z0hIEWfi0fxWCtQti0gEZUgoYCqNQH8hwHfju6Un
         FYOCS8Og8G1PHE25JDtVBoE7n/r0aMmClwE53WdZsfYjmqV8IyTQfGInKEW98gTuru8G
         meQw==
X-Gm-Message-State: AHQUAubXDDfztk8S/eF/Cdp1huMg6/MOEERgANEjBM66YPv7rmZZPAgw
        qf6AQm7GWtxYWl0vWTOwgeSjtoIpQB/sbh+0QTI=
X-Google-Smtp-Source: AHgI3IZeBbZY1qlQtvhyIS4uUAdFpaZ43zIjXBh19mPFqPd51bOnAo6snpXEhZ710VhFDpaeHvSFPskr2MEq/upSb/M=
X-Received: by 2002:a7b:c76b:: with SMTP id x11mr91967wmk.37.1548980047336;
 Thu, 31 Jan 2019 16:14:07 -0800 (PST)
MIME-Version: 1.0
References: <20190131204524.1218-1-andrew.smirnov@gmail.com> <CAOMZO5Dgz1TS_KgCR5ikdYsM=VAS3iJ-TDGuythzxvGULuaC-g@mail.gmail.com>
In-Reply-To: <CAOMZO5Dgz1TS_KgCR5ikdYsM=VAS3iJ-TDGuythzxvGULuaC-g@mail.gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 31 Jan 2019 16:13:56 -0800
Message-ID: <CAHQ1cqEVc1f+Ja=vaRH_07kBwk34cc2vh-_HskS4-LhOznv3xA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mq: Make GPC default interrupt parent
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 1:47 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Andrey
>
> On Thu, Jan 31, 2019 at 7:11 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> >
> > Now that the GPCv2 driver supports i.MX8MQ, make GPC default interrupt
> > parent.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>
> Lucas has already submitted this same change and another one that
> selects the GPC driver as part of a series.
>

OK, good to know. Please disregard this patch, then.

Thanks,
Andrey Smirnov
