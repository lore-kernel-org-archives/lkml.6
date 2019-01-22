Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CACEC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3497820870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548164477;
	bh=prFZcRP2SYee4GKipvHLC7KZ4SliP42MtaVyeVdlh2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dJapRjAcNwg4KOXFqqk/9zE6mVKm7FlFZmiu9cB7guPbxhEuRpLgjtd6n5yQg1uMZ
	 uy+2u5uW24BtnK1Dulx58Mw+C1E+tK9l5G2DroQ9eGl3JrrsRPodMlXGu4akYTaWJP
	 lIVn+NUnhrqssd8RxrwJj/vEL8566ZOygylTayTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfAVNlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:41:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728549AbfAVNlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:41:15 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE882217D4;
        Tue, 22 Jan 2019 13:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548164474;
        bh=prFZcRP2SYee4GKipvHLC7KZ4SliP42MtaVyeVdlh2A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BOQ4ycYlTLpc5uezYKUMOrfAXHswWDBGXLvrEItfClni52ctYZ3ku+tGxWE3R5D/R
         2HQw3j3kKgTMt7rAMeCTJqbTydKGnWHtkywb7Vc9t4ii/UUVcGRUuQrku/Y9g8EifT
         O+MduOUFFlrmHjm7zJyBXowCguQEWv1pzoRIIUcQ=
Received: by mail-qt1-f180.google.com with SMTP id i7so27510496qtj.10;
        Tue, 22 Jan 2019 05:41:14 -0800 (PST)
X-Gm-Message-State: AJcUukde82lOpOcwhzQhwMsTeJ38Wv/CTQaoccOCKLaHY9uMg5swkHZt
        sgcciCKPbpHqImTD14+ADJ8S4lTDr2LlKwhWhg==
X-Google-Smtp-Source: ALg8bN695c+L8pmAwWxgWUmilJnYICCOItILluOzhBlnIdnXOahwthK245Edsf20/kfKy9PIhPJMGlZImkUi73OcWwQ=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr31349294qts.144.1548164473958;
 Tue, 22 Jan 2019 05:41:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <0005c2ef28b985c663e0cd058bbc6d3856e05ec2.1547629763.git.nicolas.ferre@microchip.com>
 <20190122011014.GA25211@bogus> <be8ba0bf-993e-d38c-61e8-af422ff3c636@microchip.com>
In-Reply-To: <be8ba0bf-993e-d38c-61e8-af422ff3c636@microchip.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 22 Jan 2019 07:41:02 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+31C2KXNy_GeVU9g7mZ_aSw3yqdjU-V5mV2Xdc200TuA@mail.gmail.com>
Message-ID: <CAL_Jsq+31C2KXNy_GeVU9g7mZ_aSw3yqdjU-V5mV2Xdc200TuA@mail.gmail.com>
Subject: Re: [PATCH 4/8] net/macb: bindings doc/trivial: fix documentation for
 sama5d3 10/100 interface
To:     Nicolas Ferre <Nicolas.Ferre@microchip.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sebastian Reichel <sre@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 3:09 AM <Nicolas.Ferre@microchip.com> wrote:
>
> Hi Rob,
>
> On 22/01/2019 at 02:10, Rob Herring wrote:
> > On Wed, Jan 16, 2019 at 10:57:40AM +0100, Nicolas Ferre wrote:
> >> This removes a line left while adding the correct compatibility string for
> >> sama5d3 10/100 interface. Now use the "atmel,sama5d3-macb" string.
> >>
> >> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> >> ---
> >>   Documentation/devicetree/bindings/net/macb.txt | 3 +--
> >>   1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/net/macb.txt b/Documentation/devicetree/bindings/net/macb.txt
> >> index 3e17ac1d5d58..f5c414b10e27 100644
> >> --- a/Documentation/devicetree/bindings/net/macb.txt
> >> +++ b/Documentation/devicetree/bindings/net/macb.txt
> >> @@ -3,8 +3,7 @@
> >>   Required properties:
> >>   - compatible: Should be "cdns,[<chip>-]{macb|gem}"
> >>     Use "cdns,at91rm9200-emac" Atmel at91rm9200 SoC.
> >> -  Use "cdns,at91sam9260-macb" for Atmel at91sam9 SoCs or the 10/100Mbit IP
> >> -  available on sama5d3 SoCs.
> >> +  Use "cdns,at91sam9260-macb" for Atmel at91sam9 SoCs.
> >
> > Where is "atmel,sama5d3-macb"?
>
> It's actually a couple of line below: line 13 of the resulting macb.txt
> file. It was already in the file when I removed the leftovers.
>
> Do you advice to try to better sort entries in this file? Is there a
> common pattern?

Okay, it's fine.

Reviewed-by: Rob Herring <robh@kernel.org>
