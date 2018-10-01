Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FB3C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465CC20684
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfBxwEnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465CC20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbeJATR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:17:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40556 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbeJATR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:17:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id r83-v6so11972718ljr.7;
        Mon, 01 Oct 2018 05:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kY1SJCMCORML/zGf/7bi646MfXTL+FMmcDcULCtL8eY=;
        b=RfBxwEnJaV1lRI44ECdSFtNJjQF+sbuD9dVM2M6QGJPS0+apJyHfMP43cdy3x9oPSE
         e4ycGpT4jx/omMDzzDCvd/J213X1BDRteVmcwWPgyBWs1/XiPWZhbdJA9zNzAixyjpa3
         7Te4gdhJ7/zwgQU2ZO7PSBJGOOqr0/SDTZHjrDkQYMfHGfHbh+JygVfIDs76CVxGU9Hj
         vc30cvfeTQv3n4IPa/jirjOCRzVHvPljOk0oWMnQU3IuvHdfxcFxVUdwOHz1NK56l7b7
         diHq4a3LYb5AmpSH851WabXdxCiO3drpgc2fhOFFHjF70OOemLiRH30hI/DbSsZvR4bj
         TKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kY1SJCMCORML/zGf/7bi646MfXTL+FMmcDcULCtL8eY=;
        b=WTXmGH1stTyBuyBfwE+RMj1v2j3j7/h5kvlupfsHKwiDolV1UUIE3Q69kmIXumDE9v
         CXwAvTtob+Ggy7rcS1uA7dGaHWUGoXAEd9hy0gqV3EftC6OaGgE7OiD3uhaNM0jMTbyM
         koOHWCAtCDo6xe2d25AzTJ5frd4dHf95xzTHYikd2oeUMT9P1pnnZ7frdRk8VoAlLUP4
         x61lgGK18KdsAdDDFbd3wHyET975/zMFAqppdYhk8hJ7cOvW4ycNH4dXNjYUG1aUlSzK
         NrV0o2e+jgYQBI5awXyhlt32YUJo16GUUZHZMi6yPqbH6mqJxfPXDHP443zSz/xAeL8s
         RAwg==
X-Gm-Message-State: ABuFfoiHtNhi4rTWczbRkFRX9+6vcpZDulC/W2PS8gd33tun08bXVEQQ
        K8Tq9I7p7DG7s+BTLt762bJNwLUwXnjTqjPUZ9Q=
X-Google-Smtp-Source: ACcGV61Qkz6By7foIGLEABT/jMekQHdWPsrxtKhAG0wuWpKzjUBuZvh7o+8AK5/cO4wIFJCwH1V45M37zFmNFf6/eQo=
X-Received: by 2002:a2e:811:: with SMTP id 17-v6mr6203076lji.140.1538397619109;
 Mon, 01 Oct 2018 05:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180920204751.29117-1-ricardo.ribalda@gmail.com>
 <20180920204751.29117-3-ricardo.ribalda@gmail.com> <20180927182311.GA27227@bogus>
 <CAPybu_0CCco6M6A1JsGUTo2P7rvqN1qPnMmuee7UsXxdkmaNBw@mail.gmail.com> <CAL_JsqLM9E45nvSToQV=XDwTmppkYcsPd-Ddzy+AJ8GP==aL+A@mail.gmail.com>
In-Reply-To: <CAL_JsqLM9E45nvSToQV=XDwTmppkYcsPd-Ddzy+AJ8GP==aL+A@mail.gmail.com>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Mon, 1 Oct 2018 14:40:02 +0200
Message-ID: <CAPybu_0+F-o03qfg6u3RjgCJaeqzEoma4Niz-H9=0bSHJo+9jg@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] [media] ad5820: DT new optional field enable-gpios
To:     Rob Herring <robh@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
On Mon, Oct 1, 2018 at 2:36 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Oct 1, 2018 at 3:20 AM Ricardo Ribalda Delgado
> <ricardo.ribalda@gmail.com> wrote:
> >
> > Hi Rob
> > On Thu, Sep 27, 2018 at 8:23 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Thu, Sep 20, 2018 at 10:47:47PM +0200, Ricardo Ribalda Delgado wrote:
> > > > Document new enable-gpio field. It can be used to disable the part
> > >
> > > enable-gpios
> > >
> > > > without turning down its regulator.
> > > >
> > > > Cc: devicetree@vger.kernel.org
> > > > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > > ---
> > > >  Documentation/devicetree/bindings/media/i2c/ad5820.txt | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/media/i2c/ad5820.txt b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> > > > index 5940ca11c021..9ccd96d3d5f0 100644
> > > > --- a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> > > > +++ b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> > > > @@ -8,6 +8,12 @@ Required Properties:
> > > >
> > > >    - VANA-supply: supply of voltage for VANA pin
> > > >
> > > > +Optional properties:
> > > > +
> > > > +   - enable-gpios : GPIO spec for the XSHUTDOWN pin. Note that the polarity of
> > > > +the enable GPIO is the opposite of the XSHUTDOWN pin (asserting the enable
> > > > +GPIO deasserts the XSHUTDOWN signal and vice versa).
> > >
> > > shutdown-gpios is also standard and seems like it would make more sense
> > > here. Yes, it is a bit redundant to have both, but things just evolved
> > > that way and we don't want to totally abandon the hardware names (just
> > > all the variants).
> > >
> >
> > Sorry to insist
> >
> > The pin is called xshutdown, not shutdown and is inverse logic,
> > Wouldnt it make more sense to use the name
> > enable-gpios?
>
> Inverse of what? shutdown-gpios is the inverse of enable-gpios. By
> using shutdown-gpios you can just get rid of "Note that the polarity
> of the enable GPIO is the opposite of the XSHUTDOWN pin (asserting the
> enable GPIO deasserts the XSHUTDOWN signal and vice versa)."

The pin is called XSHUTDOWN

0V means shutdown

3.3V means enable

This is why I think is more clear to use enable as name in the device tree.

>
> This looks to me like a case of just standardizing the name so for
> example we just have "reset" instead of many flavors like rst, RSTb,
> RESETb, RESETn, nRESET, etc.
>
> Rob



-- 
Ricardo Ribalda
