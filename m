Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6386C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 01:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9081320858
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 01:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EemAEeDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9081320858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeJJIYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 04:24:03 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37506 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeJJIYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 04:24:02 -0400
Received: by mail-ot1-f68.google.com with SMTP id o14so3688121oth.4;
        Tue, 09 Oct 2018 18:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L40dxiymgKTuSUnpFwS9PSo74Asn3rQ8N8sH/0ymlbU=;
        b=EemAEeDPxl6p95S6QREFGqgDuFtvZbMJ8nDxbH7NxAVbuEEIYGrtlQJ5ooEAA6QJcK
         wsDnQYm1uOiwEiOrA5VKYqX3e57pbWFjktKz3FWdI2B7NPxt61Fe9ST1pCxoVp2I5Se8
         3k1KWS6zLcXmhBmpjcNG55NfIaXsHvsyRpcBi8IuU7fVTXZG4QwSKsfodyjRvEazcGm6
         oW+o+faoNXEh4KQA0UvrtcmXXgPeLpLzA6pOX/I6CfbNRfEamTRzO8vsyGedyRsYyA/2
         a7v6BAL3Xtzs1iqKBsjSjYr23UcwlQJ70brPxqT97uqIHRD0lz0QLeeLI88xE56YCKHi
         mLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L40dxiymgKTuSUnpFwS9PSo74Asn3rQ8N8sH/0ymlbU=;
        b=ZCogbKKUGzn0SNH+YxUMxrk4ndzcE1nH5vJw9jBzy6EhPwlprkeU0xue0cdMDHwX4c
         GgIJYSS2zzudJQYUXOWEE6t0UPwQwDIq13cd6lYMx2rDujYDht+Hcx5ExEiRHtVq7l1m
         n1B+12F/VC3HqYfwnFuHfkCylFRK0snyx5IXTnBiYUBHzd7bi+7pV24tWC9g93ob64vN
         pCx8yJtmbOwed5nWZ/4MaB1lQJJ6l8No9PAnJ1b39qv4xHWR3QgQxrtpbnAzADGg4zqc
         zkh+2hV8qj863kz+qwu3Bm3f+kX5LRYPz10UjzjwXG/FmkEJN2prjaUDglbMa6ivKmWX
         dwDg==
X-Gm-Message-State: ABuFfogi3LYoP09f7wL5GDYD515kHWtfNkcHpKO2je8MYIocdlsXOJVV
        YULZh3afGYkK5psnTe1g4Oe7Y5SNZeX+tPjcqUo=
X-Google-Smtp-Source: ACcGV60LpnjIzQuq0fuap5DEOq4o8EAHQ3e0s2k0Cf+Klf+zAmKJLEKkd2jzqYMsqGTVjt/g/LYZrue7HV4dEyRa+g8=
X-Received: by 2002:a9d:2568:: with SMTP id j37mr19409188otd.263.1539133462747;
 Tue, 09 Oct 2018 18:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180928020816.11251-1-leobras.c@gmail.com> <20181001075607.GA3776@rric.localdomain>
 <CADvQ+rETmm2Ag4sijXG-0Aya7B0oww7LkLgijAC+nznyWskkvg@mail.gmail.com>
 <alpine.LNX.2.21.1810040915040.8@nippy.intranet> <CADvQ+rE8qQmSangHOCrJo7aAD-BJiN3Gt2hCi-3O8uRTgXnP-w@mail.gmail.com>
 <alpine.LNX.2.21.1810041200240.8@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1810041200240.8@nippy.intranet>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Tue, 9 Oct 2018 22:04:11 -0300
Message-ID: <CADvQ+rFfWoGsnz-W-SFuD6zx9eO-nQqz-GVVVW00cV_Ss8pZ_w@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Remove errors building drivers/DRIVERNAME
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Robert Richter <rric@kernel.org>, lkcamp@lists.libreplanetbr.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Finn, I will take a good look at that and try to use it in my build.

Thank you,
Leonardo Bras

On Wed, Oct 3, 2018 at 11:00 PM Finn Thain <fthain@telegraphics.com.au> wrote:
>
> On Wed, 3 Oct 2018, Leonardo Bras wrote:
>
> > Both ccache and distcc seem very interesting, I will take my time to
> > study them better as they can solve some situations I face. Thanks for
> > sharing!
> >
>
> You might also want to check out 'gcc -O0', 'gcc -fopt-info' and 'gcc
> --help=optimizers' etc to see if you can reduce the compute cost.
>
> To reduce IO cost, my build tests always use 'make O=/some/path' where
> /some/path is on a tmpfs mountpoint.
>
> HTH.
>
> --
