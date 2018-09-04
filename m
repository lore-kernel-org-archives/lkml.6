Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23D6C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75852075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75852075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeIDPeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:34:16 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:32926 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeIDPeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:34:15 -0400
Received: by mail-yb1-f194.google.com with SMTP id m123-v6so1127731ybm.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 04:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pKRi1mq42PohxYzS47GA5j/6nSE1A7k//x/RUKJ8w88=;
        b=qPALPRTrbVokWnsSWCZwHcHQ6sNLKXQpmlotIJ4mpEnWc153NsMRZ+GlpEZ+0Dvre3
         wuDR+WhWowFdUWvAUqF7vn5eRsJZ3FLjkGcle06/fFrEH8GsE49e9rNc6t5WlInPQ6RI
         lRmMr2+oKslp5IyAxOAtmHSdPkAM5P+hK/E5mp2XnWEWpfAx6hfxnk7CqBshal2sZ5FJ
         X1MsQjLQpl8ESCwFD1Gi0JgRcEPNmOo6mfWwTlHg1TEctkJiWKtd5BDNPiWmy6g/yqUh
         BmazOiP4PXDufb+BtrD8vNByZ4iJwr4VlxKLuRc/3JjPY5Z8omiSOj/rdcNME0UVrsL9
         AlZw==
X-Gm-Message-State: APzg51AfVQJ1Cf9BzeakONbVH3tDyfbSkHyDhjdvdM8KKtFWtwBiceaC
        upL2uyWz9Ji4RPC7Dhg/9c6B7Q==
X-Google-Smtp-Source: ANB0VdZDoNtYYw29h/SRixnAeUugGyW5jb/RM6jSMSGh3HKxQNbu3z88Yl6HyVFiuA+ew5zeBD8S+A==
X-Received: by 2002:a25:db83:: with SMTP id g125-v6mr18331692ybf.412.1536059376185;
        Tue, 04 Sep 2018 04:09:36 -0700 (PDT)
Received: from tleilax.poochiereds.net (cpe-2606-A000-1100-DB-0-0-0-161.dyn6.twc.com. [2606:a000:1100:db::161])
        by smtp.gmail.com with ESMTPSA id t4-v6sm8066794ywa.51.2018.09.04.04.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 04:09:35 -0700 (PDT)
Message-ID: <82ffc434137c2ca47a8edefbe7007f5cbecd1cca.camel@redhat.com>
Subject: Re: POSIX violation by writeback error
From:   Jeff Layton <jlayton@redhat.com>
To:     =?UTF-8?Q?=E7=84=A6=E6=99=93=E5=86=AC?= <milestonejxd@gmail.com>,
        R.E.Wolff@bitwizard.nl
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Sep 2018 07:09:34 -0400
In-Reply-To: <CAJDTihzqn3whQ47uUOxGYk4Je4S10ehNEQCtfb=j--iCsdDqgQ@mail.gmail.com>
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com>
         <20180904075347.GH11854@BitWizard.nl>
         <CAJDTihzqn3whQ47uUOxGYk4Je4S10ehNEQCtfb=j--iCsdDqgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-04 at 16:58 +0800, 焦晓冬 wrote:
> On Tue, Sep 4, 2018 at 3:53 PM Rogier Wolff <R.E.Wolff@bitwizard.nl> wrote:
> 
> ...
> > > 
> > > Jlayton's patch is simple but wonderful idea towards correct error
> > > reporting. It seems one crucial thing is still here to be fixed. Does
> > > anyone have some idea?
> > > 
> > > The crucial thing may be that a read() after a successful
> > > open()-write()-close() may return old data.
> > > 
> > > That may happen where an async writeback error occurs after close()
> > > and the inode/mapping get evicted before read().
> > 
> > Suppose I have 1Gb of RAM. Suppose I open a file, write 0.5Gb to it
> > and then close it. Then I repeat this 9 times.
> > 
> > Now, when writing those files to storage fails, there is 5Gb of data
> > to remember and only 1Gb of RAM.
> > 
> > I can choose any part of that 5Gb and try to read it.
> > 
> > Please make a suggestion about where we should store that data?
> 
> That is certainly not possible to be done. But at least, shall we report
> error on read()? Silently returning wrong data may cause further damage,
> such as removing wrong files since it was marked as garbage in the old file.
> 

Is the data wrong though? You tried to write and then that failed.
Eventually we want to be able to get at the data that's actually in the
file -- what is that point?

If I get an error back on a read, why should I think that it has
anything at all to do with writes that previously failed? It may even
have been written by a completely separate process that I had nothing at
all to do with.

> As I can see, that is all about error reporting.
> 
> As for suggestion, maybe the error flag of inode/mapping, or the entire inode
> should not be evicted if there was an error. That hopefully won't take much
> memory. On extreme conditions, where too much error inode requires staying
> in memory, maybe we should panic rather then spread the error.
> 
> > 
> > In the easy case, where the data easily fits in RAM, you COULD write a
> > solution. But when the hardware fails, the SYSTEM will not be able to
> > follow the posix rules.
> 
> Nope, we are able to follow the rules. The above is one way that follows the
> POSIX rules.
> 

This is something we discussed at LSF this year.

We could attempt to keep dirty data around for a little while, at least
long enough to ensure that reads reflect earlier writes until the errors
can be scraped out by fsync. That would sort of redefine fsync from
being "ensure that my writes are flushed" to "synchronize my cache with
the current state of the file".

The problem of course is that applications are not required to do fsync
at all. At what point do we give up on it, and toss out the pages that
can't be cleaned?

We could allow for a tunable that does a kernel panic if writebacks fail
and the errors are never fetched via fsync, and we run out of memory. I
don't think that is something most users would want though.

Another thought: maybe we could OOM kill any process that has the file
open and then toss out the page data in that situation?

I'm wide open to (good) ideas here.
-- 
Jeff Layton <jlayton@redhat.com>

