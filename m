Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-549093-1518798793-2-3003802309840411595
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518798793; b=YB+P3Ssos9b6v2/msx7ksHax5GYDp9+djV8hn9Q473gnXN7
    PfvyZXOV1DEGPlYbdFnb2WJb2L63hx1+xOOD/cXNcMC3iUNLTWXCRtJmKwF0wGQM
    rnqTx6tlxnYa5F/UBtE1c1+wzckI88YsA9E+kFakhP36xB1GyWyjN5YIi2sPBI/3
    cJ6ZA0ruPWWB1JOiyx15zrkwsMacws7G1roSUCCq+OC/SOZcsDLtJQ+pBRoKhrRP
    Iqt68Wmxk/XmO3hNFS3i+6oF3hZMMQM2NowHjmrcToiumRrcEMkJ/fcr94HkNegl
    poqDnFV+YP7oW8QKXwsAV6RMB3YpNsxPL9L8eqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518798793; bh=kT9dQKtRnKtX8xR8m02NvyVG6Q
    W+fYpJNeq6ZSUBkw8=; b=P0A0H31/Z3j0Z6tP2dqRRkzrEjVypDag36CgKKgzqJ
    tHcNqOI3CRqIIw17bWUDOqgc/AJT0Q0jNX3OQaiV9alBbhhTfv2dOsiuqvIVxeN3
    07R0sPYI5lsWGEBI97kTvOD3bCEyyT/NEdP8+BeFXX4f8R5IRBH2a/F22sXnrly0
    DaqpcsGdS04/fDcRYOMxl7Ml0sonkhMjKYZCwdMNTMqaqvIvLqMIabUVx09NHvrn
    aHfNAneuh/01iMVh2Lmq9LzGFwfnjVBbrrf5KLWSL7TmvVqEsVAwHfu4rzHVnJ6Y
    ng9cO6t8Gv8md3MEMVE+jlv+kVXt58/DoLIQTfGuJ4hg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032111AbeBPQc6 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 11:32:58 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52498 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031831AbeBPQc5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 11:32:57 -0500
Date: Fri, 16 Feb 2018 17:32:57 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>,
        Arve Hjonnevag <arve@android.com>,
        Greg Hackmann <ghackmann@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] staging: ashmem: Fix lockdep issue during llseek
Message-ID: <20180216163257.GA7752@kroah.com>
References: <20180213010125.174811-1-joelaf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213010125.174811-1-joelaf@google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 05:01:25PM -0800, Joel Fernandes wrote:
> ashmem_mutex create a chain of dependencies like so:
> 
> (1)
> mmap syscall ->
>   mmap_sem ->  (acquired)
>   ashmem_mmap
>   ashmem_mutex (try to acquire)
>   (block)
> 
> (2)
> llseek syscall ->
>   ashmem_llseek ->
>   ashmem_mutex ->  (acquired)
>   inode_lock ->
>   inode->i_rwsem (try to acquire)
>   (block)
> 
> (3)
> getdents ->
>   iterate_dir ->
>   inode_lock ->
>   inode->i_rwsem   (acquired)
>   copy_to_user ->
>   mmap_sem         (try to acquire)
> 
> There is a lock ordering created between mmap_sem and inode->i_rwsem
> causing a lockdep splat [2] during a syzcaller test, this patch fixes
> the issue by unlocking the mutex earlier. Functionally that's Ok since
> we don't need to protect vfs_llseek.
> 
> [1] https://patchwork.kernel.org/patch/10185031/
> [2] https://lkml.org/lkml/2018/1/10/48
> 
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Arve Hjonnevag <arve@android.com>
> Cc: Greg Hackmann <ghackmann@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+8ec30bb7bf1a981a2012@syzkaller.appspotmail.com
> Signed-off-by: Joel Fernandes <joelaf@google.com>
> ---
>  drivers/staging/android/ashmem.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

Please always properly version your patches, and put what changed below
the --- line, so I have a hint as to which patch to apply.
Documentation/SubmittingPatches has the full details of how to do this.

Can you resend me the "latest" version of this patch, so I have a chance
of getting it right?  :)

thanks,

greg k-h
