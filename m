Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981C1ECDE3C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3759221486
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="X69A5WCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3759221486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbeJRGbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:31:42 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33403 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbeJRGbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:31:41 -0400
Received: by mail-qk1-f195.google.com with SMTP id 84-v6so17624125qkf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ojxHCS8JGo29W8RBYlCrc4TuCIJLhI6sWMX6g3eLN7U=;
        b=X69A5WCPGDnelCLRCcVCKfAL4+ojx7TP64d++8iQk4IPq3GBDZpV1/lMSNskzPBdWm
         bzgr6wMW9s5b40ozV7+L/fDj/R7oIAbx1Z5Ov6nZ8Q6gCephZbVcMWSJIcvzIZYqEDI4
         50qrtLHr2REIQBWy7FxvSbweypzkbnEgz7a33FewlZLtDbR8m1AFEurpjydd5aF18foA
         dxVMG/8mXReHxM3c94MOYD4ed3/EbdxmAvdUfDKEvVtSrBCi51I/K24pyOGTS/csasP2
         QYcbI7x9ndmOR7vZPUUTl83wgytQcAHl/7aCVDP7yExvQxy+tM3BGvZ5wP9gcKhD9LWy
         rHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ojxHCS8JGo29W8RBYlCrc4TuCIJLhI6sWMX6g3eLN7U=;
        b=D94sAtO84rbnVFFPKjM668BLfhS55aNfUvx3FfIm+LwZ+IdqMAO6lnDdzf0Fe6at38
         zmC0fARQVsM65ksKYUJunvFrXTIdl5N1iNZMn35RoxGcDhJmSre/L+He8Z5uZ9GZYvsr
         1XQYW+oQQHV5Tklg3myUMApn0IC9DuqDb4hUgRoO0BRGxesQk6tOALLif6PehN3pzaMy
         XqDbhUqIy1gG+g3TFqJl1aHR9Vp13xpx+yrnlp6Kr8sAvsLUpZDSINQx7VNJ256Jg/oV
         0ayZYT1au4p4z1ggLm+qfVFI1iTJVUDV7AI5m1GdQjSFi18ue8qdVppe3obxO8wydprP
         wjXQ==
X-Gm-Message-State: ABuFfogNK1qFUEgkWSfXS5NjThfoHR+JUK+fOnmuaZoIBotHgVhFwzUC
        1Nvw/h/B/nmbYGBXLEUoD6EpcA==
X-Google-Smtp-Source: ACcGV604qYX9vxnsMOKm5SDnzrehGjzWaLHVC6r5Qc0UsTnuVZfWYkqkudDsWhTTygWmQuqQr0IcRA==
X-Received: by 2002:a37:2307:: with SMTP id j7-v6mr26946993qkj.146.1539815631912;
        Wed, 17 Oct 2018 15:33:51 -0700 (PDT)
Received: from cisco ([173.38.117.94])
        by smtp.gmail.com with ESMTPSA id 14-v6sm10469744qke.3.2018.10.17.15.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 15:33:50 -0700 (PDT)
Date:   Wed, 17 Oct 2018 16:33:47 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v7 1/6] seccomp: add a return code to trap to userspace
Message-ID: <20181017223347.GC14047@cisco>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <20180927151119.9989-2-tycho@tycho.ws>
 <CAGXu5jJr3JWLYGrJ+knu3sj4wwJ_irVvs+JRrY5MuYT3voLegg@mail.gmail.com>
 <20181017202933.GB14047@cisco>
 <CAGXu5jK5yN7zcPUMzFYnUbRrVkLNE0YDCioYdNC3P6mF437+5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jK5yN7zcPUMzFYnUbRrVkLNE0YDCioYdNC3P6mF437+5g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 03:21:02PM -0700, Kees Cook wrote:
> On Wed, Oct 17, 2018 at 1:29 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> > On Thu, Sep 27, 2018 at 02:31:24PM -0700, Kees Cook wrote:
> >> On Thu, Sep 27, 2018 at 8:11 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> >> > @@ -60,4 +62,29 @@ struct seccomp_data {
> >> >         __u64 args[6];
> >> >  };
> >> >
> >> > +struct seccomp_notif {
> >> > +       __u16 len;
> >> > +       __u64 id;
> >> > +       __u32 pid;
> >> > +       __u8 signaled;
> >> > +       struct seccomp_data data;
> >> > +};
> >> > +
> >> > +struct seccomp_notif_resp {
> >> > +       __u16 len;
> >> > +       __u64 id;
> >> > +       __s32 error;
> >> > +       __s64 val;
> >> > +};
> >>
> >> So, len has to come first, for versioning. However, since it's ahead
> >> of a u64, this leaves a struct padding hole. pahole output:
> >>
> >> struct seccomp_notif {
> >>         __u16                      len;                  /*     0     2 */
> >>
> >>         /* XXX 6 bytes hole, try to pack */
> >>
> >>         __u64                      id;                   /*     8     8 */
> >>         __u32                      pid;                  /*    16     4 */
> >>         __u8                       signaled;             /*    20     1 */
> >>
> >>         /* XXX 3 bytes hole, try to pack */
> >>
> >>         struct seccomp_data        data;                 /*    24    64 */
> >>         /* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
> >>
> >>         /* size: 88, cachelines: 2, members: 5 */
> >>         /* sum members: 79, holes: 2, sum holes: 9 */
> >>         /* last cacheline: 24 bytes */
> >> };
> >> struct seccomp_notif_resp {
> >>         __u16                      len;                  /*     0     2 */
> >>
> >>         /* XXX 6 bytes hole, try to pack */
> >>
> >>         __u64                      id;                   /*     8     8 */
> >>         __s32                      error;                /*    16     4 */
> >>
> >>         /* XXX 4 bytes hole, try to pack */
> >>
> >>         __s64                      val;                  /*    24     8 */
> >>
> >>         /* size: 32, cachelines: 1, members: 4 */
> >>         /* sum members: 22, holes: 2, sum holes: 10 */
> >>         /* last cacheline: 32 bytes */
> >> };
> >>
> >> How about making len u32, and moving pid and error above "id"? This
> >> leaves a hole after signaled, so changing "len" won't be sufficient
> >> for versioning here. Perhaps move it after data?
> >
> > Just to confirm my understanding; I've got these as:
> >
> > struct seccomp_notif {
> >         __u32                      len;                  /*     0     4 */
> >         __u32                      pid;                  /*     4     4 */
> >         __u64                      id;                   /*     8     8 */
> >         __u8                       signaled;             /*    16     1 */
> >
> >         /* XXX 7 bytes hole, try to pack */
> >
> >         struct seccomp_data        data;                 /*    24    64 */
> >         /* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
> >
> >         /* size: 88, cachelines: 2, members: 5 */
> >         /* sum members: 81, holes: 1, sum holes: 7 */
> >         /* last cacheline: 24 bytes */
> > };
> > struct seccomp_notif_resp {
> >         __u32                      len;                  /*     0     4 */
> >         __s32                      error;                /*     4     4 */
> >         __u64                      id;                   /*     8     8 */
> >         __s64                      val;                  /*    16     8 */
> >
> >         /* size: 24, cachelines: 1, members: 4 */
> >         /* last cacheline: 24 bytes */
> > };
> >
> > in the next version. Since the structure has no padding at the end of
> > it, I think the Right Thing will happen. Note that this is slightly
> > different than what Kees suggested, if I add signaled after data, then
> > I end up with:
> >
> > struct seccomp_notif {
> >         __u32                      len;                  /*     0     4 */
> >         __u32                      pid;                  /*     4     4 */
> >         __u64                      id;                   /*     8     8 */
> >         struct seccomp_data        data;                 /*    16    64 */
> >         /* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
> >         __u8                       signaled;             /*    80     1 */
> >
> >         /* size: 88, cachelines: 2, members: 5 */
> >         /* padding: 7 */
> >         /* last cacheline: 24 bytes */
> > };
> >
> > which I think will have the versioning problem if the next member
> > introduces is < 7 bytes.
> 
> It'll be a problem in either place. What I was thinking was that
> specific versioning is required instead of just length.

Oh, if we decide to use the padded space? Yes, that makes sense. Ok,
I'll switch it to a version.

Tycho
