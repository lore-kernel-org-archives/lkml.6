Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DC7C00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D139E20856
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJrldm7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D139E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeJDHWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 03:22:34 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45265 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeJDHWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 03:22:34 -0400
Received: by mail-ot1-f68.google.com with SMTP id u22so7424977ota.12;
        Wed, 03 Oct 2018 17:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R+dtvBQ5vifUuwhHK/ej78dQsixVnGbZ7jJdlo78PHw=;
        b=SJrldm7iBWAljVlhlc+d//ZXOiScUGyrvn0nfz/TVyruGYf9BGZ4qv/+kb0f4NIAFu
         x+M+wCgnfikBjtl+WM9HQFFWWdIC6ETQhcpuBXfuYq0xlIK7fu7wZFLV+RNTG60mlrEI
         TsPV2Is7V5d3vY72UbBeFe+J1VXWLtKUEKUBFOcy/rU0ubChVxMQ7pnEfEjgHPZaBjPr
         c6alvYI4UQ+AuFKD0aScKiUXBcPi1YNG0fbX0u6iuGa+RbHyFeMZxaf6KGaJvQOHeCEw
         /cvdXda4+T7nI0/JJ4XkQFIErAi3nCb0Sz2vGuWtqM4xEvtghK6ERhNgeXrRWUW63ojd
         YtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R+dtvBQ5vifUuwhHK/ej78dQsixVnGbZ7jJdlo78PHw=;
        b=Ftrwa4Z9Ry57II4uDHc/ki4h/22DUsUfDk2Frck0GFZKU2OxnK2nJj4TGIwWx+yveE
         cunS6sJ+y1m2k/MXrUOqWu3utb7QHu/jDvOx2z5dpMLRtoLFL35AUL/qQEmX5UWNpPBF
         PiZ1TE+AYhUUwZVgE/8vI6XrtcT2kwe3f28MLydv6+OCRQtsJzQOj1PK4v/rCW/p4NbG
         6QmUbscrWdaZvHc9yQ1mr0PPLDI9spBuJiXE34376DTLipmyacLeTZ1E+AIQeHITuw8b
         lHBwQiKoDrVyfbG/V3dY8LHanAhQSCx+mRc4BjgJIrd69KmgEjGI5RExCxSn3Q35qkdP
         oNdQ==
X-Gm-Message-State: ABuFfogXfv6owMdo1PANh28rz4JL9uXHplzm5VvSRflIAlMaeN/K1Qqz
        5q0zoAHpgWu8QaWmyshoF+1OIUx3N4qRs0Is9vQkkkNN
X-Google-Smtp-Source: ACcGV60+dsAqUrSUyDg1PR2+KPx3JPDkFgz50/Fc1CRolEoFmQGNXEkiI04ZacRfcw/q7HCXbnkwO5XdMWuQkwJJBSA=
X-Received: by 2002:a9d:63d6:: with SMTP id e22-v6mr2388749otl.233.1538613110755;
 Wed, 03 Oct 2018 17:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180928020816.11251-1-leobras.c@gmail.com> <20180928020816.11251-4-leobras.c@gmail.com>
 <1538118915.3593.4.camel@HansenPartnership.com>
In-Reply-To: <1538118915.3593.4.camel@HansenPartnership.com>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Wed, 3 Oct 2018 21:31:39 -0300
Message-ID: <CADvQ+rGQenkoE0xCRTwjA5BuKZbZ2Upkyx=+qWFUGnUcit-aCQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] drivers: parisc: Avoids building driver if
 CONFIG_PARISC is disabled
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     lkcamp@lists.libreplanetbr.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Robert Richter <rric@kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
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

On Fri, Sep 28, 2018 at 4:15 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Thu, 2018-09-27 at 23:08 -0300, Leonardo Br=C3=A1s wrote:
> > Avoids building driver if 'make drivers/parisc/' is called and
> > CONFIG_PARISC is disabled.
>
> Is that really a problem? The drivers/Makefile has this:
>
> obj-$(CONFIG_PARISC)            +=3D parisc/
> And you just overrode that by forcing the build.  It's not even clear
> we should refuse the build in that case; how would we know you don't
> have a legitimate reason for the override?
>

Sorry I did not explained my reasons earlier. I sent everybody involved an
e-mail explaining the full reason of this change.
(For reference it's here: https://lkml.org/lkml/2018/10/3/707)

> Signed-off-by: Leonardo Br=C3=A1s <leobras.c@gmail.com>
> > ---
> >  drivers/parisc/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/parisc/Makefile b/drivers/parisc/Makefile
> > index 3cd5e6cb8478..80049d763aa0 100644
> > --- a/drivers/parisc/Makefile
> > +++ b/drivers/parisc/Makefile
> > @@ -24,5 +24,5 @@ obj-$(CONFIG_EISA)          +=3D eisa.o
> > eisa_enumerator.o eisa_eeprom.o
> >  obj-$(CONFIG_SUPERIO)                +=3D superio.o
> >  obj-$(CONFIG_CHASSIS_LCD_LED)        +=3D led.o
> >  obj-$(CONFIG_PDC_STABLE)     +=3D pdc_stable.o
> > -obj-y                                +=3D power.o
> > +obj-$(CONFIG_PARISC)         +=3D power.o
>
> If we conclude the use case is legitimate, that's not enough: the two
> inner symbols are PARISC only but CONFIG_EISA isn't.

You are right.
It worked for my needs because I am only building the drivers, and not
linking them. But i believe doing something like I did in zorro/Makefile
would fix this all. (For reference, https://lkml.org/lkml/2018/9/28/150 )

If you agree, I will send the next patchset with this change.

Thanks for your help!

Leonardo Bras
