Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFBDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37502086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVX38tyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37502086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbeK0GTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:19:33 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46639 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbeK0GTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:19:31 -0500
Received: by mail-oi1-f194.google.com with SMTP id x202so16926601oif.13;
        Mon, 26 Nov 2018 11:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AvfIZ9PB1dFlppUzJKR1909FJIJrzR+QBaeS3Cpmn9w=;
        b=SVX38tyoPh+Ne0hZ4ujiqVS3FY9BW7IyBp9zzj9KEj6shQAl+X/ODvU61qvCO5fD2r
         mUesX+qfnBKb9mYtmljgwOS/ijdZZ2zGzhkRVIqjOT1TPWGo+LKmaDz7QUXxNulCD4lE
         ONd78mQb+hHADpOag08TDvikUporiCcLxzCnSNHxrKfyUGZ5EcVDxgp6jDXZghgpTwhq
         hWH1zj6sjcwM4Z/w3j+/tuAbHz+hIv/Y2LaBddlgppeQFi31IZi4lHq9qt1jF2/0cts8
         wjOKsrJFc0r50i2+PfX1x5IpY0SscoB3Ig+np68lW/Rxgww7QzM2mbDb1pS1IjYiMKDZ
         gOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AvfIZ9PB1dFlppUzJKR1909FJIJrzR+QBaeS3Cpmn9w=;
        b=RBPNbEGTIeiZo/AAmElywdK5cbLcnES0mFZ3Q5TqX0QDbe68z/Xbbw7IqPdpVqgSvS
         PNIm9VHi+KNijsi3d9DgP7x9AyhWbtI1GCNbyUCg1pNYC08PU0lJI4E2Wp8dF+fQi1BY
         IsYjDroYuPVg570lI44r3bE87bN6KL3qHYAC92YixfdZhWcuiyTt4atkfBCgKsMfiszP
         xzOuS4XHS586puIjl25vmZTFDS18AkIfF5sxnEYvXG0ob9MSs3w1X6pgSDww+EXLtBm4
         rQlMl2BlW5qpZsM/XS4T9n2lhxy157+eMBesCtFz/7pUwJRb6CWUALwjpdm/htGqS+nz
         A1fQ==
X-Gm-Message-State: AGRZ1gJ3ECDWtPvvJDorHQTREaGq3s6YwXf0nYOlkZHS7r4jkMkK2itv
        EtPx3pXCPxzzvxlVFrU1qeSBsOfDY+/aZzb1rEU=
X-Google-Smtp-Source: AJdET5fpJOHg+9C+1W9jpnQDVdAcrdgSvWNcxEUcsvBZ0ezDrNFQBhguDY/BRM6erCbRAQf3aDKrqO/IhEYgCGPkdJg=
X-Received: by 2002:aca:a60d:: with SMTP id p13mr16745510oie.2.1543260265055;
 Mon, 26 Nov 2018 11:24:25 -0800 (PST)
MIME-Version: 1.0
References: <20181121180443.tjgcpu2webrq53rh@smtp.gmail.com>
 <1542884458.30645.22.camel@analog.com> <20181125110839.4a3aecf9@archlinux>
In-Reply-To: <20181125110839.4a3aecf9@archlinux>
From:   Giuliano Belinassi <giuliano.belinassi@gmail.com>
Date:   Mon, 26 Nov 2018 17:24:13 -0200
Message-ID: <CAG4RSAHcEYj5bUpxT8apwXZZpWkPowFJ333tZiTHhb9VVn4m7g@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: ad7780: Add gain & filter gpio support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     StefanSerban.Popa@analog.com,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thank you for the review

> On Thu, 22 Nov 2018 11:01:00 +0000
> "Popa, Stefan Serban" <StefanSerban.Popa@analog.com> wrote:
> > I think that instead of setting the gain directly, we should use
> > the IIO_CHAN_INFO_SCALE attribute. At page 12 of the ad7780 datasheet t=
here
> > is a formula from which the output code can be calculated:
> > Code =3D 2^(N =E2=88=92 1)
> > =C3=97 [(AIN =C3=97 Gain /VREF) + 1]. So, by setting the scale from use=
r space, the
> > driver can calculate the correct gain by using the formula above. Also,=
 it
> > would be useful to introduce scale available.
> > Furthermore, there is a new
> > ad7124 adc driver which does this exact thing. Take a look here: https:=
//gi
> > thub.com/analogdevicesinc/linux/blob/master/drivers/iio/adc/ad7124.c#L3=
37.

We have some questions about the code you provided to us:
  1-) What is exactly the inputs for the write_raw function?
  2-) Could you give more details about the math around lines 346-348?
Is it correct to assume that the multiplication at line 346 won't
overflow? (vref is an uint)

And regarding our code:
  1-) The val in our write_raw function should be, in case of GAIN, a
number that best approximate the actual gain value of 1 or 128? For
instance, if the user inputs 126, we should default to 128?
  2-) In the case of FILTER, is it the same? Is the user sending the
value in mHz (milihertz)?

Thank you
