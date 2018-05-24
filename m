Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2162938-1527177469-2-4852886534420390278
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527177468; b=Q87ctbXHchiZKzAGaF/DmKH27boBb5Y/GIl0gVQzqsAn24xAn5
    iWR6wslPWZb/gUwowxj6jDeKrC3MxqgzmOWGpuW9VRfo245jbvRlT4dQdQfk+9NC
    7pqMuYcstxqZnqc21K+MgD526e6onECojIz9UZAWNHCQposIlFBCQb2neNjHhWxM
    Nwofnz79QODsfwhuj7IgAUWgKeL2lCvTqUrXxPtPTkgLUQVlqkisUw265B57Ooqq
    Hp7fIOeXtIFlzG0HQJf1MgsK2v34tWgjk8RMhm5IvnnAGZP5hSClbxTfvYsV4ImS
    FPUekYzQE+2q9GIxLChyJ0drJ+8hOXVnpo/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527177468; bh=pcQUr/iViOnwxwkPpkdCOtY6Xh/gVF
    IvhuE72A6E63M=; b=PqxHK0Njd9nUsOXvX26xL22eZVYOzzrNwXoY9zoXrW/bA+
    cyleF5gTU/jl4hS/DqoRJwAOqDezaQm1WN1M7JOua31z5LlfeheHUnqevBNUl9Nt
    SIXDdIS/1wB57qi6fkx7W43FEVDXWBESK12eoNCKTR1kBmrG2DalPtHxKFXHOcNq
    kzDcDL047WWwqHXpiHattVLykXIVhuycj08YWNVu2a+kkspidFh8zbKF3oNKIGpu
    V47Zsb2VeLLsGBQmpWJhr4dqpLTjAynB3eyKRC7Oi75OH/j1W2smmCPt1UJ/tlui
    86/Iy2j9OMED0S0qeTMaorQz4RDqseTNtcTN1ksg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfKn9g/tHoYLeHOtQVb1ymrr2nuT93Y4Z+Q4VEH8fifOG8ep+4DPKZ69Pc3F+1hDcCqVyoySKskA1/KkWFyG7VhCW2U2teTVuAD2aY+E6CImZwWRYv+SU
    oSp+Lnp4qWF3P3mNmn4bwiHMyJECChOORi0YpnKJJDtZ2/+kePu4GNn2kcvEKlbJMNVvDGHAXzF1GNysdGf1s6gYj4rfTSaQAopdq4cnBiK8KltHUXYecXMo
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=DfNHnWVPAAAA:8 a=hBqU3vQJAAAA:8 a=PtDNVHqPAAAA:8 a=FVvala7CVJ9v9CD1HSAA:9
    a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22 a=WLjMIN4s_96MqnBbPenP:22
    a=BpimnaHY1jUKGyF_4-AF:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970988AbeEXP5o (ORCPT <rfc822;linux@kroah.com>);
        Thu, 24 May 2018 11:57:44 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:27686 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970986AbeEXP5n (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 May 2018 11:57:43 -0400
Date: Thu, 24 May 2018 17:57:37 +0200
From: Christian Brauner <christian@brauner.io>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org
Subject: Re: [REVIEW][PATCH 5/6] capabilities: Allow privileged user in
 s_user_ns to set security.* xattrs
Message-ID: <20180524155737.GA19932@mailbox.org>
References: <87o9h6554f.fsf@xmission.com>
 <20180523232538.4880-5-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180523232538.4880-5-ebiederm@xmission.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 06:25:37PM -0500, Eric W. Biederman wrote:
> A privileged user in s_user_ns will generally have the ability to
> manipulate the backing store and insert security.* xattrs into
> the filesystem directly. Therefore the kernel must be prepared to
> handle these xattrs from unprivileged mounts, and it makes little
> sense for commoncap to prevent writing these xattrs to the
> filesystem. The capability and LSM code have already been updated
> to appropriately handle xattrs from unprivileged mounts, so it
> is safe to loosen this restriction on setting xattrs.
> 
> The exception to this logic is that writing xattrs to a mounted
> filesystem may also cause the LSM inode_post_setxattr or
> inode_setsecurity callbacks to be invoked. SELinux will deny the
> xattr update by virtue of applying mountpoint labeling to
> unprivileged userns mounts, and Smack will deny the writes for
> any user without global CAP_MAC_ADMIN, so loosening the
> capability check in commoncap is safe in this respect as well.

Acked-by: Christian Brauner <christian@brauner.io>

> 
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> Acked-by: Serge Hallyn <serge.hallyn@canonical.com>

Note, I just talked to Serge. This should be Acked-by: Serge Hallyn <serge@hallyn.com>

> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  security/commoncap.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 1ce701fcb3f3..f4c33abd9959 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -919,6 +919,8 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>  int cap_inode_setxattr(struct dentry *dentry, const char *name,
>  		       const void *value, size_t size, int flags)
>  {
> +	struct user_namespace *user_ns = dentry->d_sb->s_user_ns;
> +
>  	/* Ignore non-security xattrs */
>  	if (strncmp(name, XATTR_SECURITY_PREFIX,
>  			sizeof(XATTR_SECURITY_PREFIX) - 1) != 0)
> @@ -931,7 +933,7 @@ int cap_inode_setxattr(struct dentry *dentry, const char *name,
>  	if (strcmp(name, XATTR_NAME_CAPS) == 0)
>  		return 0;
>  
> -	if (!capable(CAP_SYS_ADMIN))
> +	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
>  		return -EPERM;
>  	return 0;
>  }
> @@ -949,6 +951,8 @@ int cap_inode_setxattr(struct dentry *dentry, const char *name,
>   */
>  int cap_inode_removexattr(struct dentry *dentry, const char *name)
>  {
> +	struct user_namespace *user_ns = dentry->d_sb->s_user_ns;
> +
>  	/* Ignore non-security xattrs */
>  	if (strncmp(name, XATTR_SECURITY_PREFIX,
>  			sizeof(XATTR_SECURITY_PREFIX) - 1) != 0)
> @@ -964,7 +968,7 @@ int cap_inode_removexattr(struct dentry *dentry, const char *name)
>  		return 0;
>  	}
>  
> -	if (!capable(CAP_SYS_ADMIN))
> +	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
>  		return -EPERM;
>  	return 0;
>  }
> -- 
> 2.14.1
> 
