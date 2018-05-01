Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3456472-1525195455-2-8749081534949578018
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
    1525195454; b=R2m+9mJyYYP42JtnPf84kkT6o+YFHqdF1Tq8I8IEfE9i7/lAqC
    drbNRS6HFpwbwIEZLfKajGU8NN+TuItcMHm6kMhbNWdB1WFU/UC9x6f2QDxCCOkB
    ZX5VLGmME2K+ySnN/0rVcm90rD2T0uZrFutXj70ec+iKiJSJsUmoXBMlpwE7C/rc
    UTyAXtetMS2iTLbYLiZ13E7qX/Hln72oXjSw5koFd0LZ7WqDXxTOsJL8YONJSfd7
    hzW83+0wNhCmY+KEVycGKLfaFDYjhy+GDSZswYkbz4vhU/3YeRj6d2bf1wbdODSj
    zywDGIRG9Jre4upnt7bv4wDSItMndvwgksdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525195454; bh=QfX2LnhFhBuUeyi28I+xFlpUBVKNB4
    R4RTnojPiZha4=; b=kUPHM/ZR2MsF8VVc1FFpi8APnKTpb4qIw7Wfj/KmVCWajI
    F3d100ger8h6SZeAHA3NY9BfnajzqbwUq36+az/vZ8nntUQUUgH+9Daut7IwlbLn
    RRwSB2p9ry8zLvawtJzXTLm63p+LeIpzoOJALecwqrmE5Flkh8EgHm+sVz96OikY
    aT8jMCOufWAPWYspcdqQdoYN+0IWuRwtYb8hMhx5E6wXb4AHG2u0W5FXJTATcUQF
    Z14wR/4u7ruelQDyAtqhSp7QId4IIaohRzuNu1zh6c7tzT0I1CMdUl8Q7TpcR6YJ
    N4uPL2f6lglS9W61l6uqp4OrXf4qnndJadVRDqXQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=iyg9dsZf x-bits=2048
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=iyg9dsZf x-bits=2048
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
X-CM-Envelope: MS4wfOq9aWriyPsOw0LEnIqsk1xjIqu8HGAH75yv9yXSHGwk/0ElXUhvC9S2vl3IRNWwKuq+DkxVp+ZN22kTx0ymKLqpD2Z6aJidWqKq2MZl10QP9I9YppD3
    DplSo7zPt4wtdwv3r15dIuEq+G3DCSGQhrdB37h9FP0GKVlWaKxEQI9y51VKrMo6OsDOW/7TwqQYgBYS2+nf95RkaMYlG8bFaDdNf44R5VGd+QzTNYZZu6kC
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=xNf9USuDAAAA:8 a=VwQbUJbxAAAA:8 a=zkWuU_ciIrCC_SOYRcsA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=SEwjQc04WA-l_NiBhQ7s:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755035AbeEARXz (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 13:23:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49302 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753505AbeEARXy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 1 May 2018 13:23:54 -0400
Date: Tue, 1 May 2018 10:23:19 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, sandeen@sandeen.net,
        dhowells@redhat.com, tytso@mit.edu, fliu@suse.com, jack@suse.cz,
        jeffm@suse.com, nborisov@suse.com, jake.norris@suse.com,
        mtk.manpages@gmail.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] vfs: skip extra attributes check on removal for symlinks
Message-ID: <20180501172319.GK4127@magnolia>
References: <20180426234639.12480-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426234639.12480-1-mcgrof@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8880 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=31 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805010169
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 04:46:39PM -0700, Luis R. Rodriguez wrote:
> Linux filesystems cannot set extra file attributes (stx_attributes as per
> statx(2)) on a symbolic link. To set extra file attributes you issue
> ioctl(2) with FS_IOC_SETFLAGS, *all* ioctl(2) calls on a symbolic link
> yield EBADF.
> 
> This is because ioctl(2) tries to obtain struct fd from the symbolic link
> file descriptor passed using fdget(), fdget() in turn always returns no
> file set when a file descriptor is open with O_PATH. As per symlink(2)
> O_PATH and O_NOFOLLOW must *always* be used when you want to get the file
> descriptor of a symbolic link, and this holds true for Linux, as such extra
> file attributes cannot possibly be set on symbolic links on Linux.
> 
> Filesystems repair utilities should be updated to detect this as
> corruption and correct this, however, the VFS *does* respect these
> extra attributes on symlinks for removal.
> 
> Since we cannot set these attributes we should special-case the
> immutable/append on delete for symlinks, this would be consistent with
> what we *do* allow on Linux for all filesystems.

Ah, ok, so the problem here is that you can't rm an "immutable" symlink
nor can you clear the immutable flag on such a beast, so therefore
ignore the immutable (and append) flags if we're trying to delete a
symlink?

I think we ought to teach the xfs inode verifier to check for
immutable/append symlinks and return error so that we don't end up with
such things in core in the first place, and fix xfs_repair to zap such
things.

That said, for the filesystems that aren't going to check their inodes,
I guess this is a (hackish) way to avoid presenting undeletable gunk in
the fs to the user...

(Were it up to me I'd make a common vfs_check_inode() to reject
struct inode containing garbage that the vfs won't deal with, and teach
the filesystems to use it; but I was shot down when I tried to do that
for negative isize.)

--D

> The userspace utility chattr(1) cannot set these attributes on symlinks
> *and* other special files as well:
> 
> 	# chattr -a symlink
> 	chattr: Operation not supported while reading flags on b
> 
> The reason for this is different though. Refer to commit 023d111e92195
> ("chattr.1.in: Document the compression attribute flags E, X, and ...")
> merged on e2fsprogs v1.28 since August 2002. This commit prevented
> issuing the ioctl() for symlink *and* special files in consideration for
> a buggy DRM driver where issuing lsattr on their special files crashed
> the system. For details refer to Debian bug 152029 [0].
> 
> You can craft your own tool to query the extra file attributes with
> the new shiny statx(2) tool, statx(2) will list the attributes if
> they were set for instance on a corrupt filesystem. However statx(2)
> is only used for *querying* -- not for setting the attributes.
> 
> If you implement issuing your own ioctl() for FS_IOC_FSGETXATTR or
> FS_IOC_FSSETXATTR on special files (block, char, fifo) it will fail
> returning -1 and errno is set to ENOTTY (Inappropriate ioctl for
> device). The reason for this is different than for symlinks.
> For special files this fails on vfs_ioctl() when the filesystem
> f_op callbacks are not set for these special files:
> 
> long vfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> {
> 	int error = -ENOTTY;
> 
>         if (!filp->f_op->unlocked_ioctl)
> 		goto out;
> 
> 	error = filp->f_op->unlocked_ioctl(filp, cmd, arg);
> 	if (error == -ENOIOCTLCMD)
> 		error = -ENOTTY;
> out:
> 	return error;
> }
> 
> The same applies to PF_LOCAL named sockets. Since this varies by
> filesystem for special files, only make a special rule to respect
> the immutable and append attribute on symlinks.
> 
> [0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=152029
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
> 
> As discussed at LSF/MM -- I'd follow up on this low hanging fruit as
> the discussion had stalled on linux-xfs on review of the respective
> xfs_repair changes. This addresses the general API question, and
> as such I think could help establish order in how we split up patches
> for those changes.
> 
> This requires some other eyeballs, and it also requires a putting it through
> xfstests which I can do in the next few days, hence the RFC. But better put it
> out for review already. I'd also like feedback from the linux-api folks to
> see if this matches their own known / documented expectations.
> 
>  fs/namei.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 186bd2464fd5..0f9069468cfb 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2719,6 +2719,14 @@ int __check_sticky(struct inode *dir, struct inode *inode)
>  }
>  EXPORT_SYMBOL(__check_sticky);
>  
> +/* Process extra file attributes only when they make sense */
> +static bool may_delete_stx_attributes(struct inode *inode)
> +{
> +	if (!S_ISLNK(inode->i_mode) && (IS_APPEND(inode) || IS_IMMUTABLE(inode)))
> +		return false;
> +	return  true;
> +}
> +
>  /*
>   *	Check whether we can remove a link victim from directory dir, check
>   *  whether the type of victim is right.
> @@ -2757,8 +2765,8 @@ static int may_delete(struct inode *dir, struct dentry *victim, bool isdir)
>  	if (IS_APPEND(dir))
>  		return -EPERM;
>  
> -	if (check_sticky(dir, inode) || IS_APPEND(inode) ||
> -	    IS_IMMUTABLE(inode) || IS_SWAPFILE(inode) || HAS_UNMAPPED_ID(inode))
> +	if (check_sticky(dir, inode) || !may_delete_stx_attributes(inode) ||
> +	    IS_SWAPFILE(inode) || HAS_UNMAPPED_ID(inode))
>  		return -EPERM;
>  	if (isdir) {
>  		if (!d_is_dir(victim))
> -- 
> 2.17.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
