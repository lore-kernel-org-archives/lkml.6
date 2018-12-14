Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A24C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098232070B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOSAW7Oe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbeLNPom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:44:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37777 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbeLNPom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:44:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so5432840wrt.4;
        Fri, 14 Dec 2018 07:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bzLOXkh9LfPSc7RB3nIWaQHbwWzLbI0DS5jxH8FYzpI=;
        b=nOSAW7OeyCKeRn0/8g56tKYKoAnIuSe27Ga33H+Y2BY1do4JDFSwngQnsG/o+YwaCK
         j863UnBSxnx2M7QG/ix1p6aIGwSYWoJPSQoi30sd9WwAk2ofrr8jG+uf0cfOSG3Q7wzF
         IahSm1ag03fae5lYuhgKtr6tWtzj5wKx47Zd2Jjgs4udnremf3g5Ntjt2C3O2qY6AtQI
         +ipoaG+XnOM3U3jPi0bGQJHUuVEo1tR1ZgvXAMHNcjJmOBj8IXTXKA9e+JCtIrLc1DcC
         boH8nT/ssX6wU/FPkTw/Zn4d7Qq5ROgCsNULWdTO/x8jclokx0cN9stWcvdEP/C6OY7+
         efZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bzLOXkh9LfPSc7RB3nIWaQHbwWzLbI0DS5jxH8FYzpI=;
        b=bPa6UlVKvrZMWO3ysV9l5U3qW3zudD1fyKp9nH+2zJiMkSYkwGe61yh5102BJTDjxI
         ebiSQgIIXJR4+o+mVTrlhYfpcq6A9dUR5FVkpwq93CuMoxq8Nwnwzid3rfvUpgRFepZD
         dEOcwkPYa6BYB4HshtdW/CczWFAmbe+plFJny/SDnJQIRYWeflkp7zmpN9kCrfskVi6u
         5BctO8VXe8TMzXf+Llveoh08eyGz3+k7hYqPdjBrkT+0P9XNIOJv5tqDU49z+GBslRa2
         AE/dlhCCJXJiiSfTUPFKnvkS1GOQXISPBtForWHZjopWeWPUUK9hgZGM5zWYBhDFbj1m
         /1vA==
X-Gm-Message-State: AA+aEWZ9qHGjY0H63YLwn/9XWRAMr4bfqrNcsvr+Io6oYejALVTl7tRf
        IcPmU6N/z9M/OFfPFmNwLA==
X-Google-Smtp-Source: AFSGD/WlWjyqGJi+AXr6muo+nCCT9SzPSYBYF4M01ULYFPfcJv34irCc6NPRpAKHgWKmednB+u9ncw==
X-Received: by 2002:adf:84e4:: with SMTP id 91mr2993020wrg.237.1544802279940;
        Fri, 14 Dec 2018 07:44:39 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id x15sm6306508wrs.27.2018.12.14.07.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 07:44:39 -0800 (PST)
Date:   Fri, 14 Dec 2018 18:44:36 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     =?utf-8?B?56iL5rSL?= <d17103513@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Davidlohr Bueso <dbueso@suse.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: > [PATCH] Security: Handle hidepid option correctly
Message-ID: <20181214154436.GA16772@avx2>
References: <18d54cd3edbf4fd3a7c01962f41ead58@cnbox5.mioffice.cn>
 <CADd0cq1HHv4xXn0tEWb4SfQ2XvoH33O1d1rogojj=hBTm+Lwww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADd0cq1HHv4xXn0tEWb4SfQ2XvoH33O1d1rogojj=hBTm+Lwww@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 03:26:04PM +0800, 程洋 wrote:
> Anyone who can review my patch?
> 
> 程洋 <chengyang@xiaomi.com> 于2018年11月30日周五 上午10:34写道：
> >
> > Here is an article illustrates the details.
> > https://medium.com/@topjohnwu/from-anime-game-to-android-system-security-vulnerability-9b955a182f20
> >
> > And There is a similar fix on kernel-4.4:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=99663be772c827b8f5f594fe87eb4807be1994e5
> >
> > Q: Other filesystems parse the options from fill_super().  Is proc special in some fashion?
> > A: According to my research, start_kernel will call proc_mount first, and initialize sb->s_root before any userspace process runs. If others want to mount it, all options will be ignored.
> >      AOSP change here: https://android-review.googlesource.com/c/platform/system/core/+/181345/4/init/init.cpp
> >      At first I though we should mount it with MS_REMOUNT flag. But kernel will crash if we did this.

This is not true: /proc is mounted by userspace (and it is easy to see
from the fact that proc_mount() is not called from kernel anywhere).

hidepid= in its current form is misdesigned, so might as well not bother
changing anything. IIRC there were(?) patches to make it per-mount.
