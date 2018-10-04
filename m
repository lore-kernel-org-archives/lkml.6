Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1F4C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14C2213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BzP2W5kf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14C2213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeJEBVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:21:16 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36045 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeJEBVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:21:15 -0400
Received: by mail-ot1-f68.google.com with SMTP id c18-v6so10182471otm.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IwrixsSDq41OQMOHGvtswGHKDpXaAnLPe7qKHutg+OA=;
        b=BzP2W5kfotBEkyRYzqTWKjqHV78B2YVqlC15zAUecdOIpSXGZtjgEHqqqMbgo9G4U+
         b2nCqeMz2ra0hM/SwZs6CFNikhRqyUKeUnoVVSitkE6bsHPAUUrqIjoPdsVKigQJmx0f
         yrQh/156+Ygt3X6A4WBUARbXbr9rwekDx380SPODeCfrNqwYYd520tADP3wvxL52hQqP
         YdF3HWSNheQkQC8KNCaTKs7xDWWtpXJs2F+lBgsgctJaNoKXhtBN6/d8vyJx2SbqHQHQ
         wsp7515VvrNRTrOvVNDjDzp4EfURunjNeR/e/5Lm7sj98c+yonsr2WL5tMWBb1hAUEc5
         /baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IwrixsSDq41OQMOHGvtswGHKDpXaAnLPe7qKHutg+OA=;
        b=WYqSXgpmAVAuz+m5riLQbllhqAVPki3iZpWJCS2bKX542qd4+eebQ41pR/bQpi/PaO
         ZpIYjpXIpmhIRkwXU8/fVEik0Rw4K9j9yoK4HHZwpmoih0ToEmuQ0x7UNiKHDN4tCufe
         uLfT0M6yQa+23SLpR/ADtz6UX7Q8nQ071kNBCm0PFs2IN5ubL1sfWtp7+MePntd9/w+0
         WgWi+ZWFTcf2Exn1KonjfcZkg0No8KVRm6PDugYqhk+Y66JhwB7ciMyPzz1eT1OSvFeZ
         YsbbolsnUyBSIuk67dQUtSelJEQl4Yz3BfnHP4Y7loo4uwnfpg6q85rXBzJD+8/LcVMV
         3eDg==
X-Gm-Message-State: ABuFfoitW936SQwyvg2oIkSzSyMN30ynRK7s2cq1i7UCXi6wDnF6L1Zt
        EPv2bfYFhz8DY5PFK7vLLNN4hhcI1GgVpNO9iWHu3A==
X-Google-Smtp-Source: ACcGV60k6vFHpgXXGEXPhKki+EIrYMAHULPY95Es9sgPNtEdJHnPXoZM1aG5kKKhIjbCnNi2VLH2sdSQZRI3pNv5g7o=
X-Received: by 2002:a9d:2a38:: with SMTP id t53-v6mr4572776ota.35.1538677606820;
 Thu, 04 Oct 2018 11:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180929103453.12025-1-cyphar@cyphar.com> <20180929131534.24472-1-cyphar@cyphar.com>
 <CAG48ez30WJhbsro2HOc_DR7V91M+hNFzBP5ogRMZaxbAORvqzg@mail.gmail.com> <20181004162611.vdlujbdguvagalpt@ryuk>
In-Reply-To: <20181004162611.vdlujbdguvagalpt@ryuk>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 4 Oct 2018 20:26:20 +0200
Message-ID: <CAG48ez2u--Wac7d9n3idC92Pd-M40QzYtR6FKR8PAYr=VQHUBQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] namei: implement AT_THIS_ROOT chroot-like path resolution
To:     cyphar@cyphar.com
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>, jlayton@kernel.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, shuah@kernel.org,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, christian@brauner.io,
        Tycho Andersen <tycho@tycho.ws>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 6:26 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2018-09-29, Jann Horn <jannh@google.com> wrote:
> > You attempt to open "C/../../etc/passwd" under the root "/A/B".
> > Something else concurrently moves /A/B/C to /A/C. This can result in
> > the following:
> >
> > 1. You start the path walk and reach /A/B/C.
> > 2. The other process moves /A/B/C to /A/C. Your path walk is now at /A/C.
> > 3. Your path walk follows the first ".." up into /A. This is outside
> > the process root, but you never actually encountered the process root,
> > so you don't notice.
> > 4. Your path walk follows the second ".." up to /. Again, this is
> > outside the process root, but you don't notice.
> > 5. Your path walk walks down to /etc/passwd, and the open completes
> > successfully. You now have an fd pointing outside your chroot.
>
> I've been playing with this and I have the following patch, which
> according to my testing protects against attacks where ".." skips over
> nd->root. It abuses __d_path to figure out if nd->path can be resolved
> from nd->root (obviously a proper version of this patch would refactor
> __d_path so it could be used like this -- and would not return
> -EMULTIHOP).
>
> I've also attached my reproducer. With it, I was seeing fairly constant
> breakouts before this patch and after it I didn't see a single breakout
> after running it overnight. Obviously this is not conclusive, but I'm
> hoping that it can show what my idea for protecting against ".." was.
>
> Does this patch make sense? Or is there something wrong with it that I'm
> not seeing?
>
> --8<-------------------------------------------------------------------
>
> There is a fairly easy-to-exploit race condition with chroot(2) (and
> thus by extension AT_THIS_ROOT and AT_BENEATH) where a rename(2) of a
> path can be used to "skip over" nd->root and thus escape to the
> filesystem above nd->root.
>
>   thread1 [attacker]:
>     for (;;)
>       renameat2(AT_FDCWD, "/a/b/c", AT_FDCWD, "/a/d", RENAME_EXCHANGE);
>   thread2 [victim]:
>     for (;;)
>       openat(dirb, "b/c/../../etc/shadow", O_THISROOT);
>
> With fairly significant regularity, thread2 will resolve to
> "/etc/shadow" rather than "/a/b/etc/shadow". With this patch, such cases
> will be detected during ".." resolution (which is the weak point of
> chroot(2) -- since walking *into* a subdirectory tautologically cannot
> result in you walking *outside* nd->root).
>
> The use of __d_path here might seem suspect, however we don't mind if a
> path is moved from within the chroot to outside the chroot and we
> incorrectly decide it is safe (because at that point we are still within
> the set of files which were accessible at the beginning of resolution).
> However, we can fail resolution on the next path component if it remains
> outside of the root. A path which has always been outside nd->root
> during resolution will never be resolveable from nd->root and thus will
> always be blocked.
>
> DO NOT MERGE: Currently this code returns -EMULTIHOP in this case,
>               purely as a debugging measure (so that you can see that
>               the protection actually does something). Obviously in the
>               proper patch this will return -EXDEV.
>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  fs/namei.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 6f995e6de6b1..c8349693d47b 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -53,8 +53,8 @@
>   * The new code replaces the old recursive symlink resolution with
>   * an iterative one (in case of non-nested symlink chains).  It does
>   * this with calls to <fs>_follow_link().
> - * As a side effect, dir_namei(), _namei() and follow_link() are now
> - * replaced with a single function lookup_dentry() that can handle all
> + * As a side effect, dir_namei(), _namei() and follow_link() are now
> + * replaced with a single function lookup_dentry() that can handle all
>   * the special cases of the former code.
>   *
>   * With the new dcache, the pathname is stored at each inode, at least as
> @@ -1375,6 +1375,20 @@ static int follow_dotdot_rcu(struct nameidata *nd)
>                                 return -EXDEV;
>                         break;
>                 }
> +               if (unlikely(nd->flags & (LOOKUP_BENEATH | LOOKUP_CHROOT))) {
> +                       char *pathbuf, *pathptr;
> +
> +                       pathbuf = kmalloc(PATH_MAX, GFP_ATOMIC);
> +                       if (!pathbuf)
> +                               return -ECHILD;
> +                       pathptr = __d_path(&nd->path, &nd->root, pathbuf, PATH_MAX);
> +                       kfree(pathbuf);
> +                       if (IS_ERR_OR_NULL(pathptr)) {
> +                               if (!pathptr)
> +                                       pathptr = ERR_PTR(-EMULTIHOP);
> +                               return PTR_ERR(pathptr);
> +                       }
> +               }

One somewhat problematic thing about this approach is that if someone
tries to lookup
"a/a/a/a/a/a/a/a/a/a/[...]/../../../../../../../../../.." for some
reason, you'll have quadratic runtime: For each "..", you'll have to
walk up to the root.
