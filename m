Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B20C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C7D2156B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="lJ2xUnVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C7D2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391604AbeIVDy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 23:54:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37822 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391318AbeIVDy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 23:54:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id h69-v6so6545939pfd.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 15:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0L2clyUrWHJarGFHWqMrQJThOI5jgP2+1l9wSj+4op0=;
        b=lJ2xUnVlSgJW8XwXVdBubvkz7Ei3b5CZn3CgHOwBo135bgURSa6/oHFQNRqd7Yq7UH
         fY8w9EOC1NgbHx4DS2TAAxiCovC1v5GK+v0Bsay4L66cR9i5TLlG5A/hGIt78Lh9OgZP
         TSIdr4Doq/4MQEDBvyRDcc5NvtLuFdtDFhATJ+MFlsMT7fZTMFD6OtRHajn1dRq1yyq/
         FY7/cUYStpVwfK+UtD7lpoWnPO6aIpX/k8/nEsKX2cY05qJV/CUsBrPD0V0TbsNY3J4I
         nHrYCBhTYEl+NuTrn76wINGlmdCbeFLeSV9hRkWC705rIY8p9VsiSA2lArqcznO9RDmv
         9iCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0L2clyUrWHJarGFHWqMrQJThOI5jgP2+1l9wSj+4op0=;
        b=CtOUpOVF/qPsPgTS6ZRQlsTJWHJc06je3ShB+IAMsuzjQWyzR8b8Tf1heOO1i8WpJJ
         OSV940DPbP6aTg78xtP4OQYjLqWVkNsrmhs/E49hTJjPtnCdIrUBEhnfgmHaR1Fa9t7O
         C6D6dPmZYhpiBu4po6VPKthzSnDBD7JB8xvqQMuPULE/vFPprsop9VcG/r5LiLWT545v
         Vd+qn82vmaPoepi18PGTjeVvP9oV6GQzBylIgY0ZPp10k0KRDshRBKf+SHUd8WhuW9s/
         lTbFjmtI5BnTV2GXu8QK2IMnNgCIwGInE/UcSPwIwoJgTb8twEMn4PRIPeSYq7JYiA3i
         sdNg==
X-Gm-Message-State: APzg51C+M6zy/gESTaTD7/APBO8FVj9oyP1b0nUVpz+66bxtgiQyq7tm
        TaDKllu3TdJc42L66VZdxUkPPg==
X-Google-Smtp-Source: ANB0VdbVd1GYmsL2zpasnI1oFklj/EsFLulf3i5pzjrQUh418Nvj+PX5C5wg20j/+br1sG3wPeNk5Q==
X-Received: by 2002:a63:e806:: with SMTP id s6-v6mr6253313pgh.176.1537567419806;
        Fri, 21 Sep 2018 15:03:39 -0700 (PDT)
Received: from cisco ([128.107.241.181])
        by smtp.gmail.com with ESMTPSA id q85-v6sm40219482pfa.151.2018.09.21.15.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 15:03:38 -0700 (PDT)
Date:   Fri, 21 Sep 2018 16:03:36 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v6 4/5] seccomp: add support for passing fds via
 USER_NOTIF
Message-ID: <20180921220336.GU4672@cisco>
References: <20180906152859.7810-5-tycho@tycho.ws>
 <CALCETrWZmN4FeCSwemfMeayupBmQ-NqpVWQuqSU34CLvzdx8gw@mail.gmail.com>
 <20180919095536.GM4672@cisco>
 <C1406292-7496-459F-A76A-20C9EFBB12D6@amacapital.net>
 <20180919143842.GN4672@cisco>
 <CALCETrVuP0nQ5B01-iWrcQ87hisz7=jA08-Uisqud_r+zc74NQ@mail.gmail.com>
 <20180920234240.GR4672@cisco>
 <CALCETrWEr_VAtJu1mm1akTigsRUXAA7_7RHb-WGHqnyNy=j17Q@mail.gmail.com>
 <20180921133928.GS4672@cisco>
 <CALCETrWxjLw6-pMcOydDxbf6KfMrYZcdriTk5g7U3Ba6cRNJNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWxjLw6-pMcOydDxbf6KfMrYZcdriTk5g7U3Ba6cRNJNg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 11:27:59AM -0700, Andy Lutomirski wrote:
> On Fri, Sep 21, 2018 at 6:39 AM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > On Thu, Sep 20, 2018 at 07:18:45PM -0700, Andy Lutomirski wrote:
> > >
> > > I think we just want the operation to cover all the cases.  Let PUT_FD
> > > take a source fd and a dest fd.  If the source fd is -1, the dest is
> > > closed.  If the source is -1 and the dest is -1, return -EINVAL.  If
> > > the dest is -1, allocate an fd.  If the dest is >= 0, work like
> > > dup2().  (The latter could be necessary to emulate things like, say,
> > > dup2 :))
> >
> > ...then if we're going to allow overwriting fds, we'd need to lift out
> > the logic from do_dup2 somewhere? Is this getting too complicated? :)
> >
> 
> fds are complicated :-p

:D

> More seriously, though, I think it's okay if we don't support
> everything out of the box.  getting the general semantics I suggested
> is kind of nice because the resulting API is conceptually simple, even
> if it encapsulates three cases.  But I'd be okay with only supporting
> add-an-fd-at-an-unused-position and delete-an-fd out of the box --
> more can be added if there's demand.

It's the delete/replace-an-fd one that has me worried. Anyway, I'll
take a look and see what I can figure out.

> But I think that exposing an operation that allocates and reserves an
> fd without putting anything in the slot is awkward, and it opens us up
> to weird corner cases becoming visible that are currently there but
> mostly hidden.  For example, what happens if someone overwrites a
> reserved fd with dup2()?  (The answer is apparently -EBUSY -- see the
> big comment in do_dup2() in fs/file.c.)  But there's a more
> significant nastiness: what happens if someone abuses your new
> mechanism to overwrite a reserved fd that belongs to a different
> thread?  It looks like you'll hit the BUG_ON(fdt->fd[fd] != NULL); in
> __fd_install().  So unless you actually track which unused fds you own
> and enforce that the final installation installs in the right slot,
> you have a problem.
> 
> BTW, socketpair() isn't the only thing that can add two fds.
> recvmsg() can, too, as can pipe() and pipe2().  Some of the DRM ioctls
> may as well for all I know.  But socketpair(), pipe(), and recvmsg()
> can be credibly emulated by adding each fd in sequence and then
> deleting them all of one fails.  Sure, this could race against dup2(),
> but I'm not sure we care.

Yup agreed. We need to do the install when the ioctl() is called.

Tycho
