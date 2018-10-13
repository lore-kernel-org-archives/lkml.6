Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77503C6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 02:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA3B20868
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 02:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA3B20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbeJMKBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 06:01:47 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43835 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbeJMKBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 06:01:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id y20-v6so13067425eds.10;
        Fri, 12 Oct 2018 19:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+oxrHtI0zGX9gGTV4ikOtS7b7TmIoW1ok6jGY2PVgGI=;
        b=Taw7CRscUy+zArkvU5QoZakmYET1b0yZeVUgopjM/kD5MX2ZRrhh3q4zOplvw5zX63
         Nb5ec0Oe7LgFPa8q6gHVgB0OCRRDnhFULkWMZeTanVPSBZ0tjAIZqdR64+n5gM37+MOM
         NvNsK0eCuc6IrPuHHvXW1Z0Yp/TzA/aLDtOvmxkMDC7ZTDZeXD8Vu3Uo81y+VQbGx4uy
         GNPOInBnUK6T5sdz1O/iDzbWPXiu0uvlRPW3KF7kxDg9KBCr/2w/1v11cgMavpg5xKvA
         oEsfmwah+EMR2IWFOWgUiEB0/XmqyPs4YbEvb0q1O8gpV6ZZ5CiUOR8Rl405za/Qcpab
         uk3Q==
X-Gm-Message-State: ABuFfoioii3Kg0G1e/3Yl82UIzJeNthtFK20Qg1seKoypp5xOIjJM8c/
        mbFdHPHjTnkFv1k71rqu8/MWP++9AiA=
X-Google-Smtp-Source: ACcGV61GMBSIwihmU56Z0pgPaqptVztFHJDtAOwpleHHkI0RS8ZiKXPlLua6BohrWUVDzV1Wl5RIAg==
X-Received: by 2002:a17:906:4f98:: with SMTP id o24-v6mr9722825eju.237.1539397586691;
        Fri, 12 Oct 2018 19:26:26 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id b26-v6sm1043467edw.0.2018.10.12.19.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 19:26:24 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id d2-v6so15266418wro.7;
        Fri, 12 Oct 2018 19:26:23 -0700 (PDT)
X-Received: by 2002:a5d:480b:: with SMTP id l11-v6mr7540908wrq.28.1539397583289;
 Fri, 12 Oct 2018 19:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <1539012044-29998-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539339841-22235-1-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539339841-22235-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <b47c5458-683e-3e96-0bbe-f9db84579c77@suse.de> <20181012133914.GA32670@imagebutcher>
 <20181012202330.tdwedsof2bsnxkxn@flea>
In-Reply-To: <20181012202330.tdwedsof2bsnxkxn@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 13 Oct 2018 10:26:11 +0800
X-Gmail-Original-Message-ID: <CAGb2v67406+vo_eF6-UvA0hPSx50kyXWTtcaeiOoXaz8uM1TQA@mail.gmail.com>
Message-ID: <CAGb2v67406+vo_eF6-UvA0hPSx50kyXWTtcaeiOoXaz8uM1TQA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm64: dts: allwinner: new board - Emlid Neutis N5
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     aleksandr.aleksandrov@emlid.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, david@lechnology.com,
        Thierry Reding <treding@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>, johan@kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 4:23 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Oct 12, 2018 at 04:39:14PM +0300, Aleksandr Aleksandrov wrote:
> > Hi Andreas,
> >
> > Thanks for your feedback!
> >
> > > > + *
> > > > + * Copyright (C) 2018 Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
> > > > + */
> > > > +
> > > > +/dts-v1/;
> > > > +
> > > > +#include "sun50i-h5-emlid-neutis-n5.dtsi"
> > > > +
> > > > +/ {
> > > > + model = "Emlid Neutis N5 Developer board";
> > > > + compatible = "emlid,neutis-n5-devboard",
> > > > +              "emlid,neutis-n5",
> > >
> > > You are lacking bindings definitions for these new identifiers. The
> > > vendor prefix should be patch 1/3, the SoM/board compatibles 2/3 and
> > > this .dts[i] patch 3/3, so that only vendor prefixes and compatibles
> > > that are defined and don't result in checkpatch.pl warnings get used.
> >
> > Patch 2/3:
> >
> > commit 46dcb8632b36644cb20e6b35ede12ff0088a60eb
> > Author: Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
> > Date:   Fri Oct 12 16:22:28 2018 +0300
> >
> >     dt-bindings: arm: sunxi: emlid,neutis-n5(-devboard)
> >
> >     sunxi: add new compatibles for Emlid Neutis Dev board and SoM module
> >
> >     Signed-off-by: Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
> >
> > diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
> > index e4beec3..a907e52 100644
> > --- a/Documentation/devicetree/bindings/arm/sunxi.txt
> > +++ b/Documentation/devicetree/bindings/arm/sunxi.txt
> > @@ -19,3 +19,5 @@ using one of the following compatible strings:
> >    allwinner,sun9i-a80
> >    allwinner,sun50i-a64
> >    nextthing,gr8
> > +  emlid,neutis-n5
> > +  emlid,neutis-n5-devboard
> >
> > Is this right place for the neutis compatibles?
>
> No, those are for SoCs compatible. I'm not sure we ever created a
> board compatible files.

We never did. We don't even have all vendor prefixes in, only the ones
that seem more popular, and actually have an identifiable website.

ChenYu
