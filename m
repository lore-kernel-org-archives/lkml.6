Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE8BC282CD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B36520857
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbfA3E3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 23:29:44 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:33840 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727720AbfA3E3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 23:29:43 -0500
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x0U4TfSi018256
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 23:29:41 -0500
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x0U4TaOi020181
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 23:29:41 -0500
Received: by mail-qk1-f199.google.com with SMTP id d196so24175255qkb.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 20:29:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=Jps3n6PSXK0yCZsJRdQHZLGg22Bqo8S7sPKjWDkfAz4=;
        b=FXooBP8mtSjn20p/KD+CyCVuXrxYixib5XolsYCqIa13ALou/7G1IyDsOnPOhH8YeY
         Pp0dz/Y1rovssY1K33gysAeOCJtarqNX7oIhWFb4HkERRQPA3++PJsdXZuDF0kkkklbB
         iX6iZtdVm+FWmkuRBNpeBkZXrGekCztOnwGK9wfUoy0YrjEVBotqMh+ZGEpfPTHdejVI
         ptrC3p3//THixnSxr9xD9bhk42Q40iAoIOhpxSHTkihNcmCbKDnNdyYu1N/TfDSJ8WTM
         d1dPrBlR+5bfIzd7tf0Xd+IVsHgXE3Ww4n3OIdaU6WOyPi03f2x54+yO4tu4kqGuRBXH
         usWQ==
X-Gm-Message-State: AJcUukdDuriLSNP3yMAuEIago+LcJBfGeSiP0IzXTWHOOE58ccKJ1335
        2RCBKa/BRFon+FLEm9qmomwTsTEjgkipOLkZxBkPiMT8UPtRirY4Wu4n0Wa9cUlX42eiqN1xGNd
        B55siDXHUHkqxyWB8NpPpUsFfvHOApDSl3F0=
X-Received: by 2002:a0c:d792:: with SMTP id z18mr27386596qvi.183.1548822576678;
        Tue, 29 Jan 2019 20:29:36 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6Ls3B/Q0dYC+qBSN2wwftQIyMZe8ugyJfnO6f/dYNG10pWcCgq2W/i9IS0ZpUTHzYQCv1oXw==
X-Received: by 2002:a0c:d792:: with SMTP id z18mr27386577qvi.183.1548822576322;
        Tue, 29 Jan 2019 20:29:36 -0800 (PST)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id 128sm245158qkn.77.2019.01.29.20.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 20:29:35 -0800 (PST)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, vbabka@suse.cz,
        aarcange@redhat.com, rientjes@google.com, mhocko@kernel.org,
        zi.yan@cs.rutgers.edu, hannes@cmpxchg.org
Subject: Re: [regression -next0117] What is kcompactd and why is he eating 100% of my cpu?
In-reply-to: <14875.1548810399@turing-police.cc.vt.edu>
References: <20190126200005.GB27513@amd> <12171.1548557813@turing-police.cc.vt.edu> <20190127141556.GB9565@techsingularity.net> <20190127160027.GA9340@amd> <13417.1548624994@turing-police.cc.vt.edu> <20190128091627.GA27972@quack2.suse.cz>
 <14875.1548810399@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 29 Jan 2019 23:29:37 -0500
Message-ID: <9618.1548822577@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019 20:06:39 -0500, valdis.kletnieks@vt.edu said:
> On Mon, 28 Jan 2019 10:16:27 +0100, Jan Kara said:
>
> > So my buffer_migrate_page_norefs() is certainly buggy in its current
> > incarnation (as a result block device page cache is not migratable at all).
> > I've sent Andrew a patch over week ago but so far it got ignored. The patch
> > is attached, can you give it a try whether it changes something for you?
> > Thanks!
>
> Been running with the patch for about 24 hours, haven't seen kcompactd
> misbehave.  I even fired up a Chrome with a lot of tabs open, a Firefox, and a
> kernel build, intentionally drove the system into swapping, and kcompactd
> didn't make it into the top 10 on 'top'.
>
> I'm willing to say put a "tested-by:" on that one,  it looks fixed from here.
> If there's any remaining bugs, they're ones I can't seem to trigger...

Spoke too soon.  Sitting here not stressing the laptop at all, plenty of free
memory, and ka-blam.

Will keep my eyes open and do the data gathering Mel Gorban wanted - I discovered
too late that trace-cmd wasn't installed, and things broke free by themselves (probably
not coincidence that I launched a terminal window and then it cleared....)

top - 23:24:03 up  2:19,  1 user,  load average: 2.70, 2.00, 1.55
Tasks: 221 total,   3 running, 218 sleeping,   0 stopped,   0 zombie
%Cpu(s): 15.6 us, 67.3 sy,  0.0 ni,  9.5 id,  0.0 wa,  5.6 hi,  2.0 si,  0.0 st
GiB Mem :      7.6 total,      2.7 free,      3.1 used,      1.8 buff/cache
GiB Swap:      8.0 total,      8.0 free,      0.0 used.      4.1 avail Mem 

  PID  PPID  %MEM  PR  NI S    VIRT    RES    SHR   SWAP   UID  %CPU     TIME+ COMMAND                                 
   27     2   0.0  20   0 R    0.0m   0.0m   0.0m   0.0m     0  78.5   2:11.91 kcompactd0

