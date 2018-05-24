Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2656378-1527201020-3-2847034314304622916
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527201020; b=PNIuU6s2Ss8z5kASXvRxaiUL+jDAgEcvf8k1RIhQhDEMy3Zr+8
    UKiE62cVpCzv9v2wQKTjL3yIKM/E9yk0Vq2bJ1xgtEmeRt1wV1TwdUN1pybq/Isz
    C4SJdAyjXSFL8iFvG0wGVg9AaLjhGcFRnFaYAtU5Nbyabd51O4AN+1BlA9olC8Bf
    FVyj4DPTc86W5gh7n/Zmui4MwC6GTx4PPgKDzfF/0NYuDvSqf5GhXtl2gw4wjgVB
    /eJ5m9jnwipamRNT5BkHBegGkEtV79qKVpWPkrxYM6N1Bff1u5yoA2HXKWg8vk3K
    cukmDvaYrXkR3woBd/1u3aHK2SsQNCXbaaPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527201020; bh=aENKUx2wPPf1iAs62GqN0n06U67xRy
    cUvyfQN9WORVU=; b=F52M889RPoHY9wLagg8QKCmwTSkBA59zanE0HdDNUm3Ki8
    2t1fJfFRk8jqTXuenJQQIu8Yk+AHI+vCqW3cv71mpLpdD/QF56ADk/Pn7maYX0N7
    2VnA0ZZR16GBn67Y0ZVQsSsUsahev4tX4VWaWq2DHiakhWelcRQaZzbKk/yTEZuZ
    2U/SADZTnFDOGW2bhOmmCy07BOw7OvOoJVp9IglJ04eTYICESky6NrqpX2P++eZa
    zmgVj/Vr3kI5h9A+RBWHqSU7YfPZ+j7HXqv3RCbbcNawgzGNDdOsbRHGC8KiXm7Y
    KdgxY8Zav8z+7ajs8TjAWRiI68eFPiFJNtdcyACA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brauner.io;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=brauner.io header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brauner.io;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=brauner.io header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHohreV8h8DeqyFvWWF2xdyykhi43W5qtBIDadupwc3ohPMTKXPUFhirDCQvj83zjgiIr8ETZCcvmsmlbepSyKq1z31hzZsXX3T0rpaScOk+z8Jyq0lU
    IEwu/NZ2/voCx5JzcGVkCFqu9LI1U1e7fnnqYHrdZeF0TDFmCPYDT1afarTJ04wjZKUEAcTTDNoHMb1nnr7AgBZvYOH5gqSAsfi7GyQu+xpEIJ8RFnk7FXX0
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=DfNHnWVPAAAA:8 a=PtDNVHqPAAAA:8 a=_aA0F09po3iaDauuI7cA:9 a=QEXdDO2ut3YA:10
    a=rjTVMONInIDnV1a_A2c_:22 a=BpimnaHY1jUKGyF_4-AF:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034756AbeEXWaP (ORCPT <rfc822;linux@kroah.com>);
        Thu, 24 May 2018 18:30:15 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:39896 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966192AbeEXWaO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 May 2018 18:30:14 -0400
Date: Fri, 25 May 2018 00:30:08 +0200
From: Christian Brauner <christian@brauner.io>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org
Subject: Re: [REVIEW][PATCH v2 3/6] fs: Allow superblock owner to replace
 invalid owners of inodes
Message-ID: <20180524223008.GA17493@mailbox.org>
References: <87o9h6554f.fsf@xmission.com>
 <20180523232538.4880-3-ebiederm@xmission.com>
 <87bmd6549i.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bmd6549i.fsf_-_@xmission.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 06:41:29PM -0500, Eric W. Biederman wrote:
> 
> Allow users with CAP_SYS_CHOWN over the superblock of a filesystem to
> chown files when inode owner is invalid.  Ordinarily the
> capable_wrt_inode_uidgid check is sufficient to allow access to files
> but when the underlying filesystem has uids or gids that don't map to
> the current user namespace it is not enough, so the chown permission
> checks need to be extended to allow this case.
> 
> Calling chown on filesystem nodes whose uid or gid don't map is
> necessary if those nodes are going to be modified as writing back
> inodes which contain uids or gids that don't map is likely to cause
> filesystem corruption of the uid or gid fields.
> 
> Once chown has been called the existing capable_wrt_inode_uidgid
> checks are sufficient to allow the owner of a superblock to do anything
> the global root user can do with an appropriate set of capabilities.
> 
> An ordinary filesystem mountable by a userns root will limit all uids
> and gids in s_user_ns or the INVALID_UID and INVALID_GID to flag all
> others.  So having this added permission limited to just INVALID_UID
> and INVALID_GID is sufficient to handle every case on an ordinary filesystem.
> 
> Of the virtual filesystems at least proc is known to set s_user_ns to
> something other than &init_user_ns, while at the same time presenting
> some files owned by GLOBAL_ROOT_UID.  Those files the mounter of proc
> in a user namespace should not be able to chown to get access to.
> Limiting the relaxation in permission to just the minimum of allowing
> changing INVALID_UID and INVALID_GID prevents problems with cases like
> that.
> 
> The original version of this patch was written by: Seth Forshee.  I
> have rewritten and rethought this patch enough so it's really not the
> same thing (certainly it needs a different description), but he
> deserves credit for getting out there and getting the conversation
> started, and finding the potential gotcha's and putting up with my
> semi-paranoid feedback.

Ok, took me a little longer to reason about this.

Acked-by: Christian Brauner <christian@brauner.io>

> 
> Inspired-by: Seth Forshee <seth.forshee@canonical.com>
> Acked-by: Seth Forshee <seth.forshee@canonical.com>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
> 
> Sigh.  In simplifying this change so it would not require a change to
> proc (or any other similar filesystem) I accidentally introduced some
> badly placed semicolons.  The kbuild test robot was very nice and found
> those for me.  Resend with those unnecessary semicolons removed.
> 
>  fs/attr.c | 36 ++++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/attr.c b/fs/attr.c
> index 12ffdb6fb63c..d0b4d34878fb 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -18,6 +18,32 @@
>  #include <linux/evm.h>
>  #include <linux/ima.h>
>  
> +static bool chown_ok(const struct inode *inode, kuid_t uid)
> +{
> +	if (uid_eq(current_fsuid(), inode->i_uid) &&
> +	    uid_eq(uid, inode->i_uid))
> +		return true;
> +	if (capable_wrt_inode_uidgid(inode, CAP_CHOWN))
> +		return true;
> +	if (uid_eq(inode->i_uid, INVALID_UID) &&
> +	    ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
> +		return true;
> +	return false;
> +}
> +
> +static bool chgrp_ok(const struct inode *inode, kgid_t gid)
> +{
> +	if (uid_eq(current_fsuid(), inode->i_uid) &&
> +	    (in_group_p(gid) || gid_eq(gid, inode->i_gid)))
> +		return true;
> +	if (capable_wrt_inode_uidgid(inode, CAP_CHOWN))
> +		return true;
> +	if (gid_eq(inode->i_gid, INVALID_GID) &&
> +	    ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
> +		return true;
> +	return false;
> +}
> +
>  /**
>   * setattr_prepare - check if attribute changes to a dentry are allowed
>   * @dentry:	dentry to check
> @@ -52,17 +78,11 @@ int setattr_prepare(struct dentry *dentry, struct iattr *attr)
>  		goto kill_priv;
>  
>  	/* Make sure a caller can chown. */
> -	if ((ia_valid & ATTR_UID) &&
> -	    (!uid_eq(current_fsuid(), inode->i_uid) ||
> -	     !uid_eq(attr->ia_uid, inode->i_uid)) &&
> -	    !capable_wrt_inode_uidgid(inode, CAP_CHOWN))
> +	if ((ia_valid & ATTR_UID) && !chown_ok(inode, attr->ia_uid))
>  		return -EPERM;
>  
>  	/* Make sure caller can chgrp. */
> -	if ((ia_valid & ATTR_GID) &&
> -	    (!uid_eq(current_fsuid(), inode->i_uid) ||
> -	    (!in_group_p(attr->ia_gid) && !gid_eq(attr->ia_gid, inode->i_gid))) &&
> -	    !capable_wrt_inode_uidgid(inode, CAP_CHOWN))
> +	if ((ia_valid & ATTR_GID) && !chgrp_ok(inode, attr->ia_gid))
>  		return -EPERM;
>  
>  	/* Make sure a caller can chmod. */
