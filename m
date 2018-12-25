Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9E1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 07:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1EA32173B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 07:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdj629Vb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbeLYHLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 02:11:18 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53473 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbeLYHLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 02:11:18 -0500
Received: by mail-it1-f194.google.com with SMTP id g85so17774480ita.3;
        Mon, 24 Dec 2018 23:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=29HFdbwKJBK4EvPrtEg9nBilc/E/bzi4iPIpXsw/yhk=;
        b=hdj629VblY39X9PuGUXyc63kcRJN/Oh8V9QzVlgvqH87urtQufWB4+CjlWk2nkT+1i
         m2SDb/hs+yu5jJFxXj/OCHtkiRUN4EkzHE2bC93v+19eYvwcfNw81AO8UmXW3psd/y76
         gX326J/yTcoZUw+1SiSeETJ4a22+64UsqWHULpiAJ58MjYTwe/jamA1ICjQ6PAStBcU5
         W4QY2iJ3VJKth8LerIfjUnrvV/DAskL9kT4+wK+4/HbLK95p2TKflVRKR0wkRKXXEiRK
         acjJgU5oG2NIEE79tg0vZWASr1IlXM9rVi7kLgKQaU9sfre6fCkOCIcnvWKZm7f46PWw
         ZnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=29HFdbwKJBK4EvPrtEg9nBilc/E/bzi4iPIpXsw/yhk=;
        b=eiUR0CRUqSYdZeFGlUowV8SLQUXNS9u/IHWUUmsJ8KkjR68Ee09DLgq1gl4RMUKuJ/
         6iwMUb3jexVZ25Ys+FDArx6lJPK0loWu7TLSaaU1tFbtnzzqtxY9jE7giRB2lYJEG+NS
         FmlVR/YNTq/zpgOkWp8FBi5k00ERoOQp/Ns3Fl/DrIBu4syXm1LO0wRK7QgrFVCTS+6y
         3+mfXeq1CNWDbZFXMrOzpfF/de5bY180dQ2Kv2Mx9xSyAwd+vYL3jYnO0O3pEOuQctix
         JG66Y34MFmjFJUqT4RYArapvfz+Ajno3Jdeuw8G6U4YLC4kgMDh+x3Q123KvKGxrqSqP
         Wj6w==
X-Gm-Message-State: AA+aEWYRbbt9mKK5qep5PEubh5doDpG0dyyqNovx61gZLLODiiSyvzD3
        aGQiZixi2g1Cm/wKlew9RiXO4KUwGTMLmTWg+Qc=
X-Google-Smtp-Source: AFSGD/U4h6TeBRsXLd+fMQobCixJ7pNdA4w6dDZ4nncRvEBh5cDaUTIz1htcT6sOlBwkfocGv8XY1GCgCc0AL7gIJmc=
X-Received: by 2002:a02:6915:: with SMTP id e21mr10421243jac.142.1545721876652;
 Mon, 24 Dec 2018 23:11:16 -0800 (PST)
MIME-Version: 1.0
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com>
 <746B7C49-CC7B-4040-A7EF-82491796D360@brauner.io> <20181202100304.labt63mzrlr5utdl@brauner.io>
 <8736rebl9s.fsf@oldenburg.str.redhat.com> <20181203180224.fkvw4kajtbvru2ku@brauner.io>
 <874lbtjvtd.fsf@oldenburg2.str.redhat.com> <CALCETrViXJ0gD34yVd8QpB-CSeKZzzncvkPHReycTiQin4r4WQ@mail.gmail.com>
 <87y392h4b7.fsf@oldenburg2.str.redhat.com> <C5E71146-DE79-4145-B54B-E161E7372D95@brauner.io>
 <CAJhGHyC=Zc=iG+iL+Ny8GsMd-5xypxdk4Et_1ZViMao5aXreCw@mail.gmail.com>
In-Reply-To: <CAJhGHyC=Zc=iG+iL+Ny8GsMd-5xypxdk4Et_1ZViMao5aXreCw@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Tue, 25 Dec 2018 15:11:05 +0800
Message-ID: <CAJhGHyAHKm0q4FtHBgbbfaB3g4oix76vJWgjqLYoaHvKCD3gvA@mail.gmail.com>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
To:     Christian Brauner <christian@brauner.io>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 25, 2018 at 1:32 PM Lai Jiangshan
<jiangshanlai+lkml@gmail.com> wrote:
>
> Is it possible to avoid adding any syscall?
>
> Since holding /proc/pid/reg_file can also hold the pid.
> With this guarantee, /proc/pid/uuid (universally unique identifier ) can be
> introduced to identify tasks, the kernel generates
> a uuid for every task when created.
>
> save_pid_uuid_pair_for_later_kill(int pid) {
>   /* save via /proc/$pid/uuid */
>   /* don't need to keep any fd after save */
> }
>
> safe_kill(pid, uuid, sig) {
>     fd = open(/proc/$pid/uuid); /* also hold the pid until close() if
> open() successes */
>     if (open successes and read uuid from fd and if it equals to uuid)
>         kill(pid, sig)
>     close(fd)
> }
>
> All things needed to be done is to implement /proc/pid/uuid. And if pid can't
> be recycled within 1 ticket, or the user can ensure it. The user can use
> starttime(in /proc/pid/stat) instead.
>
> save_pid_starttime_pair_for_later_kill(int pid) {
>   /* save via /proc/$pid/stat */
>   /* don't need to keep any fd after save or keep it for 1 ticket at most */
> }
>
> safe_kill(pid, starttime, sig) {
>     fd = open(/proc/$pid/stat); /* also hold the pid until close() if
> open() successes */
>     if (open successes and read starttime from fd and if it equals to starttime)
>         kill(pid, sig)
>     close(fd)
> }
>
> In this case, zero LOC is added in the kernel. All of it depends on
> the guarantee that holding /proc/pid/reg_file also holds the pid,
> one of which I haven't checked carefully either.
>

Oh, Sorry, I was wrong, the pid isn't reserved even when
the fd is kept in the user space. And I'm sorry that I had
replied to an "old" email thread.
