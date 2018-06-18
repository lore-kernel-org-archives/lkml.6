Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233A5C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6569208EA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7fQLUYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6569208EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968190AbeFRIpM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:45:12 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:46404 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968071AbeFRIpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:45:09 -0400
Received: by mail-vk0-f65.google.com with SMTP id b134-v6so9019438vke.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 01:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:from:date:message-id:subject:to:cc;
        bh=nJ+CZnsKUZLN6StcvXGyqZaHNh8bZ9YdszgaE315IOo=;
        b=B7fQLUYb5dg6BspnsDwPuSlQwxyvtMJtcMhJH87mIya6JfXXSiw6lu6C3UnrV9q3kx
         82MUT0YZHQxbD0gqG3adQWbvgH9dYJkZiuSP7mp8rWhOCkgkbJZyKC3zEt3Q8m1bI4cA
         KDoINuJa12hXHkKkyIX8WixdVnthRF2m/HI50tAWFvUYhdhZElgrFtaKjRqvaW0gzTt8
         6FN9Lxs1oAyaOz/eOcn22E7H2IP3nFwn/sDzz2fG0fY0fW9Iny0ChiTCVK8iYRWIysza
         SZOgd7Hz1ITJ5RmF4diJRG9T+oak8QOq0yNMc8PVsKRgNojQg0eqsAlRzPlV8FWmHcRt
         yu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:from:date:message-id
         :subject:to:cc;
        bh=nJ+CZnsKUZLN6StcvXGyqZaHNh8bZ9YdszgaE315IOo=;
        b=Gok+J6/gSkdShP8UyG6uiy4OgZQx98zx5ybPkb1tMGH5xvsGnHKu702Bd+UbGC7Mk4
         nkwpL79tYb63jBNe34hLn4A0eQDUAOFRvLr4Tfr/jYxllvXUHz9Z0R466G8EufnxiZf1
         XcmLgkESxkXgVwDJ/5+Pnben9jKFLYQvuf9+zlxMCGxbImSXLjH3wbt6rbpL9ilHmX04
         9BHgonRZh5n696nvdBXRtwST+pJy8jeLl/FqV0TARdzUZSJvU5p5AZcBZG3Wg5FYws/0
         aeaHN+HSzJ8+97XAVxIxwvjU8fTVj7G29c0w4sMwcQb8p5Otxjx7RnvvCAEgDZzLgssO
         Zztw==
X-Gm-Message-State: APt69E1BPNXlI3AM4LwHxqnCKOPLxxhlOQxV6Dqjyft1ctbXUJMysINk
        grqN5+nxdyQV/QTCuhlGQRyj8XrOA+5xc3ctlaM=
X-Google-Smtp-Source: ADUXVKLe67vo11iJzsFa9d3uuOXK3lxYQ4vl5JYv8b9OsFxyTiaKFyByMAEFHrj1xqRrf8iTI5xcGGZrtuz4j8qM65A=
X-Received: by 2002:a1f:860b:: with SMTP id i11-v6mr6495254vkd.15.1529311508982;
 Mon, 18 Jun 2018 01:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180615174204.30581-1-pasha.tatashin@oracle.com>
 <20180615174204.30581-4-pasha.tatashin@oracle.com> <CAHp75VdRxpSYJE17bjGvRAjCq5vjf23L=HT5oA6OhPSCzJJ0FA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Jun 2018 11:44:57 +0300
Message-ID: <CAHp75VdLoSDYvX6ZiRKJq0RRtz4nbkNwsjSFxbOsNeJofoUJVw@mail.gmail.com>
Subject: Re: [PATCH v10 3/7] x86/time: read_boot_clock64() implementation
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, prarit@redhat.com,
        Feng Tang <feng.tang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 11:42 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Jun 15, 2018 at 8:48 PM Pavel Tatashin <pasha.tatashin@oracle.com> wrote:
> >
> > read_boot_clock64() returns time of when system was started. Now, that
> > early boot clock is going to be available on x86 it is possible to
> > implement x86 specific version of read_boot_clock64() that takes advantage
> > of this new feature.
>

Oops, sorry for previous empty mail.

> > +void __init read_boot_clock64(struct timespec64 *now, struct timespec64 *ts)
> > +{
> > +       u64 ns_boot = sched_clock_cpu(smp_processor_id());
> > +       bool valid_clock;
> > +       u64 ns_now;
> > +
> > +       ns_now = timespec64_to_ns(now);
> > +       valid_clock = ns_boot && timespec64_valid_strict(now) &&
> > +                       (ns_now > ns_boot);
> > +
>


> > +       if (!valid_clock)

Are we expecting more often clock to be non-valid?
Perhaps change to positive conditional?

> > +               *ts = (struct timespec64){0, 0};

I dunno if additional variable would be better for readability, like

struct timespec64 null_ts = {0,0};
...
*ts = null_ts;

> > +       else
> > +               *ts = ns_to_timespec64(ns_now - ns_boot);

But I'm fine as long as Thomas is okay with this code.

> > +}


-- 
With Best Regards,
Andy Shevchenko
