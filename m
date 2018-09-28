Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15E9C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6E020671
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hb/c17tn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6E020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeI2Emp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:42:45 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39956 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeI2Emp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:42:45 -0400
Received: by mail-ed1-f66.google.com with SMTP id j62-v6so9406337edd.7;
        Fri, 28 Sep 2018 15:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=XDMXHnRodwWSz9TFAJayP3GrPM6xRs5hUT2n1VgH2Jk=;
        b=hb/c17tn5VUADWZZ+V8jz7XpQ8b+zvbGTq1BKDqXN4OXneWYHTjQkbd28JaMs6AALi
         aFC2aMrXtswvNFq61fAlL7prkgnm6CDNHw26E6FGwZl8oRZ7s9WBvxr9cz6hteX23S+z
         lAk9ErtLjogIadl55ZUAKvkUkk8E/Cf7LwGJ8vp2QpWM7tFmLUno9C/9KE1gXedSAdqC
         Ck4kEtpqA31J/lWF/pRHR8q98CjZaoEwEWYhORPiNh/c/vOyxdneeb2/F0cob9IJCU3p
         c9f+v0PC8pRQaCmZOTWO3KQKha+Ej1OMQAn6NuMYPSmFiG7I9Ddto6EflHoYrQTi+TPt
         vn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=XDMXHnRodwWSz9TFAJayP3GrPM6xRs5hUT2n1VgH2Jk=;
        b=aYfM+Vr+ClF4zjrEyrVyCBihDqM07gl05qEdMxyGSqJGGzoMg0oUGWOD+4+41cfwZx
         AP2vrlgn1NipQkaBju1M6OKd1QgWlA/02Hm8k8P7mkwCLupw4r9CJurjWkK4e76SAuXu
         PFTZsd5sxHx8IwY+dgzOTdFJJGSzh7OAvWu2UzTmLRJCl8a+js2ZzNXoga+uFwlsPu0z
         brsVzMBfprF1vNVGvZ6zwBqEafpjZEwkigZYgtrc7kvVZ6Q+w2CzwVpd2Y00gft1N408
         839TeoP8ugGjF/kDLaBAIFBtYqDXGj65PcUAhFG1bdgn18DZ+pCduT+Y/puIoL97uNON
         DGgA==
X-Gm-Message-State: ABuFfojIj9LYH/nHlR7AczVkjbFthiggcnMjlvhJhfxxbiGyKhGmN1lS
        Ly2b9CILRRTf02znYBc410h9ZwOo74HTh7E2GBs=
X-Google-Smtp-Source: ACcGV613yUwTziprZBF45orKDdH3dTp8exyTjfzjuBep+QMour9CQy0kZGjN0JqmEW8gwapMCPPGm3DaLo1jp9yZvl0=
X-Received: by 2002:a50:baae:: with SMTP id x43-v6mr5429482ede.65.1538173015135;
 Fri, 28 Sep 2018 15:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180927151119.9989-1-tycho@tycho.ws> <686fe047-16e6-3dfc-6284-ed574d97ad2f@gmail.com>
 <20180928220359.GF18045@cisco.lan>
In-Reply-To: <20180928220359.GF18045@cisco.lan>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Sat, 29 Sep 2018 00:16:43 +0200
Message-ID: <CAKgNAkgcHENKrT=n4_YbmxJCOaY2Z+SXJcfuw9j7uOJwgym3Dg@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] seccomp trap to userspace
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tycho,

On Sat, 29 Sep 2018 at 00:04, Tycho Andersen <tycho@tycho.ws> wrote:
>
> On Fri, Sep 28, 2018 at 11:57:40PM +0200, Michael Kerrisk (man-opages) wrote:
> > Hi Tycho,
> >
> > On 09/27/2018 05:11 PM, Tycho Andersen wrote:
> > > Hi all,
> > >
> > > Here's v7 of the seccomp trap to userspace set. There are various minor
> > > changes and bug fixes, but two major changes:
> > >
> > > * We now pass fds to the tracee via an ioctl, and do it immediately when
> > >    the ioctl is called. For this we needed some help from the vfs, so
> > >    I've put the one patch in this series and cc'd fsdevel. This does have
> > >    the advantage that the feature is now totally decoupled from the rest
> > >    of the set, which is itself useful (thanks Andy!)
> > >
> > > * Instead of putting all of the notification related stuff into the
> > >    struct seccomp_filter, it now lives in its own struct notification,
> > >    which is pointed to by struct seccomp_filter. This will save a lot of
> > >    memory (thanks Tyler!)
> >
> > Is there a documentation (man page) patch for this API change?
>
> Not yet, but once we decide on a final API I'll prepare one.

Honestly, the production of such documentation should be part of the
evolution towards the final API...

Documentation is not an afterthought. It's a tool for pushing you, the
developer (and others, your reviewers) to more deeply consider your
design.

Thanks,

Michael
-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
