Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37A4C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB12720877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fmoYoXk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB12720877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933048AbeGIQGw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:06:52 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52357 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754618AbeGIQGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:06:46 -0400
Received: by mail-it0-f67.google.com with SMTP id p4-v6so26131383itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 09:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YfwKSvpHjElU5FYvYOHeJzzHdkdEokJPgsu2WhHVVPQ=;
        b=fmoYoXk3Izn8IgCRv82EtvBrSQYFFfCtuo5s+xzE+uvJPImiV5QJ4ryA2Y10oQgC/I
         +iCdUyc3u95gNip/DD0/WlC2UFjPQvtnX435DWXUp02ApQuNlqlXnjaPmnDgeL/Derl6
         w6hKN1/zPiogrGMfq4JBeIDcHRMvWuQXb1/6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YfwKSvpHjElU5FYvYOHeJzzHdkdEokJPgsu2WhHVVPQ=;
        b=mxGPBXKt6sw4t2CG3RRkwMgRroGLKLgtR91G4s82EVOQITawYCCT00A0o2RgeEFqTB
         G8leFLZtj5L0CqHTOVJI7OfXHP+M5HrG8o06QHrfdF2GTOpcTcOUTuePY+tYuoylu53p
         fBzR4iGXLNksqYotozRT9QQzkY0ePR8Qetl4pqSJF0fAPJLmXlKgEz2HZUy1v49RFODg
         9mz0RPyw2zfjCSh93uukevqnDIRFjrzsAItiKswNLqvY6KObeUCWmETGxKJaYMq3NVm8
         JpblK4MbDpC6Kl+E+/YtTbBholXcBDKIz0MnuUr0S9KIWnYrMyP5unrYd+BCMCc63XG0
         paAQ==
X-Gm-Message-State: APt69E0W5ua7e2rIMMnKRWpHf++y4ix/nJ524Ag1xzG797StC6p2nzOV
        /LuJngfQxuPOQpwxMLeEPB4orWT8bzYk3+eDNqMNew==
X-Google-Smtp-Source: AAOMgpd7oBiFySEcCbumydxH7ftfk9SiJAxoLel+rMUs6YIQgPFnWgvWZwAnFRtbRQ4uQ0+FghHt9b4GjmxLGoAGewk=
X-Received: by 2002:a24:edce:: with SMTP id r197-v6mr9069298ith.23.1531152405849;
 Mon, 09 Jul 2018 09:06:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e492:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 09:06:45 -0700 (PDT)
X-Originating-IP: [2a02:168:5628:0:496f:7dc5:66d7:a057]
In-Reply-To: <20180709160342.GA2476@hirez.programming.kicks-ass.net>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-11-daniel.vetter@ffwll.ch> <20180709103656.GH2476@hirez.programming.kicks-ass.net>
 <CAKMK7uEr9PJ0mex5CWdws55OwaLuHCbLJ5vP8KA4ZQXdAVOTYQ@mail.gmail.com>
 <20180709151258.GV2476@hirez.programming.kicks-ass.net> <20180709155204.GD3008@phenom.ffwll.local>
 <20180709160342.GA2476@hirez.programming.kicks-ass.net>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 9 Jul 2018 18:06:45 +0200
X-Google-Sender-Auth: kXk86gJMENR2-F_xzG9zMQj4ZFU
Message-ID: <CAKMK7uH2zUXCQw3DupDHHYJDL4WW_c_8bFDTA7TJs86CZsNNUw@mail.gmail.com>
Subject: Re: [PATCH 11/12] sched: use for_each_if in topology.h
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 6:03 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Jul 09, 2018 at 05:52:04PM +0200, Daniel Vetter wrote:
>> for_each_something(foo)
>>       if (foo->bla)
>>               call_bla(foo);
>>       else
>>               call_default(foo);
>>
>> Totally contrived, but this complains. Liberally sprinkling {} also shuts
>> up the compiler, but it's a bit confusing given that a plain for {;;} is
>> totally fine. And it's confusing since at first glance the compiler
>> complaining about nested if and ambigous else doesn't make sense since
>> clearly there's only 1 if there.
>
> Ah, so the pattern the compiler tries to warn about is:
>
>         if (foo)
>                 if (bar)
>                         /* stmts1 */
>                 else
>                         /* stmts2 *
>
> Because it might not be immediately obvious with which if the else goes.
> Which is fair enough I suppose.

Yup. I'll augment the commit message of patch 1 to include this as
example, and why it's confusing in context of a for_each_foo macro
containing an if().

> OK, ACK.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
