Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C080C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A478621476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="mHORzpaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A478621476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbeJRPXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:23:02 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54776 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbeJRPXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:23:02 -0400
Received: by mail-it1-f193.google.com with SMTP id l191-v6so5433049ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 00:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/kpmVatA215+ZEflb39W9wUN79Kg7rVZxAztLlvk4pM=;
        b=mHORzpaK7twShXxdGzghjmfZBbDdXwHhnUN3IjjhWaxZt1ArrkDB+Y9fmq9kAd95Dc
         eexZ9cKFCU4PRhJ4O4d4GGorMkD848lP/I9KgaubvwQ3OlEr8QKEPbpsdmy92N98WfA5
         5XD8fCJx/pG4ZY45LBHfzYCkLnkJPwP2An7YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/kpmVatA215+ZEflb39W9wUN79Kg7rVZxAztLlvk4pM=;
        b=DG2aFtIpbFv0/nlu9hP3d8xLpHALoI6ba3rU9QlhDRyOpyYu5hnR3t94h7jABsRHKG
         RemgsqCEUqwdvgZ1FkOiMTaVOAPffCKXxQVA+LmEUYGiGyGnns451h0JGg6vrNaoLA7U
         mTL5iY75G+rsy5f2GxD3Y0qrczTLKp7k68nuEeT0Bc6ar2lR5e/5giI+rXqWvCk6EILO
         9SCucqekIoLRol2Gz/xoi0WF6wZCHqHaiUoophSYbvvdqaTxvxLx4dCaBolr6L3U2Vm+
         6OG0XPhwQ9ZRp6UXSduEdQyYrWUaf7vh5Isi01kstO8w9NeXHqHAtsrUhzhu8TTudQHG
         SvWA==
X-Gm-Message-State: ABuFfogGBm/L4BBcZihvSGUZ2UYNpdDDqLUFJ3RyEH+cd+uudn3ygSeB
        zJYxD3zAac/asy9FOHKLyp3iF8Y//rvxeHH2PrN+DQ==
X-Google-Smtp-Source: ACcGV60PtH/WdJZXoUyra2JQDd5R15e/l/SJWpzO7lbpnZGy8gzhge4u1Du1K/l7mVDLdPibclsTKd7FLK447eIKXrM=
X-Received: by 2002:a05:660c:383:: with SMTP id x3mr3546344itj.121.1539847403149;
 Thu, 18 Oct 2018 00:23:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Thu, 18 Oct 2018 00:23:22
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <E9903911-9289-4038-9835-9353762A3BAF@dilger.ca>
References: <CAJfpegsxFUGeczcC-pzK0WWROjv48_PvXtNun-f5QJMoUDn1Dw@mail.gmail.com>
 <006890C4-64D4-4DE2-A1F0-335FFFD585BB@dilger.ca> <CAJfpeguvJZbP83mSULc74Yhpp_CPMBW1XvcgbvCbLnF7QCncUA@mail.gmail.com>
 <E9903911-9289-4038-9835-9353762A3BAF@dilger.ca>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 18 Oct 2018 09:23:22 +0200
Message-ID: <CAJfpegtM2Sk2fi974rgtWXvRG=Z51KOyt8RekrR4HhAmz6Agfg@mail.gmail.com>
Subject: Re: statx(2) API and documentation
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 10:22 PM, Andreas Dilger <adilger@dilger.ca> wrote:
> On Oct 17, 2018, at 1:04 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:

>> So what's the point exactly?
>
> Ah, I see your point...  STATX_ALL seems to be mostly useful for the kernel
> to mask off flags that it doesn't currently understand.

And even there it's quite pointless, since no sane implementation
would put the request mask into the result mask (aka. stx_mask)
verbatim, without picking out bits which correspond to *supported*
fields.

So it's pointless across the board.  But since it's already published
in a userspace API, the best we can do is leave it at its current
value, but with a comment to warn that it  should not be updated when
new flags are added.  And remove all traces of it from the kernel.

>> Right, OTOH I sort of see the value in  NFS: no roundtrip to server if
>> atime value is useless anyway.
>
> Well, "noatime" might be a client-only option, which doesn't mean that the
> server or some other client isn't updating the atime.  Returning an old
> atime isn't the same as not returning anything at all.

Fs is allowed (and in case of basic stats, required) to fill in dummy
values for even unsupported fields.

I understand your argument, since that was my first thought, but I
also understand the reason behind clearing STATX_ATIME.  And atime is
something that very few applications care about anyway.   But I do
think such behavior should be clarified in the documentation and
handled more consistently in the code.

> To my thinking, if the user/app requests btime/ctime/size/blocks the kernel
> should return these fields.  If DONT_SYNC is set, it means the kernel can
> return potentially stale values, but if the kernel doesn't have *any*
> values for these fields at all it still should query the server instead of
> just returning random garbage.

I'm not saying it should return garbage, instead it can just not set
the bit in the result mask to indicate that that field cannot be
filled (without network traffic, in this case).

This requires generalizing the definition of the result mask, because
the above (clearing STATX_ATIME on ro/noatim or clearing STATX_BTIME
on DONT_SYNC) don't fit the current "unsupported or unrepresentable"
definition.

> That said, it seems that it isn't even possible to get into nfs_getattr()
> without the VFS having instantiated a dentry and inode (i.e. queried the
> server via nfs_lookup() at some point), so the inode fields have already
> been filled with *something*.

There's no "i_btime" field.

But it's hard to argue this point with btime, so lets instead think
about a theoretical attribute that is:

 - hard to calculate, so filesystem will not want to cache it on inode
initialization (because it's very unlikely to be actually needed)

 - isn't constant and can be cached, so all sync types make sense.

I think the following semantics would be the most useful and sane:
FORCE_SYNC or SYNC_AS_STAT would always retrieve the attribute if
supported, and set the bit in the result mask; DONT_SYNC would only
set the bit in the result mask if the attribute is already cached.

Thanks,
Miklos
