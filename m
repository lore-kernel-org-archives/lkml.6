Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1080557-1519333394-2-10772428815453651753
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519333393; b=KYHuX+yhc529JREV/Ig0zl4koVHaODOq5VQ93uSk1ANgoS0
    W74sq3Ej194bqQMaenTPhM3WQD8JEvhVltl+OHhaU8XGX2fXc6HNVCMCNqfpddCi
    hwRSV7ZOYar5J2x3SYCUePlMHntWK8pOC/dvPQ38c2kcKAUzc1kt1f3rRO/1voaC
    lVx8S5TQFNYHohWF0ZhupMiyGXrN5xe67IKVcsZdqft/q1Swv61bGcu9bOVFkTNd
    Ml7wt0tkGWKqOB1e+cNO67WmpCbfwOoOm38gwf0Q7gQ+5K57eXkabS1vYIb+ZIeZ
    +abIINDBv58YVLSamIFh4cOmk1JXWKZnbZkSg9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519333393; bh=YXpjfyy/5Szcxgom5TVAYanhqcVcBDfDjDH02X
    f6Nr0=; b=A04E1LhkoM+5YfL7SNuG6fkI8rovhb+WbSwckV/1qyvez+bWIyAn2c
    b8yHD0vvHomIkdOMCRFsdgfzjC8SWIRF0eaMFTJlfbleozBFkfOBWBaZVO7U62SM
    3JZlle6PTbqLjC3kceHcbA64xEcv0i8gQkluQO4YQB1TKoSMNEwSFBfZ7zXM4lbR
    PksQ0Wo4H/C8RT5fqeDCvMUaYvUiQ58QPzCf/cWcOkm9rZo89QvTMb7bioEYYbD2
    km5V6cxFxcHgR6jPbDGEXs07/70Fr2CVXpwBOHGppC4qw22iSrbYHY8uxaOcxm+p
    TBD4dCw8l7TaY/0xf3gsv70rQueDB1hQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=aVW/UaUX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eWwccfwT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=aVW/UaUX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eWwccfwT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbeBVVDA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 16:03:00 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:33296 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbeBVVC7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 16:02:59 -0500
X-Google-Smtp-Source: AG47ELsNgIAt3SJqfC6Ns09mBflYRpdKAihMYJgM+Zo2d18hGX599P0UZ6LTBvFMSq1WIhWyUFUp9rCPt5vjtYiYs1o=
MIME-Version: 1.0
In-Reply-To: <20180222134832.GA1400@kroah.com>
References: <20180216190201.59572-1-joelaf@google.com> <20180222134832.GA1400@kroah.com>
From: Joel Fernandes <joelaf@google.com>
Date: Thu, 22 Feb 2018 13:02:57 -0800
Message-ID: <CAJWu+or6oK--zi6uDUipHY42wf79aVHo3WuZXXUvzR-7Atod4A@mail.gmail.com>
Subject: Re: [PATCH v2] staging: android: ashmem: Fix lockdep issue during llseek
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
        Arve Hjonnevag <arve@android.com>,
        Greg Hackmann <ghackmann@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

(reposting in plain text, sorry for the previous HTML email, I should
have not posted from the Phone)

On Thu, Feb 22, 2018 at 5:48 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Feb 16, 2018 at 11:02:01AM -0800, Joel Fernandes wrote:
>> ashmem_mutex create a chain of dependencies like so:
>>
>> (1)
>> mmap syscall ->
>>   mmap_sem ->  (acquired)
>>   ashmem_mmap
>>   ashmem_mutex (try to acquire)
>>   (block)
>>
>> (2)
>> llseek syscall ->
>>   ashmem_llseek ->
>>   ashmem_mutex ->  (acquired)
>>   inode_lock ->
>>   inode->i_rwsem (try to acquire)
>>   (block)
>>
>> (3)
>> getdents ->
>>   iterate_dir ->
>>   inode_lock ->
>>   inode->i_rwsem   (acquired)
>>   copy_to_user ->
>>   mmap_sem         (try to acquire)
>>
>> There is a lock ordering created between mmap_sem and inode->i_rwsem
>> causing a lockdep splat [2] during a syzcaller test, this patch fixes
>> the issue by unlocking the mutex earlier. Functionally that's Ok since
>> we don't need to protect vfs_llseek.
>>
>> [1] https://patchwork.kernel.org/patch/10185031/
>> [2] https://lkml.org/lkml/2018/1/10/48
>>
>> Cc: Todd Kjos <tkjos@google.com>
>> Cc: Arve Hjonnevag <arve@android.com>
>> Cc: Greg Hackmann <ghackmann@google.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: stable@vger.kernel.org
>> Reported-by: syzbot+8ec30bb7bf1a981a2012@syzkaller.appspotmail.com
>> Signed-off-by: Joel Fernandes <joelaf@google.com>
>> ---
>> Changes since first version:
>> Don't relock after vfs call since its not needed. Only reason we lock is
>> to protect races with asma->file.
>> https://patchwork.kernel.org/patch/10185031/
>
> I'd like some acks from others before I take this patch.

GregH, Todd, could you provide Acks?

>
> Joel, did the original reporter say this patch solved their issue or
> not?  For some reason I didn't think it worked properly...

That's a different but similar issue:
https://patchwork.kernel.org/patch/10202127/. That was related to
RECLAIM_FS lockdep recursion. That was posted as an RFC unlike this
one, and its still being investigated since Miles reported that the
lockdep inode annotation doesn't fix the issue.

This one on the other hand has a straightforward fix, and was verified
by the syzbot.

I can see why its easy to confuse the two issues.

Thanks,

- Joel
