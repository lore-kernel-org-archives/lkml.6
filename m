Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D91EAD79C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D871213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GwrwK7C3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D871213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeGLSVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:21:50 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52481 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeGLSVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:21:50 -0400
Received: by mail-it0-f66.google.com with SMTP id p4-v6so8103126itf.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Kc8gvEjY/sJDU3kniCAuWeH+ScBR3Ojts/E3OM9Yiw=;
        b=GwrwK7C3wFKpHftBRBUZvzwbSEiAvg51YB+gASFes8YGTVvgT9RQdV4deD8e44MB4z
         vUtoYluX/+vkPYQC6v/73NK6h10vhCZkFsyauQnBgxw8hHYPtaaMGmlQeYHRT2j3EJNi
         kkznZfZMZu47ex5u1BJULUQIdlBNzIp4lmzjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Kc8gvEjY/sJDU3kniCAuWeH+ScBR3Ojts/E3OM9Yiw=;
        b=FNg6qdlldxxz5y66MuRpRco4KTg4LsVCzQmGDg6NY9fgJf8jBIaC0WMyj+H3UrD6ok
         A9b8yB7aLfl4W7u1Ewj/W41ZBu9ZQBHrgFfSt9Ov7sodAGisB/qwZOMUMcbNBeh5nhkX
         hYzhUDIXyA1M2ngwiy7lwbyyKc47zYsWFAYfQ3W5aaUvs+ZjaKA5tX1CUx3X4CVwgJEc
         x/H56KwMHZ8fLHgiIACZEbJEfZz/avf3JrVeKp4iaNeNRGbx0908s0RFgjv7g06y91ac
         R4gTmJp2cjDCqgPTTvJpGeFlQvPaJ0l2S6WkX/5Q7D/nbj1WZBzSjNXwGyYmLB2s2iZg
         O9+g==
X-Gm-Message-State: AOUpUlFs+dROjkHRt6rh9xDaDzpYJZDnCfPU49vQubDp/CRUxQVi9/cs
        qO+pueBVpNHW0zM5frDQWbZLnXFonysQIiHMGP0=
X-Google-Smtp-Source: AAOMgpeuXBebW8pEKkAxP7n3b3WfS8USgW2HviUWWzAF3sQrVKiqSq3yLaSPbDCwZ1z6v/DTCYVN24fRONpLsIA/LCg=
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr2481671jas.72.1531419069410;
 Thu, 12 Jul 2018 11:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180712134821.GT2494@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org>
 <20180712172838.GU3593@linux.vnet.ibm.com> <20180712180511.GP2476@hirez.programming.kicks-ass.net>
In-Reply-To: <20180712180511.GP2476@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Jul 2018 11:10:58 -0700
Message-ID: <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        andrea.parri@amarulasolutions.com,
        Will Deacon <will.deacon@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nick Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 11:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> The locking pattern is fairly simple and shows where RCpc comes apart
> from expectation real nice.

So who does RCpc right now for the unlock-lock sequence? Somebody
mentioned powerpc. Anybody else?

How nasty would be be to make powerpc conform? I will always advocate
tighter locking and ordering rules over looser ones..

           Linus
