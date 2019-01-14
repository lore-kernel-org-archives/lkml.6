Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B2BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911B3206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uIrsZhku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfANNjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:39:37 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38114 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfANNjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:39:37 -0500
Received: by mail-io1-f66.google.com with SMTP id l14so17574057ioj.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 05:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+T3Ma75OKN0I9Jhu85GvuMPan5gU8uO+XETBD0TYtQ=;
        b=uIrsZhkuOvnMkRgC3DvMsbL0nrH/fK8CaMwtVwvCLH93jVqVECCYTkmtiWtMfqtMNa
         T/XhSpK/dYiMY+IpVpBFli8Nk/9042A77gxyfzHSyzD9VUIaUPQZKuD8jffuv9JxFhQD
         LBxS9UwI62m+LpeapwGruOmnJTld85Fhj6KecJhxU3gL8YgRLxOenC/TGdelWqL8cCy+
         9sx3jis6btHXII3Z8zSGJWvgbPqSkuD5py5cW1UOdZeEjsdo3v9PUmCZHuv0XkhJRWIp
         wkNPD7ZM8OpTX13kdxkrra5TlB/Mnxwjv2Mj9x5Zg4f1UkN8CXFnSkFaLGiRkcIBAgpW
         Dsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+T3Ma75OKN0I9Jhu85GvuMPan5gU8uO+XETBD0TYtQ=;
        b=Mr9du0iyN6PQ+qTI3Qx3AM/418zRHD+pgBd9rKbJi4dHyHVkd5tS9eg/gGuB1qhlYV
         K+v1BHilL4oaT/Y5pQq3i7CDq16JxnLLej7dl39bcdxFu003Pnaaq3MeGVqiJsdVh2Ya
         hGnZyVd6mEpwWkoNvj36kilqf7LjqYUtJcKwqAxreBjhF/1kaGkOKSNWOzrfR2RBnVIY
         9ZNuQosrUOnzRBpMH34xZydTPb7TqtipW+ifc58rn2zq6JliVI+Yuhriv0TeD+trwbxK
         KCsGnMQ95ONyr4lgo5d9Ri0nWN3s+jBKYseHEPfjXID4LOaVgH8DXPBSiN3bwzJ6N1jA
         Qmbg==
X-Gm-Message-State: AJcUukeGmE3TMHpd9PlTr/haVVZQIb8Egj+OOOK/xHs5vRxqriR4KmT6
        RQqXIcCrFZFPGouZch2ZSduBJT9NTNv4t+Zyqt4VEg==
X-Google-Smtp-Source: ALg8bN6dXelJIdQMKH+tPTN1a4IgllGYmcPEyy154m7djrvWl3bi42tlpN9wtQ32+0CUJ5aGpkprmXjE3IvJU/z6l34=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr16123213iom.11.1547473175952;
 Mon, 14 Jan 2019 05:39:35 -0800 (PST)
MIME-Version: 1.0
References: <1547093005-26085-1-git-send-email-longman@redhat.com>
 <CACT4Y+YJYSo5GtSvMSqh4y_w7jWC1S-RYu+exuR3DU9NyrpJqA@mail.gmail.com> <20190114133650.GC10486@hirez.programming.kicks-ass.net>
In-Reply-To: <20190114133650.GC10486@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 14 Jan 2019 14:39:25 +0100
Message-ID: <CACT4Y+bF2D_SpEi_Z5rQ80kqt4fqPdGPa==ggHrCj+NHh2GHMA@mail.gmail.com>
Subject: Re: [PATCH] locking/lockdep: Add debug_locks check in __lock_downgrade()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 2:37 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jan 10, 2019 at 11:21:13AM +0100, Dmitry Vyukov wrote:
> > On Thu, Jan 10, 2019 at 5:04 AM Waiman Long <longman@redhat.com> wrote:
> > >
> > > Tetsuo Handa had reported he saw an incorrect "downgrading a read lock"
> > > warning right after a previous lockdep warning. It is likely that the
> > > previous warning turned off lock debugging causing the lockdep to have
> > > inconsistency states leading to the lock downgrade warning.
> > >
> > > Fix that by add a check for debug_locks at the beginning of
> > > __lock_downgrade().
> > >
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> >
> > Please also add:
> >
> > Reported-by: syzbot+53383ae265fb161ef488@syzkaller.appspotmail.com
> >
> > for tracking purposes. But Tetsuo deserves lots of credit for debugging it.
>
> I made that:
>
> Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Debugged-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Reported-by: syzbot+53383ae265fb161ef488@syzkaller.appspotmail.com
>
> > > index 9593233..e805fe3 100644
> > > --- a/kernel/locking/lockdep.c
> > > +++ b/kernel/locking/lockdep.c
> > > @@ -3535,6 +3535,9 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
> > >         unsigned int depth;
> > >         int i;
> > >
> > > +       if (unlikely(!debug_locks))
> > > +               return 0;
> > > +
> >
> > Are we sure this resolves the problem rather than makes the
> > inconsistency window smaller?
> > I don't understand all surrounding code, but looking just at this
> > function it looks like it may just pepper over the problem. Say, we
> > pass this check when lockdep was still turned on. Then this thread is
> > preempted for some time (e.g. a virtual CPU), then another thread
> > started reporting a warning, turned lockdep off, some information
> > wasn't collected, and this this task resumes and reports a false
> > warning.
>
> Theoretically possible I suppose; but this is analogous to many of the
> other lockdep hooks.
>
> > Or we are holding the mutex here, and the fact that we are holding it
> > ensures that no other task will take it and no information will be
> > lost?
>
> There is no lock here; for performance reasons we prefer not to acquire
> a global spinlock on every lockdep hook, that would be horrific.

I mean the user mutex itself. Some invariants may hold while we are
holding it as Tetsuo noted.
