Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2001C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BFA2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZOO/QEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BFA2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbeLEXP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:15:26 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39701 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbeLEXP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:15:26 -0500
Received: by mail-yb1-f194.google.com with SMTP id s15so1120927ybk.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q2R0m24oFnAZmIpW8nY7qH30mlpFRtxLS3H0jRxzw44=;
        b=HZOO/QEc4CbuCJabibFDOGaLVdhdXw4y6mvvt94KQaO6ll48yCFfGcfXh46QMmo4KR
         K71puDb+a6dBwBZT7M/AKH/2jwhZqfu1EsuADdsH3XGsqPc+T5UdXEUKm9HJa6mVd3bZ
         Z9TqFxFnbOA7m3UlZETVF5j+w+oG/CP7E6ECA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q2R0m24oFnAZmIpW8nY7qH30mlpFRtxLS3H0jRxzw44=;
        b=eqkXiS0WiGSgKaoQ+ms3VYcnN9uJ+psNtJc77Axd15vU3g0ZedrNjVTtqwLX4SGfPN
         UvX+OoSLMCD+oGcBpijaJlrnkWCNxiebx36drDVDbfp0s2opExArMPtKjTUHrbNXrnHd
         C4xszor9rXi9rd3BV0DIqS3p+l40l/u7Ux04AmFK3vn8QZIuvrW+XNlRDTScP/CCJEdO
         e6f8UmIzMUlZq8xF0KbOfSXuwPOCz8bnOlJ7y8XNNovCgtNCqzizcdSOLbxuy6XwiKZx
         cfAojMgIRaf8A6gswYivdxaQZWR/R3NcgPUfM4+S+o/VjtzBqpiFoW3ywXT0ecKa4a6L
         /Kbg==
X-Gm-Message-State: AA+aEWYyg8W/VOAsbnAzGH9HFmWkfIhl4AEckCXIUk87OA2hCWZULOEI
        r9hEr1g0yElYV4abrbHsMrkqePBbCCYq+oGQyoBLkg==
X-Google-Smtp-Source: AFSGD/UelwQulFE2kM7QrJ4bawXOlEzjYwB7wIiHpd3sCPtGNaWzuc0HDbSWkf26UJXZNy6O3HknbysCCgA9M6GY/NE=
X-Received: by 2002:a81:e40b:: with SMTP id r11mr25889426ywl.56.1544051724628;
 Wed, 05 Dec 2018 15:15:24 -0800 (PST)
MIME-Version: 1.0
References: <20181016214659.22362-1-daniel.diaz@linaro.org> <CACRpkda1i_NDnBGgrEoY2ewdSvSnJFVLWWvmSGCu0sNS0hLyiQ@mail.gmail.com>
In-Reply-To: <CACRpkda1i_NDnBGgrEoY2ewdSvSnJFVLWWvmSGCu0sNS0hLyiQ@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 6 Dec 2018 00:15:13 +0100
Message-ID: <CADYN=9LEVUgz_ou6kWrXZGBpUZ5Ti7BB+0Uxp1NtP18BJDVHCg@mail.gmail.com>
Subject: Re: [PATCH] selftests: gpio: Find libmount with pkg-config if available
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Bamvor Zhang <bamv2005@gmail.com>, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018 at 22:50, Linus Walleij <linus.walleij@linaro.org> wrote=
:
>
> Sorry for top-posting,
>
> I don't understand the selftest environment very well so I do not know
> if this is the right thing to do.
>
> I can merge the patch through the GPIO tree but I need a nod from
> someone wise, like Shuah Khan or Anders Roxell (Anders has been
> using the GPIO selftests) that this is the direction we want to go.

Yes this makes sense and its already in linux-next.

Cheers,
Anders

>
> Yours,
> Linus Walleij
>
> On Tue, Oct 16, 2018 at 11:47 PM Daniel D=C3=ADaz <daniel.diaz@linaro.org=
> wrote:
>
> > If pkg-config is available, use it to define the CFLAGS and
> > LDLIBS needed for libmount; else, use the current hard-coded
> > paths and options.
> >
> > Using pkg-config is very helpful for cross-compilation
> > environments, and is sometimes readily available on developer
> > boxes to ensure we get the right compiler/linker options for
> > the given package.
> >
> > Signed-off-by: Daniel D=C3=ADaz <daniel.diaz@linaro.org>
> > ---
> >  tools/testing/selftests/gpio/Makefile | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/self=
tests/gpio/Makefile
> > index 46648427d537..f22b22aef7bf 100644
> > --- a/tools/testing/selftests/gpio/Makefile
> > +++ b/tools/testing/selftests/gpio/Makefile
> > @@ -1,7 +1,13 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> > -CFLAGS +=3D -O2 -g -std=3Dgnu99 -Wall -I../../../../usr/include/
> > -LDLIBS +=3D -lmount -I/usr/include/libmount
> > +MOUNT_CFLAGS :=3D $(shell pkg-config --cflags mount 2>/dev/null)
> > +MOUNT_LDLIBS :=3D $(shell pkg-config --libs mount 2>/dev/null)
> > +ifeq ($(MOUNT_LDLIBS),)
> > +MOUNT_LDLIBS :=3D -lmount -I/usr/include/libmount
> > +endif
> > +
> > +CFLAGS +=3D -O2 -g -std=3Dgnu99 -Wall -I../../../../usr/include/ $(MOU=
NT_CFLAGS)
> > +LDLIBS +=3D $(MOUNT_LDLIBS)
> >
> >  TEST_PROGS :=3D gpio-mockup.sh
> >  TEST_FILES :=3D gpio-mockup-sysfs.sh
> > --
> > 2.17.1
> >
