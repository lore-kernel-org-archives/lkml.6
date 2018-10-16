Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4258C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9114D20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9114D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeJPUck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:32:40 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:36682 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727042AbeJPUck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:32:40 -0400
Received: from mr1.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w9GCgMPE018752
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 08:42:22 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w9GCgHm6011424
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 08:42:22 -0400
Received: by mail-qt1-f200.google.com with SMTP id q48-v6so24077133qte.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 05:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=jrfxm+D/M+FIPBzak4i2H/bMQJvCd5PXWgk6ISzMjSw=;
        b=qAZOXvcZkk6pkv4vXYNp2Nz1Sioq+fQWXXUOISLns2IP5dQSpXSptvODM+JFdnH+a0
         3VMPQ6BePGvMiuZb2GaXHcDgarkY0BAwmVV9C95/BB2XYG9jDID2ikHV6V9tPeHun4+f
         98YgI+ywhOg/V7LH38LKm+VVFu7k1DS5WY0qQKPqrkHpts5hZZI+h3rQD2zY1NrXB1Q+
         COngJHGLEblsrKKg7imWqozn/llAWPN1cT0Og0L58l0Ln4Gr/Xn6PlSgssOqrFelI0JO
         eygUa1H1DrgTJFf9Y/NQfDoB1CVWOfRfAivJ9cv2zChO8g8YgTblraABMTOfqFDbN6hO
         QPYg==
X-Gm-Message-State: ABuFfoizbdQJ2wJ228SE+aQRy3BuoE9VoYDie0KUY/I6LNBMqrG+YRrh
        WL53iuWe66ko7dSh/3ILbULuMrtr62QeWrMzsaAI7Q0fYA7gU3FXegl8o/NrCkZDT57Cac51iqM
        Q/ryei6Cw0y0uJzra6jEofC5GOaFCtispz6s=
X-Received: by 2002:ac8:276a:: with SMTP id h39-v6mr15152689qth.274.1539693737148;
        Tue, 16 Oct 2018 05:42:17 -0700 (PDT)
X-Google-Smtp-Source: ACcGV63pz+OZk1sDRixOCIZ6CKflT2LILkYZsfNLi8pChzVb/SZ9JYjJGvYZausZqzEjdPmUmCkOEQ==
X-Received: by 2002:ac8:276a:: with SMTP id h39-v6mr15152658qth.274.1539693736745;
        Tue, 16 Oct 2018 05:42:16 -0700 (PDT)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4340::377])
        by smtp.gmail.com with ESMTPSA id k14-v6sm10795271qtk.28.2018.10.16.05.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 05:42:15 -0700 (PDT)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
cc:     Dennis Zhou <dennisszhou@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [BUG] ext4/block null pointer crashes in linux-next
In-reply-to: <20181016015201.GB18547@thunk.org>
References: <13987.1539646128@turing-police.cc.vt.edu>
 <20181016015201.GB18547@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 16 Oct 2018 08:42:14 -0400
Message-ID: <66480.1539693734@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018 21:52:01 -0400, "Theodore Y. Ts'o" said:
> Given the commit that it bisected down to, I very much doubt it has
> anything to do with a specific directory or pathname.  Either you or
> your distribution has enabled blk cgroup for I/O throttling, and

Bingo.

[~] zgrep CGROUP /proc/config.gz 
CONFIG_CGROUPS=y
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
(...)

> there's some race that you're tripping across.  What ext4 file or
> directory happens to be accessed when you trip across the problem is
> probably just pure luck.

I'm suspecting that my repeatable crash with rpm just does a *really*
good job of setting up the race.

> If you can disable the block I/O throttling configuration (which may
> very well be distro-specific), the problem will probably go away.  I
> don't use blkcg at all, personally, and on a personal laptop
> (especially if you have an SSD), I really don't see the point.

I often turn on new features just to watch the sparks fly.

> Still, I'm sure the people who *do* use blkcg for real (mostly in data
> centers, in my experience) will probably thank you for being a great
> guinea pig.  :-)

It's why I build a linux-next kernel every week. ;)

Looks like I should enable DEBUG_BLK_CGROUP and see what that says.

