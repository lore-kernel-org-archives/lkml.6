Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2343747-1528187609-2-5534354554669739803
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528187609; b=BUnxNaaD2Deg+Femb8IAHyLDx1Q5EX5MdhN354kdti6MkNdj0C
    83CdiR5o1T6rwtFfvWcm3aLwcBz2oHFkCNoJgwOrBR9c83C8O87Mwt0vhPHL91Ox
    9C2iVh0cWwim0oZg7xMjE0JBir5Vij+bIq5dBm4W6th4r1CdK6txFc78dfCRs+UQ
    6bBHxtBmoU6v1NQd/ogsvznc0hZ8j9V93pNNxAR3TBLDsivCou7uSqWfJVgzIET0
    W/wpAC2D0Lk7XUlyG5nnNFw5GNlHE26ix5hWS4s7dK5Um1aTvZi+3nAxRrwH1Nd1
    Q7l4WVXSRT87tuwL8iRVB3YrKRXoN9W8sTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1528187609; bh=SHDpLKeFIJ7qtdKCkGNkyfSm7WzA+sE5efb9AeASOI
    g=; b=TlK9mgk6l8szpzSThGJsku6ZP16jVX18/mHZrXh/ACow0gIhkD53KgtOVJ
    Q+mBMzWzQzecfUCEJPXRQJTw7gYS3aHIepSYBnbxFUIm0I0APVahhrbhqe5j17vx
    hynMwsGL40naGjB5FTz/KJGNHaQHSpQwkZeKJLI7Bdpz/DSW3JgCoZbk1tcSs6Pc
    M+JwHmxjb5+TMNFSjBkGfj5YwBkJbY4wN5sgrWCU/JashHaIUToRk7VaHW6LAp61
    k78CmkSokFpxdo9TD/Kt3Zm3SBQV6t8FswHvi3z0dcNxwk1oFJPwc+RlODAimn/Q
    jnujtvegXOyzo2+uAlcKSxk5zqdw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256)
    header.d=szeredi.hu header.i=@szeredi.hu header.b=N8WfN+dk
    header.a=-sha256 header.s=google x-bits=0;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=szeredi.hu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=mmA0YhOg;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=szeredi.hu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256)
      header.d=szeredi.hu header.i=@szeredi.hu header.b=N8WfN+dk
      header.a=-sha256 header.s=google x-bits=0;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=szeredi.hu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=mmA0YhOg;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=szeredi.hu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCWG5915u2qk7MNc9GFUjkbIBM9OYYi3Y6rF5c2ypHNqsW6QR4YlqbhyntDWeUnfkj6pXjba8strF9ua527NYLHL8uDfW3C8PwNU0EkE81Ym8xSkwoQY
    V0cUvCJREvTqTpkkYfPshVpXjaQgKgTUHkZMaXDV3YzbLz7BsdUd0oBCh4dEonJ+tuZ920Rs0mwOXDp1jpaw+/2zV4ma8W8JRu0GUCSpqBuKfXj8wfLB64Tq
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7YwWrYXYVYkA:10 a=IkcTkHD0fZMA:10
    a=7mUfYlMuFuIA:10 a=JfrnYn6hAAAA:8 a=ysCgGKDoOMug-1dScowA:9
    a=sL4KLnzntop5yC0K:21 a=gDL5rZPKVQytuoqp:21 a=QEXdDO2ut3YA:10
    a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeFEIdZ (ORCPT <rfc822;linux@kroah.com>);
        Tue, 5 Jun 2018 04:33:25 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:45201 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbeFEIdX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:33:23 -0400
X-Google-Smtp-Source: ADUXVKIagKii9tscdOFlvj/4gRMricMYePmlJDKXwUsSHL7wnmcC7bmYtXhfvM/bn2bM6Bl/W+zxM1fzlimpCjA4PnI=
MIME-Version: 1.0
X-Originating-IP: [194.176.227.33]
In-Reply-To: <20180604084336.GA11333@infradead.org>
References: <20180529144339.16538-1-mszeredi@redhat.com> <20180529144339.16538-2-mszeredi@redhat.com>
 <20180604084336.GA11333@infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Jun 2018 10:33:22 +0200
Message-ID: <CAJfpegun8HyjODXguHstxYrGE2nuSoCCicaHT3yfYWMkxxmVWg@mail.gmail.com>
Subject: Re: [PATCH 01/39] vfs: dedpue: return loff_t
To: Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Jun 4, 2018 at 10:43 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, May 29, 2018 at 04:43:01PM +0200, Miklos Szeredi wrote:
>> f_op->dedupe_file_range() gets a u64 length to dedup and returns an ssize_t
>> actual length deduped.  This breaks badly on 32bit archs since the returned
>> length will be truncated and possibly overflow into the sign bit (xfs and
>> ocfs2 are affected, btrfs limits actual length to 16MiB).
>
> Can we just make it return 0 vs errno?  The only time we return
> a different length than the one passed in is due to the btrfs cap.
>
> Given that this API started out on btrfs we should just do the cap
> everywhere to not confuse userspace.

And that's a completely arbitrary cap; sure btrfs started out with
that, but there's no fundamental reason for that becoming the global
limit.  Xfs now added a different, larger limit, so based on what
reason should that limit be reduced?

I don't care either way, but at this stage I'm not going to change
this patch, unless there's a very good reason to do so, because if I
do someone will come and suggest another improvement, ad-infinitum...

Thanks,
Miklos
