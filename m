Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67ABC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF252064A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioc913a2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF252064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbeJIB4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:56:24 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:36200 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeJIB4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:56:23 -0400
Received: by mail-wm1-f42.google.com with SMTP id a8-v6so9227790wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 11:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oBYccJHN5LWZroCwmbVcD4R/0TolCqx3XwKyHO2KMRE=;
        b=ioc913a2TzDAb7HxdlAdv7TZHhZ8DK0uHxgq2F6Ew0rqlrhyfOPQ+uQjX0AUc//o/7
         3bJJURQXrANTFJg9j7ziz6Vc1oEKxksRB6IRLEZBAsmEoRieRc/SGIK1LuQXUXn+wuZ6
         e1tP4HW0hbyD6EO1+fZcf/gZeKwThTwS0xNhjVlPjQ4kk4EMxXZB2raPI71UZn6hnie0
         ZuIotH3FreaAwv9EPXBYQodwvtHMCOO7csVdS/Vzjvya0bI4izm49wrHSuGHO9bF1pQf
         5dNWS9ozDTsQDnN2y+826s2cvfotLJ3qQ57+SLuBwCbbC8WOrGP6jcKqsJ1rsLAt8KKv
         qSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oBYccJHN5LWZroCwmbVcD4R/0TolCqx3XwKyHO2KMRE=;
        b=Inls0NOxliLWgto/4PIeGq0yZhFJJ6qEfAqFn8UWM067omdwd0A2/tnKkfOMpK22kj
         whTgXG7GhHt7g+hI5n+XcLzuGF6XBDdcvsAWNdLLI+9xGoLf6vg2oBENi75Crch0Y2Br
         gjm0jynGEblnVcRDJSore+Z4zYE4HFFrBjAokVTk8wLk8NcrrNYqXwRUaOnXUEdGb9N8
         FG0mwITi5CmsmMrkMKFajPZ/i7bJLPq+XvAy1eQfVcmer66Rzp4y8ycgmynDegGBxJYf
         VQsO/nlQpUSkMA+RjhspjjM9zd1pKMq18PJUDovg3iIVpEskaHBV/ZZp7/KE8VTxT4Gs
         J7mg==
X-Gm-Message-State: ABuFfohc2IL5c54qeNiEKst4KiWyf/sEzfnXFY0sn2E+6OGBM8HZRAXJ
        LsjaC0w5L6GhQuHGw5XrSiKR2HQOoE1WLH8zB1Y=
X-Google-Smtp-Source: ACcGV636WrO3bcKO1uscZs7AvhE+cCbkM4GD2Nf0ZKoXjM1N4C/chu7OJ5YiSG5gNJINm9Fnop1QvBQpWSf347pyVIQ=
X-Received: by 2002:a1c:de88:: with SMTP id v130-v6mr15979004wmg.59.1539024196337;
 Mon, 08 Oct 2018 11:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20181007154529.GA4493@kroah.com>
In-Reply-To: <20181007154529.GA4493@kroah.com>
From:   Shuah Khan <shuahkhan@gmail.com>
Date:   Mon, 8 Oct 2018 12:43:05 -0600
Message-ID: <CAKocOOOY7tmTt1JVv2NuF_KxGKj43MsEnEt9bH2P0EzQh7f++A@mail.gmail.com>
Subject: Re: Linux 4.19-rc7
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 7, 2018 at 9:48 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Hi all,
>
> Yet again, it's time for a kernel -rc release.  This one is bigger than
> -rc6 was, for a variety of unrelated reasons it seems.  Lots of
> different trees being merged this week, much more so than the previous
> one.  Highlights include two sets of networking fixes, lots of different
> driver subsystem fixes, arm and arm64 and x86 and riscv and powerpc64
> fixes, as well as scheduler, iommu, and vfs fixes.  Not a huge quantity
> overall, just overall a lot of different things.
>
> Given the current rate of change, and looking at the travel/conference
> schedule happening this month, it seems like we will be having a -rc8
> just to be sure 4.19 is solid as well as not having to be in the middle
> of a merge window during a conference week.  Please go test and make
> sure any remaining problems are sent in in time.
>
> thanks,
>
> greg k-h
>
Compiled and booted on my test system. I haven't seen any new issues compared
to 4.19-rc6

thanks,
-- Shuah
