Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83228C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 02:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24416206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 02:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2DY02bu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24416206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeJAJeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 05:34:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34137 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbeJAJeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 05:34:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so8116820pfi.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 19:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M/28XunWhhCCgScL7PFhM1ei0MlrNIqS5Wr4bXmkHW8=;
        b=O2DY02bu/C4m/x85iRmz25F7dQURpgfU4RpYcTm/Q0N4+8oLUUjW61GNkBzIWCo/my
         7kvRkEuC4V9d/S2oK4+Gw+5tOPdqZOS0161YR+k4FkZ8g0IJzC0LmyIQhKyQp8Gj4PnX
         bM7L1XRtezSijSKbi+vtutAnScbDgdyRRD4BmsjC309C+Be3XP6AG9dlSjTfVsBEFCfQ
         eAIG3aMACLM4DS0737p0b9y99HMKNBHDmyAVqEkvQUkZnYAz53uI6/3vyzvVJHEvDil8
         /LpKg/L/rzlyGd45KzkGwhFBlNJibU9XtRxTjCvjGwHJMbUmG5tlRs4fhSCpVW60bIcp
         5UlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M/28XunWhhCCgScL7PFhM1ei0MlrNIqS5Wr4bXmkHW8=;
        b=aihCn6EAWPojPY2buw2n0yVjHBnwCI+0cDZux5jZH5XVlhptTE3K6v8WFBAAyIvYdV
         qT1+Ey6SvTVNWkLWuzWaPQ1iWnWlNQhGFOzoiE47HhY51Wmnq1tmAQeHEPQgc9U4Vjme
         wEvqH7VOjnUEv4j3L2HCtsrwTd0iazb0acRYZ0ttYtVVGpSwSpn3F3WCbQbEBEBPx0h5
         faRBRfoczeDQGntq6JfCxUlKm4ZN1LWLFm9yP+3Xyoj8jvHChwQDGgw7I/yrK1KRuOFA
         yobCkXbrmH+0XtZ7nh+zDuQYRbt2QPL7fdsCrC4uc5et0JHGrGtkw6ifbTm+eqVJSbC4
         xlFQ==
X-Gm-Message-State: ABuFfoictKrElKIvclcrrQKMGyWK3feCIoYsVtpCAO0q1w84z7cm1baU
        kr835fbGH/r/t8J0OjLR2R4=
X-Google-Smtp-Source: ACcGV63Pr76RcrpWL4RfNx7OM6R3UiR2xpCnUlaWf5qoBz1MdkV2N6EFpI4EjLMuQB0gDokDuwPzsA==
X-Received: by 2002:a62:939d:: with SMTP id r29-v6mr1890700pfk.55.1538362713969;
        Sun, 30 Sep 2018 19:58:33 -0700 (PDT)
Received: from localhost ([39.7.15.30])
        by smtp.gmail.com with ESMTPSA id j62-v6sm11113045pgd.40.2018.09.30.19.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 19:58:32 -0700 (PDT)
Date:   Mon, 1 Oct 2018 11:58:28 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20181001025828.GB6409@jagdpanzerIV>
References: <20180914115028.GB20572@tigerII.localdomain>
 <e855cbef-03ff-b4ac-3e06-d2f2f48cfb1f@i-love.sakura.ne.jp>
 <20180914122217.GA518@tigerII.localdomain>
 <a661ed7f-889a-1811-0ada-111cc5185d05@i-love.sakura.ne.jp>
 <7dadfa8c-1f69-ae0f-d747-dbbc9f97c2b6@i-love.sakura.ne.jp>
 <20180928090939.GE1160@jagdpanzerIV>
 <3b378c7d-c613-4a8d-67f8-946fac8ad0b0@i-love.sakura.ne.jp>
 <20180929105151.GA1392@tigerII.localdomain>
 <91efcff8-dc6d-b7b4-9ac8-2f3882289f95@i-love.sakura.ne.jp>
 <20181001023721.GA6409@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001023721.GA6409@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/01/18 11:37), Sergey Senozhatsky wrote:
> If we are about to have a list of printk buffers then we probably can
> define a list of NR_CPUS cont buffers. And we probably can reuse the
> existing struct cont for buffered printk, having 2 different struct-s
> for the same thing - struct cont and struct printk_buffer - is not very
> cool.

And we also can re-use cont_add() / cont_flush() / etc.
Just pass a specific struct cont *cont to those functions.

> All printk()-s are limited by LOG_LINE_MAX. Buffered printk() is not
> special.

Correction: I was wrong about this.

Looking at cont handling, it seems that buffered printk is special after
all. We do let it to be over LOG_LINE_MAX:

	if (nr_ext_console_drivers || cont.len + len > sizeof(cont.buf))
		cont_flush();

	-ss
