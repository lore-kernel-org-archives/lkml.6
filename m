Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E4CC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D003826685
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D003826685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932135AbeFZINI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:13:08 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43350 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752411AbeFZINF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:13:05 -0400
Received: by mail-ot0-f194.google.com with SMTP id i19-v6so18072867otk.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 01:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ehUi2NdUBruSWdambVBl+nlgQdEFy/BZPwp4ki45MIU=;
        b=q46PWz/Ab6HbE1CMn4lmoDFTZjKK//AX/VS0QtulkWPTYI4SFDDzElPvY8ASpyjCFz
         NERCgqpoccDSIQPa6s+ZcAAZQbXQs/CoBbluMZa/QqHXCrKAqN7Z7186iNSFnuKA2fsO
         lsy5d5zDpTkCNk2BCYINERjY8GqNmr2r/2QePB3Kih9pZxOdGCO8Cfs+h7BXuG9Xpe6h
         Yo8WC6jsrrgH4uL9WqKRy/mxjQPy3NaS9EFD29GxaVS6b4PD76R89IaPjqMS0h/MhLF8
         QPRVZK52GULowtOlM2BYkXlDwU9lU5I0rsLGd0rb+n7eiN3e7GiOhSyHmlOb9ikXTC55
         etCQ==
X-Gm-Message-State: APt69E0N8ufmANi/ZxX/udQcn+b5hOZokWNZqz7S9JTUYPkF/z5Nm2o9
        ie4voDQgpqPChDMQJDnX0qppPdJXgmuKKsc0HiqH+Q==
X-Google-Smtp-Source: AAOMgpeEvlVFK0veNlKgcHkUfuLmIMalDakF8IcQJY6A7LrujBtCTYdACk3qoCi4ens+Qxr+3V3axkd/IHr7MlE+4Xw=
X-Received: by 2002:a9d:4115:: with SMTP id o21-v6mr225762ote.259.1530000784335;
 Tue, 26 Jun 2018 01:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180625065532.7268-1-omosnace@redhat.com> <CAHC9VhSQwAH1k-cnpQ4iYs-gtHiQRfFvX9aSVW1_-cFEtJ1JCg@mail.gmail.com>
In-Reply-To: <CAHC9VhSQwAH1k-cnpQ4iYs-gtHiQRfFvX9aSVW1_-cFEtJ1JCg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 26 Jun 2018 10:12:58 +0200
Message-ID: <CAFqZXNs5y4AWCnPntGhR_DcrX1d-6h4uPuMKy-WoyCN2Wh1H+A@mail.gmail.com>
Subject: Re: [PATCH -next v2] cred: conditionally declare groups-related functions
To:     Paul Moore <paul@paul-moore.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Eric Paris <eparis@redhat.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-next@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

po 25. 6. 2018 o 23:04 Paul Moore <paul@paul-moore.com> napísal(a):
>
> On Mon, Jun 25, 2018 at 2:56 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
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
> >  include/linux/cred.h | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/cred.h b/include/linux/cred.h
> > index 631286535d0f..7eed6101c791 100644
> > --- a/include/linux/cred.h
> > +++ b/include/linux/cred.h
> > @@ -65,6 +65,12 @@ extern void groups_free(struct group_info *);
> >
> >  extern int in_group_p(kgid_t);
> >  extern int in_egroup_p(kgid_t);
> > +extern int groups_search(const struct group_info *, kgid_t);
> > +
> > +extern int set_current_groups(struct group_info *);
> > +extern void set_groups(struct cred *, struct group_info *);
> > +extern bool may_setgroups(void);
> > +extern void groups_sort(struct group_info *);
> >  #else
> >  static inline void groups_free(struct group_info *group_info)
> >  {
> > @@ -78,12 +84,11 @@ static inline int in_egroup_p(kgid_t grp)
> >  {
> >          return 1;
> >  }
> > +static inline int groups_search(const struct group_info *group_info, kgid_t grp)
> > +{
> > +       return 1;
> > +}
> >  #endif
> > -extern int set_current_groups(struct group_info *);
> > -extern void set_groups(struct cred *, struct group_info *);
> > -extern int groups_search(const struct group_info *, kgid_t);
> > -extern bool may_setgroups(void);
> > -extern void groups_sort(struct group_info *);
>
> I was going through the list of functions to make sure it was safe to
> move all of these under CONFIG_MULTIUSER and I believe there may be an
> issue with key_task_permission() and groups_search(), specifically one
> can disable CONFIG_MULTIUSER yet keep CONFIG_KEYS enabled.

Oh, you're right, CONFIG_KEYS does not depend on CONFIG_MULTIUSER, for
some reason I was looking at CONFIG_SECURITY instead, which does :/ I
will need to update the commit message...

> I'm going to guess that the fix is going to be to have CONFIG_KEYS
> depend on CONFIG_MULTIUSER, but I would talk with the keys folks (I've
> CC'd David Howells) to see what they would prefer.

I was wondering why the security/keys/permissions.c did not give the
link error and it turns out that it is due to the definition of
__kgid_val(), which is hard-coded to 0 if CINFIG_MULTIUSER=n, so the
compiler just optimizes out most of the code in key_task_permission()
(including the groups_search() call). Thus, for permissions.c it does
not matter which fallback we choose (and since this patch always
defines groups_search(), it will not lead to compile errors in
permissions.c either).

TL;DR: There is no need to fix anything in the keys code (beyond this
patch). I also checked the other functions and they are only used in
places that either depend on MULTIUSER or use also groups_alloc(),
which is already declared only when CONFIG_MULTIUSER=y.

>
> --
> paul moore
> www.paul-moore.com

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
