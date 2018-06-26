Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF9DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A8326B4D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="H8Ye2KpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A8326B4D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965479AbeFZN1H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:27:07 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36431 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965292AbeFZN1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:27:05 -0400
Received: by mail-lf0-f68.google.com with SMTP id n24-v6so17417199lfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 06:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=14TNfjeUGQSGmMDSZTGsEEulAbauFe+EkHOlZxlcooo=;
        b=H8Ye2KpJLAZsB/JxC3ufE4yvOnYbNLrATp4tYOV1rbSUtK62TuRcf4L6S4Z6YLCWIO
         mY+BGjjGQ0chThqqh+A2c1hec/tr8Oiqdf3ugGRTrNlpHZy4PnRoNPCW1QlV+DfsYdKk
         gFwjhA2dB0vFQUKp7k5HqCXCdO98zmZD6PMoY39ZTbZ1lvrrWqUkfRKmm5R+zZ/wriGL
         tSAU4xlJofz3cVevrNavEpgzM5Qp0dU4KvYeI/iJtIb6ZPQ2KHNsuLtnyrsIQ+SY45J7
         FyxUR9JJ6CMy9Nr1/q+8B/uJNT/gHs41EnZqKXaAyFl7TJv6gH3D339yHmId52zhXNSH
         5MCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=14TNfjeUGQSGmMDSZTGsEEulAbauFe+EkHOlZxlcooo=;
        b=sU4TSYQP2lyraCQDCHvU88ItPmyGymktKHLkTnDcpZDMUMon+fo35ST5ke525m9+ui
         g+mvQ0A8u7T/+5/45QoaoI/22GZC8omJY+8iwFHr3Mt0QaJkS0PmUqeOGtL/LbwRuZOQ
         92OLnDLXgrjd+ghTNjToo1mW1RZVbdsaNsER2mcknHQSnbYhUM8um295VO4cA3MohmEs
         eJZk2QZ59WP7LkQ3OcAUXOuCTgWGUivBoVzFlfjcYw4vf/SxQX7sbo5siEIoFn0Tx5/w
         I4Ipett9mJ6kM32QIvqU3EKWwL+rmCmesb2bOPfXayKqmJQUkCggNJDSimIot4cYGseF
         bS2g==
X-Gm-Message-State: APt69E0pKcwqJ6aawVENjEuUA2rt7Yx7FCS0F6Mb0QAXqNMca2LKTzpJ
        HLmpHT5vCwU1DwYTyhdg5mvB5mD0ejDiTV8ImKwD
X-Google-Smtp-Source: AAOMgpcUIU33UJHb4mk6q8+e5iuNUwl9Mpupb3zfimViMj6Feb340zaQwVotC/+S+XnIA1YK6Gi9NfhzZ7oJKiOsQvs=
X-Received: by 2002:a19:a892:: with SMTP id r140-v6mr1295132lfe.39.1530019623746;
 Tue, 26 Jun 2018 06:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180625065532.7268-1-omosnace@redhat.com> <CAHC9VhSQwAH1k-cnpQ4iYs-gtHiQRfFvX9aSVW1_-cFEtJ1JCg@mail.gmail.com>
 <CAFqZXNs5y4AWCnPntGhR_DcrX1d-6h4uPuMKy-WoyCN2Wh1H+A@mail.gmail.com>
In-Reply-To: <CAFqZXNs5y4AWCnPntGhR_DcrX1d-6h4uPuMKy-WoyCN2Wh1H+A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 Jun 2018 09:26:52 -0400
Message-ID: <CAHC9VhR=y0bk7mK=QMM_kNNDXk8yMdVHWJCZtbhxvaOTse2v0g@mail.gmail.com>
Subject: Re: [PATCH -next v2] cred: conditionally declare groups-related functions
To:     omosnace@redhat.com
Cc:     akpm@linux-foundation.org, rdunlap@infradead.org,
        sfr@canb.auug.org.au, Eric Paris <eparis@redhat.com>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-audit@redhat.com, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 4:13 AM Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
> po 25. 6. 2018 o 23:04 Paul Moore <paul@paul-moore.com> nap=C3=ADsal(a):
> > On Mon, Jun 25, 2018 at 2:56 AM Ondrej Mosnacek <omosnace@redhat.com> w=
rote:
> > > The groups-related functions declared in include/linux/cred.h are
> > > defined in kernel/groups.c, which is compiled only when
> > > CONFIG_MULTIUSER=3Dy. Move all these function declarations under #ifd=
ef
> > > CONFIG_MULTIUSER to help avoid accidental usage in contexts where
> > > CONFIG_MULTIUSER might be disabled.
> > >
> > > This patch also adds a fallback for groups_search(). Currently this
> > > function is only called from kernel/groups.c itself and
> > > keys/permissions.c, which depends on CONFIG_MULTIUSER. However, the
> > > audit subsystem (which does not depend on CONFIG_MULTIUSER) calls thi=
s
> > > function in -next, so the fallback will be needed to avoid compilatio=
n
> > > errors or ugly workarounds.
> > >
> > > See also:
> > > https://lkml.org/lkml/2018/6/20/670
> > > https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git/com=
mit/?h=3Dnext&id=3Daf85d1772e31fed34165a1b3decef340cf4080c0
> > >
> > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  include/linux/cred.h | 15 ++++++++++-----
> > >  1 file changed, 10 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/linux/cred.h b/include/linux/cred.h
> > > index 631286535d0f..7eed6101c791 100644
> > > --- a/include/linux/cred.h
> > > +++ b/include/linux/cred.h
> > > @@ -65,6 +65,12 @@ extern void groups_free(struct group_info *);
> > >
> > >  extern int in_group_p(kgid_t);
> > >  extern int in_egroup_p(kgid_t);
> > > +extern int groups_search(const struct group_info *, kgid_t);
> > > +
> > > +extern int set_current_groups(struct group_info *);
> > > +extern void set_groups(struct cred *, struct group_info *);
> > > +extern bool may_setgroups(void);
> > > +extern void groups_sort(struct group_info *);
> > >  #else
> > >  static inline void groups_free(struct group_info *group_info)
> > >  {
> > > @@ -78,12 +84,11 @@ static inline int in_egroup_p(kgid_t grp)
> > >  {
> > >          return 1;
> > >  }
> > > +static inline int groups_search(const struct group_info *group_info,=
 kgid_t grp)
> > > +{
> > > +       return 1;
> > > +}
> > >  #endif
> > > -extern int set_current_groups(struct group_info *);
> > > -extern void set_groups(struct cred *, struct group_info *);
> > > -extern int groups_search(const struct group_info *, kgid_t);
> > > -extern bool may_setgroups(void);
> > > -extern void groups_sort(struct group_info *);
> >
> > I was going through the list of functions to make sure it was safe to
> > move all of these under CONFIG_MULTIUSER and I believe there may be an
> > issue with key_task_permission() and groups_search(), specifically one
> > can disable CONFIG_MULTIUSER yet keep CONFIG_KEYS enabled.
>
> Oh, you're right, CONFIG_KEYS does not depend on CONFIG_MULTIUSER, for
> some reason I was looking at CONFIG_SECURITY instead, which does :/ I
> will need to update the commit message...
>
> > I'm going to guess that the fix is going to be to have CONFIG_KEYS
> > depend on CONFIG_MULTIUSER, but I would talk with the keys folks (I've
> > CC'd David Howells) to see what they would prefer.
>
> I was wondering why the security/keys/permissions.c did not give the
> link error and it turns out that it is due to the definition of
> __kgid_val(), which is hard-coded to 0 if CINFIG_MULTIUSER=3Dn, so the
> compiler just optimizes out most of the code in key_task_permission()
> (including the groups_search() call). Thus, for permissions.c it does
> not matter which fallback we choose (and since this patch always
> defines groups_search(), it will not lead to compile errors in
> permissions.c either).
>
> TL;DR: There is no need to fix anything in the keys code (beyond this
> patch). I also checked the other functions and they are only used in
> places that either depend on MULTIUSER or use also groups_alloc(),
> which is already declared only when CONFIG_MULTIUSER=3Dy.

... and you've already defined a dummy implementation of
groups_search(); that's the important part.  I clearly was in a rush
while reviewing this patch.

/me shakes his head

--=20
paul moore
www.paul-moore.com
