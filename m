Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AD5C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 18:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3085D2088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 18:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZu+yq8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3085D2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933036AbeFPSnH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 14:43:07 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:44586 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932594AbeFPSnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 14:43:04 -0400
Received: by mail-ua0-f196.google.com with SMTP id f30-v6so8427994uab.11;
        Sat, 16 Jun 2018 11:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SxnT7IeDDFvAM3/pyOC2CTcwocS6ZwOOGxIsQwg7ERk=;
        b=LZu+yq8AEKpzqkc91XLP8e5T9VU30DVhJaBt29EIZbStwSUz6JPdSVvT6Kr8P52C1A
         OD1VcbMxTpKn975b0wRvLmd4xtu50AenKpJkAtKU+6MWrovAGz3i4z0scE97lR5xAymc
         XrNWXyxS8iYxPw/GDPCu0aarqhGXQYg4Q1mJQHjTlJNXwFNkAQs4zDUPTa8yqmwpGPVG
         9506UXIceuBKk3UQFDz8vNNxaBXK8PIJld7mmcxunZNnSKdvZGJQ+tjy7C7LVVKzu7iM
         2vBlFmcGCbjQqStvda0EYZ4xCq/JqAhkIaHQy/acck8ReSdU0SepsUVEgRJ8GOfppxDQ
         0S2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SxnT7IeDDFvAM3/pyOC2CTcwocS6ZwOOGxIsQwg7ERk=;
        b=dy0NiXU4gIPlTfeesxKMb1m9GvhnLf5xM+DDg4Ps0nEDpL4jIlhHsVXKNtGn+wpvw2
         4pR6TqTMrHljA1N4tuf1CXnqPvAZtNYgOKmtcB+xCvYqrilbu3wHUE1X8rjBBjcleL30
         j2ZCDguAe1Th0qUcVbcESlVJ+fEXZJOX59krr0yb1lSDPqaaJmHLiDePbZ57nBK51kiL
         p3Qu1Q1O3H9DSJmIQkuZDF0hrfLMhiI9DoVi2Epb47qJNrNOJa5F5MVjcpKZf8cNbmXp
         iOY79g5Koe96DhFjKsrF93ragn85FH1b+cBKIsWDb8/I7kcqP/hBb0ljE8LHpYrsFtsN
         y1kw==
X-Gm-Message-State: APt69E1W+bq+DKeMDWQ45UG2vjX21qOCrRoDGepysqacFE6usNQgN2We
        HxFl7oGUTkY+sjpZdP83NffGjyohzlghJPsADFk=
X-Google-Smtp-Source: ADUXVKLQ3hmvwiVyc7vXXXtkbxYHL0sg/rfVZZPLTF0MCfwV5alZlkwlicgowKAUFnSM6ZhO2hkcsyxWzLjUV214w2w=
X-Received: by 2002:ab0:1b9b:: with SMTP id k27-v6mr4244618uai.122.1529174583818;
 Sat, 16 Jun 2018 11:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180615132017.23889-1-andriy.shevchenko@linux.intel.com>
 <20180615132017.23889-4-andriy.shevchenko@linux.intel.com> <20180615222346.GC371@yury-thinkpad>
In-Reply-To: <20180615222346.GC371@yury-thinkpad>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 16 Jun 2018 21:42:52 +0300
Message-ID: <CAHp75VfH7ZOQDXv+uDpXv8d_KX23-MWnWeWwd7i3RDvhWu_HnQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] bitmap: Add bitmap_alloc(), bitmap_zalloc() and bitmap_free()
To:     Yury Norov <ynorov@caviumnetworks.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        agk@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, shli@kernel.org, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 1:24 AM Yury Norov <ynorov@caviumnetworks.com> wrote:
> On Fri, Jun 15, 2018 at 04:20:15PM +0300, Andy Shevchenko wrote:
> > A lot of code become ugly because of open coding allocations for bitmaps.
> >
> > Introduce three helpers to allow users be more clear of intention
> > and keep their code neat.
>
> I like the idea. But in following patches you switch to new API only
> couple of drivers.

I have converted much more, indeed.
I published only for couple of drivers as an example. This is I
mentioned in cover letter.

> I think, it worth to switch more, especially core
> users to make new API visible for developers. Brief grepping for
> candidates showse only 17 suspected places:

Yes, but not in this series. Since it covers many subsystems and
drivers the applying that kind of series would take ages. That's why I
have decided to submit for one subsystem only.

-- 
With Best Regards,
Andy Shevchenko
