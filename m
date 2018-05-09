Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3603391-1525825101-2-11068175419973722628
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525825100; b=eZ7oXbCJem1o6gNiMnxBf6EA3DtJwuP7JTbQIOsyhvXkKH10S6
    uxa1mrPL6SfGS/VM9qFGzpFZLDJGyIM7n5+U/BPmoIZuEiyK+5CNHpDleEtFyc1h
    rFxOb7gKONa4s0jS9C6SH8UAdjjO4z7aLjGKGffkP/SxwHIrcFNHxgIxlFaTx+lm
    5e8ujfTNvytnJvpGzr6tvmSVPzdAGjNfI5tmZiGEJ39q73BSxpGrY9v0lPkLRIOQ
    uSOaBBDsEa/fj8DOLpEdujmUokJS7olhU6T+j/fawifGnIGVdfcFbg00omwAy9k1
    eg81sFnpyCKeH2zKteXQ4swOKhA2qNTWoOOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525825100; bh=sP6t8asAGRRKSIybNxa7pheFK2uMRp
    YEGtNWGVsCIfs=; b=E9M5acUu5t64d6wHYovgro/zfETfoBXwvxmSaShRG+Klc0
    tvn64fO7Xa9jauhnWiQtOf5mPvCoffXn/D2k+y7BQUAHdlSuNSENjnoyVTEcAXYB
    qZRf6cX9hlcGJYUaLkkSNlhDFhR9M66ThIFV/XxAhlTluCUBOi/j/bQn67AMmEuV
    01m5NIsJq9nw3Z08R/Gm4ceRGc366BjG+BJ8QoFg0iVUYa43cqDBy7Js4+ml0VBH
    rEkYoZdxH1tuWBKq3+uFjjbtwbf3O6cm+5F6IhjXG2bkgXKKgwSrOF4J7d8ZQusx
    eLH9EwZenb65LUn+FEkKOt5F02B2hC7YwW4xlbwA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=TNqcOcjN x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=TNqcOcjN x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP60z0EJSeSxM7GdSbMRzUYejYO7P6gs8L4+XSW4WPq9RGgKk1ZBUTUmXEYdjSQXZTHje85uz79EXeRWX278ts76+oXyIMZgijzZpQvNploQLS8LGD8a
    4IdsR1kfE734XO795DMic7TshAPF6Nk+8EZcFPPzU2pOBuxdmMXJqui1CnfzumIGSKRPuHbgj/NjzIySW3LbfeVFOgnQ0mzIdGnH/71f2xW8VmdeCevvQ+r/
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=MSVEv4ucfyJWbj0UawgA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932760AbeEIASS (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 20:18:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41092 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932654AbeEIASR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 8 May 2018 20:18:17 -0400
Date: Tue, 8 May 2018 17:17:41 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, sandeen@sandeen.net,
        dhowells@redhat.com, tytso@mit.edu, fliu@suse.com, jack@suse.cz,
        jeffm@suse.com, nborisov@suse.com, jake.norris@suse.com,
        mtk.manpages@gmail.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] vfs: skip extra attributes check on removal for symlinks
Message-ID: <20180509001741.GB11261@magnolia>
References: <20180426234639.12480-1-mcgrof@kernel.org>
 <20180501172319.GK4127@magnolia>
 <20180501174512.GA27853@wotan.suse.de>
 <20180508003055.GC11261@magnolia>
 <20180509000327.GJ27853@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509000327.GJ27853@wotan.suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8887 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805090001
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 12:03:28AM +0000, Luis R. Rodriguez wrote:
> On Mon, May 07, 2018 at 05:30:55PM -0700, Darrick J. Wong wrote:
> > On Tue, May 01, 2018 at 05:45:12PM +0000, Luis R. Rodriguez wrote:
> > > On Tue, May 01, 2018 at 10:23:19AM -0700, Darrick J. Wong wrote:
> > > > On Thu, Apr 26, 2018 at 04:46:39PM -0700, Luis R. Rodriguez wrote:
> > > > > Linux filesystems cannot set extra file attributes (stx_attributes as per
> > > > > statx(2)) on a symbolic link. To set extra file attributes you issue
> > > > > ioctl(2) with FS_IOC_SETFLAGS, *all* ioctl(2) calls on a symbolic link
> > > > > yield EBADF.
> > > > > 
> > > > > This is because ioctl(2) tries to obtain struct fd from the symbolic link
> > > > > file descriptor passed using fdget(), fdget() in turn always returns no
> > > > > file set when a file descriptor is open with O_PATH. As per symlink(2)
> > > > > O_PATH and O_NOFOLLOW must *always* be used when you want to get the file
> > > > > descriptor of a symbolic link, and this holds true for Linux, as such extra
> > > > > file attributes cannot possibly be set on symbolic links on Linux.
> > > > > 
> > > > > Filesystems repair utilities should be updated to detect this as
> > > > > corruption and correct this, however, the VFS *does* respect these
> > > > > extra attributes on symlinks for removal.
> > > > > 
> > > > > Since we cannot set these attributes we should special-case the
> > > > > immutable/append on delete for symlinks, this would be consistent with
> > > > > what we *do* allow on Linux for all filesystems.
> > > > 
> > > > Ah, ok, so the problem here is that you can't rm an "immutable" symlink
> > > > nor can you clear the immutable flag on such a beast, so therefore
> > > > ignore the immutable (and append) flags if we're trying to delete a
> > > > symlink?
> > > 
> > > Yup.
> > > 
> > > > I think we ought to teach the xfs inode verifier to check for
> > > > immutable/append symlinks and return error so that we don't end up with
> > > > such things in core in the first place,
> > > 
> > > Agreed. But note that one way to end up with these things is through
> > > corruption. Once a user finds this the first signs they'll run into
> > > (unless they have the awesome new online scrubber) is they cannot delete
> > > some odd file and not know why. And then they'll see they cannot change
> > > or remove either the immutable or append flag. The immutable attribute
> > > is known to not let you delete the file, but its less known that the
> > > append attribute implies the same. Folks would scratch their heads.
> > > 
> > > Since one cannot *set* these attributes on symlinks on Linux, other than
> > > ignoring such attributes perhaps we should warn about it? As the only
> > > way you could end up with that is if your filesystem got corrupted.
> > > 
> > > But without filesystems having a fix for that merged users can't do anything.
> > > 
> > > > and fix xfs_repair to zap such things.
> > > 
> > > This is what my patch for xfs_repair does, which is pending review.
> > > 
> > > But note that special files are handled differently, I explain the logic on the
> > > RFC commit log, which is why I suggested splitting up adding a fix for special
> > > files as a separate patch.
> > > 
> > > > That said, for the filesystems that aren't going to check their inodes,
> > > > I guess this is a (hackish) way to avoid presenting undeletable gunk in
> > > > the fs to the user...
> > > 
> > > That's why its RFC. What is the right thing to do here?
> > 
> > Ideally, none of the filesystems should ever feed garbage to the vfs,
> > but it's not all that obvious exactly what things the vfs will trip over.
> > And knowing that a lot of the filesystems do minimal checking if any, I
> > guess I'll just say that...
> > 
> > ...XFS (and probably ext4) should catch immutable symlinks in the inode
> > verifiers so that xfs_iget returns -EFSCORRUPTED.  For the rest of the
> > filesystems, it's probably fine to let them delete the symlink since the
> > user wants to kill it anyway.
> 
> Alrighty, I have this implemented now.
> 
> > > My own logic here was since we cannot possibly allow extended attributes on
> > > symlinks is to not use them then as well, in this case for delete.
> > > 
> > > > (Were it up to me I'd make a common vfs_check_inode() to reject
> > > > struct inode containing garbage that the vfs won't deal with,
> > > 
> > > There certainly are cases that we could come up with for the VFS where
> > > if such things are found, regardless of the filesystem, we're very sure
> > > its a corruption. This is just one example, as you note.
> > > 
> > > So it is correct that there are two things here:
> > > 
> > > 1) Do we respect the attribute for symlink on delete
> > > 2) Do we warn to users of the fact that the inode is very likely corrupted
> > >    regardless of the filesystem?
> > 
> > But I suppose we could WARN_ON_ONCE to state that we're allowing
> > deletion of an immutable symlink that we couldn't possibly have set.
> 
> Yes, I think that's better than to allow filesystems to do things even
> though the VFS in this case *knows* better.
> 
> > Anyway, couple this patch with a second one to fix the xfs verifier and
> > I'll be happy.
> 
> Groovy, thanks, let's not forget the xfs_repair respective fix :) let me know
> if you have any feedback on that.

TBH I've lost any proposed xfs_repair patches to the mists of time
because some patch volcano keeps erupting on the lists. :P

Uh... I think it's fine for xfs_{repair,scrub} to clear the immutable
and append flags on any special inodes it finds, particularly since
neither flag has any real meaning for block/char/fifo/socket/symlinks
anyway.

(Well ok I could imagine immutable pipes being meaningful for
ignoring^Wdealing with the bureaucracy but I don't see a non-joke
meaning. :P)

--D

>   Luis
> --
> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
