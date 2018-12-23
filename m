Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70DEC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 18:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F95721773
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 18:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUejQIJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbeLWSuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 13:50:32 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37731 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbeLWSub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 13:50:31 -0500
Received: by mail-io1-f67.google.com with SMTP id r7so555301iog.4;
        Sun, 23 Dec 2018 10:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFt1ekf7vi1u8pyDOq8wR77/GttuunLb+Um4zlTfDIg=;
        b=sUejQIJhFheEhniHKLH2U6B4CBfjOyx6tYQ3/7hyOH4b0yKMLktZ4Et2UVSDGQ5Zi+
         is8M13Bi+JTFbeSZzBay3rtxRGIYJiYp8S2mVJr+z6UWSYe7EuARcJh3o9gTeX/kNuOg
         /E/7ND9lQWg2JcRUPPhfxMVevHm8kPFTIT/aLqRzQqEj45kYbZFJzW63J8vRRGRc+i44
         tpsALSsfUu/2f1TZC8/gQPkVHyKFZwKjuL5WlVwXAmW5T9ycgbeYQWWRsBl4IzSOAWnH
         snQbR+458MdiIfEcwG/U6vYTkCrqZ7XarqGS7e1DTga5UxsvWww+nMVpWbgv5ekb7oXX
         o1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFt1ekf7vi1u8pyDOq8wR77/GttuunLb+Um4zlTfDIg=;
        b=NURamCnRqriNBGHxVzDSPeUFMPn9P/BcPkkM95jj9cliGyjJAVfFJNRE1dhpU9+93b
         OjqOeXlb7W/HWCJCImD1mzLnv7JU7GwCD3KTF+B0c+tqlX5ZkxxZgmE3+yWW3JHyy4tA
         YfdPItnybDtJokpD3hfwGKmJSIKlvrasKlOJ2bf0R77hJ5/d+tiVBeeRuCAfRKcGMvRg
         MhtcRAVM2ZLp+35zRHrxmDnGJ+iHPQgvCEnZ4GbAARARa5HSx3ZGYQLov8+kzXunlg45
         BP7KMBbmlotBmXyah1ol89X3pouhmnOr0kejrqc/Hagg3+rPwJObhNCQaTBn7LrZx5sN
         pwCw==
X-Gm-Message-State: AJcUukdwaASq0UJpulLzUZWt47RPEwnk1LTCXLMCsQsUOu/qJlxG/CmE
        d3DzreqVoiRuAGaJVp6AJbKYA7zKdBdEZrJF2nY=
X-Google-Smtp-Source: ALg8bN52SIMQyOhWCOCnWrLqjucgTfaxnrUy67xXx7CiOSm3hn/XWvnCZ32nYSn1jXvQ2nr9Qvsgn+cI/PFu554D7HU=
X-Received: by 2002:a6b:3b4f:: with SMTP id i76mr7607485ioa.266.1545591031093;
 Sun, 23 Dec 2018 10:50:31 -0800 (PST)
MIME-Version: 1.0
References: <20181221202733.19627-1-deepa.kernel@gmail.com> <e4f80b85-eafb-691d-2ebc-056d565f5d62@gmail.com>
In-Reply-To: <e4f80b85-eafb-691d-2ebc-056d565f5d62@gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sun, 23 Dec 2018 10:50:19 -0800
Message-ID: <CABeXuvpzcfM13KpDoYr51KTi7UvPUe5eQotq7i3p1pn7FNoTnA@mail.gmail.com>
Subject: Re: [PATCH] sock: Make sock->sk_tstamp thread-safe
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Network Devel Mailing List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 11:31 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 12/21/2018 12:27 PM, Deepa Dinamani wrote:
> > Al Viro mentioned that there is probably a race condition
> > lurking in accesses of sk_tstamp on 32-bit machines.
> >
> > sock->sk_tstamp is of type ktime_t which is always an s64.
> > On a 32 bit architecture, we might run into situations of
> > unsafe access as the access to the field becomes non atomic.
> >
> > Use seqlocks for synchronization.
> > This allows us to avoid using spinlocks for readers as
> > readers do not need mutual exclusion.
> >
>
> Hi Deepa
>
> Please come up with something that has zero added costs for 64bit kernels.
>
> Most of us do not really care about 32bit kernels anymore, so we do not want to slow
> down 64bits kernels for such things.
>
> Look at include/linux/u64_stats_sync.h for initial thoughts.

This is similar to what I did here. But, I can add a few ifdef's to
make this code a noop on 64 bit arches.
I will include this in my next update.

I'm assuming there is no contention on whether writers need exclusive
access and hence requiring a lock here.
Let me know otherwise.

Thanks,
Deepa
