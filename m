Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69FFC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C15206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547041088;
	bh=JEX/WA41tWLUL5lb1hLFMmeoTFpFWMJiF5NYAGjxSTU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G6rPv31TRiG0w+L37LzygcCXobH6dR9SeW84LLE1EMsVr+qa/p8D0iExUG2rFzi7+
	 T1t01isDRcJ0nHZYrd5QjA13XBe23056bKtgGHSrnQX5Mjp0bZ28qZ20gtSx9JJ1AR
	 staKq8VmMGMqO9eOKSXBsWdJ+wjXLOlEHntSHDvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbfAINiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 08:38:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729895AbfAINiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 08:38:07 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1032F206B6;
        Wed,  9 Jan 2019 13:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547041086;
        bh=JEX/WA41tWLUL5lb1hLFMmeoTFpFWMJiF5NYAGjxSTU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N17HwHV6Uq3KOlVno8G7mEQO3FIotPzcuvp30vR9FyLyDHiZV446/96uyVX1HERcQ
         5dRsAcl3/56H/wwSmbdlJrj8It9obzpdwL4FoTD8Mnb8CRIJJFxLVmvUbcyUvixmo/
         RtYuoQdyvhnY85gdYfhSztSw9gxRcxbQ5IoaQyqA=
Received: by mail-qt1-f177.google.com with SMTP id l11so8315001qtp.0;
        Wed, 09 Jan 2019 05:38:06 -0800 (PST)
X-Gm-Message-State: AJcUukfIIFwj5jrDG+uaqEZJ8KL/gKGWAQiPzr3NJ3q7kgt1adnr+1DC
        j7vxc8R/kfvZ719raldlHS3Us6xSE6xdRX+Xgw==
X-Google-Smtp-Source: ALg8bN4DF3mlKU1IdHq9PsFFWwLZFrCTjgV3TQfEMWuqUm3JVW14ptNhwGBp1WJaR2gkesmA1qAhFmiYDOVha1FGSBw=
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr5468091qta.38.1547041085191;
 Wed, 09 Jan 2019 05:38:05 -0800 (PST)
MIME-Version: 1.0
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
 <20181215151802.18592-2-jagan@amarulasolutions.com> <20190107225810.ggmkkbrnkoy2ykx5@penguin>
In-Reply-To: <20190107225810.ggmkkbrnkoy2ykx5@penguin>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 9 Jan 2019 07:37:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKTnPVM7Qahy9ejQbPfENpLCdzf5K5uUTcPh8j3EiqWRA@mail.gmail.com>
Message-ID: <CAL_JsqKTnPVM7Qahy9ejQbPfENpLCdzf5K5uUTcPh8j3EiqWRA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: input: touchscreen: goodix: Document
 AVDD28-supply property
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC DT list if you want bindings reviewed.

On Wed, Jan 9, 2019 at 1:40 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Sat, Dec 15, 2018 at 08:47:59PM +0530, Jagan Teki wrote:
> > Most of the Goodix CTP controllers are supply with AVDD28 pin.
> > which need to supply for controllers like GT5663 on some boards
> > to trigger the power.
> >
> > So, document the supply property so-that the require boards
> > that used on GT5663 can enable it via device tree.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > index f7e95c52f3c7..c4622c983e08 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > @@ -23,6 +23,7 @@ Optional properties:
> >   - touchscreen-inverted-y  : Y axis is inverted (boolean)
> >   - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
> >                               (swapping is done after inverting the axis)
> > + - AVDD28-supply     : Analog power supply regulator on AVDD28 pin
>
> I think we normally use lower case in DT bindings and rarely encode
> voltage in the supply name unless we are dealing with several supplies
> of the same kind, but I'll let Ron comment on this.

Yes on lowercase though there are some exceptions.

There's also a AVDD22 supply as well as DVDD12 and VDDIO. So we
probably need to keep the voltage, but the binding is incomplete.

Rob
