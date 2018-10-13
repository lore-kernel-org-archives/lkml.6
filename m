Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A19CC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 23:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9A42077C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 23:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="1Wk7jHJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9A42077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbeJNGnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 02:43:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37169 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbeJNGnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 02:43:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id y11-v6so17079044wrd.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 16:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zDU55Z7GEv2DLZuPO5DfQC2EZl5hyoZHqjCYlXCgYWg=;
        b=1Wk7jHJ0WYlvj6/zxx/Rix+ts/UbwS7BmyfmUQjOAETj3dGlbpqBehyRqlC5GGUHBt
         bpfpXjApY1Ba0WsKptGvu++1C0Vsix0o2Z2nUmBcDSOgcm5pgYe4tryVvckbqqZcwwh+
         ZIpWSS+LFvJ6fxGVamZIR8IjhlAZJqlTb2DuSouAWggmYPC6ghShTk1aqjCYM2C+T2y4
         NP6AWedmUNtk8b3OCZQl0nNfcrTIW536CNeYLOoSlWGCVX8Ef2rLp8FWTVmXqMbBy8BH
         2BBIa4B5/pskuKsAC/9LtMrVRzKiEEwytfRhCJ97b9jAgBfc0wAxngxL6DZf6K+OUR/I
         3Xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDU55Z7GEv2DLZuPO5DfQC2EZl5hyoZHqjCYlXCgYWg=;
        b=PfHM1RVDmfQWybFvCNKSxFkYiOUSNqAI+0O1YiI3bsCLaxixXTzFu5Zq9NjNDmlon+
         x81hfFo3rNYF0upLih637GzvP4vzysp7+d4+8gpto426CK5AANcK6mTI6DTD2qas0gnF
         c0WaMAXa/lPwDlR4cNbjx6i48f4CEWb0EMdwjSiC526j/lo+qW8gFVcOxC916G02m/95
         HOhM4Rn0liHXjXjNok2gVlfQqWNWHTNpQvWJygJk8Gp7SqvWr9uLzqWcbzcETmb+U3Ww
         KluqXfGO5U+gse5UAgiLhPjV7FPBGoHAywAPdmpKUWue2eiDm9r4ggvVpw+sMkYeXKiV
         s/lw==
X-Gm-Message-State: ABuFfoiEhLxE0pVQ++O0fQhHq5d6WoQ8aa1rEFp0BDD1xgD1hMrs1NcY
        z72ZHi0EzqulK23ev2m0GHTj8bFAVnkZkTBI6/fx8A==
X-Google-Smtp-Source: ACcGV62/WboaGWYZ75js5qFvOb9kIBby8f2zwCDUtOT0UF80cpxfQznhlEOKJbqs4nei1xKwZ/Pz2zS04WakpNQbTCY=
X-Received: by 2002:adf:b188:: with SMTP id q8-v6mr9665317wra.95.1539471861516;
 Sat, 13 Oct 2018 16:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754766004.17872.9829232103614083565.stgit@warthog.procyon.org.uk>
 <9b8bf436-65de-13b9-0002-0479d11c18ca@gmail.com> <20181013061141.GR32577@ZenIV.linux.org.uk>
 <68a2107f-bf70-055b-86cf-1ba2ba9422bf@gmail.com>
In-Reply-To: <68a2107f-bf70-055b-86cf-1ba2ba9422bf@gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Sat, 13 Oct 2018 16:04:09 -0700
Message-ID: <CALCETrWvEJHGWNXvOBcaFbX16pyBEqmNk4V+dBxX00OAS4OMng@mail.gmail.com>
Subject: Re: [PATCH 31/34] vfs: syscall: Add fspick() to select a superblock
 for reconfiguration [ver #12]
To:     alan.christopher.jenkins@gmail.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 2:45 AM Alan Jenkins
<alan.christopher.jenkins@gmail.com> wrote:
>
> On 13/10/2018 07:11, Al Viro wrote:
> > On Fri, Oct 12, 2018 at 03:49:50PM +0100, Alan Jenkins wrote:
> >>> +SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags)
> >>> +{
> >>> +   struct fs_context *fc;
> >>> +   struct path target;
> >>> +   unsigned int lookup_flags;
> >>> +   int ret;
> >>> +
> >>> +   if (!ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN))
> >>> +           return -EPERM;
> >>
> >> This seems to accept basically any mount.  Specifically: are you sure it's
> >> OK to return a handle to a SB_NO_USER superblock?
> > Umm...  As long as we don't try to do pathname resolution from its ->s_root,
> > shouldn't be a problem and I don't see anything that would do that.  I might've
> > missed something, but...
>
> Sorry, I guess SB_NOUSER was the wrong word.  I was trying find if
> anything stopped things like
>
> int memfd = memfd_create("foo", 0);
> int fsfd = fspick(memfd, "", FSPICK_EMPTY_PATH);
>
> fsconfig(fsfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
> fsconfig(fsfd, FSCONFIG_SET_STRING, "size", "100M", 0);
> fsconfig(fsfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);
>
> So far I'm getting -EBUSY if I try to apply the "ro", -EINVAL if I try
> to apply the "size=100M".  But if I don't apply either, then
> FSCONFIG_CMD_RECONFIGURE succeeds.
>
> It seems worrying that it might let me set options on shm_mnt. Or at
> least letting me get as far as the -EBUSY check for the "ro" superblock
> flag.
>
> I'm not sure why I'm getting the -EINVAL setting the "size" option.  But
> it would be much more reassuring if I was getting -EPERM :-).
>

I would argue that the filesystem associated with a memfd, and even
the fact that there *is* a filesystem, is none of user code's
business.  So that fspick() call should return -EINVAL or similar.
