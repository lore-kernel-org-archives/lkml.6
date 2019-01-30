Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805EBC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586B02086C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfA3BGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 20:06:48 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:39454 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726693AbfA3BGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 20:06:48 -0500
Received: from mr4.cc.vt.edu (mr4.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x0U16lFn001290
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 20:06:47 -0500
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x0U16gkR014393
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 20:06:47 -0500
Received: by mail-qt1-f198.google.com with SMTP id w18so26607734qts.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 17:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=KCfxyw28pJTkT4Pxa5YE6ES0HyYW9dDOm+XE6a0guVM=;
        b=KUoqu0Fx5CktN8QsXjxsf5hwRzErEXAbYt5m8B9kifGrTFYN5mAgmEcVjVF0DQoyMB
         1tmMIHYxZ30I1sVm1M/RGEfzYoegbB8ZVSkOyhWWHfQUZrq0gfMgubld5P0EwTbAvXzo
         ufP5ptY5q2lbYr4vtNIUVmq0z/I4FgsOLHq0fW0WU0zzVApBbL+wiGk9tP8UXNkLHM74
         ZirqNyo35O8KYy5EiFL2eFYKT9nwBpqbBoBA4Oyvb0cbDcYFlZ9s7t8fQwuGQL5xXn/T
         Hj34+4+B3UXXEoZyKQqnUGNd30dybh7dNbQbXL5RVJiJh3rFuL9OSTD97bmHcoru5MRr
         VMJQ==
X-Gm-Message-State: AJcUukcIcBxD/oN1RY7JiA0I+OqUemwo0itueGYYAJFB7Jpplxzirbuf
        VQ3ZW8sJXKtgZsW1af9oSqWP4mS/5gXvJeT0sMeIG3NeHlhGKQTPd0LhqMz6t6TnG0TjQCKWDHg
        YOTUKKL75ocRkKLT8/5tkmx1IlvTFjnDUSG4=
X-Received: by 2002:a0c:f8cb:: with SMTP id h11mr27142555qvo.134.1548810402116;
        Tue, 29 Jan 2019 17:06:42 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4NENS8kOPtZCwisiX+XNzRSNeiRRAIhAwQOu/X0TDutUDpoy4NN4J5/GgheBSh9ZxV+I9uJA==
X-Received: by 2002:a0c:f8cb:: with SMTP id h11mr27142544qvo.134.1548810401911;
        Tue, 29 Jan 2019 17:06:41 -0800 (PST)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id r47sm3631qtc.77.2019.01.29.17.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 17:06:40 -0800 (PST)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Jan Kara <jack@suse.cz>
cc:     Pavel Machek <pavel@ucw.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, vbabka@suse.cz,
        aarcange@redhat.com, rientjes@google.com, mhocko@kernel.org,
        zi.yan@cs.rutgers.edu, hannes@cmpxchg.org
Subject: Re: [regression -next0117] What is kcompactd and why is he eating 100% of my cpu?
In-reply-to: <20190128091627.GA27972@quack2.suse.cz>
References: <20190126200005.GB27513@amd> <12171.1548557813@turing-police.cc.vt.edu> <20190127141556.GB9565@techsingularity.net> <20190127160027.GA9340@amd> <13417.1548624994@turing-police.cc.vt.edu>
 <20190128091627.GA27972@quack2.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 29 Jan 2019 20:06:39 -0500
Message-ID: <14875.1548810399@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 10:16:27 +0100, Jan Kara said:

> So my buffer_migrate_page_norefs() is certainly buggy in its current
> incarnation (as a result block device page cache is not migratable at all).
> I've sent Andrew a patch over week ago but so far it got ignored. The patch
> is attached, can you give it a try whether it changes something for you?
> Thanks!

Been running with the patch for about 24 hours, haven't seen kcompactd
misbehave.  I even fired up a Chrome with a lot of tabs open, a Firefox, and a
kernel build, intentionally drove the system into swapping, and kcompactd
didn't make it into the top 10 on 'top'.

I'm willing to say put a "tested-by:" on that one,  it looks fixed from here.
If there's any remaining bugs, they're ones I can't seem to trigger...

