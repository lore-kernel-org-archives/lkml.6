Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A18C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F55247B1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="WyhmVdoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F55247B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934322AbeFVTTW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:19:22 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35493 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933382AbeFVTTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:19:21 -0400
Received: by mail-lf0-f67.google.com with SMTP id i15-v6so9870692lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 12:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ct7f98itfCBfgqqAIuz74dnVsDNI/ayRdb9VrPnqwZc=;
        b=WyhmVdoSMxbx4++MB6z8QhoNG4iCNk6l8pEWNyEAqiBLxEBG7YObatU6iuWiISYtPV
         p75F/OEJTVRZjMktG4N5dR9iXS2It1/wl1KPFsUCD0c6GC46CjaYdEVAe2naBaRdch59
         OQU+l6G0hhB8iBPDw3UZJedMDdl/lS7sZPJuLPx/1uKyExxOhPDeoMTIPR2sDExcijQI
         ooWo5JBGCD3CPgJLyCQ6FHewbsbJHnTrb4cmLAxAVukEUUi0RTODYsXMf5C6NnswwZEN
         xVJWzIONrT8BxruOQMorMfQeMVf5LqZGl7c8LX8FYQ99SzuTLRZT8uvILy2xUTiGzER0
         /syQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ct7f98itfCBfgqqAIuz74dnVsDNI/ayRdb9VrPnqwZc=;
        b=nh9a9b0szU6D3KZNWysRwsw4CvKCzpjvpU2BbpcBdyq3LIH7tGJFk1O9FCuK1X2c0m
         4mm4E4Db+WYaHcUKWgYdPMEB129Pu+kGsgWBLGz0G61QAYLc7ixYMlfXflLw/BWrTrLR
         iYHtndq5BM/yaOq42akBDRvH8njCL4BqbqC0YuSEFJqIkWYn/sAHdDvJMtY1RPD0zkiV
         bP3OeURkKE7Lay2elXLETaLTxt0p8y0Y6VUWtSuNdSk44Bk1Se8/Y7z9KTSILt75zqhK
         vC/Osl1Xqk63WAZAKIwEi2Sny0in33rgeW/CHbUGb6xZEfaVJxjsm3ETVyIV46Zmrx4W
         ugsw==
X-Gm-Message-State: APt69E1JXmTOy17A2GlSMC3ePZvKjiD8M3mI10UzIePtk9aECUFEX8zN
        P2/e03ZYu53+4ao/qdHjL94td7Nq5qPe63cDQxWI
X-Google-Smtp-Source: ADUXVKLNRfbLxp+kFntPqoNRXZlopv67YnHNXiIpUbcey3KuvjZ4nal6mvvQltCoF98hRF1NstHgcYpV8V70Q+vRjJY=
X-Received: by 2002:a19:23cb:: with SMTP id j194-v6mr74262lfj.90.1529695159371;
 Fri, 22 Jun 2018 12:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQv26uPWSYmhNdhJ4QM+AMKK=JFkMmDftLb1WpvOUyN8Q@mail.gmail.com>
 <20180621083316.8765-1-omosnace@redhat.com> <CAHC9VhQk42UA5c_XAaG20h3TZt20TQyJxDMfqWHHgu2=8+kcVQ@mail.gmail.com>
 <CAFqZXNs_cKtTZKGkhL4KwTweKEMdVwgS0RAQS_Soqw1c1HSNyw@mail.gmail.com>
In-Reply-To: <CAFqZXNs_cKtTZKGkhL4KwTweKEMdVwgS0RAQS_Soqw1c1HSNyw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Jun 2018 15:19:08 -0400
Message-ID: <CAHC9VhTO7QQt-ZduEZj2y54zbYefCQiZwEpmXaM82_5MqjYoOA@mail.gmail.com>
Subject: Re: [PATCH -next] cred: conditionally declare groups-related functions
To:     omosnace@redhat.com
Cc:     akpm@linux-foundation.org, rdunlap@infradead.org,
        sfr@canb.auug.org.au, Eric Paris <eparis@redhat.com>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 3:47 AM Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
> =C5=A1t 21. 6. 2018 o 23:17 Paul Moore <paul@paul-moore.com> nap=C3=ADsal=
(a):
> > On Thu, Jun 21, 2018 at 4:33 AM Ondrej Mosnacek <omosnace@redhat.com> w=
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
> > >  include/linux/cred.h | 16 +++++++++++-----
> > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/linux/cred.h b/include/linux/cred.h
> > > index 631286535d0f..8917768453cc 100644
> > > --- a/include/linux/cred.h
> > > +++ b/include/linux/cred.h
> > > @@ -65,6 +65,12 @@ extern void groups_free(struct group_info *);
> > >
> > >  extern int in_group_p(kgid_t);
> > >  extern int in_egroup_p(kgid_t);
> > > +
> > > +extern int set_current_groups(struct group_info *);
> > > +extern void set_groups(struct cred *, struct group_info *);
> > > +extern int groups_search(const struct group_info *, kgid_t);
> > > +extern bool may_setgroups(void);
> > > +extern void groups_sort(struct group_info *);
> > >  #else
> > >  static inline void groups_free(struct group_info *group_info)
> > >  {
> > > @@ -78,12 +84,12 @@ static inline int in_egroup_p(kgid_t grp)
> > >  {
> > >          return 1;
> > >  }
> > > +
> > > +static inline int groups_search(const struct group_info *group_info,=
 kgid_t grp)
> > > +{
> > > +       return 0;
> >
> > Is this the right fallback value?  If CONFIG_MULTIUSER is disabled,
> > wouldn't we always want to indicate a group match?  The in_group_p()
> > and in_egroup_p() dummy functions would seem to indicate that is the
> > correct behavior ...
>
> Hm, indeed this is a bit tricky and I'm guilty of not noticing this...
>
> The way I see it (now that I though about it a little), there are
> basically two possible semantics of groups_search():
> 1. as an (auxiliary) permissions checking function (like
> in_[e]group_p()) -- in this case we would expect the same return value
> as in_group_p(), i.e. 1.
> 2. as a function that simply checks if a group is contained in a list
> of groups (taken from a cred struct) -- in this case we would expect
> it to return 0 in single-user mode, since there will be always no
> supplemental groups set for any task (if I understand it right).
>
> I guess no matter which semantic we pick, we might confuse someone
> expecting the other one, so I would suggest dropping this patch (or at
> least the fallbacks for groups_search) and explicitly handle the
> single-user case in audit.
>
> We should probably default to 1 in audit anyway, because the original
> code used in_[e]group_p(). Even though 0 would seem more logical to
> me, comparing GIDs doesn't really make sense in single-user mode
> anyway, so keeping the legacy behavior will be safer. (In fact now
> that I think of it, having audit enabled (or even compiled) in
> single-user mode does not make much sense either... maybe we should
> just make CONFIG_AUDIT depend on CONFIG_MULTIUSER...).

If CONFIG_MULTIUSER is unset then basically everything runs as
root:root, there is no user separation anymore.  With that in mind it
seems the proper behavior is to always return 1 when groups_search()
is called.

Please make the adjustment and resubmit your patch.

--=20
paul moore
www.paul-moore.com
