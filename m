Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754B1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236332083A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uyrz08e9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236332083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755300AbeFRQcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:32:17 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33172 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754587AbeFRQcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:32:16 -0400
Received: by mail-ot0-f196.google.com with SMTP id h6-v6so19217631otj.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 09:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hzDvwOg37zlqHvHZUx5d0S4ZP+RU8rXMZ8sb3ohVwtI=;
        b=uyrz08e9sKTwim9n+p+GLhfoYxeeml7bneji9wAkEvwaTXlW3dULWCZTbk2VGc0mOS
         COmUyosd30J2RmuTyX7qtE9a5tqCCFH2bUoLoCP6G9H/OW5ZQQE5//4PaSYSQtlAYWoT
         Hwqfk2HNVjHsAvkunuRteiRw79Alu6GPA/qpSgTooad8VvIqcBcyxnbs4Odfl5N6OC5k
         zpwNipsG4oGEuxMrTXFWIy1x4c0n/BNVdCuXN49y7Gdhk3DEyT1cb0JoopVObq1bdYEK
         2oVuslHm3uVBllQ/6tWcX+c/XQVYw296ITp4zb4wvLUuGZvU8QQwYo8CanuY6PDLDi1Y
         mCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hzDvwOg37zlqHvHZUx5d0S4ZP+RU8rXMZ8sb3ohVwtI=;
        b=gRrQfeNCqFeOHIsHvlHczf0KMpSi4oVyzW35Q0euGSnl5XGOdHitXNPxs3V4BFHFUf
         ehRu2NJNN60IbBDaKnB6xqmfgDcIBnoonJe1NkynytBJ06y4grWmgAJTBmQTjCkzqWDG
         8ZgJ1wuBaQUAxw0tlt2oemuo64Ya1iufuJRBy0VO6XxGpL0MsXzVIDZv6NB9WQ73W0zN
         41XyqxQg6caB1Wp3OSYetbFDNVLZBsLrv4RTRCCDz5zdE6BTOquOxDUi3KqPkhyZBfJ8
         OAVJkdW7pA0q8nHp7nsrpkMQcD2MH63PXrNn0FaRADMkyI6BNA4ZCntPhDWe7gk/hqOS
         NhMQ==
X-Gm-Message-State: APt69E3EFqU55WkCHeaUvMaFWMyMnbZZmz/SrrpIeJDpKiqGyXzJDsXk
        tX37AqdpGjyX15n6TKX75DPo2xOlz2kEM833/z8=
X-Google-Smtp-Source: ADUXVKLtSOby72XvN6AEULuSe4wxCZRbolp7xPwE43Xc7dkCsy7PGwKrghx/iIHnH5PvjSuDKON6znzy63Ck8OOdamo=
X-Received: by 2002:a9d:30c2:: with SMTP id r2-v6mr8615409otg.25.1529339535235;
 Mon, 18 Jun 2018 09:32:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 09:32:14
 -0700 (PDT)
In-Reply-To: <abacbb7485b0c9b908eae8ae87be9d8e0eab87b3.1529327283.git.leonard.crestez@nxp.com>
References: <abacbb7485b0c9b908eae8ae87be9d8e0eab87b3.1529327283.git.leonard.crestez@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 18 Jun 2018 13:32:14 -0300
Message-ID: <CAOMZO5AJH=Ay4MPt1Gi8LxmUSfhg3dMdcHRjsFzzQ9ZxD72TjA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7d-sdb: Remove duplicate regulator-can2-3v3
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Robby Cai <robby.cai@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 10:11 AM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> Two different regulators are defined with the same name and label but
> distinct properties.
>
> The first definition was added with the first board dts and the second
> was added when upstream added flexcan support.
>
> Looking at schematics it is indeed gpio2 14 connected to the STB pin of
> the CAN transceiver so remove the first definition.
>
> The second definition entirely overrides the first so this already
> worked and this patch results in no DTB change, just a cleanup.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
