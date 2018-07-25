Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACBBC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE4720843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="eOYCMmgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE4720843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbeGYP3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:29:36 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:43553 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbeGYP3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:29:36 -0400
Received: from mail-ua0-f174.google.com (mail-ua0-f174.google.com [209.85.217.174]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w6PEHLCI027475
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 23:17:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w6PEHLCI027475
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532528242;
        bh=eN8CwJzALhkb91FU1zpceBAhTpUEfIqrr/L+E9rTR3Y=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=eOYCMmgnurHieBuc75pLW3RMb03316PJ8Hg2tj1TSDQdfs1Lwepikt7uxqgNujGVE
         PfesDvQqVJkdprmBi8LQycXZouW967djGy7V4Mzc3j1ApD0+400riMEqQDjfzXrtW6
         Tdnsnurv5rUPUudvMv2MyWqYNeao7Un37+HBVw7edG+H0SCkNwpyvikVmeOBmk3s81
         oCsxLdGVAPIURuDFA/fcvbBLN4tFK2k6dJ/xwXF7Rr/91GawXvB+ek4o3DbFFWnnnJ
         YSD3rAguLNCtHebu8aV3cXKihkf3m/RoegQJPUTB4nW1iwAnIw0U4dvmKvPSo862bT
         v5hGLJBrTSWuA==
X-Nifty-SrcIP: [209.85.217.174]
Received: by mail-ua0-f174.google.com with SMTP id t14-v6so5148887uao.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 07:17:22 -0700 (PDT)
X-Gm-Message-State: AOUpUlEf8nmVeLqXv7VuEHdxi5VBbrgi51l6p/M2slIHi0NlCEQN04LG
        wVLFJ34aQtXrUJn0R5LrsH894BqMspV71hFS0Nk=
X-Google-Smtp-Source: AAOMgpea8mQP8l+2/NduFqbQ63PFn9JWBEgw75Ef+XcMH9CirdwS2mElqRwy4JCP+XB1TOISdqHdZJ+FFFNELzc7xiw=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr14567740ual.141.1532528241304;
 Wed, 25 Jul 2018 07:17:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7289:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 07:16:40
 -0700 (PDT)
In-Reply-To: <20180725144717.604d3197@xps13>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
 <20180720151527.16038-5-miquel.raynal@bootlin.com> <CAK7LNASmJRWM7Gj9qqqZqwenPkoRFeA8tupx+3PKPXC6OxD_eA@mail.gmail.com>
 <20180725115116.1fb38fe3@bbrezillon> <20180725144717.604d3197@xps13>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 25 Jul 2018 23:16:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNASmSOi9mygxD2PLmYJ=br2qdK_UtECYZXFNavmUc4OA1Q@mail.gmail.com>
Message-ID: <CAK7LNASmSOi9mygxD2PLmYJ=br2qdK_UtECYZXFNavmUc4OA1Q@mail.gmail.com>
Subject: Re: [PATCH v4 04/35] mtd: rawnand: denali: convert to nand_scan()
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mans Rullgard <mans@mansr.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Broadcom Kernel Feedback List 
        <bcm-kernel-feedback-list@broadcom.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Han Xu <han.xu@nxp.com>, Xiaolei Li <xiaolei.li@mediatek.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-25 21:47 GMT+09:00 Miquel Raynal <miquel.raynal@bootlin.com>:
> Hi Boris,
>
> Boris Brezillon <boris.brezillon@bootlin.com> wrote on Wed, 25 Jul 2018
> 11:51:16 +0200:
>
>> On Wed, 25 Jul 2018 18:42:44 +0900
>> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>>
>> >
>> > You need to remove kfree(denali->buf)
>> > from denali_remove(), right?
>>
>> Absolutely.
>>
>> >
>> > void denali_remove(struct denali_nand_info *denali)
>> > {
>> >         struct mtd_info *mtd =3D nand_to_mtd(&denali->nand);
>> >
>> >         nand_release(mtd);
>> >         kfree(denali->buf);       <---- REMOVE !!
>> >         denali_disable_irq(denali);
>> > }
>> >
>> >
>> > Otherwise, denali_remove() will free denali->buf twice
>> > because kfree(denali->buf) is called from denali_detach_chip().
>>
>
> Absolutely, thanks for reviewing!
>
> I'll apply with this changed.
>
> Miqu=C3=A8l


Assuming you will fix this,

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


--=20
Best Regards
Masahiro Yamada
