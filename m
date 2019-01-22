Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994A9C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6937720870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548164443;
	bh=esbp9yipemWFMphPhojg5duibYbaUh0JWxIadTVP0vY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0Dq5Ar9n6GdQhPul2r1UMpT497wcP0KkG3Ct9pwb6WANh4pqH0pg1UGJJWheh0E4/
	 8IP7NzEPVfvAic2GDtxN7xi1eZBX4xYVecC02VEkpUSNEe/5WE3i89BTO4aUTnjvmp
	 vHooQRB0Asy6R4ETHAU61B+ehT8cAPYhNp8jDJ1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbfAVNkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:40:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbfAVNkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:40:41 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A89920870;
        Tue, 22 Jan 2019 13:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548164440;
        bh=esbp9yipemWFMphPhojg5duibYbaUh0JWxIadTVP0vY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NPH9i+oUre4ZzBzURZisLcgijhVu68l0fyNbD1HBoOYXzIBIM2F8oi+ISdjS3rZcO
         6kNGyXcHK7ABrzq6aKJxQrBU3B1MsVYRyWgN+9WM02/EavoUThA3n7Uhcw0eC3uOCD
         7FIeWBPZzEaDam+sNvgHhyMenn0uW6ompduZsIb0=
Received: by mail-qt1-f181.google.com with SMTP id d19so27513354qtq.9;
        Tue, 22 Jan 2019 05:40:40 -0800 (PST)
X-Gm-Message-State: AJcUukfoeiFn27tegQjGaLd69qBeb/+l8YRpriMAL899LnmbzSynP0FY
        0zprlP+mWgNP2leS07dPtlw+UmQivktfEH+XNw==
X-Google-Smtp-Source: ALg8bN6VWQGgEZg/m39bTZGl5i9AbykXudTG4rdsmuBKNFX7AihzzCAkCGIaaG+cZcAC9tqIVmkzewOr+lMujKnbjoI=
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr30157262qta.38.1548164439355;
 Tue, 22 Jan 2019 05:40:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <ed46005be5beff6efc47d40cea304185efa2bcc0.1547629763.git.nicolas.ferre@microchip.com>
 <20190122010733.GA21139@bogus> <24a53365-1a8c-51cd-dcd4-db4a69d5256a@microchip.com>
In-Reply-To: <24a53365-1a8c-51cd-dcd4-db4a69d5256a@microchip.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 22 Jan 2019 07:40:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLb3W=UG5VRFheGd2CfS+8rb5pJpHmHNq2bb1zrR3mEwA@mail.gmail.com>
Message-ID: <CAL_JsqLb3W=UG5VRFheGd2CfS+8rb5pJpHmHNq2bb1zrR3mEwA@mail.gmail.com>
Subject: Re: [PATCH 2/8] dt-bindings: arm: atmel: add new sam9x60 reset
 controller binding
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

On Tue, Jan 22, 2019 at 3:00 AM <Nicolas.Ferre@microchip.com> wrote:
>
> Hi Rob,
>
> On 22/01/2019 at 02:07, Rob Herring wrote:
> > On Wed, Jan 16, 2019 at 10:57:38AM +0100, Nicolas Ferre wrote:
> >> Update the Reset Controller's binding to add new SoC compatibility string.
> >>
> >> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> >> ---
> >>   Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> >> index 36952cc39993..badce6ef3ab3 100644
> >> --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> >> +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> >> @@ -22,6 +22,7 @@ Its subnodes can be:
> >>   RSTC Reset Controller required properties:
> >>   - compatible: Should be "atmel,<chip>-rstc".
> >>     <chip> can be "at91sam9260", "at91sam9g45", "sama5d3" or "samx7"
> >> +  it also can be "microchip,sam9x60-rstc"
> >
> > How is this related to at91sam9260-rstc?
>
> at91sam9260 and sam9x60 are completely different products (they share
> the same core though...). I know the naming could be misleading but it
> is like it is...
>
> > The 'x' is a wildcard? We generally avoid wildcards.
>
> Here, the 'x' is definitively not a wildcard nor a kind of "family"
> name, it's included in the (upcoming) single product's name.
>
> I hope it clarifies.

Yes, thanks.

Reviewed-by: Rob Herring <robh@kernel.org>
