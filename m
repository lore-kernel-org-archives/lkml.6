Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9C410C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EC520891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WY6QUJH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EC520891
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936016AbeFMPnX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:43:23 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35134 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935833AbeFMPnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:43:22 -0400
Received: by mail-oi0-f68.google.com with SMTP id e8-v6so2755470oii.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rbv3LFQpwkrqD8YmW+XftjO/vG3Ok/eabDEVpMqWqS0=;
        b=WY6QUJH2BgVIOi8HHAOq85YMU9v7WznhC3V9NZFtjk0Y1kGbF2uap06owHgsr9HtZj
         j+7lBrlts6OsC0QD4D8pIYZ1qmboqsI7JA2zbGENLVENtb9fCKxt5r861AoUGtyEHYxJ
         4qqmb+VjLma0yWXqldE4GYJO7IESgzRW8/HEgq2IAwl04Bocn5hgzO0LdNX36mUqkpXp
         /3zKfbfB9PIQ205VeYYpK92o+z2FVpO8qrJ9hGnB797nGB3NpGDIjl/16PW+QkGwi8yt
         15LJDI1Wih7s0FCYLa4eU4biabomY8O6h3+9Yar/6Tpc1YfI/kcsN7DV4/ng4gj1h0Gm
         IcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbv3LFQpwkrqD8YmW+XftjO/vG3Ok/eabDEVpMqWqS0=;
        b=byNSXDH5dhfp+wENstmYyNT21mZQ/3xnZdA5iJitAzfnnfPvEih04uQMovGrgrUkv7
         GdyZk3o3au3NYvQhCQ99m1++z7MCxsqa92MioTiPHs34rQNKBNG/teoK7kSkjCkfv7+B
         lDqtMzembFutFk4JfsSOV/Qrjola5Nn+WsrfmCSlUBrBrj1xTSlTyYVbNs/WW2e7bmKR
         VS2PC2rkhJddpRsxf/yOncZMKHAMdpPCbERAnbC/gNS+9FpRPcSBSl/1oiU6mtQbebvB
         vmmeFSG5ZZKliM3H2K02MyVBtQyOi1JO/pxPPpMMHUqQIUP55d7OEy+zSDeQ7yvjHo+T
         9Fig==
X-Gm-Message-State: APt69E0TixTpZPPlcI8l+oGGzRqUbvzup3fRVnKfPWr4oMh+hjw5xEuR
        ZxesrjoJiD7AH+wMwwKjs5UvBNT9xuOMMyja5M8bDQ==
X-Google-Smtp-Source: ADUXVKJxQAF9n6frGQNPsZ15Ug12CDo1euKCHkZkcqdg/S5yo83FyEy4qMtqUvPNdnHeZokHUBzGUXdKfdZc3dFIkAA=
X-Received: by 2002:aca:3048:: with SMTP id w69-v6mr4390349oiw.29.1528904601256;
 Wed, 13 Jun 2018 08:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180531144949.24995-1-tycho@tycho.ws> <20180531144949.24995-2-tycho@tycho.ws>
 <CAG48ez3x9HSkLZc-da6zjPbckyfdPvwyQa3p9P6EzQ5sGk53eg@mail.gmail.com>
 <20180604001812.GE15998@cisco> <CAG48ez2ZD1fMFcTfro-axUzC7g2Nb4ACnHPKXgr2q=_BchJuYg@mail.gmail.com>
In-Reply-To: <CAG48ez2ZD1fMFcTfro-axUzC7g2Nb4ACnHPKXgr2q=_BchJuYg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 13 Jun 2018 17:43:08 +0200
Message-ID: <CAG48ez01T_FZ5GWnx6YnSb4QU5HQbJGuwxc-gzQhSUxdTSc9PQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] seccomp: add a return code to trap to userspace
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        suda.akihiro@lab.ntt.co.jp, "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 5:32 PM Jann Horn <jannh@google.com> wrote:
>
> On Mon, Jun 4, 2018 at 2:18 AM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > Hi Jann,
> >
> > On Sun, Jun 03, 2018 at 08:41:01PM +0200, Jann Horn wrote:
> > > On Sun, Jun 3, 2018 at 2:29 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > > >
> > > > This patch introduces a means for syscalls matched in seccomp to notify
> > > > some other task that a particular filter has been triggered.
[...]

By the way: You should probably CC linux-api@ on the next version of
this patchset.
Documentation/process/submitting-patches.rst says:

| If changes affect userland-kernel interfaces, please send the MAN-PAGES
| maintainer (as listed in the MAINTAINERS file) a man-pages patch, or at
| least a notification of the change, so that some information makes its way
| into the manual pages.  User-space API changes should also be copied to
| linux-api@vger.kernel.org.
