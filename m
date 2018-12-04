Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6C8C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A46206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0hXyPnI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A46206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeLDPJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:09:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbeLDPJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:09:10 -0500
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79BC6214DA;
        Tue,  4 Dec 2018 15:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543936149;
        bh=+0MI/8EOCqbI1qFoWjATuKQrFBYgzbVNInZxkwwjqEM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0hXyPnI9maJyqcmzB6tMN4pIULVnhwcNY4dEKGfbJxU1GFyu/FoWh7TzessGN03cZ
         s/rGuYd11D1t1GeUI0SOQwFVIOJlnCSH2FrdqhPNho5g/tLINU/kkTfPDLdepWZRDC
         GmnQOyJlSCRF9CMIS6hXfsXK//Ld8wZn6+P3moGM=
Received: by mail-qk1-f177.google.com with SMTP id d19so9792120qkg.5;
        Tue, 04 Dec 2018 07:09:09 -0800 (PST)
X-Gm-Message-State: AA+aEWY9sHymcanqU2SOR8zn5A3GxE49uOhLPlJrZng/RUcP/6H7yxTg
        E7/LPQRcgDoQF4E/wqC3b0ybjwr0vTDvYjOqlA==
X-Google-Smtp-Source: AFSGD/VUggFDQVcQ6qA6a8K2W5gIb5rqDIXHwIpEuSzH4QIaox5BhRGzLSfFb7Q1X7Odc6q1CLQrY+AToiydWVRNR2k=
X-Received: by 2002:a37:5686:: with SMTP id k128mr17892902qkb.29.1543936148619;
 Tue, 04 Dec 2018 07:09:08 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org> <20181203213223.16986-27-robh@kernel.org>
 <20181204144822.uqonsto45u7ysdu5@verge.net.au> <CAMuHMdV5brJyAmP0Bj7Bp7wruLNM1tSWkj_AyN5HCx4vdg-nrg@mail.gmail.com>
In-Reply-To: <CAMuHMdV5brJyAmP0Bj7Bp7wruLNM1tSWkj_AyN5HCx4vdg-nrg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 Dec 2018 09:08:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJX9eb58piavQayXM5j5GXxsGxmy93m5oRKtghMFvkhuA@mail.gmail.com>
Message-ID: <CAL_JsqJX9eb58piavQayXM5j5GXxsGxmy93m5oRKtghMFvkhuA@mail.gmail.com>
Subject: Re: [PATCH v2 26/34] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms@verge.net.au>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Kumar Gala <kumar.gala@linaro.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        Grant Likely <grant.likely@arm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 8:57 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Simon,
>
> On Tue, Dec 4, 2018 at 3:48 PM Simon Horman <horms@verge.net.au> wrote:
> > On Mon, Dec 03, 2018 at 03:32:15PM -0600, Rob Herring wrote:
> > > Convert Renesas SoC bindings to DT schema format using json-schema.
> > >
> > > Cc: Simon Horman <horms@verge.net.au>
> > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: linux-renesas-soc@vger.kernel.org
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../devicetree/bindings/arm/shmobile.txt      | 151 ------------
> > >  .../devicetree/bindings/arm/shmobile.yaml     | 218 ++++++++++++++++++
> > >  2 files changed, 218 insertions(+), 151 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt
> > >  create mode 100644 Documentation/devicetree/bindings/arm/shmobile.yaml
> >
> > Hi Rob,
> >
> > what is this based on? I get a conflict when applying the .txt change
> > and if I knew the base for this patch it would be rather easy to work
> > out what has changed.

4.20-rc2

> >
> > Also, should we do an s/shmobile.txt/shmobile.yaml/ in MAINTAINERS?

Yes. Though it was pointed out that get_maintainers.pl can pull emails
out of this file. We'd need to get that to work by default though.

> Probably even s/shmobile.yaml/renesas.yaml/, while at it?

Sure, if that's what you all want.

Rob
