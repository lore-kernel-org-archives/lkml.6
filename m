Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC66C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DC520684
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZxErydO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DC520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbeJATOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729134AbeJATOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:14:11 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBFFE20C0A;
        Mon,  1 Oct 2018 12:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538397395;
        bh=HCnBavlSe47ZyqtIPKCMc6g8D+Y87ZmL7Hr2WAnld60=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XZxErydOY/d2UD1xi8MmpPOEgn2FeIl7Xqc/Hxm/7iZ/cSfx5RNWbo6JCCRrOZIoc
         yYvf/ig6Kag42Ua128f+jetOEd0y0D6gnHX73O9dNfuqgXq/IFs6j/1EzrCPbMKSeg
         PRIYKg0dUOhY/9UgK97FIJ+eDhcKvkV+sR4SF9Gs=
Received: by mail-qt1-f175.google.com with SMTP id u34-v6so3090670qth.3;
        Mon, 01 Oct 2018 05:36:34 -0700 (PDT)
X-Gm-Message-State: ABuFfohbyiaZy5Lgmmi6dSx1osbPPEQ+fqq2zgrnFSp7JUcdOVkVViaT
        VLYSbes1lT11T4dm9nBkpjMkF8V0bOb2g3aJPA==
X-Google-Smtp-Source: ACcGV62yAiDXAhkuhnr6hPtnk4ru+WPuxAG94mv4Y5mcT7KFudxlnY8oUwiIo13Xg2LevcBapTmRgODoOPWUb0Sv418=
X-Received: by 2002:a0c:d4c3:: with SMTP id y3-v6mr8472819qvh.106.1538397393974;
 Mon, 01 Oct 2018 05:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180920204751.29117-1-ricardo.ribalda@gmail.com>
 <20180920204751.29117-3-ricardo.ribalda@gmail.com> <20180927182311.GA27227@bogus>
 <CAPybu_0CCco6M6A1JsGUTo2P7rvqN1qPnMmuee7UsXxdkmaNBw@mail.gmail.com>
In-Reply-To: <CAPybu_0CCco6M6A1JsGUTo2P7rvqN1qPnMmuee7UsXxdkmaNBw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 1 Oct 2018 07:36:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLM9E45nvSToQV=XDwTmppkYcsPd-Ddzy+AJ8GP==aL+A@mail.gmail.com>
Message-ID: <CAL_JsqLM9E45nvSToQV=XDwTmppkYcsPd-Ddzy+AJ8GP==aL+A@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] [media] ad5820: DT new optional field enable-gpios
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 3:20 AM Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
>
> Hi Rob
> On Thu, Sep 27, 2018 at 8:23 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Sep 20, 2018 at 10:47:47PM +0200, Ricardo Ribalda Delgado wrote:
> > > Document new enable-gpio field. It can be used to disable the part
> >
> > enable-gpios
> >
> > > without turning down its regulator.
> > >
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > ---
> > >  Documentation/devicetree/bindings/media/i2c/ad5820.txt | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/media/i2c/ad5820.txt b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> > > index 5940ca11c021..9ccd96d3d5f0 100644
> > > --- a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> > > +++ b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> > > @@ -8,6 +8,12 @@ Required Properties:
> > >
> > >    - VANA-supply: supply of voltage for VANA pin
> > >
> > > +Optional properties:
> > > +
> > > +   - enable-gpios : GPIO spec for the XSHUTDOWN pin. Note that the polarity of
> > > +the enable GPIO is the opposite of the XSHUTDOWN pin (asserting the enable
> > > +GPIO deasserts the XSHUTDOWN signal and vice versa).
> >
> > shutdown-gpios is also standard and seems like it would make more sense
> > here. Yes, it is a bit redundant to have both, but things just evolved
> > that way and we don't want to totally abandon the hardware names (just
> > all the variants).
> >
>
> Sorry to insist
>
> The pin is called xshutdown, not shutdown and is inverse logic,
> Wouldnt it make more sense to use the name
> enable-gpios?

Inverse of what? shutdown-gpios is the inverse of enable-gpios. By
using shutdown-gpios you can just get rid of "Note that the polarity
of the enable GPIO is the opposite of the XSHUTDOWN pin (asserting the
enable GPIO deasserts the XSHUTDOWN signal and vice versa)."

This looks to me like a case of just standardizing the name so for
example we just have "reset" instead of many flavors like rst, RSTb,
RESETb, RESETn, nRESET, etc.

Rob
