Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10052C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5142184A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r+fShDgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbfBRP45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:56:57 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46902 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730199AbfBRP44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:56:56 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so8644989pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 07:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=15CNhbhWvXOtTCo6jebNIpwW9Qe1MGlcrULyF7u9LqQ=;
        b=r+fShDgqwp3BRKoIYd1vFXRjXb/bsjS+BtPyxt+qG9KLv3jmc25gVLCV9z2TF2KX1a
         nSh63p3TFizYDVhfxplA2EMwo19/ZhGILwoBruhStGNB4bxSxYcFcMYMFOxLxNfXPSzO
         qBRD05FV4TBN1sJcgTPgNV3M14SGWrKuKHWltT3T3GcXBfuQhVjzTaBfMAC9NWW0V/At
         68RZRJZcZ0UjQR7zFzXBFZHH/O+K3Sg0k0bswJ4tXXjjIcWFG5Dk+1w04JG1YA0fKrel
         dBmcB/0QF+tKqiG62e8X7wTGSlXzX54jWxoCk7OGLIzteyRNHsDW6VYY7lRheEGctLKJ
         aJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=15CNhbhWvXOtTCo6jebNIpwW9Qe1MGlcrULyF7u9LqQ=;
        b=FASLy5Gm5Am1vXWAzgfE8sv9CO+6icT29CS7RMGyNznQCkgpWx4U2LIAlazE4fhx27
         DNuUK0RZipZbjI5nVArpoNMBEL7ZFCbU+XJweWZ/KSWhcfpyMZzZKtvF+2GwhP/yN41W
         Sm/t2w5jowzIcCS+91Rwl0FdEeVA6BI0ywnypeLv8a7hwJfghM2nuuE2MzZEMBIz11/N
         jmj7jFF7wcpH0KkGfyAD/8JatUyjKIVS20uqzKg/nZnL1QXZrjaSvgQ4p0y8DYbBdCFZ
         0D7E0NiJP+HJEvodko0FCWNqLDAyh5nM2lHqcoiAT8BTOPMBQl6TQwC1dLSMDtdkiLnH
         Nx+A==
X-Gm-Message-State: AHQUAuaD/42YsYQpFxRrJCAjKIrH+GlPYm7PB8X3GZmrSJmlgFgTl2Dc
        sxnuVjKlT9l2rIVorHEFrZpcOLqY1F3QYtgZdB2aRw==
X-Google-Smtp-Source: AHgI3IZMGzkFgLdqE+AD7Y3hfwzxkylhvyZESOlZyS8079LBJNa4hh/152UrmuZJtH7Oj/um+B//tVelXBjizv0bfMs=
X-Received: by 2002:a62:1c86:: with SMTP id c128mr25717905pfc.54.1550505415843;
 Mon, 18 Feb 2019 07:56:55 -0800 (PST)
MIME-Version: 1.0
References: <20190217043434.46233-1-cai@lca.pw> <CAAeHK+y8Xd1J2DppUMQLVhoc69wrqgNA=9hV45Jsd7V97CN6yw@mail.gmail.com>
 <dddc0e6e-af71-c98c-c8db-20c6d9fa87c3@lca.pw>
In-Reply-To: <dddc0e6e-af71-c98c-c8db-20c6d9fa87c3@lca.pw>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 18 Feb 2019 16:56:44 +0100
Message-ID: <CAAeHK+yDa=Ks7TY8unVfFYt7ekDOyqpqW4otyMg1XUxkFt5Q+A@mail.gmail.com>
Subject: Re: [PATCH] trace: skip hwasan
To:     Qian Cai <cai@lca.pw>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 4:53 PM Qian Cai <cai@lca.pw> wrote:
>
>
>
> On 2/18/19 10:25 AM, Andrey Konovalov wrote:
> > On Sun, Feb 17, 2019 at 5:34 AM Qian Cai <cai@lca.pw> wrote:
> >>
> >> Enabling function tracer with CONFIG_KASAN_SW_TAGS=y (hwasan) tracer
> >> causes the whole system frozen on ThunderX2 systems with 256 CPUs,
> >> because there is a burst of too much pointer access, and then KASAN will
> >> dereference each byte of the shadow address for the tag checking which
> >> will kill all the CPUs.
> >
> > Hi Qian,
> >
> > Could you check if adding "CFLAGS_REMOVE_tags.o = -pg" into
> > mm/kasan/Makefile helps with that?
>
> Yes, you nailed it!

Great! I'll send the patch.
