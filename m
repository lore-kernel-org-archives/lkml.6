Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60F2C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A349A20811
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b/wiWi0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A349A20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeKSG5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 01:57:45 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:42314 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbeKSG5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 01:57:45 -0500
Received: by mail-lf1-f46.google.com with SMTP id l10so16271813lfh.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 12:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=c2q909P5sQXrRCxAmLqJKhSOqMwkN4WUpDNve55F4QM=;
        b=b/wiWi0ahgUOkI04rx2yD1qgNMQkfVEmb0YATHKOHwpMArfml6ygXROrPtmxDMZaNa
         Yo+JUbzUPKDqwJgW2d721zYXyYVgDBm1O1GHu9etMGuHZd5EWX0qX+gwULUbAUseJF10
         tXh5/vxMQB3aDxgihsV5ok62HJFhieBeqvo8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=c2q909P5sQXrRCxAmLqJKhSOqMwkN4WUpDNve55F4QM=;
        b=edpk/Oi41IQfITz+ON+E+FYKVgW1wl3+xoU3rlnsI2RvklzvcO1Xh2irG13nFovHRq
         yJKNSWfgY7DZiecn6r1wwa7pHeKjm8rIVGnHTrsG5zqw41cW0qcrnuQaejbGbsBKkSRk
         xyK3xxwVwA3MXwC5+07RyLPFRsL9A3fW28gc66tSaLB66iMhHaJO5NOxBJDovfhJtmgc
         89eX29fU3e+IBZ5XlvyQCWHpQitaJqbs25el2DUUvnvwI450FjEcpyrWhWpTFgffMLNT
         Gkv2GfV2o4SKhTrit/9O1lWEQBGKkajM9/NA/Vm5tLD93E4vqoo1k4nIjm8Z2/fAlY2K
         5xXw==
X-Gm-Message-State: AGRZ1gJ88/VBbaDXzkfw5OhiA6Ehi3umDOdiyYHNhK99P1Nngj/WMGGc
        2pLbkU8XJc7ve7e7IAKPq81++RIXCBQ=
X-Google-Smtp-Source: AJdET5cehQlGhgeIZsyWXIiv3K6eWu7OWr86JmEFm2MLW5ByYLwM8e/0Fbo/OeuEOlaS9py4MF/6QQ==
X-Received: by 2002:a19:2584:: with SMTP id l126mr9067318lfl.69.1542573386378;
        Sun, 18 Nov 2018 12:36:26 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id g17sm54154lfj.36.2018.11.18.12.36.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 12:36:25 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id p6so19883130lfc.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 12:36:24 -0800 (PST)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr8964929lfa.106.1542573384297;
 Sun, 18 Nov 2018 12:36:24 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 18 Nov 2018 12:36:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg-9FUGU=grF4gKDq1sm1m39Jbs3A_iyLbSSntU47ncwg@mail.gmail.com>
Message-ID: <CAHk-=wg-9FUGU=grF4gKDq1sm1m39Jbs3A_iyLbSSntU47ncwg@mail.gmail.com>
Subject: STIBP by default.. Revert?
To:     Jiri Kosina <jkosina@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was marked for stable, and honestly, nowhere in the discussion
did I see any mention of just *how* bad the performance impact of this
was.

When performance goes down by 50% on some loads, people need to start
asking themselves whether it was worth it. It's apparently better to
just disable SMT entirely, which is what security-conscious people do
anyway.

So why do that STIBP slow-down by default when the people who *really*
care already disabled SMT?

I think we should use the same logic as for L1TF: we default to
something that doesn't kill performance. Warn once about it, and let
the  crazy people say "I'd rather take a 50% performance hit than
worry about a theoretical issue".

                  Linus
