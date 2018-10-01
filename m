Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E267C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078472084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nChDd4cg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078472084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbeJAO5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 10:57:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44171 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeJAO5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 10:57:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id v6-v6so2162659ljc.11;
        Mon, 01 Oct 2018 01:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VG4gfgwkAslPxSBir9I5/veaLPYcdwiozeknu84lV5A=;
        b=nChDd4cgOof74uSxsmneLp5tb1dPNgeyDtqToqvXCvbd/uybFovqgkfdTn/6F4Acbr
         U4rvuBVxcpuyELd2G2UpgMSWnSSRY/j/d1V1tH+ZVcS/AksTHnxsBecwZSaV7JI/6wgc
         7nVGksyNGAMuGhSXutaCk5JOdwMGpdo0Hta52xgsbT59DFUFD0HBYCQwU386bSHXO0ga
         c8ApkfPksyNEtXTKIjD8RmSoq7gIHMZayrfVzYT8mol9mPcAlKjJuY+lGS9/ObZi5LnK
         5i6FOQnKQFLq/Q/BmMgNcAk6lsUnC0h1vexeuexiLDEa60ULj6Oa/0VOHdPkCf1xEsaH
         YCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VG4gfgwkAslPxSBir9I5/veaLPYcdwiozeknu84lV5A=;
        b=HITeXcHiOTZcqHLehqetIn1ErEzmJ8LrX0jy5DUiuR8OzqQEUszwGWSxV+d0i3biEj
         lv/Pk9BK+SJSYMkCcAE9XNE//gAh4htCRb4zWZjAaDRi+1VBBXfWALyVnE5eBxu7sW2h
         FG1KxuzcX74EU4GtrMCfNnksQdEVmpx3nw+LDKSbEUUZ3LPQ24WHwNWpHYrCKxjNWknP
         DOsLhAYTyhdO79IDC+mj9rNHbB6VuTrIlubscnYET+6+2s7ACN3BbGymj9m6AoDDMS1j
         DcatgGArjq9OikpijeJY3IlAJzxZaJSIZbLl3eZ2HWNwbKxOy7AJ09p2cHK2c62mbch+
         j8Tw==
X-Gm-Message-State: ABuFfoi0gd1JD9Yw0Mmn5Bo5lzAk4trM8vtl49pbPx6+SYjuB9agp/OE
        JJEU6BiPb8WyCCIUXwo+ndaDA22w0W+TCGsqdPldyA==
X-Google-Smtp-Source: ACcGV63HwRuV7Qe6fo3WRNQIy/JeOZyHnRJXXX1lhVhnsH+kKl78CDLgsmQvrdu2chxlH6uzIP08vT5X4HAnzxmjWbE=
X-Received: by 2002:a2e:974a:: with SMTP id f10-v6mr5605627ljj.30.1538382039914;
 Mon, 01 Oct 2018 01:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180920204751.29117-1-ricardo.ribalda@gmail.com>
 <20180920204751.29117-3-ricardo.ribalda@gmail.com> <20180927182311.GA27227@bogus>
In-Reply-To: <20180927182311.GA27227@bogus>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Mon, 1 Oct 2018 10:20:23 +0200
Message-ID: <CAPybu_0CCco6M6A1JsGUTo2P7rvqN1qPnMmuee7UsXxdkmaNBw@mail.gmail.com>
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

Hi Rob
On Thu, Sep 27, 2018 at 8:23 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Sep 20, 2018 at 10:47:47PM +0200, Ricardo Ribalda Delgado wrote:
> > Document new enable-gpio field. It can be used to disable the part
>
> enable-gpios
>
> > without turning down its regulator.
> >
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > ---
> >  Documentation/devicetree/bindings/media/i2c/ad5820.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/media/i2c/ad5820.txt b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> > index 5940ca11c021..9ccd96d3d5f0 100644
> > --- a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> > +++ b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> > @@ -8,6 +8,12 @@ Required Properties:
> >
> >    - VANA-supply: supply of voltage for VANA pin
> >
> > +Optional properties:
> > +
> > +   - enable-gpios : GPIO spec for the XSHUTDOWN pin. Note that the polarity of
> > +the enable GPIO is the opposite of the XSHUTDOWN pin (asserting the enable
> > +GPIO deasserts the XSHUTDOWN signal and vice versa).
>
> shutdown-gpios is also standard and seems like it would make more sense
> here. Yes, it is a bit redundant to have both, but things just evolved
> that way and we don't want to totally abandon the hardware names (just
> all the variants).
>

Sorry to insist

The pin is called xshutdown, not shutdown and is inverse logic,
Wouldnt it make more sense to use the name
enable-gpios?

Regards

> Rob



-- 
Ricardo Ribalda
