Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB630C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912A120871
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RpdGOBd1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912A120871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934134AbeGIRzW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:55:22 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51605 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933757AbeGIRzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:55:21 -0400
Received: by mail-it0-f66.google.com with SMTP id g4-v6so10576405iti.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=bbHfMuMrrmphloUUIwdXihmj0pjnBrVZZaFk/LtGvps=;
        b=RpdGOBd1PlokXPQYMrHkeoCO73158fYQrborQpPt3IIm3JnjZldqYozQc145POZtlK
         MHoNMaW2tsPdMgZWA/gHcwsufEr0bkR4Ek7PXy6b7vi2UZN/Wnf9zFUYTfKH1EF5FUo5
         FOPB/R7L3yRosDcr0Uo8iDFm6GrG5hNhRdGEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=bbHfMuMrrmphloUUIwdXihmj0pjnBrVZZaFk/LtGvps=;
        b=FPruAB36qmX6BkPNNzLYge5GlDk7b2pjmODSv/syoboeyVeMaTIhbqkr0+9gxa2Bjr
         6ag15cx+h8QeSpfeGSdSvsLWDnCSAVCc3uEr05EWyQIrkjEW/Zo5Hzs527870JF0+wJQ
         6b36uYlgOwhp6FIvFTerqrEJczujPpk8DdD15kgPVmoYqpPEXLpLrESgWc1tcd6V+DDj
         FL4v+nDf0C/YfvyEbK5Yb41nbpvdsrZ43YFYDiBFOaIJLlVLHt03Pbq++/cPP+xJFWH6
         A0rAeixQAbeVyILsfQ0HA4P8/oX6OSSB7wXaKX1hFQqHKknZtEm41q4eICwW/tckZO2u
         00Hw==
X-Gm-Message-State: AOUpUlHvX5kbQBCIeXP54CRepo4H4oa3iNREtOGYQEJiO/xLvUfBmdAo
        RY62kSxeOs/nJ2Xmt72OUpHfSpzuAJpWB9GZxa/Jrw==
X-Google-Smtp-Source: AAOMgpfpdZ6vF7W6SDwCSxYxibtojVV7IJrr+doH5SkxtN2PuGmCo8M1kWJO5wijNHa34LG7o5mw6Ie8Pk+TFxnzjZ4=
X-Received: by 2002:a24:558a:: with SMTP id e132-v6mr6153491itb.2.1531158920764;
 Mon, 09 Jul 2018 10:55:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e492:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 10:55:20 -0700 (PDT)
X-Originating-IP: [2a02:168:5628:0:496f:7dc5:66d7:a057]
In-Reply-To: <20180709161232.up6vnuybvkxn76am@lakrids.cambridge.arm.com>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-11-daniel.vetter@ffwll.ch> <20180709103656.GH2476@hirez.programming.kicks-ass.net>
 <CAKMK7uEr9PJ0mex5CWdws55OwaLuHCbLJ5vP8KA4ZQXdAVOTYQ@mail.gmail.com>
 <20180709151258.GV2476@hirez.programming.kicks-ass.net> <20180709155204.GD3008@phenom.ffwll.local>
 <20180709160342.GA2476@hirez.programming.kicks-ass.net> <20180709161232.up6vnuybvkxn76am@lakrids.cambridge.arm.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 9 Jul 2018 19:55:20 +0200
X-Google-Sender-Auth: EHYgHoKt2m29KRhUWAKW_pLCiok
Message-ID: <CAKMK7uHQz6+=30nCU-8CerC9eRrwnA_O-cxRSoHHbGf0uNMYmA@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 11/12] sched: use for_each_if in topology.h
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 6:12 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Jul 09, 2018 at 06:03:42PM +0200, Peter Zijlstra wrote:
>> On Mon, Jul 09, 2018 at 05:52:04PM +0200, Daniel Vetter wrote:
>> > for_each_something(foo)
>> >     if (foo->bla)
>> >             call_bla(foo);
>> >     else
>> >             call_default(foo);
>> >
>> > Totally contrived, but this complains. Liberally sprinkling {} also shuts
>> > up the compiler, but it's a bit confusing given that a plain for {;;} is
>> > totally fine. And it's confusing since at first glance the compiler
>> > complaining about nested if and ambigous else doesn't make sense since
>> > clearly there's only 1 if there.
>>
>> Ah, so the pattern the compiler tries to warn about is:
>>
>>       if (foo)
>>               if (bar)
>>                       /* stmts1 */
>>               else
>>                       /* stmts2 *
>>
>> Because it might not be immediately obvious with which if the else goes.
>> Which is fair enough I suppose.
>>
>> OK, ACK.
>
> Just to bikeshed, there could be macros other than for_each_*() macros
> that will want to use this internally, so perhaps it would be worth the
> generic version being named something like if_noelse().
>
> We could always add that as/when required, though.

I think a better name would be really good, but both when we added it
for i915 and when we move it to drm headers we drew a blank.
if_noelse() describes pretty good what it does, but kinda fails on the
"where should I use it" departement. If there's some consensus I can
sed the patches quickly.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
