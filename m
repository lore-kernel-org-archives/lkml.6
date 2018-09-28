Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1A2C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67808206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FO61LX+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67808206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeI2FPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:15:14 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46127 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbeI2FPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:15:14 -0400
Received: by mail-ot1-f67.google.com with SMTP id q4-v6so7531405otf.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 15:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9RkEYaQni0JBMd8CowPIJUUqF8FVeeDKEcu3vP7h/S0=;
        b=FO61LX+hbTvJVg7WGXjNlLLMnuFCWdJnVR1gde1j26kU/2Wr83v3F4AZgUn04mcVGz
         nkT3gyzdeadiKfxe/o+KcSvwf8hUe63L7cclk9/Cua6PGiTBsY/dR27XmPAD3Y7ivch9
         HZrOa4qoQfvXimTaAZN3NNf8huF15wekbTVev2UbwvXu9OJvcmHc3lLXMiCWAOzk+a5c
         vUtC0zLrYMS/lf1kq1V/HCytRFKuAIDWXtj727wSQULbxI+P9jiHp2yheehUtg3ePaka
         ZVQz5XkuFKsRYbEfZCsjIfi8iSlfRvRla9agqpM8BFG6noV2hgvhq4JTiP0vVQN530YU
         Et7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9RkEYaQni0JBMd8CowPIJUUqF8FVeeDKEcu3vP7h/S0=;
        b=uMFC5uUDp7MOliMCcHIMb1kCPmMG2qvMhqM3FLV8L5H9MnktKhc3978P4NV+mJDry2
         +jT3TDngIUPTEKihD0a9lQQgojfRyE4nUbhh8Y5hvVR82ElYc6hAVkqGKDACG8nGA+PW
         TqOmh/qJKCggt5iKbYl3pvlBS21xsR5VPSclFcTA/SZAZDaiE7ucdyhP8CwtOLIOaK1R
         acHro93YGke68aDb1pB6hxnRGpsg1PfYw/MPo604xS2kDbTy5/V+GKTVW/8TYWHOTpAA
         SiD1cJjSJ6Ebl/ZQFx7H8AfDltBzQrJyWdsN2ZbMPS7rrQdiPMyB6CUL/B4jGFEho4Vd
         K4tg==
X-Gm-Message-State: ABuFfogiNvYvWqxJZ7QEslZ+eCEPvTQ+83tqAzR49Bd/4c1xl0SDzdbP
        g2Fc+mYclnurIiYnlt6HXQPcdsekb4qyqq1ZaUeZUNjITkXgJpo1
X-Google-Smtp-Source: ACcGV60VzQeuz6o/xvQMorkpz6Ji1H70Mc6Zy9xtHVeG7ZNnOVmsD7GF58ibbscKWewR3uXuScWbm54tGHcSdKgW/FM=
X-Received: by 2002:a9d:2843:: with SMTP id h3-v6mr465866otd.230.1538174957801;
 Fri, 28 Sep 2018 15:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180927151119.9989-1-tycho@tycho.ws> <686fe047-16e6-3dfc-6284-ed574d97ad2f@gmail.com>
 <20180928220359.GF18045@cisco.lan> <CAKgNAkgcHENKrT=n4_YbmxJCOaY2Z+SXJcfuw9j7uOJwgym3Dg@mail.gmail.com>
 <CAGXu5j+GTwOZnNscfMmArxxJgNvPETgBns1Y6u11tapkoOwn+w@mail.gmail.com> <CAKgNAkis9WVwLoYGV+uT_YfQVTR-wh+-Ut_2wZW8B_F1KGRzOA@mail.gmail.com>
In-Reply-To: <CAKgNAkis9WVwLoYGV+uT_YfQVTR-wh+-Ut_2wZW8B_F1KGRzOA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 29 Sep 2018 00:48:51 +0200
Message-ID: <CAG48ez1f7Cf-9J5wxnAt=NJ=SRuYLj75cNjCrCYmPH2=FypBdg@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] seccomp trap to userspace
To:     Michael Kerrisk-manpages <mtk.manpages@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Tycho Andersen <tycho@tycho.ws>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        suda.akihiro@lab.ntt.co.jp, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 12:47 AM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> On Sat, 29 Sep 2018 at 00:35, Kees Cook <keescook@chromium.org> wrote:
> > On Fri, Sep 28, 2018 at 3:16 PM, Michael Kerrisk (man-pages)
> > <mtk.manpages@gmail.com> wrote:
> > > On Sat, 29 Sep 2018 at 00:04, Tycho Andersen <tycho@tycho.ws> wrote:
> > >> On Fri, Sep 28, 2018 at 11:57:40PM +0200, Michael Kerrisk (man-opages) wrote:
> > >> > On 09/27/2018 05:11 PM, Tycho Andersen wrote:
> > >> > > Here's v7 of the seccomp trap to userspace set. There are various minor
> > >> > > changes and bug fixes, but two major changes:
> > >> > >
> > >> > > * We now pass fds to the tracee via an ioctl, and do it immediately when
> > >> > >    the ioctl is called. For this we needed some help from the vfs, so
> > >> > >    I've put the one patch in this series and cc'd fsdevel. This does have
> > >> > >    the advantage that the feature is now totally decoupled from the rest
> > >> > >    of the set, which is itself useful (thanks Andy!)
> > >> > >
> > >> > > * Instead of putting all of the notification related stuff into the
> > >> > >    struct seccomp_filter, it now lives in its own struct notification,
> > >> > >    which is pointed to by struct seccomp_filter. This will save a lot of
> > >> > >    memory (thanks Tyler!)
> > >> >
> > >> > Is there a documentation (man page) patch for this API change?
> > >>
> > >> Not yet, but once we decide on a final API I'll prepare one.
> > >
> > > Honestly, the production of such documentation should be part of the
> > > evolution towards the final API...
> > >
> > > Documentation is not an afterthought. It's a tool for pushing you, the
> > > developer (and others, your reviewers) to more deeply consider your
> > > design.
> >
> > In Tycho's defense, he did write up documentation in Documentation/
> > for the feature, so it won't be an afterthought. :)
>
> So, I missed that... How do I find this Documentation/ ?

It's in patch 1:
https://lore.kernel.org/lkml/20180927151119.9989-2-tycho@tycho.ws/
