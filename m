Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3887703-1521234745-2-16324517175861127251
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521234745; b=ILnSa7SORDWfO700YtVP06L9b9efU/swgaj2+w0HzxUJkRv
    ryfoytaAVsvad7tfUYrN51XmjleMnZQ92mMss8qa1k41LMd47yMosUO0FPcmtrsR
    pyjFV7hsjrbKVYQs8BquKOItBnT0OIxTtl1zSOnhF6pRYcBisiuCILFD9nvAqdRi
    iP+ZeiJPXMs+KuVQCWAKbbyntsW8h3gloM8onAy+jv3yuAreDUFbCdbopKgiLUO7
    D1hG0jWGhSCB+d2saoHgwvA0Q2iPmPTyGShmBUFSV+EyT54n/ZFo+RDPmmAAY5a9
    zHL4DDaydxiB6LqxPGaM3S7rqWxujprP1mVIEwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521234745; bh=wXOi0gXj4FsZCOnHBY+O14gV3Or3eDjFcmf31LjZ098=; b=a
    hOFSZXF6j0uqn1FBqLQvWLx9VZ55MNDafw7rujnOqDfFUnNliLFPk/lsrONhIJtV
    QTD+nk10HpOY73tiygGMvWC4AtibH7g/poQvYqc7yYErOS7tzBZqBAwr9Xn+IU1U
    QxJK9brc5n0+Numwd4lT/PIAxbn9UVDb2Juexzmth55G6yEZaCep/TPoJj9IE8d2
    4EjvkSFDgX/mxjBfZKqgcLhn+DFSYQSHI2aUGOGcRqweCMFd3wGCsxGMCk7rcTEc
    O4EuCAIvmkwUdwgrtMqv2CIAExfTXUJTOkitz5rSOEcJ5UZJE1q0TMckcTe6hgAz
    YFgq6HVVKSm9gphFpViMg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751562AbeCPVMX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 17:12:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37734 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbeCPVMX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 17:12:23 -0400
Date: Fri, 16 Mar 2018 14:12:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: jglisse@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>, stable@vger.kernel.org,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 03/14] mm/hmm: HMM should have a callback before MM is
 destroyed v2
Message-Id: <20180316141221.f2b622630de3f1da51a5c105@linux-foundation.org>
In-Reply-To: <20180316191414.3223-4-jglisse@redhat.com>
References: <20180316191414.3223-1-jglisse@redhat.com>
        <20180316191414.3223-4-jglisse@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 16 Mar 2018 15:14:08 -0400 jglisse@redhat.com wrote:

> The hmm_mirror_register() function registers a callback for when
> the CPU pagetable is modified. Normally, the device driver will
> call hmm_mirror_unregister() when the process using the device is
> finished. However, if the process exits uncleanly, the struct_mm
> can be destroyed with no warning to the device driver.

Again, what are the user-visible effects of the bug?  Such info is
needed when others review our request for a -stable backport.  And the
many people who review -stable patches for integration into their own
kernel trees will want to understand the benefit of the patch to their
users.
