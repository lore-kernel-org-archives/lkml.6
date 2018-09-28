Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C5DC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CFF20652
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="WfEdMII/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CFF20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbeI1VDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:03:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34104 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeI1VDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:03:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id d19-v6so4648816pgv.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x2x4F0oXgq7iQlh6/OuJYM4N5wT5Us+ar/PJGNWHIAo=;
        b=WfEdMII/KNj6jmhF5sIcAmkSPi06inSujNabDclA1L7NRT5WxhYQN4VN0fDmEroTqp
         +5GvQwbfsHP4XVIZp2sv4t1i3mEMllFxrbyXawVtkipwurGVcofzLDUD8zwjT01/4fTI
         mDOgCdjUVWbwYEmf/TfVWBYPiJZ3bU8Bi1OvBkrN91UWWFrvgUf7fMk+hIiMaUD5HSrg
         ZlRljAEtdXReiSm+vAzLKjvxy7qR3skgX7jOkRtDnEtyHcgysMO7V3+y4Btww4Y/CzFh
         6WOx/CdHrw+Li/xKGd6E7xoziUsOpSc6Vba80Byd9YDtokz2ku6tzdwr8hNmT4gL0CHo
         LkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x2x4F0oXgq7iQlh6/OuJYM4N5wT5Us+ar/PJGNWHIAo=;
        b=pK3j/6W0OxDIvcVpA8tjH5E/D4EVZeACDoJKjEiPVcEHO5AvWBNGoTeZkZKbf+VSya
         lBP6OAPZbb8b4HW037dEoo/i8eDv3nS/pQgoYaVEd/jciIH4bLcjAZBnlDp5+Nwv150R
         tvI7MrysWbQ82+25+Z51VB1qs9su7jvdblnZachK9HMyco7ShrIJixICTx5BHBzOCXH2
         02s3yhiSv5oIE4miSVNZq9p0et6h55N/wCOAvTbzMkusSz7C4xoQG5NWO+hky9RNsjJE
         IjCDhWKm3hlkthhQmZg1vIf4WVMHjZdWvId14QRRbs1C7d0HHGwkOt8XkO8M7NeyM8+t
         Svxw==
X-Gm-Message-State: ABuFfoj91yYCKXftr8MTOHKJ4a7RFKx/0tXAKGdY1nc4KhFs1mUWOWJ2
        5lNqnAE+QCnvmYb/HSFsA3cxqg==
X-Google-Smtp-Source: ACcGV62d09KV+bKj+/LVsNKG44ZYub9oOjvPHJq3GZNB+23/QDyXQ/zPbPSe37TQ3sVzc7kcmy2tVg==
X-Received: by 2002:a62:411a:: with SMTP id o26-v6mr17314576pfa.111.1538145545648;
        Fri, 28 Sep 2018 07:39:05 -0700 (PDT)
Received: from cisco.lan ([128.107.241.190])
        by smtp.gmail.com with ESMTPSA id t12-v6sm6324855pgg.72.2018.09.28.07.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 07:39:04 -0700 (PDT)
Date:   Fri, 28 Sep 2018 08:39:01 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     Stephane Graber <stgraber@ubuntu.com>,
        LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <20180928143901.GB18045@cisco.lan>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <20180927151119.9989-2-tycho@tycho.ws>
 <CAGXu5jJr3JWLYGrJ+knu3sj4wwJ_irVvs+JRrY5MuYT3voLegg@mail.gmail.com>
 <20180927224839.GF15491@cisco.cisco.com>
 <CAGXu5jJ8VSJ6BqqxAL+B12bv2xTNU3CzpBOMf-zEChO9opaFMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJ8VSJ6BqqxAL+B12bv2xTNU3CzpBOMf-zEChO9opaFMA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 04:10:29PM -0700, Kees Cook wrote:
> On Thu, Sep 27, 2018 at 3:48 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> > On Thu, Sep 27, 2018 at 02:31:24PM -0700, Kees Cook wrote:
> >> On Thu, Sep 27, 2018 at 8:11 AM, Tycho Andersen <tycho@tycho.ws> wrote:
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
> > I'm not sure what you mean by "len won't be sufficient for versioning
> > here"? Anyway, I can do some packing on these; I didn't bother before
> > since I figured it's a userspace interface, so saving a few bytes
> > isn't a huge deal.
> 
> I was thinking the "len" portion was for determining if the API ever
> changes in the future. My point was that given the padding holes, e.g.
> adding a u8 after signaled, "len" wouldn't change, so the kernel might
> expect to starting reading something after signaled that it wasn't
> checking before, but the len would be the same.

Oh, yeah. That's ugly :(

> >> I have to say, I'm vaguely nervous about changing the semantics here
> >> for passing back the fd as the return code from the seccomp() syscall.
> >> Alternatives seem less appealing, though: changing the meaning of the
> >> uargs parameter when SECCOMP_FILTER_FLAG_NEW_LISTENER is set, for
> >> example. Hmm.
> >
> > From my perspective we can drop this whole thing. The only thing I'll
> > ever use is the ptrace version. Someone at some point (I don't
> > remember who, maybe stgraber) suggested this version would be useful
> > as well.
> 
> Well that would certainly change the exposure of the interface pretty
> drastically. :)
> 
> So, let's talk more about this, as it raises another thought I had
> too: for the PTRACE interface to work, you have to know specifically
> which filter you want to get notifications for. Won't that be slightly
> tricky?

Not necessarily. The way I imagine using it is:

1. container manager forks init task
2. init task does a bunch of setup stuff, then installs the filter
3. optionally install any user specified filter (or just merge the
   filter with step 2 instead of chaining them)
4. container manager grabs the listener fd from the container init via
   ptrace
5. init execs the user specified init

So the offset will always be known at least in my usecase. The
container manager doesn't want to install the filter on itself, so it
won't use NEW_LISTENER. Similarly, we don't want init to use
NEW_LISTENER, because if the user has decided to block sendmsg as part
of their policy, there's no way to get the fd out.

> > Anyway, let me know if your nervousness outweighs this, I'm happy to
> > drop it.
> 
> I'm not opposed to keeping it, but if you don't think anyone will use
> it ... we should probably drop it just to avoid the complexity. It's a
> cool API, though, so I'd like to hear from others first before you go
> tearing it out. ;) (stgraber added to CC)

It does seem useful for lighter weight cases than a container. The "I
want to run some random binary that I don't have the source for that
tries to make some privileged calls it doesn't really need" case. But
as a Container Guy I think I have in my contract somewhere that I have
to use containers :). But let's see what people think.

> >> > +       if (copy_from_user(&size, buf, sizeof(size)))
> >> > +               return -EFAULT;
> >> > +       size = min_t(size_t, size, sizeof(resp));
> >> > +       if (copy_from_user(&resp, buf, size))
> >> > +               return -EFAULT;
> >>
> >> For sanity checking on a double-read from userspace, please add:
> >>
> >>     if (resp.len != size)
> >>         return -EINVAL;
> >
> > Won't that fail if sizeof(resp) < resp.len, because of the min_t()?
> 
> Ah, true. In that case, probably do resp.len = size to avoid any logic
> failures due to the double-read? I just want to avoid any chance of
> confusing the size and actually using it somewhere.

Yep, sounds good.

Tycho
