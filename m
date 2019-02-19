Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB170C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A2F217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MFyqB7Wy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfBSQzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:55:13 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36651 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfBSQzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:55:12 -0500
Received: by mail-qt1-f193.google.com with SMTP id p25so23638602qtb.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 08:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vGlFpfUB5VgPPfUiNSUHULE/lIMMcTubxMHGY92F0OY=;
        b=MFyqB7WyR5i41fn8HycsoCcBQUh56mln/dXNSaxoi7cW93bRb6Oq7//Q16TdyWdzoU
         us8SxMVyaqRWtFVTo1FUPBhUeiPnUhcXveNIDz3qwQlPDJA3crg7NRzc52aI5qZ///n3
         QcXE6gxCGPpso9G3p0NqFJBLw8Nnk8QUmDx3Zobiovq5guhPquhl23qQ30hzW5NbSIfN
         anPVkzL5p7P0FmHwQtJ8S18p7eqKB84ZXpgeyBLmnppXt1mO9eSwhMP9qLGJHWa7/hx/
         4gCt6YiBwPvBOar9yJia3K18CRbUB5+crrbG0RCyOKJI6m0iW7W/dJpLWO+KD1p90Vug
         wL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vGlFpfUB5VgPPfUiNSUHULE/lIMMcTubxMHGY92F0OY=;
        b=QZyLfrRU/eSMMGwBqXZQGlsnEXdoN1AH1D6VDj54E2UAVKEFN+u3WQonoh3t1i60Mz
         Xhq0Un6EEF9gFv4m1TShKtudBuVctwDqBxO0sp80FGjCAg2/FyLP/HprsZOodCgJ2zjF
         H8/SzjtUh+EOJGbr1g7LoZqO8MBYtmoaygvL7nDA/M2Qb47eDKg03DXq+jWdGuuNJlUk
         Oau2BbE2PYKDlWgsGu1hUBH7aQ+qrWrb78b8lpDpe7MyBrIJDFnGZFUcRqun9MpHb51E
         VE7b+0oxqi1ZEK40PStQpAxr7nIDG/16K9hqcn84kSeKwhHP1yKTgFZ+iyT1MJUuSoml
         9Qog==
X-Gm-Message-State: AHQUAuZPlRQyH2EPIKL4yYjO6LQjvp0R/rpcqIJWj8WojVHcjSp+Pbvg
        p1Dc3Fw+A6yEonecCPHtLNpSxVWFy1fad6KQbKMmig==
X-Google-Smtp-Source: AHgI3IaMKAZOwEueYYOXTzmH2lBOvOY5PKQvh6so/bdLOvlAsWOFh5A453OZiwMe80lbNCisuGgSR/gcnm2CRKiNd78=
X-Received: by 2002:ac8:3227:: with SMTP id x36mr23164991qta.56.1550595310993;
 Tue, 19 Feb 2019 08:55:10 -0800 (PST)
MIME-Version: 1.0
References: <20190218081145.86633-1-minchan@kernel.org> <20190218083208.GA20069@kroah.com>
 <20190218104725.GA160999@google.com>
In-Reply-To: <20190218104725.GA160999@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 19 Feb 2019 08:54:59 -0800
Message-ID: <CAHRSSEy7bHsVr9CSbybRU0SvL2EHoWbF0wyZi72FJPXyPMDj+Q@mail.gmail.com>
Subject: Re: [PATCH] binder: reduce mmap_sem write-side lock
To:     Minchan Kim <minchan@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 2:47 AM Minchan Kim <minchan@kernel.org> wrote:
>
> On Mon, Feb 18, 2019 at 09:32:08AM +0100, Greg KH wrote:
> > On Mon, Feb 18, 2019 at 05:11:45PM +0900, Minchan Kim wrote:
> > > binder has used write-side mmap_sem semaphore to release memory
> > > mapped at address space of the process. However, right lock to
> > > release pages is down_read, not down_write because page table lock
> > > already protects the race for parallel freeing.
> > >
> > > Please do not use mmap_sem write-side lock which is well known
> > > contented lock.
> > >
> > > Cc: Todd Kjos <tkjos@google.com>
> > > Cc: Martijn Coenen <maco@android.com>
> > > Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Minchan Kim <minchan@kernel.org>

Acked-by: Todd Kjos <tkjos@google.com>

> > > ---
> > >  drivers/android/binder_alloc.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Is this just needed for the recent binder changes that are in
> > linux-next, or for older kernels as well?
>
> It has been there for several years but no need to fix older kernels
> because down_write of mmap_sem is technically not a bug to stop the
> working of binder. Rather than, it's just abuse of the lock so
> it's okay to fix only recent kernel.
>
> Thanks.
