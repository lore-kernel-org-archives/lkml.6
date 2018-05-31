Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1650533-1527781190-2-7589438806695450570
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527781190; b=Y+2rWfqCeIXU+6aqvunHTHsCMnugrt17hO1figa/CalsrjwTgu
    QXRjrj/5i1wtk8Qjegpl6CYpre9ICAjKdSDIgyciAQCpvS/UQ+RTNZ1HtcqxaD6f
    KECXRg1UvQ+RzwU7YvlykHnC97Xt6LnhzhZU/AhWmiQ0be7Kbn1YU9spWYMz3Z32
    1q0OraSpeo0QZYyGHdQ0UdOWwFOiTZnj1msQWPkYYyekeTT1qU//R6T7gSfTkS4U
    plZZ00jbqpPlXisnUeizFdck76WuRgOY1lLPDEq7f4jnbYEMS8j1rFIxDTjWanYW
    UjKi0ZTJXRTbUy8EY4RuY0EtCa0Bpw+Ed7xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527781190; bh=sVenU82p1rcJey97SthTDMKU3+NSic
    i0gA4bZtJDMgQ=; b=KWMMsBSpFj6dblldIlFgjuk88yEyxZtOAFT8UInKSXl7yC
    bVAekIv7cMZMu4YZWw6oyGR44ELh86pcBbp8EiLxw7z+9Ax2brGju7FEhVwI8jWt
    wOWbiOn8lfUshSC3fPVPQyBwcMrNf3ObAZzed35sOBJCS9KPPAOh41Mn0ZJiY4kE
    /JokXoD+dPQIrlhEOtFP57iEFZYYERcwiZpZ7GZrhCBLkJ5vShRAZzQGIv1gsRAs
    MRLDWsARHPjnc11MJ6XzF4Itmmqipfr7/U09DsvSs0GZJKuIZFT8XnJWOxAzkQv5
    7Tb+d3TG1FRwSdRFnlLN9XlAJl3xKvJHIh/D63XQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=BX1H14mr
    header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=TCFl3it3;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=BX1H14mr
      header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=TCFl3it3;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMof+wlOthnI9amLiQEVe+g80elWsa6qqIPhM76jC23JbfpnJd1z7SSHhJABrCe7Ri8G3w4op/EtdcikOF01f/jYyC85fB/A2SCS1dyJswjyMdGa8zYg
    Z/NOQCqnVoXmgQ7ggT/5EzIFtxqG46vKin8PurLG5OEbrKeQ5nZYVnNzMkyfHSkzOOPlBCvkTHMovFm7dR9cK5CssVAmyyZtcoJ64H+Z7pplgk55lfxGFclH
    ppC84ZvTmNuTq961uH+ycQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=KhmTcX5AaoMSY4qCriMA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755443AbeEaPjs (ORCPT <rfc822;linux@kroah.com>);
        Thu, 31 May 2018 11:39:48 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:42355 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755417AbeEaPjr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 May 2018 11:39:47 -0400
X-Google-Smtp-Source: ADUXVKKFhWWRtbs7Yo5TcKmL2LdoHQMyWCkqq4flApZ8JnJOok050f2+yInHTC5ZntkXhEWdgW/urw==
Date: Thu, 31 May 2018 08:39:43 -0700
From: Tejun Heo <tj@kernel.org>
To: CHANDAN VN <chandan.vn@samsung.com>
Cc: gregkh@linuxfoundation.org, bfields@fieldses.org,
        jlayton@kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, casey@schaufler-ca.com,
        cpgs@samsung.com, sireesha.t@samsung.com,
        Chris Wright <chrisw@sous-sol.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/1] Fix memory leak in kernfs_security_xattr_set and
 kernfs_security_xattr_set
Message-ID: <20180531153943.GR1351649@devbig577.frc2.facebook.com>
References: <CGME20180531092848epcas1p24b638ccd6da00f1e039bdb64de7e1a5b@epcas1p2.samsung.com>
 <1527758911-18610-1-git-send-email-chandan.vn@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527758911-18610-1-git-send-email-chandan.vn@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

(cc'ing more security folks and copying whole body)

So, I'm sure the patch fixes the memory leak but API wise it looks
super confusing.  Can security folks chime in here?  Is this the right
fix?

Thanks.

On Thu, May 31, 2018 at 02:58:31PM +0530, CHANDAN VN wrote:
> From: "sireesha.t" <sireesha.t@samsung.com>
> 
> Leak is caused because smack_inode_getsecurity() is allocating memory
> using kstrdup(). Though the security_release_secctx() is called, it
> would not free the allocated memory. Calling security_release_secctx is
> not relevant for this scenario as inode_getsecurity() does not provide a
> "secctx".
> 
> Similar fix has been mainlined:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=57e7ba04d422c3d41c8426380303ec9b7533ded9
> 
> The fix is to replace the security_release_secctx() with a kfree()
> 
> Below is the KMEMLEAK dump:
> unreferenced object 0xffffffc025e11c80 (size 64):
>   comm "systemd-tmpfile", pid 2452, jiffies 4294894464 (age 235587.492s)
>   hex dump (first 32 bytes):
>     53 79 73 74 65 6d 3a 3a 53 68 61 72 65 64 00 00  System::Shared..
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffff80081be770>] __save_stack_trace+0x28/0x34
>     [<ffffff80081bedb8>] create_object+0x130/0x25c
>     [<ffffff80088c82f8>] kmemleak_alloc+0x30/0x5c
>     [<ffffff80081b3ef0>] __kmalloc_track_caller+0x1cc/0x2a8
>     [<ffffff800818673c>] kstrdup+0x3c/0x6c
>     [<ffffff80082d78b0>] smack_inode_getsecurity+0xcc/0xec
>     [<ffffff80082d78f4>] smack_inode_getsecctx+0x24/0x44
>     [<ffffff80082d5ea0>] security_inode_getsecctx+0x50/0x70
>     [<ffffff800823bbcc>] kernfs_security_xattr_set+0x74/0xe0
>     [<ffffff80081eafec>] __vfs_setxattr+0x74/0x90
>     [<ffffff80081eb088>] __vfs_setxattr_noperm+0x80/0x1ac
>     [<ffffff80081eb238>] vfs_setxattr+0x84/0xac
>     [<ffffff80081eb374>] setxattr+0x114/0x178
>     [<ffffff80081eb44c>] path_setxattr+0x74/0xb8
>     [<ffffff80081ebdcc>] SyS_lsetxattr+0x10/0x1c
>     [<ffffff800808310c>] __sys_trace_return+0x0/0x4
> 
> Signed-off-by: sireesha.t <sireesha.t@samsung.com>
> Signed-off-by: CHANDAN VN <chandan.vn@samsung.com>
> ---
>  fs/kernfs/inode.c | 3 ++-
>  fs/nfsd/nfs4xdr.c | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index a343039..53befb8 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -369,7 +369,8 @@ static int kernfs_security_xattr_set(const struct xattr_handler *handler,
>  	mutex_unlock(&kernfs_mutex);
>  
>  	if (secdata)
> -		security_release_secctx(secdata, secdata_len);
> +		kfree(secdata);
> +
>  	return error;
>  }
>  
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index aaa88c1..1e0dbe9 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2911,7 +2911,7 @@ static int get_parent_attributes(struct svc_export *exp, struct kstat *stat)
>  out:
>  #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>  	if (context)
> -		security_release_secctx(context, contextlen);
> +		kfree(context);
>  #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
>  	kfree(acl);
>  	if (tempfh) {
> -- 
> 1.9.1
> 

-- 
tejun
