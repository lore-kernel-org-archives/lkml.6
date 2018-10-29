Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCE9C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356FB2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="ICFJACvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356FB2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbeJ2Shi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:37:38 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38940 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729490AbeJ2Shi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:37:38 -0400
Received: by mail-ua1-f67.google.com with SMTP id j38so2742318uae.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vD2aM5YFPo6bS2ROTaVOqQdcMrkuUsGl1K13WoGDC6Q=;
        b=ICFJACvsbcA6FRARfuD3zB7Ncbfvua4+qU1cCZ636QXG8LmMCZqbp4ATmuCOvtPQOx
         R2jjnu0Cr+1r4cCW4QcP97zwtn/fTcoeSiwMl/lbWoHde/MWU5GlgnNNCK6MUxcoRo71
         YuVpsu53tmxbCg5GOeQrOK2FI7bUyDLUOt9yj+9I8CN8Q84R6G8O+D2tDk8QVNDm35G6
         2mDnvpWPdd7x5SeOqrXDSdYr/Udm/kqSFRF7oW3M9pjVUbGEPXPUe7PmYUiZfszSHPsA
         SpN7AQTOhbrgJsY7QYv8DNdpgA09wPcdKb7YbP0isEVaAXPlurxaeBMyAxwHeCiuDBR1
         Hu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vD2aM5YFPo6bS2ROTaVOqQdcMrkuUsGl1K13WoGDC6Q=;
        b=SmDmsvsbA8r6Kzeucf8FdB2MbZ7B7NLAqetTsHKka52EgIGo5+BuVuYZb+ksbbCD52
         1u6huzTUoLqP+lo2a8RZ0MeCZJyTFsQ8PpOSJTgD0SK+nuJm9S3cVgkMY6ufFzpVIG2v
         rwsZksVPsaDTsc3lUf2UQnO+/798ul0MomTt42HXQwLvAOmIJYDFnqI2l281t9TMgqPr
         h4zzA+yU5JKBoujKi5xEHrMUY5R8TwJ1/DISCN4K5OWG3aYDP8/Jc16skNiWlMYO+aSm
         tXIqw1p8cxlFadA97zXWqKLL4mKLxzVxd+svIlg8iGufHzIEbPdkLYVQPCqZqnP1PeRU
         0/ng==
X-Gm-Message-State: AGRZ1gI3WpUsHvKDg+IS/Tmniow4mF6Y4tHvmro3+qmvBz+7ztz2kdxC
        xTHqQYiIZK9gDzHlp0cFBUkRx65duCl05ZTwjnq/LQ==
X-Google-Smtp-Source: AJdET5e8RYeI5rpFbwauKF8Rinmh7BNsIZV7aUlmGavBmDnpOafcht9svQgQhhrDGRGBhbsqrfw+YB65R/q+LqASJ+Y=
X-Received: by 2002:ab0:5648:: with SMTP id z8mr5143924uaa.126.1540806582291;
 Mon, 29 Oct 2018 02:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <1539696935-4433-1-git-send-email-gilad@benyossef.com>
 <1539696935-4433-3-git-send-email-gilad@benyossef.com> <20181025001221.GA12740@bogus>
In-Reply-To: <20181025001221.GA12740@bogus>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Mon, 29 Oct 2018 11:49:31 +0200
Message-ID: <CAOtvUMd9W9HvFuXRH=LAyQYLnvL_hmwv703LzE-aA=2OSsVHMQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] crypto: ccree: add dt bindings for ccree 713
To:     robh@kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Ofir Drang <Ofir.Drang@arm.com>,
        Yael Chemla <Yael.Chemla@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 3:12 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Oct 16, 2018 at 02:35:32PM +0100, Gilad Ben-Yossef wrote:
> > Add device tree bindings associating Arm TrustZone CryptoCell 713 with =
the
> > ccree driver.
>
> "dt-bindings: crypto: ..." for the subject.
> >
> > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> > ---
> >  Documentation/devicetree/bindings/crypto/arm-cryptocell.txt | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/crypto/arm-cryptocell.tx=
t b/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
> > index 999fb2a..880de07 100644
> > --- a/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
> > +++ b/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
> > @@ -1,8 +1,9 @@
> >  Arm TrustZone CryptoCell cryptographic engine
> >
> >  Required properties:
> > -- compatible: Should be one of: "arm,cryptocell-712-ree",
> > -  "arm,cryptocell-710-ree" or "arm,cryptocell-630p-ree".
> > +- compatible: Should be one of: "arm,cryptocell-713-ree",
> > +  "arm,cryptocell-712-ree", "arm,cryptocell-710-ree" or
> > +  "arm,cryptocell-630p-ree".
>
> Please format 1 per line.
>

Will do.
Thanks for the review.

I will send a corrected patch.

Gilad


--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
