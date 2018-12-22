Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65032C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258E02146E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsTYKQ7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389540AbeLVRFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:05:49 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42477 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbeLVRFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:05:49 -0500
Received: by mail-io1-f65.google.com with SMTP id x6so6186520ioa.9;
        Sat, 22 Dec 2018 09:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sqyo8BjuhEUHh01zmRwRq83DpP1VEMnV2KGReOoWGt4=;
        b=IsTYKQ7caJdRl2/UPJ9gFRZqCXRE7Jn5umJQdD++3uSDy9yUxLTmnA8mv6+KwQVJFC
         kHK4188qRY//BugMlaF4FGj+VnR3d0lEjoBy3LppBsnWVg0wlIyesyrlGAA7IReAQEgO
         G7ZWqB1AHriHINubdexf3y3DCF1gJMhh0fHY0OqfawAUw96UlTuVhBrH9HV7uDG8uyxH
         MU3aP+QB58Mdzib3TflMeB9hZ0dCdF8+/6rLuw/ohloE6zIvXHxZfyIJyAxLxI+ml2uR
         V5qTAK1beIYinQkzhxqeVq0oaxiRTniK08dppH8b/+TLmNfd4LrDOc4Zy+TXq/z6k6LI
         8bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sqyo8BjuhEUHh01zmRwRq83DpP1VEMnV2KGReOoWGt4=;
        b=cAyg37gT0bcZ8BsA0n8y43RHV+iZ0mecBmkx4C5bI3yCcRUaNfPExu1mATjdsRozv7
         DysvKLOLOfrTtx9H9+6iOCWCJ5g75asxceinIEexVAWXhAK5Slz9Prc5sKMxMi3fr6Zl
         9en7YkjSGFFUoKr3Q7+hFe4vPTCMnfrZUBWL2YeMLUqCo5AUVnUDMVk4N3JRhirrBKXH
         TArE2Ql5ZFGdlwsUEzCAEgOE62JOiDi78XBzVTba3b65VvsjVejpreX4plVlpSuWfiOO
         A1vD0yddu92GB0fwLLtOj3AMLe8N004Yo3JNmMOZ890UYCT2sZyqetvS6w6XJ6OObwhV
         kkaA==
X-Gm-Message-State: AJcUukfUliOvDRaMOzmf2NiPux/ngK9bqnyydhkSYIuVGcIoLGHlNnGR
        gUeN65rutgwJpqQmKORx3ZjBZ6QgEPdM+h73VYpeMDX7
X-Google-Smtp-Source: ALg8bN435NDuhHTusN4DCbs3hVYtKrxd+OW+azlIYYcaRBZzG5StJP0PYXMiBtilVxGQ2XU3I6CAbbKUQ/6TVHHlzGQ=
X-Received: by 2002:a6b:b706:: with SMTP id h6mr4312225iof.295.1545491622797;
 Sat, 22 Dec 2018 07:13:42 -0800 (PST)
MIME-Version: 1.0
References: <1545444741-31694-1-git-send-email-laoar.shao@gmail.com> <20181222031747.GA2217@ZenIV.linux.org.uk>
In-Reply-To: <20181222031747.GA2217@ZenIV.linux.org.uk>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 22 Dec 2018 23:13:05 +0800
Message-ID: <CALOAHbBX9QmWUzdOHtpqPbMxFd8PtcmvR82JY-NxHWi=3mUmRQ@mail.gmail.com>
Subject: Re: [PATCH] proc: sysctl: fix double drop_sysctl_table()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     mcgrof@kernel.org, Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 11:17 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Dec 22, 2018 at 10:12:21AM +0800, Yafang Shao wrote:
> > The callers of insert_header() will drop sysctl table whatever
> > insert_header() successes or fails.
> > So we can't call drop_sysctl_table() in insert_header().
> >
> > The call sites of insert_header() are all in fs/proc/proc_sysctl.c.
>
> Except that at least insert_links() does this:
>
>         ...
>         core_parent->header.nreg++;
>         ...
>         err = insert_header(core_parent, links);
>         if (err)
>                 kfree(links);
> out:
>         drop_sysctl_table(&core_parent->header);
> with that drop clearly paired with explicit increment of nreg.  So your
> patch appears to break at least that one.
>
> Looking at the rest of callers... __register_sysctl_table() demonstrates
> the same pattern - explicit increment of nreg, then insert_header(),
> then *unconditional* drop undoing that increment.
>
> The third and last caller (get_subdir()) appears to be different.
> We do insert_header(), if it succeeds we bump nreg on new and
> unconditionally drop a reference to dir, as well as new.
>
> Let's look at the callers of that sucker.
>
>         /* Reference moved down the diretory tree get_subdir */
>         dir->header.nreg++;
>         spin_unlock(&sysctl_lock);
>
>         /* Find the directory for the ctl_table */
>         for (name = path; name; name = nextname) {
>                 int namelen;
>                 nextname = strchr(name, '/');
>                 if (nextname) {
>                         namelen = nextname - name;
>                         nextname++;
>                 } else {
>                         namelen = strlen(name);
>                 }
>                 if (namelen == 0)
>                         continue;
>
>                 dir = get_subdir(dir, name, namelen);
>                 if (IS_ERR(dir))
>                         goto fail;
>         }
>
>         spin_lock(&sysctl_lock);
>         if (insert_header(dir, header))
>                 goto fail_put_dir_locked;
>
> Aha...  So we are traversing a tree and it smells like get_subdir()
> expects dir to be pinned by the caller, drops that reference and
> either fails or returns the next tree node pinned.
>
> _IF_ that matches the behaviour of get_subdir(), the code above
> makes sense -
>         grab dir
>         for each non-empty pathname component
>                 next = get_subdir(dir, component)
>                 // dir got dropped
>                 if get_subdir has failed
>                         goto fail
>                 // next got grabbed
>                 dir = next
>         insert_header(dir, header)
>         drop dir
>         if insert_header was successful
>                 return header
> fail:
>         // all references grabbed by the above are dropped by now
>
> So let's look at get_subdir() from refcounting POV (ignoring the locking
> for now):
>         subdir = find_subdir(dir, name, namelen);
>         if (!IS_ERR(subdir))
>                 goto found;
>         if (PTR_ERR(subdir) != -ENOENT)
>                 goto failed;
> yeccchhhhhhh....  What's wrong with if (subdir == ERR_PTR(-ENOENT))?
> Anyway, find_subdir() appears to be refcounting-neutral.
>         new = new_dir(set, name, namelen);
> OK, looks like we are creating a new object here.  What's the value of .nreg
> in it?  new_dir() itself doesn't seem to set it, but the thing it calls at
> the end (init_header()) does set it to 1.  OK, so we'd got a reference to
> new object, our counter being 1.  On failure it appears to return NULL.
> OK...
>         subdir = ERR_PTR(-ENOMEM);
>         if (!new)
>                 goto failed;
> right, so if allocation in new_dir() has failed, we are buggering off to the
> same 'failed' label as on other exits.  In failure case new_dir() is
> refcounting-neutral, so we are in the same environment.
>         /* Was the subdir added while we dropped the lock? */
>         subdir = find_subdir(dir, name, namelen);
>         if (!IS_ERR(subdir))
>                 goto found;
>         if (PTR_ERR(subdir) != -ENOENT)
>                 goto failed;
> Interesting...  So we can get to 'failed' in some cases when new_dir()
> has not failed.
>         /* Nope.  Use the our freshly made directory entry. */
>         err = insert_header(dir, &new->header);
>         subdir = ERR_PTR(err);
>         if (err)
>                 goto failed;
> Looks like it expects insert_header() to be refcounting-neutral in failure
> case...
>         subdir = new;
> found:
>         subdir->header.nreg++;
>
> OK, we can get here from 3 places:
>         * subdir found by lookup before we even tried to allocate new.
> new is NULL, subdir has just gotten a reference grabbed.
>         * subdir found by re-lookup after new had been allocated.
> new is non-NULL and we are holding one reference to it, subdir has
> just gotten a reference grabbed and it's not equal to new.
>         * new got successfully inserted into dir; subdir is equal
> to new and we'd just grabbed the second reference to it.
>
> Looks like in all those cases we have a reference grabbed on subdir
> *and* a reference grabbed on new (if non-NULL).  Covers all 3 cases.,,
>
> failed:
> ... and now we rejoin the failure paths (a lousy label name, that - we
> get here on success as well).
>         if (IS_ERR(subdir))
>                 whine
>         drop reference to dir (the one that caller had grabbed for us)
>         if new is not NULL
>                 drop reference to new.
>         return subdir.
>
> OK, in success case we have ended up with the total effect
>         drop dir
>         grab subdir
> Holds in all 3 cases above.  On failure, we have dropped the reference
> grabbed by new_dir (if any) and dropped dir.  That matches the behaviour
> guessed by the look of the caller, and it definitely expects
> insert_header() to be refcounting-neutral on failures.
>
> And AFAICS, insert_header() is that.  Before your patch, that is...
>
> The bottom line is, proposed behaviour change appears to be broken for all
> callers.
>
> NAK.
>
> PS: I was going to add that get_subdir() was in bad need of comments, until
> I actually looked around.  And right in front of that function we have this:
> /**
>  * get_subdir - find or create a subdir with the specified name.
>  * @dir:  Directory to create the subdirectory in
>  * @name: The name of the subdirectory to find or create
>  * @namelen: The length of name
>  *
>  * Takes a directory with an elevated reference count so we know that
>  * if we drop the lock the directory will not go away.  Upon success
>  * the reference is moved from @dir to the returned subdirectory.
>  * Upon error an error code is returned and the reference on @dir is
>  * simply dropped.
>  */
>
> So it *IS* documented, description does match the behaviour and
> I should've bloody well checked if it's there first.  And verified
> that it does match the code, of course, but that's generally
> simpler than deriving the behaviour from code and trying to come
> up with sane description of such.

Many thanks for your detailed explanation!
I undanstand it.

Thanks
Yafang
