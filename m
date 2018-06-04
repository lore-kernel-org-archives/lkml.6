Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1547173-1528102639-2-11506237368889747299
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528102638; b=FxgqTdmhknXwZ0/eSayVRCVDxY/jmzK+bQecjv4tKz6NPepGel
    Dwfa6TccUihx4jlwLTiNr5COnSfSDmASsUOOw5tHAWxnAvwxu5j+KeXJNx26CCDk
    k0K5oE5w9n+E93fXh77ByR5u60iWeXIy3oX1o33XHMkRYKfX2gRHlniRengI2Xac
    ho2D14C4maYsyLtk35mExj9pqrfkqgaxexYUc4ZQ+Z63o3O9jMcWTMkh7S6NV/ZS
    aFKLNXaerlHMF0hpxY0aDj8SAZ2dZ1T2xN+eJg8WC3ymKEqhbiPb0ZTeqyhu6LGg
    9nV3vgn+zRs8f+U2IoI2UFWHKmTCU7BaFwLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1528102638; bh=us+KxjIOeLG5h+/EwpYsXJSD5Mxz+9CyTN0Uetkmxl
    E=; b=Rl4iTWTCe9PXTPVkKLdDHAPUszWKXqd9KJfxTbO3PzAdkuzuijLP7eToei
    4fBVuL0qCtleEqUEPO0AulIwUnc8psDkWd/aC94yfhI5nNP/Ky5QUIx/ctel20Kn
    gbwLgcRlRAX5c0MszzVFkLztM9nAhW/mvWzGkUZYWUaiJ1/rbKE/kRE3F6V3kwv7
    sXw5KbnUD0TSuts4zwqY9LRo6Bd/KBK9cmxQ2vscMcua4lodtiMhr9yvfg+zePob
    fUfLgVJkJvs+mVwYPrTehe3PXcCTjZZKPozNVxsQI6dKol1Z+W4xy0UxZAlOGKhg
    HNooyWU/3swWI7V9zzO0WgVoIORA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256)
    header.d=szeredi.hu header.i=@szeredi.hu header.b=Ibrt12LT
    header.a=-sha256 header.s=google x-bits=0;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=szeredi.hu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=l18Z2C8W;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=szeredi.hu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256)
      header.d=szeredi.hu header.i=@szeredi.hu header.b=Ibrt12LT
      header.a=-sha256 header.s=google x-bits=0;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=szeredi.hu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=l18Z2C8W;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=szeredi.hu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHrnbdbRdP9eiAho1/swuBIlOlrzfMuHoK1WGr6kdqpArZu3KxP7MKKq7LmK1aveSiSP1Q04NS08fx7GtVvsxvG35AvcDDHDkmkIVKvP5GmsqvhnKMH6
    BssLh653KvvHsq8Bv7gIV+/9MuTINxTR6qHD7xa3TRsa/Fu6IWrcY/Z9yVj1UFfHJ6Tc9MVfhNS0svuAtoCj63Ck++Y7G3KQw9i64nAo87WRz++LGOraiq/N
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7YwWrYXYVYkA:10 a=IkcTkHD0fZMA:10
    a=7mUfYlMuFuIA:10 a=JfrnYn6hAAAA:8 a=UhJdpEXFCaxYSY8GN1oA:9 a=QEXdDO2ut3YA:10
    a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbeFDI5P (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 04:57:15 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:38577 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbeFDI5O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:57:14 -0400
X-Google-Smtp-Source: ADUXVKJr1VUqDeIQaXLFCgIocIuHg0GJg1/wzbDpLH5uz4/p1f1uIUxZb+FwTePj8KrT4Gd5Wc8a5G3gd2JwGiMd3Ps=
MIME-Version: 1.0
X-Originating-IP: [194.176.227.33]
In-Reply-To: <20180604084739.GD11333@infradead.org>
References: <20180529144339.16538-1-mszeredi@redhat.com> <20180529144339.16538-6-mszeredi@redhat.com>
 <20180604084739.GD11333@infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 4 Jun 2018 10:57:13 +0200
Message-ID: <CAJfpegvRWUBRUNidw7QjVL1NfaoR9O80QUW3SrTevp8isWBtpA@mail.gmail.com>
Subject: Re: [PATCH 05/39] vfs: optionally don't account file in nr_files
To: Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Jun 4, 2018 at 10:47 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, May 29, 2018 at 04:43:05PM +0200, Miklos Szeredi wrote:
>> Stacking file operations in overlay will store an extra open file for each
>> overlay file opened.
>>
>> The overhead is just that of "struct file" which is about 256bytes, because
>> overlay already pins an extra dentry and inode when the file is open, which
>> add up to a much larger overhead.
>
> But that overhead is exactly what nr_files accounts for, so this looks
> bogus to me.

According to comment above  files_maxfiles_init() one open file uses
roughly 1k, which is the total from struct file + pinned dentry +
pinned inode.  The actual struct file is just a quarter of that.

So while overlayfs does currently pin almost 2k per file and,
according to that calculation should already be using two nr_file
slots, it isn't.  And switching to using two slots means current
setups might well have regressions due to that.

I'm not against switching to two slots, but it's something that would
need to come with backward compatibility guarantees (e.g. explicitly
enabled with boot option, or whatever) and I don't think it's worth
the trouble.

Maintaining the two versions  of overlayfs (with and without stacked
fops) also makes little sense.

Thanks,
Miklos
