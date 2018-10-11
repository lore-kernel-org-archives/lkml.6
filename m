Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EC3C4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B5020659
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B5020659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbeJKVOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:14:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbeJKVOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:14:32 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63E4F20652;
        Thu, 11 Oct 2018 13:47:15 +0000 (UTC)
Date:   Thu, 11 Oct 2018 09:47:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20181011094713.1d853af2@gandalf.local.home>
In-Reply-To: <3a7a180a-b644-bb0c-54e0-21dc3eb1d83b@i-love.sakura.ne.jp>
References: <20180928090939.GE1160@jagdpanzerIV>
        <3b378c7d-c613-4a8d-67f8-946fac8ad0b0@i-love.sakura.ne.jp>
        <20180929105151.GA1392@tigerII.localdomain>
        <91efcff8-dc6d-b7b4-9ac8-2f3882289f95@i-love.sakura.ne.jp>
        <20181001023721.GA6409@jagdpanzerIV>
        <880ef52f-dff7-af91-5353-f63513265ffe@i-love.sakura.ne.jp>
        <20181002063851.GF598@jagdpanzerIV>
        <5a958a1b-a986-014a-5908-816e0a3ef4ff@i-love.sakura.ne.jp>
        <20181008160310.ldwryudzkvp5de3b@pathway.suse.cz>
        <3ce1695b-9c47-40cc-602b-7c5ffb593024@i-love.sakura.ne.jp>
        <20181009145229.3lv5vl2ypz5i45cq@pathway.suse.cz>
        <a4a2ecae-3c47-db1f-8124-4d2d0ab8b91c@i-love.sakura.ne.jp>
        <d3e76073-c896-5807-1a2d-fe320643617d@i-love.sakura.ne.jp>
        <3a7a180a-b644-bb0c-54e0-21dc3eb1d83b@i-love.sakura.ne.jp>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2018 19:20:34 +0900
Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:

> Thus, here is v4.
> 
> >From a65f018d563928c7b7e4a9bec1d1a564dd8b4635 Mon Sep 17 00:00:00 2001  
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Thu, 11 Oct 2018 14:21:22 +0900
> Subject: [PATCH v4] printk: Add line-buffered printk() API.

Hi Tetsuo,

Can you resend this as a separate patch starting a new thread? Having
v4 hidden deep in another thread makes it hard to find patches like
these searching mail archives.

If you want to reference back to this discussion, just add in the v4
change log:

Link: https://lore.kernel.org/lkml/201805112058.AAB05258.HJQFFOMFOVtOSL@I-love.SAKURA.ne.jp/

Thanks!

-- Steve
