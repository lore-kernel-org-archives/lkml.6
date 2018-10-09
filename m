Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0307ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8C12087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="crxD6DoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8C12087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbeJJAE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:04:59 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41553 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbeJJAE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:04:58 -0400
Received: by mail-ot1-f67.google.com with SMTP id c32so2339392otb.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o1BaTp0M17T5kDBODSTuCLVUFELZt/q2avjOti0PYLY=;
        b=crxD6DoBtPnPEOuJNZPkKla1pwqNuNqXpUmC5B1ClvaF3Zc6kneA2xe2YDNetmXkAG
         o4irsIJ+OuE9FIYqZBRT/1e+wB9/5mNtfvcpNnNSLbOUOW29tl+YvB6fAgyl7XkRITBQ
         v5vUhHAeRpatJjhonLcLlCjJ3e4IBy6yfU2Y7V4S2dyNmeswTJKr6RUAByVf5F7X38HK
         kHnteWGa0c8Ead0C3emXCMouacYfzoxFu5zHRkK4evYyZ2n/7ER+du21Vt5VaHEB/DI7
         xCQAxv3b1kJ+8X3bScXWS1KiLhRt7leU8SihcBoy7n3fTvn5X0Lxcln5USEioF8AjbPp
         8voA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1BaTp0M17T5kDBODSTuCLVUFELZt/q2avjOti0PYLY=;
        b=az9tZXROerl2dNG38ob1V7KTBxI7o9F8NDyTVCrd+gR9LPyKb2UeS3X6sidQz+lN6E
         smB9vFgbzN6A1BoKydwQPf2Rj7Tfr09APhzoVrYOCNT6BCUlHaAvYvoMDwba9GtydX1C
         lUFWOiarEFJ1/Wtwc1DAZ//jQoSL7nUaizcKicyn0s2iILyHaerYbTw7yFXCULXC9X9h
         YWY4t7CKG1DpSDq3qnDRV7nHd8FbvdTWNtmRem0/FumKNTn+Al19NH2nTfJ2lncmVVCc
         dhDuqr9Cgw9Xr119eWt0iRg03NuIIflpwF5luIt2oPMxTkEqmaDu6sonDDlIOEEYhOCn
         CcjQ==
X-Gm-Message-State: ABuFfogsgDohzXJPU3JK0yrVNFaOJhpOlpfD/V41m641bq0trIIFcudn
        nQoK3tprPFdztIi17BrOzoR1C+JdNQfqvbf6PAZYJA==
X-Google-Smtp-Source: ACcGV61WPrl5cZ3k5YCAmh23lcobRYCJiN1lT6kMIeay2i8YlYOF8tW7WfQCVFc18PJHxXW+5V9UOUtL+A6tNYps7qQ=
X-Received: by 2002:a9d:5733:: with SMTP id p48mr16358823oth.292.1539103627631;
 Tue, 09 Oct 2018 09:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181009070230.12884-1-cyphar@cyphar.com> <20181009070230.12884-4-cyphar@cyphar.com>
 <CAG48ez3Ae5b20g2UquekfBNaUw1tLt4nWy2pYm-LNRMbDVpHfA@mail.gmail.com> <20181009153728.2altaqxclntvyc7b@mikami>
In-Reply-To: <20181009153728.2altaqxclntvyc7b@mikami>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 9 Oct 2018 18:46:41 +0200
Message-ID: <CAG48ez0TeT7=SC7rxNC6RA4ALUcqfRrewx9RYtg9PwFkmy044A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] namei: aggressively check for nd->root escape on
 ".." resolution
To:     asarai@suse.de
Cc:     cyphar@cyphar.com, Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>, jlayton@kernel.org,
        Bruce Fields <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>, christian@brauner.io,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>, dev@opencontainers.org,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 5:36 PM Aleksa Sarai <asarai@suse.de> wrote:
> On 2018-10-09, 'Jann Horn' via dev <jannh@google.com> wrote:
> > On Tue, Oct 9, 2018 at 9:03 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
> > > This patch allows for AT_BENEATH and AT_THIS_ROOT to safely permit ".."
> > > resolution (in the case of AT_BENEATH the resolution will still fail if
> > > ".." resolution would resolve a path outside of the root -- while
> > > AT_THIS_ROOT will chroot(2)-style scope it). "proclink" jumps are still
> > > disallowed entirely because now they could result in inconsistent
> > > behaviour if resolution encounters a subsequent "..".
> > >
> > > The need for this patch is explained by observing there is a fairly
> > > easy-to-exploit race condition with chroot(2) (and thus by extension
> > > AT_THIS_ROOT and AT_BENEATH) where a rename(2) of a path can be used to
> > > "skip over" nd->root and thus escape to the filesystem above nd->root.
> > >
> > >   thread1 [attacker]:
> > >     for (;;)
> > >       renameat2(AT_FDCWD, "/a/b/c", AT_FDCWD, "/a/d", RENAME_EXCHANGE);
> > >   thread2 [victim]:
> > >     for (;;)
> > >       openat(dirb, "b/c/../../etc/shadow", O_THISROOT);
> > >
> > > With fairly significant regularity, thread2 will resolve to
> > > "/etc/shadow" rather than "/a/b/etc/shadow". There is also a similar
> > > (though somewhat more privileged) attack using MS_MOVE.
> > >
> > > With this patch, such cases will be detected *during* ".." resolution
> > > (which is the weak point of chroot(2) -- since walking *into* a
> > > subdirectory tautologically cannot result in you walking *outside*
> > > nd->root -- except through a bind-mount or "proclink"). By detecting
> > > this at ".." resolution (rather than checking only at the end of the
> > > entire resolution) we can both correct escapes by jumping back to the
> > > root (in the case of AT_THIS_ROOT), as well as avoid revealing to
> > > attackers the structure of the filesystem outside of the root (through
> > > timing attacks for instance).
> > >
> > > In order to avoid a quadratic lookup with each ".." entry, we only
> > > activate the slow path if a write through &rename_lock or &mount_lock
> > > have occurred during path resolution (&rename_lock and &mount_lock are
> > > re-taken to further optimise the lookup). Since the primary attack being
> > > protected against is MS_MOVE or rename(2), not doing additional checks
> > > unless a mount or rename have occurred avoids making the common case
> > > slow.
> > >
> > > The use of __d_path here might seem suspect, but on further inspection
> > > of the most important race (a path was *inside* the root but is now
> > > *outside*), there appears to be no attack potential. If __d_path occurs
> > > before the rename, then the path will be resolved but since the path was
> > > originally inside the root there is no escape. Subsequent ".." jumps are
> > > guaranteed to check __d_path reachable (by construction, &rename_lock or
> > > &mount_lock must have been taken after __d_path returned),
> >
> > "after"? Don't you mean "before"? Otherwise I don't understand what
> > you're saying here.
>
> I meant that the attacker doing the rename must've taken &rename_lock
> or &mount_lock after __d_path returns in the target process (because the
> race being examined is that the rename occurs *after* __d_path) and thus
> are guaranteed to be detected).
>
> Maybe there's a better way to phrase what I mean...

Aah, I thought you were referring to what the victim process is doing,
not what the racing attacker is doing.
