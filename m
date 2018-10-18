Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11119C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC5321479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="PpFjQaM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC5321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeJSEYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:24:19 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39004 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeJSEYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:24:19 -0400
Received: by mail-it1-f196.google.com with SMTP id m15so1967839itl.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 13:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OhNhchLPLBtm3unwO3q1aOhVus3CWLtDxXWN07KraLs=;
        b=PpFjQaM6n+m+7/E0w5P7rNJJil2zgA1dk3FJwZrLtMAaugzC88W84rPQcEzGtq6f2F
         nQKGJ1yTELW5e/DGcUw33f/AcoVMPEA0V+5TMnPrPWNEGfVGknPq4cvkzoKp0F6+WbJF
         sOE+89rtzv6kvD+adUUv3/ZXac7xvea1r7Z7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OhNhchLPLBtm3unwO3q1aOhVus3CWLtDxXWN07KraLs=;
        b=F7LzulXKm2zCd9eqLUmfpKfepsPMKTt6QpwHjoPW5GXWLeC/wpRNIn89TGdiQSV2UL
         J2m/JuucE06x5TtrVGoFaa+IFPrCQ/AIvvwd85iXuLwQn1pzO0A8kv05oEJFtn5NOaRk
         kvDotVk4uuNj49elD1uORx4enSQ1VoC/DOuo8uB4YyZPeVOy44rbQyCDEx5Hr6bQeqfQ
         H63A861dCWcjX8BDbWArORxr8sos2U1xHuX6612vOXFCSa9rwy48cdqpJnBftaOIY/PE
         yu/xDEDnWLONqEBobIfES0qzyEmNQTxjBdojAkpSKtqsakp67Nxpf22ZPy6i0ZgVNG3U
         MvGw==
X-Gm-Message-State: ABuFfojLLRvbU9Nu6VyPD7zm3ElIqpGgUQfIpJ+GvVI4R3DmxuaAdLeY
        2Su/c3MOX9AWdW3SnQQublamx15QuPQ/juU0EuobAA==
X-Google-Smtp-Source: ACcGV61W5baXj/It2ozr5kqJTxMjGxpFJsOgWmY0lfJWPDWNUwACbAvuKe/X+jCmR6ntvaDySkS3ejB0UK81w8pglHc=
X-Received: by 2002:a02:55c1:: with SMTP id e184-v6mr24025137jab.35.1539894098673;
 Thu, 18 Oct 2018 13:21:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Thu, 18 Oct 2018 13:21:37
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <4893.1539878663@warthog.procyon.org.uk>
References: <CAJfpegsxFUGeczcC-pzK0WWROjv48_PvXtNun-f5QJMoUDn1Dw@mail.gmail.com>
 <4893.1539878663@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 18 Oct 2018 22:21:37 +0200
Message-ID: <CAJfpeguEriFyL4cpB1ZmoHi_03ouiGgMxFE0u1iZSriDa5bCjw@mail.gmail.com>
Subject: Re: statx(2) API and documentation
To:     David Howells <dhowells@redhat.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 6:04 PM, David Howells <dhowells@redhat.com> wrote:
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
>> I'm trying to implement statx for fuse and ran into the following issues:
>>
>> - Need a STATX_ATTRIBUTES bit, so that userspace can explicitly ask
>> for stx_attribute; otherwise if querying has non-zero cost, then
>> filesystem cannot do it without regressing performance.
>
> Okay, though the way your patch implements it makes it superfluous.  I presume
> you have further patches that will actually make use of it from the fuse side?

Being worked on, yes.

>
>> - STATX_ALL definition is unclear, can this change, or is it fixed?
>> If it's the former, than that's a backward compatibility nightmare.
>> If it's the latter, then what's the point?
>
> It's the set of supported attributes known by the headers, and such can
> only be added to over time.  But yes, it's probably unnecessary.  Asking
> fsinfo() will be a better way of doing things.
>
>> - STATX_ATIME is cleared from stx_mask on SB_RDONLY,
>
> Ummm...  Where?  It's cleared on IS_NOATIME() in generic_fillattr().  I made
> the assumption that IS_NOATIME() == false indicates that there isn't an atime
> to be had.

Look at IS_NOATIME definition in <linux/fs.h>

You probably wanted inode->i_sb->s_flags & SB_NOATIME instead.

>> and on NFS it is also cleared on MNT_NOATIME, but not on MNT_RDONLY.  We
>> need some sort of guideline in the documentation about what constitutes
>> "unsupported": does atime become unsupported because filesystem is remounted
>> r/o?  If so, why isn't this case handled consistently in the VFS and
>> filesystems?
>
> STATX_ATIME should mean there is an actual atime from the "medium" in
> stx_atime, rather than something made up by the filesystem driver; it doesn't
> necessarily promise that this will be updated.

In this case generic_fillattr() and nfs_getattr() are simply buggy.

>
> There can still be an atime if the medium is read-only.
>
> atime is even more complicated with MNT_NOATIME or MNT_RDONLY because that
> doesn't stop the atime from actually being updated through another mountpoint
> on the same system.
>
> Note that stx_atime should always contain something that can be used directly
> to fill in st_atime if emulating stat() - even if STATX_ATIME is cleared.
>
>> - What about fields that are not cached when statx() is called with
>> AT_STATX_DONT_SYNC?  E.g. stx_btime is supported by the filesystem,
>> but getting it requires a roundtrip to the server.
>
> Not necessarily.  It's not cached in *struct inode*, but that doesn't mean
> that the filesystem can't cache it elsewhere.
>
>> Requesting STATX_BTIME in the mask and adding AT_STATX_DONT_SYNC to the
>> flags means the filesystem has to decide which it will honor.  My feeling is
>> that it should honor AT_STATX_DONT_SYNC and clear STATX_BTIME in stx_mask.
>> Documentation has no word about this case.
>
> From the manpage:
>
>        AT_STATX_DONT_SYNC
>               Don't synchronize anything, but rather just  take  whatever  the
>               system  has cached if possible. ...
>
> Note the "if possible".  If it's not possible, you still need to go get it if
> they explicitly asked for it.

Okay.

Thanks,
Miklos
