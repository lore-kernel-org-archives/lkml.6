Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B5FC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6E420868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544125138;
	bh=R15F2uQ3pXQCp7bVIOuAth3P/jfGbhBVk+KMwmpfWB0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Tyi500txOb0Mlm2cxjEA5A/lYYTIAmpET+iGhFDXi8AuJVssT5oiW0W2U7I9Ywt/e
	 9slXANdt3x6tpyhPvVLD9STHGmr/eyaE/aEY4l9Ni6uhSTaO22ldc5XUYCGmGNY2fd
	 kF88dxCw8KLtrFb8oHylknH0jJliC1cMm6wy/mFI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6E420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbeLFTi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:38:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:51876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbeLFTi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:38:57 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4E1B214F1;
        Thu,  6 Dec 2018 19:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544125136;
        bh=R15F2uQ3pXQCp7bVIOuAth3P/jfGbhBVk+KMwmpfWB0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qn9iTtt0raOx10iGEVlD4bAKxMmC6tRyMD3t2TPHW8unn7KLrLjaoSuyLMEWXWRmK
         RUjogClJhhm6zEzmLhigVgq1F63l1ZywAXJRxk96Dbkr7MvfaYerzZBpm33AyDx+ZA
         2VsBi8JCU3mZYoS5P4GVIYZb9r1j9yyhJKSunoec=
Received: by mail-qt1-f171.google.com with SMTP id t13so1910579qtn.3;
        Thu, 06 Dec 2018 11:38:55 -0800 (PST)
X-Gm-Message-State: AA+aEWY4W3Rxt7wK1BL0Ynlg1/AGcj/ZyVFK6RlXvAL7/+AW9+DTvvsr
        xBNCjwVMgG2a1sFEdRzSvBc+oBjAaq72fSaVvg==
X-Google-Smtp-Source: AFSGD/XfapvVxtgRCg5w8FKOyzy07I+hnLoDVXwvjcbTigNHC8acVEaq0cWkWQbnEk++xrOO7b1rywtLrTjH7jfXDwc=
X-Received: by 2002:a0c:f212:: with SMTP id h18mr29147928qvk.106.1544125135017;
 Thu, 06 Dec 2018 11:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org> <20181203213223.16986-27-robh@kernel.org>
 <20181204144822.uqonsto45u7ysdu5@verge.net.au> <CAMuHMdV5brJyAmP0Bj7Bp7wruLNM1tSWkj_AyN5HCx4vdg-nrg@mail.gmail.com>
 <CAL_JsqJX9eb58piavQayXM5j5GXxsGxmy93m5oRKtghMFvkhuA@mail.gmail.com> <20181205194419.p6u56h57yk63xshj@verge.net.au>
In-Reply-To: <20181205194419.p6u56h57yk63xshj@verge.net.au>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 6 Dec 2018 13:38:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKHwYhHSb7GNFgOtBCqEeMshbRnU+0ONe_yW8OOiRC=SA@mail.gmail.com>
Message-ID: <CAL_JsqKHwYhHSb7GNFgOtBCqEeMshbRnU+0ONe_yW8OOiRC=SA@mail.gmail.com>
Subject: Re: [PATCH v2 26/34] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
To:     Simon Horman <horms@verge.net.au>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Kumar Gala <kumar.gala@linaro.org>,
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

On Wed, Dec 5, 2018 at 1:44 PM Simon Horman <horms@verge.net.au> wrote:
>
> On Tue, Dec 04, 2018 at 09:08:57AM -0600, Rob Herring wrote:
> > On Tue, Dec 4, 2018 at 8:57 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Tue, Dec 4, 2018 at 3:48 PM Simon Horman <horms@verge.net.au> wrote:
> > > > On Mon, Dec 03, 2018 at 03:32:15PM -0600, Rob Herring wrote:
> > > > > Convert Renesas SoC bindings to DT schema format using json-schema.
> > > > >
> > > > > Cc: Simon Horman <horms@verge.net.au>
> > > > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > > Cc: linux-renesas-soc@vger.kernel.org
> > > > > Cc: devicetree@vger.kernel.org
> > > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > > ---
> > > > >  .../devicetree/bindings/arm/shmobile.txt      | 151 ------------
> > > > >  .../devicetree/bindings/arm/shmobile.yaml     | 218 ++++++++++++++++++
> > > > >  2 files changed, 218 insertions(+), 151 deletions(-)
> > > > >  delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt
> > > > >  create mode 100644 Documentation/devicetree/bindings/arm/shmobile.yaml
> > > >
> > > > Hi Rob,
> > > >
> > > > what is this based on? I get a conflict when applying the .txt change
> > > > and if I knew the base for this patch it would be rather easy to work
> > > > out what has changed.
> >
> > 4.20-rc2
> >
> > > >
> > > > Also, should we do an s/shmobile.txt/shmobile.yaml/ in MAINTAINERS?
> >
> > Yes. Though it was pointed out that get_maintainers.pl can pull emails
> > out of this file. We'd need to get that to work by default though.
> >
> > > Probably even s/shmobile.yaml/renesas.yaml/, while at it?
> >
> > Sure, if that's what you all want.
>
> How about this?

LGTM

> From: Rob Herring <robh@kernel.org>
> Subject: [PATCH v2.1] dt-bindings: arm: Convert Renesas board/soc bindings to
>  json-schema
>
> Convert Renesas SoC bindings to DT schema format using json-schema.
>
> v2.1 [Simon Horman]
> - rebased on renesas-devel-20181204-v4.20-rc5
>   + Added r8a7744 development platform and SoM
>   + Correct RZ/G2E part number
> - Update MAINTAINERS
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  Documentation/devicetree/bindings/arm/renesas.yaml | 228 +++++++++++++++++++++
>  Documentation/devicetree/bindings/arm/shmobile.txt | 155 --------------
>  MAINTAINERS                                        |   4 +-
>  3 files changed, 230 insertions(+), 157 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/renesas.yaml
>  delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt
