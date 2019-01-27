Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D964BC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 12:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE26217D7
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 12:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MPy5WjsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfA0M0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 07:26:47 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43680 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfA0M0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 07:26:47 -0500
Received: by mail-ot1-f67.google.com with SMTP id a11so12403568otr.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 04:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FV09SYoL0F04ZmSUaNF5xOhlXlJTckZ/GU1hR92+CcY=;
        b=MPy5WjsJlaQiwcMncMwsJ5UFS7ZMJeBLA+3P1DRfqyigMRlDTk9SBD7VBGVJuoeFx9
         JCDjwxEkl5hg24uZmIH4BB2qy0LWpSXcPwgO1ZQ8qBkEIy3V+wkESXqmHnh1evX1Lw96
         BUjoydtFnWg2EtZvKpWaPO/1jv2AIrB/z9h2HN+BDIM5ZjbT67YMGjmsHQRGP7umF/dK
         1ZT8KiRNiqIefnlL7tGjWSMzaqzHmh08TGsBHiKFL5NKHiO+FOnTnDMH/MF/0HdcXH+s
         SEvVk1gPv/TITcF+7a/0CQU62H/tvSLC8WW5IRwvxMWmigl2eMja+bwDHo5MCFnH4bHA
         7MJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FV09SYoL0F04ZmSUaNF5xOhlXlJTckZ/GU1hR92+CcY=;
        b=kgTIqCa1K8R76dlPtgyJisT6dPWNUrGNJ0/4ACnbvO54vGrcqfHN6GMssYZLhQBQVN
         0nEJQb8YUQyuvrbz3L2XKImBh4PSKP4zoE9DIjg599li3WGf4QNsJ5B1BHsVx+5u7ks8
         9NmzcxEUnvdF9yXGx1hvVxgVz9tFiDtVxgVqGlFIq5AbjBKBWLf2zrbj9/2wPEg+40ry
         UKABdqugf9ztcaMxxU4JIwJayKd1t4ewIVp2zfxDPIhjSWH8zvVfRnLexhIQZLszk1in
         6e6V5dSQmK5DN88LAy3EK6kTXE1Lg+PXEs9sc/tRSzbipDjzgxnA+i0bjNGskuxXYk/e
         kP9g==
X-Gm-Message-State: AJcUukeB3jnH5kkG6q2UxDlDqJWr3+JfEYKu+vitFTE4CtRa5NF7fqUV
        gXvqOlVrD4ER92M+FYRpSU8WVsjiiDbRbOkItr6RFA==
X-Google-Smtp-Source: ALg8bN4HwA9drGKobG9D/YBH0b7fqsVPIKzg6dyz6wZHcrg8C9kuTgwJ6Z+iOW8kvKSOrp+9PSPce9tS3QjA86cCAhA=
X-Received: by 2002:a9d:70d5:: with SMTP id w21mr9862260otj.301.1548592006116;
 Sun, 27 Jan 2019 04:26:46 -0800 (PST)
MIME-Version: 1.0
References: <20190108091539.16674-1-brgl@bgdev.pl> <8c190cf3-b4f3-90d0-07ce-4bb7927160df@ti.com>
 <20190122122228.GA2736@kroah.com>
In-Reply-To: <20190122122228.GA2736@kroah.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Sun, 27 Jan 2019 13:26:35 +0100
Message-ID: <CAMpxmJW+ODrqCTSaQMOgRG2d3Qy2SipzYQU3JRPbJE_Wn85H0w@mail.gmail.com>
Subject: Re: [RESEND PATCH 00/12] eeprom: at24: remove platform_data
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 22 sty 2019 o 13:22 Greg Kroah-Hartman
<gregkh@linuxfoundation.org> napisa=C5=82(a):
>
> On Thu, Jan 10, 2019 at 07:43:47PM +0530, Sekhar Nori wrote:
> > Hi Bartosz,
> >
> > On 08/01/19 2:45 PM, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Hi Sekhar,
> > >
> > > now that all dependencies are in and v5.0-rc1 is tagged, please consi=
der
> > > picking up the second batch of davinci-specific changes into your tre=
e.
> > > Once that's done, please provide me with an immutable branch for me t=
o
> > > apply the last patch to my at24 tree.
> >
> > You can use branch v5.1/eeprom-for-bartosz in my tree for this (commit
> > e430685f4969).
> >
> > >
> > > This is the second part of the effort to modernize the at24 driver an=
d
> > > remove the legacy platform data structure in favor of device properti=
es.
> > > It required getting rid of the at24 setup callback in favor of nvmem
> > > lookups.
> > >
> > > Re-tested with da850-evm and dm365-evm.
> >
> > Applied patches 1-11 for v5.1
>
> Feel free to take patch 12 as well :)

Hi Greg,

I took over the at24 driver from Wolfram Sang. I collect patches for
it in my branch and then send pull-requests to Wolfram directly. I've
applied this patch to my branch in case there's some more development
for at24 in this cycle. Sekhar provided me with an immutable branch
with the arch commits I merged in.

Best regards,
Bartosz Golaszewski
