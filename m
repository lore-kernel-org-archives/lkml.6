Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48FCC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 03:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AFF2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 03:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vQXOF2NS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfABDsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 22:48:13 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36223 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfABDsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 22:48:12 -0500
Received: by mail-ot1-f66.google.com with SMTP id k98so25845875otk.3;
        Tue, 01 Jan 2019 19:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lj+HXFiyeSp2iatCPOHH7H41XOwFdCCB7wpYsZSyrSk=;
        b=vQXOF2NSLBt3fmz0t1SvDuoXwHWRPRFqHHuLG259wBDmX5PX23HCUiLX+i5N9Z73tl
         hp4sKJ2VWrWn/t7JZuYOkqea5Uq3eMbSUigyZG9P4j6XBOS9x498rcgKzgr+HZDA64Js
         i6/Y167qkRyFoqZAJa6RWfHOfnRRm9Mxe2s4+2fmig2wFL5Ih3nuSKzPGcwZd/dHb69S
         tQujXZzmjefBSJ5gvSIYBs2WzuxF8bwt5N3iZeIhHeA5NyZ0JiXONXtWt+W5eEadQRry
         HxTut1+iBYoi43WdsmaD7dasDW7g2Jl51/NffqU88OgUKwSbtrAULd27JvJtieb+4bq6
         asCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lj+HXFiyeSp2iatCPOHH7H41XOwFdCCB7wpYsZSyrSk=;
        b=kjeLwGSYryZgivr9r/Atgl5pg3VAs8Ze0pXXI0KSkClTlR8LW2NsdAEeUTi4vqUEl6
         KwT+qCab9ug2niIH5Yau6UeWLyjwr9J8VqaoFqwSlYGoqVvloLmF/E41R4tkISKUntvW
         Iizw3j0CkhthcfpruFlIwarAvVXQklZ3kx76IGcdalETaJ4+Dbtyt9p2h0YbmpehsZ5O
         0mbFmYr9xjwIyRFnpC5jvN/6dNYAFkOb+Qhqhl63uQzwUnu8EZJBLaWwrO7ucgmAp0DG
         uEXPpcBz8HsUMvYxNv6rRn0iGxBz8+bZVYU0WLLWTRvv4Hj+VVfJ0zY9dFYMAfURolJ2
         qn0g==
X-Gm-Message-State: AJcUukdQOPuZXhLcghAWWp/Q5+N+D7tEMu6PEyTq0etBV5H+9c4wV9IL
        9qvhL9yVkg+yYkX0tFrAus6tDkoOwtAK83Bsi9fujUNcpw==
X-Google-Smtp-Source: ALg8bN5tBDPBa2TwzX3qPSOhMiFWR72MBjM15nqEwUCMf6NgUkxWdAjWH4wkcMvAAVPg7hwCiO61bJD8LTjxom9lWXQ=
X-Received: by 2002:a9d:5c82:: with SMTP id a2mr28237304oti.64.1546400891554;
 Tue, 01 Jan 2019 19:48:11 -0800 (PST)
MIME-Version: 1.0
References: <1546351400-16389-1-git-send-email-junchangwang@gmail.com>
 <1546351400-16389-3-git-send-email-junchangwang@gmail.com> <20190101175510.GW4170@linux.ibm.com>
In-Reply-To: <20190101175510.GW4170@linux.ibm.com>
From:   Junchang Wang <junchangwang@gmail.com>
Date:   Wed, 2 Jan 2019 11:48:00 +0800
Message-ID: <CABoNC82px+072c2eKWcpjMyJX-m8Dh4=L0W6Wxw5Q+HeXoK2Pg@mail.gmail.com>
Subject: Re: [PATCH 2/2] torture.txt: update the list of supported torture types
To:     Paul McKenney <paulmck@linux.ibm.com>
Cc:     dave@stgolabs.net, josh@joshtriplett.org,
        Jonathan Corbet <corbet@lwn.net>, rostedt@goodmis.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 1:54 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>
> On Tue, Jan 01, 2019 at 10:03:20PM +0800, Junchang Wang wrote:
> > Torture types "rcu_bh" and "sched" were removed in commit "c770c82a23".
> > The name of torture type "rcu_busted" was changed to "busted" in commit
> > "b3c983142d". Two other types, "srcud" and "busted_srcud" were added in
> > commits "ca1d51ed98" and "2397d072f7", respectively. This patch updates
> > torture.txt accordingly.
> >
> > Signed-off-by: Junchang Wang <junchangwang@gmail.com>
>
> Given that this section of this file duplicates the rcutorture kernel boot
> parameters called out in Documentation/admin-guide/kernel-parameters.txt,
> perhaps the best way forward is to instead remove this information from
> Documentation/RCU/torture.txt in favor of a reference to the information
> (with search string) in Documentation/admin-guide/kernel-parameters.txt.
>
> Thoughts?

Hi Paul,

Thanks for the comment; indeed the section "MODULE PARAMETERS" in
torture.txt duplicates the corresponding sections in
kernel-parameters.txt. I can resubmit a patch that (1) removes the
section "MODULE PARAMETERS" in torture.txt, and (2) add a single
sentence saying "Module parameters are detailed in
Documentation/admin-guide/kernel-parameters.txt". Does that sound
good?

Thanks,
--Junchang

>
>                                                         Thanx, Paul
>
> > ---
> >  Documentation/RCU/torture.txt | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/RCU/torture.txt b/Documentation/RCU/torture.txt
> > index 55918b5..6395f0b 100644
> > --- a/Documentation/RCU/torture.txt
> > +++ b/Documentation/RCU/torture.txt
> > @@ -155,20 +155,19 @@ torture_type    The type of RCU to test, with string values as follows:
> >                       along with expedited, synchronous, and polling
> >                       variants.
> >
> > -             "rcu_bh": rcu_read_lock_bh(), rcu_read_unlock_bh(), and
> > -                     call_rcu_bh(), along with expedited and synchronous
> > -                     variants.
> > -
> > -             "rcu_busted": This tests an intentionally incorrect version
> > +             "busted": This tests an intentionally incorrect version
> >                       of RCU in order to help test rcutorture itself.
> >
> >               "srcu": srcu_read_lock(), srcu_read_unlock() and
> >                       call_srcu(), along with expedited and
> >                       synchronous variants.
> >
> > -             "sched": preempt_disable(), preempt_enable(), and
> > -                     call_rcu_sched(), along with expedited,
> > -                     synchronous, and polling variants.
> > +             "srcud": A second form of srcu that dynamically allocates
> > +                     and frees srcu_struct to test srcu cleanup code path.
> > +
> > +             "busted_srcud": This torture type verifies rcutorture's ability
> > +                     to detect extensions of RCU read-side critical sections
> > +                     that are not handled.
> >
> >               "tasks": voluntary context switch and call_rcu_tasks(),
> >                       along with expedited and synchronous variants.
> > --
> > 2.7.4
> >
>
