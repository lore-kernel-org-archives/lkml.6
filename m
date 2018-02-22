Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-175092-1519307314-2-12214674599678744520
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519307313; b=F48LZo0YMOo04vEs7QOV2PTdjcJVQf+nLECF6hI3zrkRc50
    wCX3MasRt5Phozcj9u54sFaRDPfMpWCQ+IuWFMo+hnNdQxp3laJtdV14rmIvTgYy
    WC6dbZ4XcWmRYKA+EbXYFNdceyBH4G/sNaojbZxZNLCWshtXlIA7rFnumVTPhCZw
    SSjFeXvf5OvdKi3YxPWmnG6eRVqxxfVun+xy+C9ucGdGJqtoa9JeunMYHGX1jPev
    VyTq19yNnQcTE1AoIqLmkQD+WGZhwfo7yumlsc78W1d71x+SXTgy/kTQwR9NnS1N
    DjKtS8GXw0XDild7/Zc3DggkR6qPw9n3/UrMwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519307313; bh=n1HtRBXa4k+zURa5N/bxP2AHSI
    oB5Mn23bInl3grk3s=; b=BsxglCBNk2aCF3lr0cNMxhOPHz33MhCfCn7j4R8RED
    mkwwvoXrCRdpDvkdldbopgCAXIuGCNhIGiXf2yOi/rvJnmEC3ju7hrOg2wbTxYyL
    k47e6IA3uWSFMoNNBL4ddXOfHb03NJXfy+S6sDOFcbuHwO++tFVhZEZYmlYCyWZQ
    KSHig4ZP4oFacQ2E5H5B3t7QgbDKlMXYbZWEAc33MTM3qTpg1RGbqPvXvjbUZxCU
    8JXRQ8EdWmZuvVoic2Ll+gXjOhia7V1PEgVxBGeTacHGpiGz+J3XIyUB5UazXnLb
    9TOoMoQzCuEySXFcZ64ZffNdrM1KXwRIKtg68/PgVwwA==
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
        id S932516AbeBVNsc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 08:48:32 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:58920 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932467AbeBVNsb (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 08:48:31 -0500
Date: Thu, 22 Feb 2018 14:48:32 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>,
        Arve Hjonnevag <arve@android.com>,
        Greg Hackmann <ghackmann@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] staging: android: ashmem: Fix lockdep issue during
 llseek
Message-ID: <20180222134832.GA1400@kroah.com>
References: <20180216190201.59572-1-joelaf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216190201.59572-1-joelaf@google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 11:02:01AM -0800, Joel Fernandes wrote:
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
> Changes since first version:
> Don't relock after vfs call since its not needed. Only reason we lock is
> to protect races with asma->file.
> https://patchwork.kernel.org/patch/10185031/

I'd like some acks from others before I take this patch.

Joel, did the original reporter say this patch solved their issue or
not?  For some reason I didn't think it worked properly...

thanks,

greg k-h
