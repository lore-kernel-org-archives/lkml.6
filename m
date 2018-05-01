Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3459038-1525196730-2-9513076323000467830
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525196729; b=mTRW8IBebCgkzrD4Mz3Ar61qUzExmHxBkOcfrBPdyll+rsOtxU
    ibNtkiLqFmWk+j1N0BU2no/Ig5ZSpigNT2Pxa5n/rmGe3lKEoqwWx9a+brnQSVjt
    6i0ua9iY0VTH4ajz3p/1YeOw143v9XKj3mC87xGtwUlOA/P+I/q9IL6754qxG5i3
    auLQ5vhWuL0/D/ERrXfy1QLS/jw2/PEmG+blI3kehUDJzRo35Zc8x3w97knNB2qF
    weNyAvIrYhd0NuJ4c0nCnF4N6BnpjmbLLiLLqTIkyEyX3jjw7+21T6oe84+LJATz
    R5N02FST0I68hr8VmO2CZjkgBTmvpG62Tmnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525196729; bh=eyVIRYJ7kIU5wxI6IoedJCyF6Z1DVT
    ThruYRp/Du4UM=; b=JndJOuWVSpkJIEqW1anuz3gYC3Vtn99XunJ4wHngXQzeTg
    erUcCLBZzPtehmPKbbs7p28U43AWQEn0V1LKNEVl+DbT7GslU5UKGxfW4Fv5GHKR
    x0tTIUQW6smoZ5CSuIu03pQne4OoiNpcBBUS5oPZTobIe9lchfAY5IYfuZgQ6d7h
    PINX8eTGMRDx1KyIRnZzyPLWP9eONy7OFTkHZ0BczE9avgUOTaQgf2I74tY4qE+c
    +7fUM97Oeq+04gZU+aCl36bdwy4oJ/joaBphjPpNIqeHdk0P4Q7Bz5nWHssyYqMc
    XiIWPrFBBRq2Nwn5Tk+FQolg0dRj68FizdfGS9EA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK7nWllyaytBIp/72b4cAXL7zyDeqywLhcHtxodO703i5S6codJqx2YfFuOSFsfWjTMp+4Sa+KGzdPITjGF8HoDqH00Vb5FTYp+nsLqmd1LDGqHFnPoi
    qM//xzpGB+qcqvAMDy5hYrGmx+LLR6QnGdOgctsLFxmA21b8yFbB8xcv3TxwZtGu/ZuldZRUtUkqGjvVoISwLhogfcNjxrmMMn7kMiWSBQhlA2xlbCAoNeT6
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=tDJ_kq-PG3TC64NMDcwA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755898AbeEARpQ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 13:45:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:40672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755443AbeEARpP (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 13:45:15 -0400
Date: Tue, 1 May 2018 17:45:12 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        sandeen@sandeen.net, dhowells@redhat.com, tytso@mit.edu,
        fliu@suse.com, jack@suse.cz, jeffm@suse.com, nborisov@suse.com,
        jake.norris@suse.com, mtk.manpages@gmail.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] vfs: skip extra attributes check on removal for symlinks
Message-ID: <20180501174512.GA27853@wotan.suse.de>
References: <20180426234639.12480-1-mcgrof@kernel.org>
 <20180501172319.GK4127@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501172319.GK4127@magnolia>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 10:23:19AM -0700, Darrick J. Wong wrote:
> On Thu, Apr 26, 2018 at 04:46:39PM -0700, Luis R. Rodriguez wrote:
> > Linux filesystems cannot set extra file attributes (stx_attributes as per
> > statx(2)) on a symbolic link. To set extra file attributes you issue
> > ioctl(2) with FS_IOC_SETFLAGS, *all* ioctl(2) calls on a symbolic link
> > yield EBADF.
> > 
> > This is because ioctl(2) tries to obtain struct fd from the symbolic link
> > file descriptor passed using fdget(), fdget() in turn always returns no
> > file set when a file descriptor is open with O_PATH. As per symlink(2)
> > O_PATH and O_NOFOLLOW must *always* be used when you want to get the file
> > descriptor of a symbolic link, and this holds true for Linux, as such extra
> > file attributes cannot possibly be set on symbolic links on Linux.
> > 
> > Filesystems repair utilities should be updated to detect this as
> > corruption and correct this, however, the VFS *does* respect these
> > extra attributes on symlinks for removal.
> > 
> > Since we cannot set these attributes we should special-case the
> > immutable/append on delete for symlinks, this would be consistent with
> > what we *do* allow on Linux for all filesystems.
> 
> Ah, ok, so the problem here is that you can't rm an "immutable" symlink
> nor can you clear the immutable flag on such a beast, so therefore
> ignore the immutable (and append) flags if we're trying to delete a
> symlink?

Yup.

> I think we ought to teach the xfs inode verifier to check for
> immutable/append symlinks and return error so that we don't end up with
> such things in core in the first place,

Agreed. But note that one way to end up with these things is through
corruption. Once a user finds this the first signs they'll run into
(unless they have the awesome new online scrubber) is they cannot delete
some odd file and not know why. And then they'll see they cannot change
or remove either the immutable or append flag. The immutable attribute
is known to not let you delete the file, but its less known that the
append attribute implies the same. Folks would scratch their heads.

Since one cannot *set* these attributes on symlinks on Linux, other than
ignoring such attributes perhaps we should warn about it? As the only
way you could end up with that is if your filesystem got corrupted.

But without filesystems having a fix for that merged users can't do anything.

> and fix xfs_repair to zap such things.

This is what my patch for xfs_repair does, which is pending review.

But note that special files are handled differently, I explain the logic on the
RFC commit log, which is why I suggested splitting up adding a fix for special
files as a separate patch.

> That said, for the filesystems that aren't going to check their inodes,
> I guess this is a (hackish) way to avoid presenting undeletable gunk in
> the fs to the user...

That's why its RFC. What is the right thing to do here?

My own logic here was since we cannot possibly allow extended attributes on
symlinks is to not use them then as well, in this case for delete.

> (Were it up to me I'd make a common vfs_check_inode() to reject
> struct inode containing garbage that the vfs won't deal with,

There certainly are cases that we could come up with for the VFS where
if such things are found, regardless of the filesystem, we're very sure
its a corruption. This is just one example, as you note.

So it is correct that there are two things here:

1) Do we respect the attribute for symlink on delete
2) Do we warn to users of the fact that the inode is very likely corrupted
   regardless of the filesystem?

This patch only addresses 1) and makes it match the VFS expectation, and
I think this is safe if we're not doing 2). This is why I'm also looking
for feedback from linux-api folks.

This is one of those odd corner cases we run into, and very likely not
well documented anywhere.

> and teach the filesystems to use it;

Or the VFS uses it.

  Luis
