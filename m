Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0358EC6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDB62082B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="eiONO5SN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDB62082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbeJaJZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 05:25:04 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38733 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbeJaJZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 05:25:04 -0400
Received: by mail-it1-f196.google.com with SMTP id j9so4171253itl.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 17:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lkUNNno4q3RBKAyzzuec6e37uO+nfV0t8ELaCqQ7rA4=;
        b=eiONO5SNPOEA5JYUFiwL1Cdz6q/i8JEdUigRymrr033SNGTCQ18+qDmIq8wyA+Kgp+
         TQdVcJ7OOH/XOQ/w7++0e4eGbff8jKhml45visdG8U1RKn2m24CwruY9P+hhdkgBbo+h
         4xTQsPDWhROkED86a+bcbGruD1kniWJVJ/yxS7NuBEavmGJxUdYC0Gisv4c0yOGgODGW
         9652cripEhqWRY2hp8KrPPgePjN3nSDdbpB8CUQB7oQBeu28lMwkSsFQ1nKcPuYy6bm5
         v+H1yh/s18Jimm9fSuFpc/lCrjhIwTRmOi5dsZ4JfeMpGtbVLBpUnPIqDPT1nTtxg+xn
         AUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lkUNNno4q3RBKAyzzuec6e37uO+nfV0t8ELaCqQ7rA4=;
        b=HJVKbtKqBEkQ4Yztryg4iGXeMygD/qY/twibSDbUR0f2pylJvxLXzSrsuST0pDgTUn
         Un4uxAq/0zKqNKXUuEGs4z5GU/HGpfyRZdc6uhh0y1mZLSvMeBGvMbpJpsTASw1RtuaH
         loNdOWQ7X3GWagS9mbCUIkPlFpge5B0GYNuz6WNPTpmfE68LdOP092AeWCfO/TE0VRHS
         QtsTEvmnYJYmJLuP0HFmXxselKQCku6UOaKM+E+a77p8rkliBe2JIpP/92y+qdjM5JH4
         6jQk8aHt359mDOcDsYjasPjQWEF5SRzcdqgY6bRjha50/QKyIB78IgiRb6dQeoIz/nJh
         9PNg==
X-Gm-Message-State: AGRZ1gIdFLHdhzH7Jn6eLO/6IquFh4bYwyy4v0og4IP1vS/GIVDV0plE
        ZCSVRc3rdvChol8HrOcaEqvqCA==
X-Google-Smtp-Source: AJdET5eHzq3oKLUbm2Meemyn7YfJjnEqz68CE4cBJVQZPec/vLnAD+3sjsxJ9cN83eLJkSKOJDu/ew==
X-Received: by 2002:a24:493:: with SMTP id 141-v6mr642249itb.39.1540945760226;
        Tue, 30 Oct 2018 17:29:20 -0700 (PDT)
Received: from cisco (75-166-175-210.hlrn.qwest.net. [75.166.175.210])
        by smtp.gmail.com with ESMTPSA id b5-v6sm10470785iof.74.2018.10.30.17.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 17:29:19 -0700 (PDT)
Date:   Tue, 30 Oct 2018 18:29:17 -0600
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
Message-ID: <20181031002917.GA2180@cisco>
References: <20181029224031.29809-1-tycho@tycho.ws>
 <20181029224031.29809-2-tycho@tycho.ws>
 <CAGXu5jLjum=TDab67L5XdWKEmzU_5rYeLfGXB1vb2BmfZdPuHQ@mail.gmail.com>
 <20181030215404.GF7343@cisco>
 <CAGXu5j+ZPxu6egE1fEr+N9+zLx3N+SJ_vbS_zzj9_hrdWrrrWQ@mail.gmail.com>
 <20181030223228.GG7343@cisco>
 <CAGXu5j+XEYqVye7yZaYF1_-xpCQt7pA=YgsTpQJnYupE5MSa4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXu5j+XEYqVye7yZaYF1_-xpCQt7pA=YgsTpQJnYupE5MSa4Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 03:34:54PM -0700, Kees Cook wrote:
> On Tue, Oct 30, 2018 at 3:32 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> > On Tue, Oct 30, 2018 at 03:00:17PM -0700, Kees Cook wrote:
> >> On Tue, Oct 30, 2018 at 2:54 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> >> > On Tue, Oct 30, 2018 at 02:49:21PM -0700, Kees Cook wrote:
> >> >> On Mon, Oct 29, 2018 at 3:40 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> >> >> >     * switch to a flags based future-proofing mechanism for struct
> >> >> >       seccomp_notif and seccomp_notif_resp, thus avoiding version issues
> >> >> >       with structure length (Kees)
> >> >> [...]
> >> >> >
> >> >> > +struct seccomp_notif {
> >> >> > +       __u64 id;
> >> >> > +       __u32 pid;
> >> >> > +       __u32 flags;
> >> >> > +       struct seccomp_data data;
> >> >> > +};
> >> >> > +
> >> >> > +struct seccomp_notif_resp {
> >> >> > +       __u64 id;
> >> >> > +       __s64 val;
> >> >> > +       __s32 error;
> >> >> > +       __u32 flags;
> >> >> > +};
> >> >>
> >> >> Hrm, so, what's the plan for when struct seccomp_data changes size?
> >> >
> >> > I guess my plan was don't ever change the size again, just use flags
> >> > and have extra state available via ioctl().
> >> >
> >> >> I'm realizing that it might be "too late" for userspace to discover
> >> >> it's running on a newer kernel. i.e. it gets a user notification, and
> >> >> discovers flags it doesn't know how to handle. Do we actually need
> >> >> both flags AND a length? Designing UAPI is frustrating! :)
> >> >
> >> > :). I don't see this as such a big problem -- in fact it's better than
> >> > the length mode, where you don't know what you don't know, because it
> >> > only copied as much info as you could handle. Older userspace would
> >> > simply not use information it didn't know how to use.
> >> >
> >> >> Do we need another ioctl to discover the seccomp_data size maybe?
> >> >
> >> > That could be an option as well, assuming we agree that size would
> >> > work, which I thought we didn't?
> >>
> >> Size alone wasn't able to determine the layout of the seccomp_notif
> >> structure since it had holes (in the prior version). seccomp_data
> >> doesn't have holes and is likely to change in size (see the recent
> >> thread on adding the MPK register to it...)
> >
> > Oh, sorry, I misread this as seccomp_notif, not seccomp_data.
> >
> >> I'm trying to imagine the right API for this. A portable user of
> >> seccomp_notif expects the id/pid/flags/data to always be in the same
> >> place, but it's the size of seccomp_data that may change. So it wants
> >> to allocate space for seccomp_notif header and "everything else", of
> >> which is may only understand the start of seccomp_data (and ignore any
> >> new trailing fields).
> >>
> >> So... perhaps the "how big are things?" ioctl would report the header
> >> size and the seccomp_data size. Then both are flexible. And flags
> >> would be left as a way to "version" the header?
> >>
> >> Any Linux API list members want to chime in here?
> >
> > So:
> >
> > struct seccomp_notify_sizes {
> >     u16 seccomp_notify;
> >     u16 seccomp_data;
> > };
> >
> > ioctl(fd, SECCOMP_IOCTL_GET_SIZE, &sizes);
> >
> > This would be only one extra syscall over the lifetime of the listener
> > process, which doesn't seem too bad. One thing that's slightly
> > annoying is that you can't do it until you actually get an event, so
> > maybe it could be a command on the seccomp syscall instead:
> >
> > seccomp(SECCOMP_GET_NOTIF_SIZES, 0, &sizes);
> 
> Yeah, top-level makes more sense. u16 seems fine too.

So one problem is this is that the third argument of the seccomp
syscall is declared as const char, so I get:

kernel/seccomp.c: In function ‘seccomp_get_notif_sizes’:
kernel/seccomp.c:1401:19: warning: passing argument 1 of ‘copy_to_user’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
  if (copy_to_user(usizes, &sizes, sizeof(sizes)))
                   ^~~~~~
In file included from ./include/linux/compat.h:19:0,
                 from kernel/seccomp.c:19:
./include/linux/uaccess.h:152:1: note: expected ‘void *’ but argument is of type ‘const char *’
 copy_to_user(void __user *to, const void *from, unsigned long n)
 ^~~~~~~~~~~~

If I drop the const it doesn't complain, but I'm not sure what the protocol is
for changing the types of syscall declarations. In principle it doesn't really
mean anything, but...

Tycho
