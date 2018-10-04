Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F410C00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 01:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BC92098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 01:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ecin5W3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BC92098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJDHvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 03:51:50 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43069 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbeJDHvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 03:51:49 -0400
Received: by mail-oi1-f196.google.com with SMTP id s69-v6so6110234oie.10;
        Wed, 03 Oct 2018 18:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yzv8j5nNfSqSo8yLZdF6AXL8KtZq50GbDQcajX7W0MQ=;
        b=Ecin5W3LvMebovdxOnx/G7VJXG1Uszry2NERF/cbjFHNwEKlpfHfLJ2IylH0DO48f5
         8ZsAo0kanpXmWvyWcoec3NjLOBYltKI5USaC6MhjQcUXkI4+0XPbTtuPPgd/Y4+1u09Q
         vA/+UY7IMGSgsdcEnfVpRD8Vdd6aiXYCSn8A6h8carlNNf6RqxGhkev8UXwZHMBKXqXg
         s9LLlZgUUJQwyrkEb/zkqyidhl1BPJFSjZtQwrvJLP0iUXf+z3jL2qFmMwbxCo2wz2MF
         tV2sBp1rx7cQ1ETJ6aylmQrNwyDhuxuE5NTcHryFajW5lSPE6oEYYMucytDpz1icKLjV
         8jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yzv8j5nNfSqSo8yLZdF6AXL8KtZq50GbDQcajX7W0MQ=;
        b=Sf6Rtvo631j8mARmuDpzF0qfBIL2E8f9bYUdJq8iUTfshn+ZdzpWcVVwbd4372VU6N
         6fndNxyYTk/9Lr5vMONUVz2Olzfe0PGSbOcBMtqvNrWg37eKsIRq7trSjvdmwjdDpxYe
         97Smw6o+Q6cJyyHikm1Vr/WpIz02wI88cUP5EGL0vpqhLmxfCNszKgDf4w9U6XONfUqW
         jogn/7vtdd5AHjA+tycnunrLGHTLh6QQlb7jkBKxUuCWDa1P/YLeKwLGWf4QCKp0iB2w
         Finh+CY2P4MF8+eWEzRdxYszrKu6XN6DZXMdKC/ewIyHGC5SLvGmfRkWD1xDxQ4jxli9
         Ckpw==
X-Gm-Message-State: ABuFfoiCqDdr2JfS4dCwT7JXkRMd3UUsWZWJyav10zhBqM8Vpjs3brBK
        LTkxT8njD0+utu0uLqSVm7+MLKimWTz3YcH4FLI=
X-Google-Smtp-Source: ACcGV62pcCl6GwIpzQ5fG7Rf5CRjRX9VMseqjonaQLPZnnLpUVorqXOhEoVVlD2RVBT5CGEJ0b8As1w5Phe+A+654SQ=
X-Received: by 2002:aca:2cc6:: with SMTP id s189-v6mr2065318ois.72.1538614860840;
 Wed, 03 Oct 2018 18:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180928020816.11251-1-leobras.c@gmail.com> <20180928020816.11251-6-leobras.c@gmail.com>
 <20181001124617.GA3185@osiris>
In-Reply-To: <20181001124617.GA3185@osiris>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Wed, 3 Oct 2018 22:00:49 -0300
Message-ID: <CADvQ+rHDB390FWW5cPrmJqDobkv-R2K1B7-potVtTLp0RfUS-Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] drivers: s390: Avoids building drivers if ARCH is
 not s390.
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     lkcamp@lists.libreplanetbr.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Robert Richter <rric@kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 9:46 AM Heiko Carstens <heiko.carstens@de.ibm.com> w=
rote:
>
> On Thu, Sep 27, 2018 at 11:08:14PM -0300, Leonardo Br=C3=A1s wrote:
> > Avoids building s390 drivers if 'make drivers/s390/' is called but
> > ARCH is not s390.
> >
> > Signed-off-by: Leonardo Br=C3=A1s <leobras.c@gmail.com>
> > ---
> >  drivers/s390/Makefile | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/s390/Makefile b/drivers/s390/Makefile
> > index a863b0462b43..0575f02dba45 100644
> > --- a/drivers/s390/Makefile
> > +++ b/drivers/s390/Makefile
> > @@ -3,7 +3,7 @@
> >  # Makefile for the S/390 specific device drivers
> >  #
> >
> > -obj-y +=3D cio/ block/ char/ crypto/ net/ scsi/ virtio/
> > -
> > -drivers-y +=3D drivers/s390/built-in.a
> > -
> > +ifeq ($(ARCH),s390)
> > +     obj-y +=3D cio/ block/ char/ crypto/ net/ scsi/ virtio/
> > +     drivers-y +=3D drivers/s390/built-in.a
> > +endif
>
> And then somebody wants to build with e.g. "make drivers/s390/cio/" and i=
t
> still doesn't work. So _if_ this should be supported then it should work
> with all directory levels and all configuration options. Otherwise this i=
s
> going to be a never ending story.
>


It makes sense.
I proposed this change to help me solving a problem described here
(https://lkml.org/lkml/2018/10/3/707), and for this it was enough if it did=
n't
build when "make drivers/s390/" was called.

Sorry I didn't send the e-mail with the reason earlier.

For solving my problem it was not necessary, but if you think it's interest=
ing,
I could refactor all drivers/s390 Makefiles to make them all build only if
we are dealing with the s390 architecture.

What do you think?

Thanks for the reply,

Leonardo Bras
