Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D2EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D62120877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D62120877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeIYWtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:49:41 -0400
Received: from mail-yb1-f177.google.com ([209.85.219.177]:36331 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbeIYWtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:49:40 -0400
Received: by mail-yb1-f177.google.com with SMTP id 5-v6so10045690ybf.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 09:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cEsgGXKVNr0bWlECtfZgGytV04JVJFDOy7CtIh1ZmNc=;
        b=i07IqnDp52RhuMFrX9GjP0b1e4SZEnXDJiWXKDiDXk9Ny7bIjzcekZWBsb3TJ15NuD
         gj2GKSGc/5lFN+9HCrhhfu2cJyhM1hFRSySoOoVT2vyawtV6gT48RYab1hPgCJx/rGRt
         +ZODo6532W2riGoPZv7qHm/f76nYpqjlDdfCAfYj7fFBCV0dZXJCCp6ImD4vc0+1dT3a
         jxKuqWB+cUaTamrtLhVk+R1tYeWOOHalwmspKRkCgmtuFfUdVWWXbAeHZ/jEfF5/gJaQ
         Hv8AFsvOC5H+9koM8eC7t3ViEJU907kk6HNuyz89ZodWMBdTJLRJ/QNgNESqV2WZjJh0
         nyIg==
X-Gm-Message-State: ABuFfogI/y5yN1R9jRCf7CzOvmQ7w3/x0kjX96y9O5VHpzPnAuiV57v0
        Y3AZL+ufrEAvzmYEiohtMVxB5g==
X-Google-Smtp-Source: ACcGV60IV+HpprAR6ghjxIqIyAMnbi+2eiCQtOaHqTj5xh8VEgUfHqDj7MRHMY5fC+5MFNLkpS+45g==
X-Received: by 2002:a25:e548:: with SMTP id c69-v6mr1043696ybh.393.1537893680943;
        Tue, 25 Sep 2018 09:41:20 -0700 (PDT)
Received: from tleilax.poochiereds.net (cpe-2606-A000-1100-DB-0-0-0-D5E.dyn6.twc.com. [2606:a000:1100:db::d5e])
        by smtp.gmail.com with ESMTPSA id t2-v6sm1030940ywd.99.2018.09.25.09.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 09:41:20 -0700 (PDT)
Message-ID: <23cd68a665d27216415dc79367ffc3bee1b60b86.camel@redhat.com>
Subject: Re: POSIX violation by writeback error
From:   Jeff Layton <jlayton@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        =?UTF-8?Q?=E7=84=A6=E6=99=93=E5=86=AC?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>
Date:   Tue, 25 Sep 2018 12:41:18 -0400
In-Reply-To: <20180925154627.GC2933@thunk.org>
References: <CAJDTihx2yaR-_-9Ks1PoFcrKNZgUOoLdN-wRTTMV76Jg_dCLrw@mail.gmail.com>
         <486f6105fd4076c1af67dae7fdfe6826019f7ff4.camel@redhat.com>
         <20180925003044.239531c7@alans-desktop>
         <0662a4c5d2e164d651a6a116d06da380f317100f.camel@redhat.com>
         <20180925154627.GC2933@thunk.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-25 at 11:46 -0400, Theodore Y. Ts'o wrote:
> On Tue, Sep 25, 2018 at 07:15:34AM -0400, Jeff Layton wrote:
> > Linux has dozens of filesystems and they all behave differently in this
> > regard. A catastrophic failure (paradoxically) makes things simpler for
> > the fs developer, but even on local filesystems isolated errors can
> > occur. It's also not just NFS -- what mostly started me down this road
> > was working on ENOSPC handling for CephFS.
> > 
> > I think it'd be good to at least establish a "gold standard" for what
> > filesystems ought to do in this situation. We might not be able to
> > achieve that in all cases, but we could then document the exceptions.
> 
> I'd argue the standard should be the precedent set by AFS and NFS.
> AFS verifies space available on close(2) and returns ENOSPC from the
> close(2) system call if space is not available.  At MIT Project
> Athena, where we used AFS extensively in the late 80's and early 90's,
> we made and contributed back changes to avoid data loss as a result of
> quota errors.
> 
> The best practice that should be documented for userspace is when
> writing precious files[1], programs should open for writing foo.new, write
> out the data, call fsync() and check the error return, call close()
> and check the error return, and then call rename(foo.new, foo) and
> check the error return.  Writing a library function which does this,
> and which also copies the ACL's and xattr's from foo to foo.new before
> the rename() would probably help, but not as much as we might think.
> 
> [1] That is, editors writing source files, but not compilers and
> similar programs writing object files and other generated files.
> 
> None of this is really all that new.  We had the same discussion back
> during the O_PONIES controversy, and we came out in the same place.
> 
> 						- Ted
> 
> P.S.  One thought: it might be cool if there was some way for
> userspace applications to mark files with "nuke if not closed" flag,
> such that if the system crashes, the file systems would automatically
> unlink the file after a reboot or if the process was killed or exits
> without an explicit close(2).  For networked/remote file systems that
> supported this flag, after the client comes back up after a reboot, it
> could notify the server that all files created previously from that
> client should be unlinked.
> 
> Unlike O_TMPFILE, this would require file system changes to support,
> so maybe it's not worth having something which automatically cleans up
> files that were in the middle of being written at the time of a system
> crash.  (Especially since you can get most of the functionality by
> using some naming convention for files that in the process of being
> written, and then teach some program that is regularly scanning the
> entire file system, such as updatedb(2) to nuke the files from a cron
> job.  It won't be as efficient, but it would be much easier to
> implement.)

That's all well and good, but still doesn't quite solve the main concern
with all of this. It's suppose we have this series of events:

open file r/w
write 1024 bytes to offset 0
<background writeback that fails>
read 1024 bytes from offset 0

Open, write and read are successful, and there was no fsync or close in
between them. Will that read reflect the result of the previous write or
no?

The answer today is "it depends".
-- 
Jeff Layton <jlayton@redhat.com>

