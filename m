Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6325FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246EC2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246EC2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbeIYRWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:22:41 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:39015 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbeIYRWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:22:40 -0400
Received: by mail-qt1-f176.google.com with SMTP id c25-v6so7096095qtp.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 04:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ZaB5uho8LaSM6sh6H3DEGss2LOQGi3J21oe3U2ZmnE=;
        b=dlE20AHoxcmZjLbK9AK41pzXJuztsoA+yta6XECrGBS7JB7pzX0d7A+9glzb1NTh77
         uGqgxka2oNV6FDXovJN+Z1vws821AZszzWu6Q1XxVNnktwr0+uZNNAr69bhz6Pitcr7j
         eGTA04oyDcjzceLxdPsT7PzfzlouY3FUt3b51BYdyQlYekrRn4TVbHTVFO5UvpyMva7M
         kAWpwexl9NfJhVFKslvT4C3hLUODTyeKU6HIk5RyjesP4DJ9O/WOgmLio48JE+PFpRTW
         4ledJyXTsCSUjzcztDGmfZTRicRXbu0299QV0p3hSxHToBi0fFsAuSp/vfHYjiN+Z6Wj
         7IGg==
X-Gm-Message-State: ABuFfogQwJLjc7nDuj0D/jE1SN10vmPZ51ifU3HjR2gXvJxB1ffmehNS
        o+fOTg5HTXcIp6/N2pDf5tfg4A==
X-Google-Smtp-Source: ACcGV62bYDZo+dpm0bTG38W6q/wqZTHXPl19VTr3mG7JdilDFnhrfyGJsU4U49aSKXbyVTS126f8hw==
X-Received: by 2002:aed:2963:: with SMTP id s90-v6mr320671qtd.189.1537874135791;
        Tue, 25 Sep 2018 04:15:35 -0700 (PDT)
Received: from tleilax.poochiereds.net (cpe-2606-A000-1100-DB-0-0-0-D5E.dyn6.twc.com. [2606:a000:1100:db::d5e])
        by smtp.gmail.com with ESMTPSA id f63-v6sm1140935qtb.64.2018.09.25.04.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 04:15:35 -0700 (PDT)
Message-ID: <0662a4c5d2e164d651a6a116d06da380f317100f.camel@redhat.com>
Subject: Re: POSIX violation by writeback error
From:   Jeff Layton <jlayton@redhat.com>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     =?UTF-8?Q?=E7=84=A6=E6=99=93=E5=86=AC?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>
Date:   Tue, 25 Sep 2018 07:15:34 -0400
In-Reply-To: <20180925003044.239531c7@alans-desktop>
References: <CAJDTihx2yaR-_-9Ks1PoFcrKNZgUOoLdN-wRTTMV76Jg_dCLrw@mail.gmail.com>
         <486f6105fd4076c1af67dae7fdfe6826019f7ff4.camel@redhat.com>
         <20180925003044.239531c7@alans-desktop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-25 at 00:30 +0100, Alan Cox wrote:
> > write()
> > kernel attempts to write back page and fails
> > page is marked clean and evicted from the cache
> > read()
> > 
> > Now your write is gone and there were no calls between the write and
> > read.
> > 
> > The question we still need to answer is this:
> > 
> > When we attempt to write back some data from the cache and that fails,
> > what should happen to the dirty pages?
> 
> Why do you care about the content of the pages at that point. The only
> options are to use the data (todays model), or to report that you are on
> fire.
> 

The data itself doesn't matter much. What does matter is consistent
behavior in the face of such an error. The issue (IMO) is that
currently, the result of a read that takes place after a write but
before an fsync is indeterminate.

If writeback succeeded (or hasn't been done yet) you'll get back the
data you wrote, but if there was a writeback error you may or may not.
The behavior in that case mostly depends on the whim of the filesystem
developer, and they all behave somewhat differently.

> If you are going to error you don't need to use the data so you could in
> fact compress dramatically the amount of stuff you need to save
> somewhere. You need the page information so you can realize what page
> this is, but you can point the data into oblivion somewhere because you
> are no longer going to give it to anyone (assuming you can successfully
> force unmap it from everyone once it's not locked by a DMA or similar).
> 
> In the real world though it's fairly unusual to just lose a bit of I/O.
> Flash devices in particular have a nasty tendancy to simply go *poof* and
> the first you know about an I/O error is the last data the drive ever
> gives you short of jtag. NFS is an exception and NFS soft timeouts are
> nasty.
> 

Linux has dozens of filesystems and they all behave differently in this
regard. A catastrophic failure (paradoxically) makes things simpler for
the fs developer, but even on local filesystems isolated errors can
occur. It's also not just NFS -- what mostly started me down this road
was working on ENOSPC handling for CephFS.

I think it'd be good to at least establish a "gold standard" for what
filesystems ought to do in this situation. We might not be able to
achieve that in all cases, but we could then document the exceptions.
--
Jeff Layton <jlayton@redhat.com>

