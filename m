Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B025FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF9520873
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="vqgxmuF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbeL2SFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 13:05:11 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38677 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbeL2SFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 13:05:11 -0500
Received: by mail-oi1-f196.google.com with SMTP id a77so19524580oii.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 10:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=diHcY2oayP0QytsDMxTpuXsg03KpLPub1jZnSVuOESY=;
        b=vqgxmuF0yXcXw8NupT3/90EefD8yClQUTteITC5yFBpcWeiLrOZOuw+sBvOVLnTG/Q
         jNI16e6p0Lle0kAujDN0RAueoKAdH6m0QOi8Yay6nZ97iRjNabgZj5ug0VUcsN0T5Wyn
         dAU7+3c1RUoFrkQ91SDpat+eSz9afVGBQhwo7sR3IRR1hfRz5Y8pxwBYpY3HzQr+YdaE
         9lr4DYoiszMQ8ANlTyS9YpLkQuP4Z4GJzw2yBkn944ETsdZDKbV4R8tPrY5t+vMfr6pP
         WO1hAbIkPXbpxZfjgqe5AtOBAMZzQlJ+GvVI4CKfeiAGjx+tkvQcRecmonqZMbFeS4z6
         DPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=diHcY2oayP0QytsDMxTpuXsg03KpLPub1jZnSVuOESY=;
        b=rKsdM6x01sTvyRydVyTgr/D/24pwEwrD6BvF02swYuB0EinaaHxQk4noMeVmYVGh8J
         EY93jz7IS1f3eu0wCuUYb4xftr3Wn8x1HKFEwraQnoMo9GPiAxMMHJtNkYB07kJqP9BS
         aN0PrurriX6VfVgg0jJs8iuMvR3lLsNOlQK/3gzhG+lJXnEVCb/0R5eV/al4qGlloEIW
         v0aBnKbGCXdkQl9vaMpQUqekJoHD179CISP3DOX+exACTvR8GpHM/SrRoX2CTn657f4J
         A0/MLe5e6wyU94wjmQhW5KfTtnQWNAzXxFqZU7yEemebnhpDjuKjUnVQ+bDNxM+gog/m
         catg==
X-Gm-Message-State: AA+aEWaczU8oBZAVq1JPoUyU2DbNTqZLvm630bT7NBhw6KeFJJA/Skj4
        MVYsI5HYtZ8gwtiCoZl0moFgBSvB2UMQ70AOl6QuYg==
X-Google-Smtp-Source: AFSGD/WKkSJ/6IbzSU6hF/PSoAwp2odzmFA2bSQZ4MTmAhhYRmw5W3Qr2/luc5UGHtKDeXIuqvOQNhzCK/SzksjIlak=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr19603188oig.232.1546106710399;
 Sat, 29 Dec 2018 10:05:10 -0800 (PST)
MIME-Version: 1.0
References: <4880b31d0d32c38a675048be903814a062907125.camel@intel.com>
 <CAHk-=wgMfBXdiaeAxYrdTq9VoaVgN26T8MU7+3EnvJP_e0byuw@mail.gmail.com> <20181229153608.GA21173@pure.paranoia.local>
In-Reply-To: <20181229153608.GA21173@pure.paranoia.local>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 29 Dec 2018 10:04:59 -0800
Message-ID: <CAPcyv4h_J6fmkrf2rjwcDjfZitmgAmxn11KBk2YeVNgH3ma9PA@mail.gmail.com>
Subject: Re: [GIT PULL] libnvdimm for 4.21
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 7:36 AM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Fri, Dec 28, 2018 at 09:57:28PM -0800, Linus Torvalds wrote:
> > Hmm.
> >
> > This pull request doesn't seem to have gotten an automatic pr-tracker
> > reply, even though I pulled it, and even though it was cc'd to lkml.
> >
> > Konstantin, any idea why the automation didn't trigger? I'm not seeing
> > anything all that odd about it.
>
> As you've noticed, it's not on lore, and it's also not on any other LKML
> archive out there (I've checked lkml.org, lkml.iu.edu, marc.info). So,
> I'm not sure precisely what happened, but it would appear that despite
> the CC in the headers, the mail never actually passed vger.
>
> > Does lkml hate Dan?

I suspect this is the case, or more specifically this is likely one of
those times where vger needed to put the Intel mail servers in a
time-out for bouncing too many mails.
