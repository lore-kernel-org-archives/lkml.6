Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1828EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB60213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAtGPX8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfBYOMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:12:54 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42521 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfBYOMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:12:53 -0500
Received: by mail-ed1-f65.google.com with SMTP id j89so7647917edb.9;
        Mon, 25 Feb 2019 06:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LEM1oXlnncLpowJ1n6g6z7vC7Tb7CbxjEz6a4dpcu0Q=;
        b=tAtGPX8KVAxwtd57C+AD1xhjoKVP3WPm1sStzJSFoMDWUhoOGWVW1cN/WwS4Dtll0m
         FHjW3nX42QnI8w6pyW7Kie5RN01e1guagCOg6LvgoHo3K9DX6ySZRd10ZCwo9E2qXaGG
         721WV+qVL59ZqQswaNeROcuRlyRqZ8JRxMqXnT56F/UyA4F+qlXH14mb9svPKgZHq1XO
         DG0AfaDDUovR5rNAB6bTtziukkf8gGJAb6fuSG6zki8p8+ugzx6wPH0HYafDOrK9dBQq
         H4QaHa7ktv1HrYCP3Act3dKWizLln2F69N3FRWTOdt/xrPFQ+lev/GMa45k4wFDROukI
         wAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LEM1oXlnncLpowJ1n6g6z7vC7Tb7CbxjEz6a4dpcu0Q=;
        b=MuS2/VifMfeB26lL4/rBdzaVPiIcbkZZ2zlI6oTybx/ZoAhtG2aQ/S/8oA7Mb2eHfv
         rQONJc1xEJatE2NVtM/2/A0ERdiPxdZ24J9J7oKwkB7Lo+KiWS7GgpLPFF59go9/BtvT
         ym/zM2lJnt83A8+kwa0aPmBC5AyxhI8BjTEyIDvyZa2viLVazwxsLM14C36hWKmXQ6dL
         pOnLst1t9kdLygrkX1RKjkotwVgyKA6EUi3A2KN++N41GYPuvpmZZVG7Z04qM4gnfWwq
         45UHBilMlp82s9uDPb4qh8ReuEvz2hQs7/9rjyBbB9SGr5xymd/6e0jtFNUc7Atzd9Ig
         xTLA==
X-Gm-Message-State: AHQUAuZvVmNgffer4p2a8u8AhqcbzjD4V5cpgdSlTBiFBWFl4kne5P+J
        JCEdgXFb+YsXCff3n0CkZOnCqRP4jSnE7cgzAYo=
X-Google-Smtp-Source: AHgI3IYcWUQ059d+peIp4lqM7RKFu+N8sSg9a34L4T5YAPP3KSWycBmhHUzxwkAkAt+CJpxzyFqQwTWVPgxruKo0ht4=
X-Received: by 2002:a50:b847:: with SMTP id k7mr14589254ede.265.1551103972045;
 Mon, 25 Feb 2019 06:12:52 -0800 (PST)
MIME-Version: 1.0
References: <20190225132617.10987-1-daniel.baluta@nxp.com> <CAGUNXRQdETxnJGP9uQs91mn1w9qJrh4PhZz72bwEh63hrKCX7A@mail.gmail.com>
In-Reply-To: <CAGUNXRQdETxnJGP9uQs91mn1w9qJrh4PhZz72bwEh63hrKCX7A@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 25 Feb 2019 16:12:40 +0200
Message-ID: <CAEnQRZDviDcZPJ2cP8_g6v67=T212G5KZosvEMqMeGGE9NL30g@mail.gmail.com>
Subject: Re: [PATCH 0/5 v2] Enable wm8524 on i.MX8MQ
To:     Chris Spencer <spencercw@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 4:02 PM Chris Spencer <spencercw@gmail.com> wrote:
>
> Hi Daniel,
>
> On Mon, 25 Feb 2019 at 13:26, Daniel Baluta <daniel.baluta@nxp.com> wrote:
> >   arm64: dts: imx8mq: Add SDMA nodes
> >   arm64: dts: imx8mq: Add SAI2 node
> >   arm64: dts: imx8qm: Add SAI pinctrl configuration
> >   arm64: dts: imx8qm: Enable SAI2 for wm8524 codec
> >   arm64: dts: imx8qm: Enable wm8524 codec
>
> imx8qm ought to be imx8mq here by the looks of it.

Hi Chris,

You are right :), will fix with v3. Will send v3 tomorrow to allow some
time for more feedback.

Thanks!
