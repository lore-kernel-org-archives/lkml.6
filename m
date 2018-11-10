Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B038C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 21:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32AA214DB
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 21:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kl4XoSj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32AA214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeKKH3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 02:29:53 -0500
Received: from mail-it1-f178.google.com ([209.85.166.178]:56244 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeKKH3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 02:29:53 -0500
Received: by mail-it1-f178.google.com with SMTP id b7-v6so7790383itd.5;
        Sat, 10 Nov 2018 13:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NQ3XTGqk7TT54dMiJFYwymU6ZgR614PmxrDqJ7DQkdE=;
        b=Kl4XoSj8g3iDxLtbot+KHpwc2W5lvSLHPEQsTzaM3AHpYggVnZnvfiF/plNu+FZ6oh
         SDrWh2ISu+4+bjQQHlC4PnyZmXScuXVcpmZkqqmHVlDEfCEatlcoR2TjvgLa1+Poi1+G
         8LvGyWNzunYm9zhTsMFouYc2pTpS20uF34sDZou0RgWm4Mz/v/pJbesa5aHdpDEPfKO0
         Xlx/oxmxH9op0pSfZzSbUmuQhRKBg4CowC7s7z110udLhsk8BOfLRIg7ez0lOPDNqAef
         CNqDzXtRtQuZyo73OhRmObnCn8Qv3Gk/LaE5rSWzJ4mCPi/stqQU5m0es2vplr/bmls0
         RjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQ3XTGqk7TT54dMiJFYwymU6ZgR614PmxrDqJ7DQkdE=;
        b=N5piNB8lOpgeIptLlczUupvH8aIOT0+SiXTz7JYFfB/Lm41XZPPfhHu2ioSQjwY3h4
         QHpZYvJbz5jOTuM5CbDjm9L8kzVdDM2uKZAKmny3CcGQ9juJmqUZWsh9BQ6n8atx+OTJ
         tdRB4MEIQRSLS5Pv7fBNojZoD0nsjC6d+8vSk+GmXP+pcKPkIjZQ6Kzr1bf+P/v2XA99
         i8GxJmAl7Dz9TTYRhxEEQov4IGzwlEcN6XwYGOz7ayUnOf5o8XY1oK4l78xKSIOn4OR0
         6+KkVhgOHIeFRJqdv18anRfNAipFoq91dnCEfbwTaerk58Kbx5mAYsyFYxA0/LfFQBXR
         GZOA==
X-Gm-Message-State: AGRZ1gL1nkk5Lct7ZgCpi4RqvEXVfxWTTzeXFahFhyrIJBQyuMCM6Vcg
        GAwQX7UFTeg9yTxMJzn7H/Jr97jvV4uCqBGEc5s=
X-Google-Smtp-Source: AJdET5c1Hrtn+S1cIyBYYuK+agK5ZBzJnfTz9yyCAoDp4hzgMYvnLppS6y8waX8i8ZD4T6I4PYiuYwuURqXauhcUSdM=
X-Received: by 2002:a24:5e93:: with SMTP id h141-v6mr7125373itb.103.1541886207073;
 Sat, 10 Nov 2018 13:43:27 -0800 (PST)
MIME-Version: 1.0
References: <2335309.gnWok9HYb4@agathebauer> <3227038.olIWmsCzzY@agathebauer>
 <20181105205119.GC25674@krava> <3799078.YBnU1OB0PF@agathebauer> <20181106001037.GQ6218@tassilo.jf.intel.com>
In-Reply-To: <20181106001037.GQ6218@tassilo.jf.intel.com>
From:   Travis Downs <travis.downs@gmail.com>
Date:   Sat, 10 Nov 2018 16:42:48 -0500
Message-ID: <CAOBGo4za8hnGt1NUWy1Y1V12WycbxbYP0G0Sm=UT7T9dQ88vDg@mail.gmail.com>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
To:     ak@linux.intel.com
Cc:     milian.wolff@kdab.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 7:11 PM Andi Kleen <ak@linux.intel.com> wrote:
> Milian is right.
>
> There is a execution window from PEBS capturing registers to actually triggering
> the PMU, and if there is stack manipulation in that window
> the PEBS state might be out of sync with the real stack.

This explains some weird results I was always getting especially when
functions were small, including
failed unwindings when using dwarf unwinder.

I guess this problem doesn't occur for LBR unwinding since the LBR
records are captured at the same
moment in time as the PEBS record, so reflect the correct branch
sequence. Of course, LBR doesn't
always let you unwind fully, right?

>
> The right RIP/RSP to use for the stack unwinding is always the data
> in the PMI's exception frame on the stack.
>
> Probably would need to modify perf to report those too in addition
> to the PEBS registers.
>
> Of course it would still mean that the stack unwinding may not exactly
> match the sample RIP, but at least it should be consistent.

What would this fix mean for perf report when you use cycles:pp and
cycles:ppp (or any PEBS based events)? The unwinding should generally
work, but the IP at the top of that stack (from the PMI) will
generally be different than that recorded by PEBS. The tree view and
overhead calculations will be based on the captured stacks, I guess -
but when I annotate, will the values I see correspond to the PEBS IPs
or the PMI IPs?

If someone is using cycles:pp or :ppp they probably care about
instruction-level accuracy, so it would be a shame to throw it away.
