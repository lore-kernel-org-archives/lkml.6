Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70B9C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78590217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1aQMvEfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfAXQEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:04:37 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:55498 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbfAXQEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:04:37 -0500
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x0OG4Nvc013899;
        Fri, 25 Jan 2019 01:04:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x0OG4Nvc013899
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548345864;
        bh=QN2srEV54z/tZD5aguZyOGVsZO+FGm6s0oyJdmlgyMo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1aQMvEfzS3xKHAjM92msDPQStoKXIIOnGsS0esqGq7z/46KLRiMHASBCzP4lvvLFQ
         vcjF/j6M0+mcp7VQPE1ppJm5PpVIKTCyrcyhEi4bHvbP/z/W+C8Qwlcsr4dTVGHB/I
         SxKXtdTGlw0H88kNCeaXIgkBtdMyGTT0xisBXo3UWQjkEN7Ql5EizVlnCSJUQyV67F
         L87mlKNJP9mbsZ6p8xd3aIIFOxQv4DUc2qAI2rz5kILcnk8Bz8kAzOTB805CM3SH2s
         GidFmTEBUCeg6DxYPDQucPThWmoKxzB6lcsZ0HI20f9f7fb8uKSrLPuFiBWbk1Fz3/
         cpV82bkUzlQdQ==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id u19so2170032uae.4;
        Thu, 24 Jan 2019 08:04:23 -0800 (PST)
X-Gm-Message-State: AJcUukfvnQeoWkgR7s2t4SkOCeWISpY3/9TsGnGuYyqUXmy9WUTV0Agx
        LxIMuMYjR2cVHwoE3osm4Xnu8p/5i9oj/fH6UJs=
X-Google-Smtp-Source: ALg8bN7I+2sXIYOQk1rjfI4gIKoyp8MM0grkYi1qWtLETRQn4OxTXxsmQ+IGfwZtye1oMyTdEPU8o6C+ySuHSfE4PuU=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr2935203uap.6.1548345862608;
 Thu, 24 Jan 2019 08:04:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1546888138.git.leonard.crestez@nxp.com> <VI1PR04MB553355D6D5EBC2604E1AD256EE9F0@VI1PR04MB5533.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB553355D6D5EBC2604E1AD256EE9F0@VI1PR04MB5533.eurprd04.prod.outlook.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 25 Jan 2019 01:03:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ+eNhkfNsjGEdAg+j2ButQ8R6NyZ10SckCGSP5MZ4jtg@mail.gmail.com>
Message-ID: <CAK7LNAQ+eNhkfNsjGEdAg+j2ButQ8R6NyZ10SckCGSP5MZ4jtg@mail.gmail.com>
Subject: Re: [PATCH 0/3] kbuild: Add wilddt function instead of listing dtbs
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 1:17 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> On 1/7/2019 9:31 PM, Leonard Crestez wrote:
> > The dts makefiles go through a lot of pointless churn when boards are
> > added. Many SOCs (such as imx) have very simple naming conventions for
> > all boards using a certain chip and board listings can be easily
> > collapsed using wildcards.
> >
> > Add a "wilddt" function and use it for imx6/7/8 and layerscape. This can
> > be applied to many other soc families later.
> >
> > Previously sent as RFC: https://lore.kernel.org/patchwork/patch/1022737/
>
> Any feedback? This should be reviewed by kbuild and arm-soc
>
> I think this is a worthwhile cleanup, are there any corner cases or more
> exotic setup I should try in order to validate this series?



Personally, I prefer explicit listing
because I can browse the Makefile to get a quick idea
of which boards are compiled.

I like this to be consistent.


 - Exploit wildcard for all platforms

    or

- Do not do this at all


But, I am pessimistic about the former
when I look at AT91 platform.


-- 
Best Regards
Masahiro Yamada
