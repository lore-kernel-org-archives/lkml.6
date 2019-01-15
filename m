Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF9EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE5720645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="YOZwQ7jk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbfAOQDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:03:48 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53067 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbfAOQDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:03:47 -0500
Received: by mail-it1-f194.google.com with SMTP id g76so5823252itg.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 08:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQ9oGYMTQtDjsWmcfp043HGj8iWGVgsL0MfPOslg3/g=;
        b=YOZwQ7jk9v2/cxp/wzqDkDPFnUN2I4KAzsX6cztbZGaD3kQjTyyM5u1MCNtbVaM0MQ
         yYjpaLBUSvsJ/FIkvF07pRNZkH7nNllK3uMnNZcVgpcA2GWQbRRF+OAn9s+cubH6vR62
         yDnHen2lIMkrw5fnDJ7+QpRAUpfCrjo+Xt7eQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQ9oGYMTQtDjsWmcfp043HGj8iWGVgsL0MfPOslg3/g=;
        b=D2Ti1ViK97y44E9bY52K/rNSczxIfBRgShkknnGnWfheiaaIjcW3Ur0t3qrQC7qE+z
         QmWaBhw7hDTuI6qSivO33EhSVCJ0p9P9/YzD9kzmz7iCYt5cLpHnN7aK5CGxQOvBL28x
         HB512xjzOuxt4ub2QKxt+hPp+3MUBrq2zPyGnnT1Pw/zO358pMYIRl3GKpO3YE1rMybZ
         OFqvAUf8Hx1k3r9jKu8Y11MytiQK8wkjD+R9h+i+tgZh5syeSKJ5l4vprenE7qK45Rv6
         viuuysYGXywJoQOi5h75E1zlElOgT8s3KqVItNzgbusR8sS+asT9Ci+aoJk0IJP3yrCn
         PEBA==
X-Gm-Message-State: AJcUukfrKDnYu4SCTgscD5sPHDfnORk6t2/qI9B6IW5oGEFL7/PQqtsH
        YyfwwJE782aX9udHjM+/5npk8Vfr9fxxIKOmcUR5kQ==
X-Google-Smtp-Source: ALg8bN7NnJumDyuyNhWuinIbttBkZUW9YRqs/3QCFzR2TwsciPhOMWNhaKocZ0OvzwmFrJsrVUlgypN9+ISP7/tcCDo=
X-Received: by 2002:a24:710:: with SMTP id f16mr2590092itf.121.1547568226980;
 Tue, 15 Jan 2019 08:03:46 -0800 (PST)
MIME-Version: 1.0
References: <154322517208.18737.3297786654135648324.stgit@localhost.localdomain>
 <00b1782a-5c5c-5bc8-7ea9-4f8450679fa1@virtuozzo.com> <CAJfpeguokUoCPEnK7Q_Rp9cmyBCMfm51=7TmbbS-QiEy2BxxAQ@mail.gmail.com>
 <a45d54a3-b275-9c95-3c9d-a19566e447dc@virtuozzo.com> <CAJfpegvOgA+Wd3vTRqYQP7p_SJ11YCffquP_R=WRHwqYD4b=Ng@mail.gmail.com>
 <b198f480-9ce7-9663-40b1-193a05846c95@virtuozzo.com>
In-Reply-To: <b198f480-9ce7-9663-40b1-193a05846c95@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 15 Jan 2019 17:03:35 +0100
Message-ID: <CAJfpegvVq3z0CDYb4M4QSCko9Ckw6DOizeHBp=J==Muqn21Yhw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: Fix race in fuse_writepage_in_flight()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 4:55 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 15.01.2019 18:37, Miklos Szeredi wrote:
> > On Thu, Jan 10, 2019 at 12:03 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>
> >> On 10.01.2019 14:00, Miklos Szeredi wrote:
> >>> On Thu, Jan 10, 2019 at 11:48 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>>>
> >>>> Hi, Miklos,
> >>>>
> >>>> any comments about this?
> >>>
> >>> Is there a reproducer?  ISTR that fsx-linux with mmaps enabled was
> >>> good for stressing the writeback_cache code.
> >>
> >> There is no a reproducer, since I found that by eyes during preparation of another patchset.
> >
> > That's good.  It would even better to have a reproducer, but it
> > doesn't look easy...
> >
> > Completely redid this and reordered the patchset so this change is
> > made before the locking changes actually introduce the bug.
>
> Hm, I meant that I found this during preparation of the patchset,
> but not that fi->lock patchset introduces the bug. I don't think
> the patchset is involved:
>
> 1)before we had race, because different locks fc->lock and fiq->waitq.lock
> are taken in fuse_dev_read() and fuse_writepage_in_flight();
> 2)after we have the same race, and the locks are fi->lock and fiq->waitq.lock.

Ah, so the race was introduced earlier, when fiq->waitq.lock was split
out from fc->lock.

Thanks,
Miklos
