Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD425C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD7E218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="V6HCfBzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbfB0AEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 19:04:16 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40330 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfB0AEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 19:04:16 -0500
Received: by mail-ot1-f68.google.com with SMTP id v20so12797878otk.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 16:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rrHG/dtKKfHhHANQkB0lUJqMlgzwZ3RCNAV+Mz5Nhuc=;
        b=V6HCfBzcfnjFssuqjQd4kVxAcRjDPvv7SHIe3YOKqnCd54FHnA+5KQHjz2Iq4azb8+
         AkKXv5FKTQRbh5SWelNr0hm7EYBrrZ626EF49pwbudD7edY98s4jviyIJEEN8TmiDgVF
         3UL9iMr+hU/W5vso6a/1bdUFmBN4KvdO3iAER1cqouKHMXMxrBlZyHFyyqjYSg8wTsyg
         Zw7sAgQzjTVwawEyiwKfkTmJJGXBCBe31JzEQGRgbjTCMTeCdqi89WZyF6HOx6rWyOvd
         PHQAcsGC4CtN1M1WIP8dlpOvygZOkn61cAYCFSs+cJNq+uJkbzAcvS1ywej2OYxLqblI
         hiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rrHG/dtKKfHhHANQkB0lUJqMlgzwZ3RCNAV+Mz5Nhuc=;
        b=RkZytb93Yqtpof8+Hii4kEcBICE7lnXoqueytUjVrVk6jFwAepAvrZAfKohWGM6rKA
         YUq11aUsD5EZLoIeFi4C01PfaN/xrSiSlZoMn6PoqT0KhJ1VEgIt7MEG8KvLi/qIop80
         kMPI2zA3S3hhUjcCkNP79vASBIiI6SOG2N4fYieIO6fCwoW4STMuT4vC+yBAw2A8Q+8+
         XSlcx7HYyKlO2ggiWPo8eQEQl5OtenP/GKjArLR5cyOAvU5XjNtrc1k/tMyIBf44jeOf
         9TTa8pRqYjw42zcSOKJjeVhTzg9KZ+WX63MigK/GMh7HudJhWC1uf+sOGVtCHBeNtBvX
         nqjQ==
X-Gm-Message-State: AHQUAuYLFQLuEFKUDK6vRPuq9U6Bkx5cAK81E/NV4PRMp/B811zlXGc5
        m5KV8i59KWdDjdPf1Vcx6p7IqpvQ03Wm15BM2ZiN0w==
X-Google-Smtp-Source: AHgI3IY1svijvLkauq7rncxA+KVzUUnWRQ9yAKy7sB13oouHnj7BpiwnibvcPCFf8jD2ZE4D9qJip1sp7Gv3DX6Zs9U=
X-Received: by 2002:a9d:7a87:: with SMTP id l7mr417454otn.98.1551225855529;
 Tue, 26 Feb 2019 16:04:15 -0800 (PST)
MIME-Version: 1.0
References: <5c6702da.1c69fb81.12a14.4ece@mx.google.com> <20190215104325.039dbbd9c3bfb35b95f9247b@linux-foundation.org>
 <20190215185151.GG7897@sirena.org.uk> <20190226155948.299aa894a5576e61dda3e5aa@linux-foundation.org>
In-Reply-To: <20190226155948.299aa894a5576e61dda3e5aa@linux-foundation.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 26 Feb 2019 16:04:04 -0800
Message-ID: <CAPcyv4ivjC8fNkfjdFyaYCAjGh7wtvFQnoPpOcR=VNZ=c6d6Rg@mail.gmail.com>
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mark Brown <broonie@kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        guillaume.tucker@collabora.com, matthew.hart@linaro.org,
        Stephen Rothwell <sfr@canb.auug.org.au>, khilman@baylibre.com,
        enric.balletbo@collabora.com, Nicholas Piggin <npiggin@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Hocko <mhocko@suse.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 4:00 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 15 Feb 2019 18:51:51 +0000 Mark Brown <broonie@kernel.org> wrote:
>
> > On Fri, Feb 15, 2019 at 10:43:25AM -0800, Andrew Morton wrote:
> > > On Fri, 15 Feb 2019 10:20:10 -0800 (PST) "kernelci.org bot" <bot@kernelci.org> wrote:
> >
> > > >   Details:    https://kernelci.org/boot/id/5c666ea959b514b017fe6017
> > > >   Plain log:  https://storage.kernelci.org//next/master/next-20190215/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-collabora/boot-am335x-boneblack.txt
> > > >   HTML log:   https://storage.kernelci.org//next/master/next-20190215/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-collabora/boot-am335x-boneblack.html
> >
> > > Thanks.
> >
> > > But what actually went wrong?  Kernel doesn't boot?
> >
> > The linked logs show the kernel dying early in boot before the console
> > comes up so yeah.  There should be kernel output at the bottom of the
> > logs.
>
> I assume Dan is distracted - I'll keep this patchset on hold until we
> can get to the bottom of this.

Michal had asked if the free space accounting fix up addressed this
boot regression? I was awaiting word on that.

I assume you're not willing to entertain a "depends
NOT_THIS_ARM_BOARD" hack in the meantime?
