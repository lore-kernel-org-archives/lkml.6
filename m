Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1156137-1517923951-2-5155361871809358933
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517923951; b=pffZDSzlss2UOBXtyyHSDnERZqyOcWGzm5ngutBKCALfhEe
    vm3ICLuA2qbvwj63VMDYP4nwwz96JJF4P/FeO0qDzo7a5eZjeXfRRaKk4e0x4i+e
    Sp+AUOULPOKMEEeVGzHVSWFvkqHrt5+cHqNqMz9OaGTiaHU5d2VVRtbfh5e5Doeo
    wZp0hee5x0dkN+DEnReL8h2OeCxraw3bpSJ8eRu365ygdW6sfQQjCUST7+CVySu/
    W55lkb0Y50Zpn5jv1f8Q83LrZPXUNR1jtHc4P0nbR8K9npys4y1+eKhe1b3I0JlM
    mZXARnl3OqcsPao//NfMIaOt8+CeGYhLjs9KxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517923951; bh=mW43LSy3Cr1Ns+szL59WoLgIT4
    SPYWXxOESZZqiHFlM=; b=SYg1zus6A0cJqaKWkRrVBKqI5sAKJzh3uqy8vfHJny
    bQiKc9QgyPs5EyOWySeAJS1lLZpkq7qI3/UbbUvwaT3ABAk8kzLmmI8eQIGn67o4
    YMunLronFhxqH3fXmB8DYc3yeNr+RgEJgYaNrv41LGjfxnm1yqit0dz8rc09fSm2
    6AkjAG4mEAdJrMUnt2pBsYu7aWOHKcRU0AeTrrkYY6+cUYWDtOW+oZhJTCXgGwVN
    YjPoyMlA/TxJtcpB/WwaobkuT0nOPGz5B9fJT40OYQdbxFMrLQ8eyuD933Zci0Ua
    QQuWazyLP864hw2zqTQYAMmbMX+SeX+fxQXPhoL7fNGw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=dUkUuU4F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mit.edu header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=dUkUuU4F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mit.edu header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeBFNcQ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 08:32:16 -0500
Received: from imap.thunk.org ([74.207.234.97]:41772 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751084AbeBFNcP (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Feb 2018 08:32:15 -0500
Date: Tue, 6 Feb 2018 08:32:09 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Jin Qian <jinqian@android.com>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jin Qian <jinqian@google.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] ext4: don't put symlink in pagecache into highmem
Message-ID: <20180206133209.GD17801@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Jin Qian <jinqian@android.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jin Qian <jinqian@google.com>,
        stable@vger.kernel.org
References: <20180205195739.9654-1-jinqian@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205195739.9654-1-jinqian@android.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 05, 2018 at 11:57:39AM -0800, Jin Qian wrote:
> From: Jin Qian <jinqian@google.com>
> 
> partial backport of 21fc61c73c3903c4c312d0802da01ec2b323d174.

Hi Jin,

When you do a partial backport like this, it would be helpful you
could indicate which kernel version(s) it is meant for, since there
are many stable kernel trees.

Thanks!!

						- Ted
