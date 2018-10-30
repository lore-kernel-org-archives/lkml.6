Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF4CC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7026420664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="cudBxkTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7026420664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeJaH1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 03:27:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42709 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbeJaH1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 03:27:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id f26-v6so6572119pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 15:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8OuOJaXdqAriTvinMmIHBpzpbXpIMiG/JA7aCf5n8ys=;
        b=cudBxkTZ65rcexeB1AGKzMWBs8RncUZ7VYT37tqwFl30HyKzsqNKIazV/QUHiLND8A
         k3AUBLlWuy0SnY95VBfbSgoQee2pXs2MD9NDuOJgcccQrl9utvkqrYDF774iKPEBXCef
         fs9YoZSo84xlC9EUSCxvE17THeJAh7fnbPpw+eAZMn8GEXjcNhiNVaOle1bCkrBEwYvw
         AxAS8OZtkqyWGb5eINoYZo26hYglgmD8pB9SON2NqqCUDPy6j1WploNHYcc5DSU58OD0
         cvZd/a6XrxirA9bWMpNgbgSWUYimET7J2u9RqMVY3AESZ4upxDVWsazZ9BwnUQpIrv9X
         c0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8OuOJaXdqAriTvinMmIHBpzpbXpIMiG/JA7aCf5n8ys=;
        b=nR/g8bgCr+dRZH8w4AjRwRomOjlBVdRTTt4YIL2uMT4w30xRqpQrfgq3x9oVKznRgp
         VMVD1tyhuVBUEFw1cHQtRqjrYCauzbNtZnHq7F0eEdXmiiWm79h2b7RDSdSeecCw760w
         xN+WxVU/RzCuzfj3ImpbwX6duVikhDDYPC6ZgcYH3Y5fW8K/O0UOQlRUhjpI2U6t1F8J
         DFEVF5mICnyl7X6SeVaCkTRgY/KE/oRK/Ielg2IrQrKcHOe+S/0Z1R/1f9EqqOPRAS78
         H5cza7bMZnvAx+STi/pcfzSE7QWNs5U99kWOVIy7xhSlZ3Nihhqdf/9/VxJbNcttDOyI
         owHQ==
X-Gm-Message-State: AGRZ1gL8yNnuiivLzRvKTRipS9iVVziMUFS9EjYdVhPi0H280tmZkKAI
        q8+9m5WkoA1osBGaJ2XNQLpwnQ==
X-Google-Smtp-Source: AJdET5cLykzC7sfSdRfm9ssL1ewLiQIq5oyi+39n7Dj0ZSIyYf/tc/NlFJ44SJnKBkSoR8T9lfJDhw==
X-Received: by 2002:a62:4681:: with SMTP id o1-v6mr593748pfi.108.1540938752213;
        Tue, 30 Oct 2018 15:32:32 -0700 (PDT)
Received: from cisco ([128.107.241.161])
        by smtp.gmail.com with ESMTPSA id 124-v6sm24718034pfb.132.2018.10.30.15.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 15:32:31 -0700 (PDT)
Date:   Tue, 30 Oct 2018 16:32:28 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v8 1/2] seccomp: add a return code to trap to userspace
Message-ID: <20181030223228.GG7343@cisco>
References: <20181029224031.29809-1-tycho@tycho.ws>
 <20181029224031.29809-2-tycho@tycho.ws>
 <CAGXu5jLjum=TDab67L5XdWKEmzU_5rYeLfGXB1vb2BmfZdPuHQ@mail.gmail.com>
 <20181030215404.GF7343@cisco>
 <CAGXu5j+ZPxu6egE1fEr+N9+zLx3N+SJ_vbS_zzj9_hrdWrrrWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+ZPxu6egE1fEr+N9+zLx3N+SJ_vbS_zzj9_hrdWrrrWQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 03:00:17PM -0700, Kees Cook wrote:
> On Tue, Oct 30, 2018 at 2:54 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> > On Tue, Oct 30, 2018 at 02:49:21PM -0700, Kees Cook wrote:
> >> On Mon, Oct 29, 2018 at 3:40 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> >> >     * switch to a flags based future-proofing mechanism for struct
> >> >       seccomp_notif and seccomp_notif_resp, thus avoiding version issues
> >> >       with structure length (Kees)
> >> [...]
> >> >
> >> > +struct seccomp_notif {
> >> > +       __u64 id;
> >> > +       __u32 pid;
> >> > +       __u32 flags;
> >> > +       struct seccomp_data data;
> >> > +};
> >> > +
> >> > +struct seccomp_notif_resp {
> >> > +       __u64 id;
> >> > +       __s64 val;
> >> > +       __s32 error;
> >> > +       __u32 flags;
> >> > +};
> >>
> >> Hrm, so, what's the plan for when struct seccomp_data changes size?
> >
> > I guess my plan was don't ever change the size again, just use flags
> > and have extra state available via ioctl().
> >
> >> I'm realizing that it might be "too late" for userspace to discover
> >> it's running on a newer kernel. i.e. it gets a user notification, and
> >> discovers flags it doesn't know how to handle. Do we actually need
> >> both flags AND a length? Designing UAPI is frustrating! :)
> >
> > :). I don't see this as such a big problem -- in fact it's better than
> > the length mode, where you don't know what you don't know, because it
> > only copied as much info as you could handle. Older userspace would
> > simply not use information it didn't know how to use.
> >
> >> Do we need another ioctl to discover the seccomp_data size maybe?
> >
> > That could be an option as well, assuming we agree that size would
> > work, which I thought we didn't?
> 
> Size alone wasn't able to determine the layout of the seccomp_notif
> structure since it had holes (in the prior version). seccomp_data
> doesn't have holes and is likely to change in size (see the recent
> thread on adding the MPK register to it...)

Oh, sorry, I misread this as seccomp_notif, not seccomp_data.

> I'm trying to imagine the right API for this. A portable user of
> seccomp_notif expects the id/pid/flags/data to always be in the same
> place, but it's the size of seccomp_data that may change. So it wants
> to allocate space for seccomp_notif header and "everything else", of
> which is may only understand the start of seccomp_data (and ignore any
> new trailing fields).
> 
> So... perhaps the "how big are things?" ioctl would report the header
> size and the seccomp_data size. Then both are flexible. And flags
> would be left as a way to "version" the header?
> 
> Any Linux API list members want to chime in here?

So:

struct seccomp_notify_sizes {
    u16 seccomp_notify;
    u16 seccomp_data;
};

ioctl(fd, SECCOMP_IOCTL_GET_SIZE, &sizes);

This would be only one extra syscall over the lifetime of the listener
process, which doesn't seem too bad. One thing that's slightly
annoying is that you can't do it until you actually get an event, so
maybe it could be a command on the seccomp syscall instead:

seccomp(SECCOMP_GET_NOTIF_SIZES, 0, &sizes);

?

Tycho
