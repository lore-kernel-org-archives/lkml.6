Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-174305-1526064875-5-4268850204019590418
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526064875; b=fvd6NCB+VbYFP3Y5WQ1e2rfnptCfiYGadjvUUewi1TpRDvRtU3
    sdZDTg//YWcEq6sGIDAoCFxXE5cEUwjiMZg6YhpubXqixX2iH1zKEuSecoEeQn1I
    qrdWGWLYvjZZjj3bSOMoFGVDKsYQy/0zJz9BthjWPtL7XaPdHjxpSmhU7k8azJw3
    FcjHYnh+Z9DqNAxbFzgwW+n+Fg7C6dT0qCy6t89iCWlIdw+VVCMMwrAHRKBLmHpA
    wZD/SHve8+x117uE8iNnx5krhgvuzJSKADInvXBmQ2ioWd25YccK83QZnzRnZ6qn
    Rksm/Cow42r5mC6B73in/J/MuBZVTfkr707Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526064875; bh=2efnxt77BmhcJMGHU4y13/Y2Dhbk0B
    lhqJ72134UbSM=; b=USz9rQdoHxaKH+1NzfkgCKOPZsoecv+DLlsyrIOAvE85j+
    NQ2aOpi4M2GYVFvtMSurKxr2+KWXYcR88wHJeXGP54mXOXPEBW9hkfqtk7zQT0o6
    dUUPgHejrdCN1+SToRaJdkwAwjtKlVAIEvxl5CO7uFGcdgtomk6b7d/4SwP/aH7E
    8wz2aMeJE82zK/vvNQepvhuUCuK7lunesOXT92oC8YYhGpfv/At87qG4B5xm7VG9
    j2RphlJWH42oZkODz6oEQMF8R+2ATi8du5LZ17V/NALxdZ5HctZ7pz2S4J9X/0VM
    nlJa6fpCvXINvyz+Vpvk6QxE5lQBY9Ud9dgfYcRA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJPs+ZwtcmwahAM7DqSO0uj+dimDJJIvl/yDxqeohRbn9TU7jcngdtMr4GdRWhQZgwrqvVpqyiM7VF9HOnJXZJmT4X6ry0O7W/Dyyej0rBikHWRwIROW
    1EKLeFJgpLdR6GIhup3o57ZPaPuEM37ttayU2seihuaDRB4kGfwJSS9zA/VILBbEOPIyzXXJXXfCI5bblrHSzJn6Ur4+zfV52u0t2N8Lg8w97PHf756wLqU5
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=9c5tj4TsTwd62wWh5a0A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeEKSyd (ORCPT <rfc822;linux@kroah.com>);
        Fri, 11 May 2018 14:54:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751400AbeEKSyc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 May 2018 14:54:32 -0400
Date: Fri, 11 May 2018 14:54:30 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org,
        Daniel J Walsh <dwalsh@redhat.com>,
        Paul Moore <pmoore@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v2 22/35] vfs: don't open real
Message-ID: <20180511185430.GE6044@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
 <20180507083807.28792-23-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507083807.28792-23-mszeredi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 10:37:54AM +0200, Miklos Szeredi wrote:
> Let overlayfs do its thing when opening a file.
> 
> This enables stacking and fixes the corner case when a file is opened for
> read, modified through a writable open, and data is read from the read-only
> file.  After this patch the read-only open will not return stale data even
> in this case.

[CC Dan, Steven, Paul, linux-security-module list]

Hi Miklos,

I was running selinux-testsuite and one of the tests seems to fail. I
think this is side effect of installing overlay inode in file->f_inode
instead of real underlying inode.

Following test is failing.

sub test_90_1 {
    print "Attempting to enter domain with bad entrypoint, should fail.\n";
    $result = system(
"runcon -t test_overlay_client_t -l s0:c10,c20 $basedir/container1/merged/badentrypoint >/dev/null 2>&1"
    );
    ok($result);
    return;
}

Basically, this test has an executable named "badentrypoint" with selinux
label "unconfined_u:object_r:test_overlay_files_ro_t:s0". And we mount
overlay with context=unconfined_u:object_r:test_overlay_files_rwx_t:s0:c10,c20

So effectively overlay inode of "badentrypoint" now gets the label
specified by "context=".

I think intent of test is that this file's real label is "...ro_t". That
means this file is not supposed to be executed and any attempt to execute
it should be denied.

Currently test works and execution fails with following avc.

AVC avc:  denied  { entrypoint } for  pid=1425 comm="runcon" path="/root/git/selinux-testsuite/tests/overlay/container1/merged/badentrypoint" dev="dm-0" ino=34515261 scontext=unconfined_u:unconfined_r:test_overlay_client_t:s0:c10,c20 tcontext=unconfined_u:object_r:test_overlay_files_ro_t:s0 tclass=file permissive=0

But with new patches, this test starts passing. 

I think currently selinux_bprm_set_creds() returns error. It does
checks on inode returned by file_inode() and as of now that inode is
real inode and that inode has real lable of "...ro_t" and permission
to execute that file is denied.

But after the patches file_inode() returns overlay inode. Which has
the label specified by context= mount option "...rwx_t". And that
label allows executing file, so file execution is not blocked by
selinux.

I feel that even now code is working accidently. Ideally our theme was
that task's credential as checked against overlay inode and mounter's
creds are checked against underlying inode to determine if certain
permission is allowed. So ideally mounter should not have been allwed
to execute a file of type "...ro_t". But we don't have that workflow
and VFS calls into selinux and selinux checks the underlying file's
label against task.

It worked so far but the moment we install overlay inode in file, selinux
checks it against overlay inode label and allows permission to execute and
mounter is never checked against real inode.

I am not sure what's the right solution. So far selinux is not aware of
two levels of checks and if two levels of checks are to be performed, it
somehow needs to be enforced by overlay and call same hook on two levels.

Thought of atleast starting a conversation on this.

Thanks
Vivek


> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/open.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 6e52fd6fea7c..244cd2ecfefd 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -897,13 +897,8 @@ EXPORT_SYMBOL(file_path);
>  int vfs_open(const struct path *path, struct file *file,
>  	     const struct cred *cred)
>  {
> -	struct dentry *dentry = d_real(path->dentry, NULL, file->f_flags, 0);
> -
> -	if (IS_ERR(dentry))
> -		return PTR_ERR(dentry);
> -
>  	file->f_path = *path;
> -	return do_dentry_open(file, d_backing_inode(dentry), NULL, cred);
> +	return do_dentry_open(file, d_backing_inode(path->dentry), NULL, cred);
>  }
>  
>  /**
> -- 
> 2.14.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-unionfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
