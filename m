Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72B5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFE724781
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="XoQArSvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFE724781
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753186AbeGCU7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:59:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44914 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbeGCU7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:59:18 -0400
Received: by mail-ed1-f65.google.com with SMTP id f12-v6so2533882edq.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 13:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N2pG8ccc20850A8HCPHHJEVPnJPh6t7eBnt25dFT4qI=;
        b=XoQArSvhTGiTQGT5XaPSw9hOK3Q9TeO7bvSqQSXibgWwMmPTs1haHtSV00XOupPWYU
         8V2sQdfnVH1cuqA1sOXeImUK/BR6MP4wz+Wk1NQACFZauF9EYN/52GH3OtkqwS0dbREk
         b7JKMXg0DSCvBwmoLDkGw2NlSXktclVHfjHY/vyg5Cq7lCbcCB7uR72yTo4sfcwrq9g9
         dIR9V6r3qFMoDRDW+aY6Ge3ZiOvwAtbbXpbElRac2FfJUmqMtHKd2tC8OJP2oCq+yfix
         9U9EHxgH2M74x6H5gu/w/3ILFSCRt9dMDRNpvdwpDxiR6Ufxnd+TtGSRWAed99qAwKBe
         yaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N2pG8ccc20850A8HCPHHJEVPnJPh6t7eBnt25dFT4qI=;
        b=Kt0WK69vayBh5DLSpYkXHE+9kWwdYBVk6xD0tbZ8RvlSMitV4b6K4Jry+KwkXZIPLs
         N5aVhR2UmhDVDVH18RjoXTrQf7iAdWvVenNu494g6IgHx00+5p1CBg9b5IXqFllHrHxu
         Ahe9MlrVPLmFtZ/4ZAs4cxG6pXra5AW1w1oGJjBHlqDJ7l7/FT5MOA/TgQZlOh7J6/pV
         dKlxB/N2toxhrENm7fSPrQGwzwEZ7vMn8nUkQWf56xW99MlLHUO0bZMFcbB3buuDdDrD
         FDdTOzE5KdNvRH0PtGz970RcrrC2ydwjoxiGZcLpqTMjOQOPVBiojyvh9pOWgfc6Zi0b
         wjUg==
X-Gm-Message-State: APt69E2GnjpPsJC3BXYyZ1ihR1GapfFL/EzQBxMvvDzGbjMAGKNbkqPJ
        tnuqjtDRcKR9a6Lv94xxZhFB/w==
X-Google-Smtp-Source: AAOMgpd86cgNW01aN05QCQqz/Hbh0bvC3eo+yTsC1+qV/eX3NqkJtoNZKs4aOy07JZZuW1EyUl+9iw==
X-Received: by 2002:a50:a624:: with SMTP id d33-v6mr29317313edc.8.1530651556892;
        Tue, 03 Jul 2018 13:59:16 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id y26-v6sm1091655edr.51.2018.07.03.13.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 13:59:15 -0700 (PDT)
Message-ID: <1530651554.3205.37.camel@arista.com>
Subject: Re: [PATCHv2] lib/ratelimit: Lockless ratelimiting
From:   Dmitry Safonov <dima@arista.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Date:   Tue, 03 Jul 2018 21:59:14 +0100
In-Reply-To: <CAHp75VfxajbTK3azfRWVBY6+f91JjGZwzHKrhQcHXDw9xeO_HA@mail.gmail.com>
References: <20180626162438.16306-1-dima@arista.com>
         <CAHp75VchWpr+76rBCmXctpYi5a06pr-MT==FrNDy03g=boxfog@mail.gmail.com>
         <1530035183.3205.6.camel@arista.com>
         <CAHp75VfxajbTK3azfRWVBY6+f91JjGZwzHKrhQcHXDw9xeO_HA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 21:41 +0300, Andy Shevchenko wrote:
> > > > @@ -42,9 +41,10 @@ static inline void
> > > > ratelimit_state_init(struct
> > > > ratelimit_state *rs,
> > > >  {
> > > >         memset(rs, 0, sizeof(*rs));
> > > > 
> > > > -       raw_spin_lock_init(&rs->lock);
> > > >         rs->interval    = interval;
> > > >         rs->burst       = burst;
> > > > +       atomic_set(&rs->printed, 0);
> > > > +       atomic_set(&rs->missed, 0);
> > > 
> > > Can it be
> > > 
> > > *rs = RATELIMIT_STATE_INIT(interval, burst);
> > > 
> > > ?
> > > 
> > > (Yes, the '(struct ratelimit_state)' has to be added to macro to
> > > allow this)
> > 
> > Sure.
> 
> This part, by the way, potentially can be split into preparatory
> patch. Please, double check if it possible to do this way.

Hmm, I tried this way:
:#define RATELIMIT_STATE_INIT(name, interval_init, burst_init) ({ \
:               struct ratelimit_state name = {                   \
:                       .lock = __RAW_SPIN_LOCK_UNLOCKED(name.lock), \
:                       .interval       = interval_init,          \
:                       .burst          = burst_init,             \
:               };                                                \
:               name;                                             \
:       })

but the expression becomes non-constant, so it fails to compile in
definitions of globals.

I think I'll change it to
struct ratelimit_state tmp = RATELIMIT_STATE_INIT(...);
*rs = tmp;

Not perfect, but we did memset() and set elements after, so it's kinda
the same.

-- 
Thanks,
             Dmitry
