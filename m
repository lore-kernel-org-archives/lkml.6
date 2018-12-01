Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144CEC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 23:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00C72081D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 23:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pd4uPiz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00C72081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbeLBKha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 05:37:30 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44976 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725729AbeLBKha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 05:37:30 -0500
Received: by mail-qt1-f194.google.com with SMTP id n32so9980958qte.11;
        Sat, 01 Dec 2018 15:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9ex1yDTFBOZH8oBUJUNdOXEjg0UXXLqMVVgTNO5HPVk=;
        b=pd4uPiz23jtfP/yMGCeDDZh+Qrae1CkUdyaUXAMJReNclVbTmEf5eZCHxuI/5O0FfD
         Jrkd0pjP3M+RZNggWQ7Ho380Ev3Zb39EJ73cUqunMmryZVHkm91bZHyQLPvz2qXojsoh
         vx0CIHkudhcpnU7vlQMkEBmuBYy2a8JbPfQcQ5jc+q+1ajtsOWjxgLrpsanqQfrRc/OV
         XhzXqFb6KkS1u1m+3LP4qViNmml9n4cp4RIEoXn4oE1YRPW0YXwuaLY2M/CPTMBWqFGy
         hws76823rQiu/lFFUERS55DK6ZnqcI0t+keHkzoswjPBRIS6vOzkTETQYXS9B+S+eJkl
         8AkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9ex1yDTFBOZH8oBUJUNdOXEjg0UXXLqMVVgTNO5HPVk=;
        b=ZM/4QXAF5Sm15Z7pgXb9dNYhtiOCFXrNrm9ernNPPMgNNVo1cjbD1DGkq9U6kH58fY
         VBPCOnL19ys3VCB/fwEAjCaz9YvRZ6qDwYcZgsgebICjw0cjc0CeKzE4Y8kBveT6Pa+S
         5fTn4XTxrTHqT3BmtONXSenSNOxg4YS7UO8BtqurVR0n1LWGTt8eJkzc4hfdgfChTYcd
         +2NR5egkDgO7Ti7ikKQ05SBhzmLfT8/PHpvyWYqozcXJ6Trhgp76CK2t2sAtqJLM2Kg1
         D9RJ3WQAOkDBfmrlIs9PDd/1OeDTBwd0C8f53re2/kj+C4YV5ySuZjv2ty71pG2AgcEs
         TDLg==
X-Gm-Message-State: AA+aEWYWNTq6SqjD017h0T0wS2VuOTOLndNw/KEu1KMGnCQLCxHnAX5H
        /9AYE1e/ZkeLJDujoxeTfZ8NAxo=
X-Google-Smtp-Source: AFSGD/Xbkd8SmS9c/xAfQicAg8jfKUFgSUq3XjjNu5znO3QrgjzGOsa0jui6cqTdubm+VPAe8pFHsA==
X-Received: by 2002:a0c:b0db:: with SMTP id p27mr10925281qvc.73.1543706629798;
        Sat, 01 Dec 2018 15:23:49 -0800 (PST)
Received: from kmo-pixel (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id z8sm4171795qto.45.2018.12.01.15.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 15:23:48 -0800 (PST)
Date:   Sat, 1 Dec 2018 18:23:46 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
Subject: Bcachefs status update, current work
Message-ID: <20181201232346.GA3571@kmo-pixel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So, since I've been pretty quiet since LSF I thought I ought to give an update
on where bcachefs is at - and in particular talk about what sorts of problems
and improvements are currently being worked on.

As of last LSF, there was still a lot of work to be done before we had fast
mount times that don't require walking all metadata. There were two main work
items:
 - atomicity of filesystem operations. Any filesystem operation that had
   anything to do with i_nlink wasn't atomic (but they were ordered so that
   filesystem consistency wasn't an issue) - on startup we'd have to scan and
   recalculate i_nlink and also delete no longer referenced inodes.
 - allocation information wasn't persisted (per bucket sector counts) - so on
   startup we have to walk all the extents and recalculate all the disk space
   accounting.

#1 is done. For those curious about the details, if you've seen how bcachefs
implements rename (with multiple linked btree iterators), it's based off of
that. Basically, there's a new btree transaction context widget for allocating
btree iterators out of, and queuing up updates to be done at transaction commit
- so that different code paths (e.g. inode create, dirent create, xattr create)
can be used together without having to manually write code to keep track of all
the iterators that need to be used and kept locked, etc. I think it's pretty
neat how clean it turned out.

So basically, everything's fully atomic now except for fallocate/fcollapse/etc. -
and after unclean shutdown we do have to scan just the inodes btree for inodes
that have been deleted. Eventually we'll have to implement a linked list of
deleted inodes like xfs does (or perhaps fake hidden directory), but inodes are
small in bcachefs, < 100 bytes, so it's a low priority.

Erasure coding is about 80% done now. I'm quite happy with how erasure coding
turned out - there's no write hole (we never update existing stripes in place),
and we also don't fragment writes like zfs does. Instead, foreground writes are
replicated (raid10 style), and as soon as we have a stripe of new data we write
out p/q blocks and then update the extents with a pointer to the stripe and drop
the now unneeded replicas. Right now it's just reed solomon (raid5/6), but
weaver codes or something else could be added in the future if anyone wants to.
The part that still needs to be implemented before it'll be useful is stripe
level compaction - when we have stripes with some empty blocks (all the data in
them was overwritten), we need to use the remaining data blocks when creating
new stripes so that we can drop the old stripe (and stop pinning the empty
blocks). I'm leaving that off until later though because that won't impact the
on disk format at all, and there's other stuff I want to get done first.

My current priority is reflink - as that will be highly useful to the company
that's funding bcachefs development. That's more or less requiring me to do
persistent allocation information first though, so that's become my current
project (the reflinked extent refcounts will be much too big to keep in memory
like I am now for bucket sector counts, so they'll have to be kept in a btree
and updated whenever doing extent updates - and the infrastructure I need to
make that happen is also what I need for making all the other disk space
accounting persistent).

So, bcachefs will have fast mounts (including after unclean shutdown) soon.

At the very moment what I'm working on (leading up to fast mounts after clean
shutdowns, first) is some improvements to disk space accounting for multi device
filesystems.

The background to this is that in order to know whether you can safely mount in
degraded mode, you have to store a list of all the combinations of disks that
have data replicated across them (or are in an erasure coded stripe) - this is
assuming you don't have any kind of fixed layout, like regular RAID does. That
is, if you've got 8 disks in your filesystem, and you're running with
replicas=2, and two of your disks are offline, you need to know whether you have
any data that's replicated across those two particular disks.

bcachefs has such a table kept in the superblock, but entries in it aren't
refcounted - we create new entries if necessary when inserting new extents into
the extents btree, but we need a gc pass to delete them, generally triggered by
device removal. That's kind of lame, since it means we might fail mounts that
are actually safe.

So, before writing the code to persist the filesystem level sector counts I'm
changing it to track them broken out by replicas entry - i.e. per unique
combination of disks the data lies on. Which also means you'll be able to see in
a multi device filesystem how your data is laid out in a really fine grained
way.

Re: upstreaming - my current thinking is that since so much of the current
development involves on disk format changes/additions it probably make sense to
hold off until reflink is done, which I'm expecting to be in the next 3-6
months. That said, nothing has required any breaking disk format changes -
writing compat code where necessary has been easy enough, so there haven't been
any breaking changes except for one accidental dirent cockup in quite awhile
(~2 years, I think) and one or two changes in features that weren't considered
stable yet (e.g. there was a change to fix extent nonces when encryption was
still new, and I'm still making one or two breaking changes to erasure coding as
it can't actually be used yet without stripe compaction).

That sums up all the big stuff I can think of, the todo list continues to get
shorter and bugs continue to get fixed...
