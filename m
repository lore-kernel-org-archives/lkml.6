Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12B9C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F6A20867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="INyP2QuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F6A20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbeIYWL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:11:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46438 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbeIYWLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:11:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so22260190ljj.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1WV1HcJK0YbgAbr9GySV+e1YURPHe3VWWenxW3nt244=;
        b=INyP2QuAWZGM6KNNVJ5iMW1odVdySrOnoq20jT9XCc2TVcl+Wvt9uHjux27JJKvKkQ
         lC9cNr4qrxH7683yC3HJivlfUFHiH3eNmSVJsof16LibDU3VeXvHJwIV23BglVFWEcnU
         kHICOqOGQQLkdvJRryA0z7liegZ45fyn/haEpQKCA5po5coZwC5lLBSVSVqlDyuFYr3B
         5ovCiwqAA1cVlUeNqvUJAkRKLq7C9+SHvqLi36xhx2aCSGqZcn9cKyUwzBbC371tzfnZ
         Zn07yGLyu1zMmkf2zsTj1I0Gp1eD5Ki6BgvawL1JF3ImruQtfzLv+oGXxi+w5YK5mFi1
         maZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1WV1HcJK0YbgAbr9GySV+e1YURPHe3VWWenxW3nt244=;
        b=sDcL0JCDzjMbpI1kjZkGJCBlAwIAX6DNort1EuYUvLyGRv2/YOXyyTROzfF6OZX7iJ
         w73WeGl4emOkYrqf5ZfFAfhazgwsAkCuRxqZ6dtxwR1jJtHvzdJuccvxpywEQCTEDuTR
         906zZKRZ4hpoM4+IkmawAcDy3m/VD9udH5sEMcJTRypbdYUYaprw531pk7SU7ZaEEKWK
         RxovIJUl6Nc+9aXawHr6CdFejTtHMpe6P9jl3PX48WXTxFSLLmBtdXSquYsQ866IhgZg
         pXHbIn4Ld1okyNkELwGV1EkrOr5CYWOH/tdzQHdOOEOh0tozrv2iAuAvJzqRsxznOO12
         WTdg==
X-Gm-Message-State: ABuFfohw4dZLqSUAtnZWbgFHd8a6k4IvPi45EGhJ8wJr2+AWFT5pxZpu
        YxQrEiYtXbdfGMZdQCoY4mPRGpM6+2CEC+pot1Gz
X-Google-Smtp-Source: ACcGV61bN5zWwRhX11NuApsm5SWrc5XZCKRrlkmljmN9XHvBJDnNA0y/b5GcwpjO7+hSHE8t09US+x1nAjYvwD2zOQY=
X-Received: by 2002:a2e:44c6:: with SMTP id b67-v6mr1442313ljf.102.1537891423158;
 Tue, 25 Sep 2018 09:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180919165248.53090-1-takondra@cisco.com> <f283c1e7-19eb-2b99-3fef-a19e2bf99a2b@tycho.nsa.gov>
 <153741130781.7326.1773144725860636439@takondra-t460s> <9a944aea-f35e-5a49-841d-6bfca8f17b9d@tycho.nsa.gov>
 <153748436388.5590.1406237328277739821@takondra-t460s> <66ec16b0-a335-d9ef-deb3-ef391cdd66e0@tycho.nsa.gov>
 <CAHC9VhRorkfqRTsssx_eGMy+fJQtoJew7f5i24UBkZ6tGJ5CUw@mail.gmail.com>
 <153785433233.5039.17960184426345262866@takondra-t460s> <a23ad753-8fd4-e9c3-cdbf-391ee154794b@tycho.nsa.gov>
In-Reply-To: <a23ad753-8fd4-e9c3-cdbf-391ee154794b@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Sep 2018 12:03:31 -0400
Message-ID: <CAHC9VhRRArA7_ON5P2JfrKxExwzm5Wznj150pfgijBoR+JxYBA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: add a fallback to defcontext for native labeling
To:     Stephen Smalley <sds@tycho.nsa.gov>, takondra@cisco.com
Cc:     Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, xe-linux-external@cisco.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 9:58 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 09/25/2018 01:45 AM, Taras Kondratiuk wrote:
> > Quoting Paul Moore (2018-09-24 20:46:57)
> >> On Fri, Sep 21, 2018 at 10:39 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>> On 09/20/2018 06:59 PM, Taras Kondratiuk wrote:
> >>>> Quoting Stephen Smalley (2018-09-20 07:49:12)
> >>>>> On 09/19/2018 10:41 PM, Taras Kondratiuk wrote:
> >>>>>> Quoting Stephen Smalley (2018-09-19 12:00:33)
> >>>>>>> On 09/19/2018 12:52 PM, Taras Kondratiuk wrote:
> >>
> >> ...
> >>
> >>>> IMO it would be more consistent if defcontext cover all "unlabeled"
> >>>> groups. It seems unlikely to me that somebody who currently uses
> >>>> defcontext can somehow rely on mapping invalid labels to unlabeled
> >>>> instead of default context.
> >>>
> >>> Yes, and that seems more consistent with the current documentation in
> >>> the mount man page for defcontext=.
> >>>
> >>> I'd be inclined to change selinux_inode_notifysecctx() to call
> >>> security_context_to_sid_default() directly instead of using
> >>> selinux_inode_setsecurity() and change security_context_to_sid_core()
> >>> and sidtab_search_core() as suggested above to save and use the def_sid
> >>> instead of SECINITSID_UNLABELED always (initializing the context def_sid
> >>> to SECINITSID_UNLABELED as the default).  selinux_inode_setsecurity() we
> >>> should leave unchanged, or if we change it at all, it should be more
> >>> like the handling in selinux_inode_setxattr().  The notifysecctx hook is
> >>> invoked by the filesystem to notify the security module of the file's
> >>> existing security context, so in that case we always want the _default
> >>> behavior, whereas the setsecurity hook is invoked by the vfs or the
> >>> filesystem to set the security context of a file to a new value, so in
> >>> that case we would only use the _force interface if the caller had
> >>> CAP_MAC_ADMIN.
> >>>
> >>> Paul, what say you?  NB This would be a user-visible behavior change for
> >>> mounts specifying defcontext= on xattr filesystems; files with invalid
> >>> contexts will then show up with the defcontext value instead of the
> >>> unlabeled context.  If that's too risky, then we'd need a flag or
> >>> something to security_context_to_sid_default() to distinguish the
> >>> behaviors and only set it when called from selinux_inode_notifysecctx().
> >>
> >> Visible changes like this are always worrisome, even though I think it
> >> is safe to assume that the defcontext option is not widely used.  I'd
> >> feel much better if this change was opt-in.
> >>
> >> Which brings about it's own problems.  We have the policy capability
> >> functionality, but that is likely a poor fit for this as the policy
> >> capabilities are usually controlled by the Linux distribution while
> >> the mount options are set by the system's administrator when the
> >> filesystem is mounted.  We could add a toggle somewhere in selinuxfs,
> >> but I really dislike that idea, and would prefer to find a different
> >> solution if possible.  I'm not sure how much flak we would get for
> >> introducing a new mount option, but perhaps that is the best way to
> >> handle this: defcontext would continue to behave as it does now, but
> >> new option X would behave as mentioned in this thread.
> >>
> >> Thoughts?
> >
> > The new option X will also mean "default context", so it will be pretty
> > hard to come up with a different but a sensible name. I'm afraid that
> > having two options with hardly distinguishable semantics will be very
> > confusing.
> >
> > What about a kernel config option that modifies the behavior of
> > defcontext?
>
> First, the existing documentation for defcontext= leaves open the door
> to the proposed new behavior.  From mount(8):
> "You can set the default security context for  unlabeled  files  using
> defcontext= option.  This overrides the value set for unlabeled files in
> the policy and requires a filesystem that supports xattr labeling."
>
> "Unlabeled files" could just mean files without any xattr, or it could
> mean all files that either lack an xattr or have an invalid one under
> the policy, since both sets of files are currently mapped to the
> unlabeled context.

This may be true for the major SELinux policies being shipped by
distributions, but can we say this holds true for *all* SELinux
policies in use today?

> Second, under what conditions would this situation break existing
> userspace?  The admin would have had to mount an xattr filesystem with
> defcontext= specified, and that filesystem would have to both contain
> files without any xattrs and files with invalid ones (otherwise how they
> are treated by the kernel is irrelevant), and the policy would need to
> distinguish access to files without xattrs vs files with invalid ones.
> Seems unlikely.

I think you answered your own question.  Yes, it is unlikely, but I
*really* dislike changing visible behavior like this without some
explicit action on behalf of the user/admin.  We've done it in the
past and it has left me uneasy each time.

> Third, the fact that policy maintainers remapped both SECINITSID_FILE
> (the default value for defcontext) and SECINITSID_UNLABELED (used for
> invalid contexts) to the unlabeled context (getting rid of file_t as a
> separate type, aliased to unlabeled_t) long ago suggests that there is
> no meaningful difference there.

Related to the comments above.

> I'm inclined to just change the behavior for defcontext= unconditionally
> and have it apply to both native and xattr labeling.  If that's a no-go,
> then the simplest solution is to just leave defcontext= behavior
> unchanged for xattr labeling and only implement the new semantics for
> native labeling.  That's just a matter of adding a flag to
> security_context_to_sid_default() and only setting it when calling from
> selinux_inode_notifysecctx().

Neither option is very appealing to me, but that doesn't mean I'm saying "no".

From a sanity and consistency point of view I think option #1 (change
the defcontext behavior) is a better choice, and I tend to favor this
consistency even with the understanding that it could result in some
unexpected behavior for users.  However, if we get complaints, I'm
going to revert this without a second thought.

So to answer your question Taras, go ahead and prepare a patch so we
can take a look.  A bit of fair warning that it might get delayed
until after the upcoming merge window since we are already at -rc5; I
want this to have plenty of time in -next.

Thanks guys.

-- 
paul moore
www.paul-moore.com
