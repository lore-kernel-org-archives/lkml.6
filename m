Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BCFC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC732213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBrEghzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC732213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeJCWgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:36:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38817 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJCWgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:36:11 -0400
Received: by mail-ot1-f67.google.com with SMTP id h15-v6so6021703otj.5;
        Wed, 03 Oct 2018 08:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zsllUS+Kzx1vGutnlLm10odU3msdV1cIiglb6OGdel8=;
        b=lBrEghzK1aX2yTVfVtQr636mE5MGGJF0lLVJsj9YmeyhWapuy/T4GhuccLELKfKMnH
         CuUf5CWsKq2bdQq6ZbL7vitXIrxVAvDwBrTfKqC8/75ldUuOyyFESJrbZbRulmIXdmhk
         OcBXk2UfBdVLgDh/cMZBqzlXJo/SYnI84gVtfWXq5uGqj/KULxznG+qVbA6eHHOHIGGy
         wFPnvRk3aAHkUmoXgDFO+XjGNfmA6AitoyiRGGEYIsCe7eyWZkR2EESctYle9kgzHXw9
         dF+KWdzmDmG0BrymfsK2USQAn5da1YF31YGZZKmOSRpWG/c1HxZ44qdhEd0x3Iygjdp+
         UUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zsllUS+Kzx1vGutnlLm10odU3msdV1cIiglb6OGdel8=;
        b=CStuw7OE/rNLJeBMXedmqJkLS9Jww4nhuP2Ta2uJdG7manIzmJbp118Ij6EwqJW9Bj
         Qd64/vn3AepCRioGXP5gsQBeKAD7hXkZqgzi82bRQJNKbT3sLkAKY0cg3T6uIjYyXFGb
         Jp5FdqIYKKW6o5CDaXDWJtXYOnu7l7SuqXh2VA3v7FUxazv7lzAhz25AaKEk0YkxINIj
         8CthK7EycEhuX1phLK/22L4cjPMI1fVaDbQgWkw8JYjiVi/Rf+4OSHKxDPwMJDOTxSRM
         yYifm372P0jLi7H8G9WvzG6+WB8yghgftQP33gZd5Z31dK2Ak7Cr2iUFe0BUm392Lcb7
         DKew==
X-Gm-Message-State: ABuFfojvgDlCp86gbAeDAKIEEz2GsnTG8Aa/h6UljfnKlOvVuMPgUmDs
        ZQ1EHKJfRJz4B1+zCFo0YJqqbIlad6GcjBBMu5M=
X-Google-Smtp-Source: ACcGV63KZG3vdnVu3Lc4NxpCdQLS4SV10ArwRif+i86A68ves7mpSvSmsXBMZS4bgPXy7eC6vIGAlNHRFqMLqGMK+Bc=
X-Received: by 2002:a9d:948:: with SMTP id 66mr1198303otp.178.1538581635412;
 Wed, 03 Oct 2018 08:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180928020816.11251-1-leobras.c@gmail.com> <20181001075607.GA3776@rric.localdomain>
In-Reply-To: <20181001075607.GA3776@rric.localdomain>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Wed, 3 Oct 2018 12:46:15 -0300
Message-ID: <CADvQ+rETmm2Ag4sijXG-0Aya7B0oww7LkLgijAC+nznyWskkvg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Remove errors building drivers/DRIVERNAME
To:     Robert Richter <rric@kernel.org>
Cc:     lkcamp@lists.libreplanetbr.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 4:56 AM Robert Richter <rric@kernel.org> wrote:
>
> On 27.09.18 23:08:09, Leonardo Br=C3=A1s wrote:
> > This Patchset changes some driver's Makefile to allow them building
> > using the command 'make drivers/DRIVERNAME', if compatible.
> >
> > The changed drivers would return error if the above command was run
> > on them, after an x86 allyesconfig.
>
> I don't see what you are trying to achieve here. Why shouldn't the
> command fail if it is not the intended way to call it? There are a
> couple of use cases where drivers/ is used to share common code over
> different archs and it is not always the intention to build them in
> drivers/ directly.


Sorry, I was not very clear at my reasons why this change is important,
I will try to briefly explain the whole story.

Some weeks ago I was trying to solve a task that needed to change some
compiling options, build the whole kernel (allyesconfig) and look for error=
s.
The problem was: It would take a long time to build everything in my comput=
er.
And many friends with slimmer laptops would take much longer.

So, I was looking for a service that could do that for me, in the cloud.
I found out Gitlab.com offers free 50k minutes of CI for open source projec=
ts,
and allows anyone get this CI time by only forking my project, adding their
changes and pushing to Gitlab.

But Gitlab don't allow 'jobs' to take longer than 3 hours, after that the '=
job'
is killed.

The kernel could not be built in 3h, not with allyesconfig. So, I created a
'job' for each directory in Linux kernel, and tried to build them separatel=
y.
All went fine, except for drivers/, which took over 3 hours.

Most logical thing was to continue the division and create five 'jobs' that
could divide the building time of drivers. To do that, each job took care o=
f a
range of starting letters, as you can see in this link:
https://gitlab.com/LeoBras/linux-next/blob/build-ci/.gitlab-ci.yml

But then I found out some drivers were failing to build. Even if they were =
not
enabled in my .config. After some work I found out some drivers selection i=
s
done in drivers/Makefile, and incompatible drivers would break my build if
tried to call them directly on drivers/DRIVERNAME.

This patchset intents to let the .config selection happen also in
drivers/DRIVERNAME/Makefile, avoiding accidentally building drivers
that are not in .config.

This would allow the kernel to be build on Gitlab CI, and would benefit man=
y
people who wants to help in the kernel development, but have not much
processing power in their machines.

I understand my changes may have mistakes, and I am trying to fix them all.
I thank you any suggestion to make the code better.

Also, I would be happy to know of any other solution to remote build my cha=
nges
and look for warnkings / errors.


Thank you for reading,
Leonardo Bras
