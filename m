Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9270DC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423B423E5B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423B423E5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbeFVHr3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:47:29 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:39884 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbeFVHr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:47:28 -0400
Received: by mail-ot0-f194.google.com with SMTP id l15-v6so6511423oth.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 00:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Iyn30l9fde7x/pZ4JHMEIRjg/CWn3zVgPaWp6ysGwM0=;
        b=gh3xwTl8aiemGI954KI7MpoHcrEJByUuHC8fHJmcuKKO6/tDIxZ42XrFz+1dkroHls
         QeqQfhsjGogJh8M9tNj3ucRrb3gZnNQxOsgNn8kLSNFWt1ifpJ193Dthi8RkWTLbYbBY
         WN6AUwrkqOU/Mgz5zUvgmuQCE1BjAvyUuKIqk729T2a4kqh1jJEyL6E1Em5A+MVO0wQD
         vnknvhnH+n6Wc/YbwyYRkW0Su/QZJ6jERRPEztgskiY8jWX3/QlupgkB5BPnjGJKBd3n
         uc0FBm0cloIwCgT7+PEe5MDNW6oXs1gvolyj+tb7oSVxwXHUbMxrMA13pWQNCalCsRf0
         iGfg==
X-Gm-Message-State: APt69E08z5W4VS8AopD/jO3ZRKwMTz6szuQSfIfqpmw4rPy9olI3nc0u
        Eme9C6cO8Zt9D8m7MgY/JFyZBrI3C1Tv52+DZCn5iQ==
X-Google-Smtp-Source: ADUXVKItHq6FZo5qWBtWd2/71jrnd8NJK/LwjqEVZX718URoObyUVmKMPMc3TQCNXk713PMnHZlp88gJcICD+2OoX/c=
X-Received: by 2002:a9d:17ce:: with SMTP id j72-v6mr322723otj.244.1529653647475;
 Fri, 22 Jun 2018 00:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQv26uPWSYmhNdhJ4QM+AMKK=JFkMmDftLb1WpvOUyN8Q@mail.gmail.com>
 <20180621083316.8765-1-omosnace@redhat.com> <CAHC9VhQk42UA5c_XAaG20h3TZt20TQyJxDMfqWHHgu2=8+kcVQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQk42UA5c_XAaG20h3TZt20TQyJxDMfqWHHgu2=8+kcVQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 22 Jun 2018 09:47:16 +0200
Message-ID: <CAFqZXNs_cKtTZKGkhL4KwTweKEMdVwgS0RAQS_Soqw1c1HSNyw@mail.gmail.com>
Subject: Re: [PATCH -next] cred: conditionally declare groups-related functions
To:     Paul Moore <paul@paul-moore.com>
Cc:     akpm@linux-foundation.org, rdunlap@infradead.org,
        sfr@canb.auug.org.au, Eric Paris <eparis@redhat.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-next@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

št 21. 6. 2018 o 23:17 Paul Moore <paul@paul-moore.com> napísal(a):
>
> On Thu, Jun 21, 2018 at 4:33 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > The groups-related functions declared in include/linux/cred.h are
> > defined in kernel/groups.c, which is compiled only when
> > CONFIG_MULTIUSER=y. Move all these function declarations under #ifdef
> > CONFIG_MULTIUSER to help avoid accidental usage in contexts where
> > CONFIG_MULTIUSER might be disabled.
> >
> > This patch also adds a fallback for groups_search(). Currently this
> > function is only called from kernel/groups.c itself and
> > keys/permissions.c, which depends on CONFIG_MULTIUSER. However, the
> > audit subsystem (which does not depend on CONFIG_MULTIUSER) calls this
> > function in -next, so the fallback will be needed to avoid compilation
> > errors or ugly workarounds.
> >
> > See also:
> > https://lkml.org/lkml/2018/6/20/670
> > https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git/commit/?h=next&id=af85d1772e31fed34165a1b3decef340cf4080c0
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  include/linux/cred.h | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/cred.h b/include/linux/cred.h
> > index 631286535d0f..8917768453cc 100644
> > --- a/include/linux/cred.h
> > +++ b/include/linux/cred.h
> > @@ -65,6 +65,12 @@ extern void groups_free(struct group_info *);
> >
> >  extern int in_group_p(kgid_t);
> >  extern int in_egroup_p(kgid_t);
> > +
> > +extern int set_current_groups(struct group_info *);
> > +extern void set_groups(struct cred *, struct group_info *);
> > +extern int groups_search(const struct group_info *, kgid_t);
> > +extern bool may_setgroups(void);
> > +extern void groups_sort(struct group_info *);
> >  #else
> >  static inline void groups_free(struct group_info *group_info)
> >  {
> > @@ -78,12 +84,12 @@ static inline int in_egroup_p(kgid_t grp)
> >  {
> >          return 1;
> >  }
> > +
> > +static inline int groups_search(const struct group_info *group_info, kgid_t grp)
> > +{
> > +       return 0;
>
> Is this the right fallback value?  If CONFIG_MULTIUSER is disabled,
> wouldn't we always want to indicate a group match?  The in_group_p()
> and in_egroup_p() dummy functions would seem to indicate that is the
> correct behavior ...

Hm, indeed this is a bit tricky and I'm guilty of not noticing this...

The way I see it (now that I though about it a little), there are
basically two possible semantics of groups_search():
1. as an (auxiliary) permissions checking function (like
in_[e]group_p()) -- in this case we would expect the same return value
as in_group_p(), i.e. 1.
2. as a function that simply checks if a group is contained in a list
of groups (taken from a cred struct) -- in this case we would expect
it to return 0 in single-user mode, since there will be always no
supplemental groups set for any task (if I understand it right).

I guess no matter which semantic we pick, we might confuse someone
expecting the other one, so I would suggest dropping this patch (or at
least the fallbacks for groups_search) and explicitly handle the
single-user case in audit.

We should probably default to 1 in audit anyway, because the original
code used in_[e]group_p(). Even though 0 would seem more logical to
me, comparing GIDs doesn't really make sense in single-user mode
anyway, so keeping the legacy behavior will be safer. (In fact now
that I think of it, having audit enabled (or even compiled) in
single-user mode does not make much sense either... maybe we should
just make CONFIG_AUDIT depend on CONFIG_MULTIUSER...).

>
> > +}
> >  #endif
> > -extern int set_current_groups(struct group_info *);
> > -extern void set_groups(struct cred *, struct group_info *);
> > -extern int groups_search(const struct group_info *, kgid_t);
> > -extern bool may_setgroups(void);
> > -extern void groups_sort(struct group_info *);
> >
> >  /*
> >   * The security context of a task
> > --
> > 2.17.1
> >
>
>
> --
> paul moore
> www.paul-moore.com

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
