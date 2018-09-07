Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E299BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 23:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817DF20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 23:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzhw1ooj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817DF20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeIHEjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 00:39:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51019 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeIHEjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 00:39:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so16172086wmc.0;
        Fri, 07 Sep 2018 16:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=taRPVOrHrGvD2YSua6Hf3AZ7rwDh97WOfd1mGUdVhd8=;
        b=kzhw1oojk/4IzpbpJACGYLV6lMz4ejnc5pUbHU9RWXlHbTeUqm+79B24wNrmJZ3tnJ
         SAl1JaVZv6KQ3CoQ6RWnsH9qrtmsgwzCU4nGX7pUgyeaH8DY8F91OBp3rPhrcT5st/sL
         +XjMNJmtU2CJJkiT98RrF3IqLcz3ycWdxk0oiAqN1oLbBbOJMUCdyV0+Bf3LELhlDgfF
         /CO4dsNetmeRv8sVD2kaLgQyDE790n6Mphlo1/XUqGIKsewRxu8a8HRDmFlAEAWFxAab
         xQ7RpA7VUCeemw8zgY7VXxaZ208BPleLeIy8VVdMgUWmglfcQI5TuVlPq+vj8uVxwZks
         0zTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=taRPVOrHrGvD2YSua6Hf3AZ7rwDh97WOfd1mGUdVhd8=;
        b=QCYwJGl3XecS/0JUJXDvUli5OQPmtPmvWcQU5aAMBZBTJIU0zzhNnXl5pr267XqWHE
         rFaFl/RP/QqXRHbiGym+bjxXwqkNojRhdWjVM2jCtmN5sZu1AeM/qxvUGDZ3fZcywgTc
         cvNnk0jCQ1G3pObSCCamLOBEroHGkiBTYrzLQQaqJHrfOD7jUcN6JRrgcqXSiH0SwPdI
         n8AQW09OHaHmTPz4ycRLHbRyOepGiv5GE2Lxg8Uxj20TOSxI/0TSQ2X0JtRF7IV6HCH2
         YESqA8IZnuu5v76qTl6CKPd8OH2c5EpujE9M7qusTBcIZ95vFrgeC1klvvPyRiFRmtPI
         ykkA==
X-Gm-Message-State: APzg51DqYRky0gMt34dvwonxYSQgBhdR6LogEaoNeWOUFC6nSJqXYzVc
        R3jSgoJmmNDqRSsB4Nq4dqk=
X-Google-Smtp-Source: ANB0VdaS9VtOpxO5qrEsjgJ/EVOYvgELnOUeSZqeN0MW2Ios9bPRJOFsyPLRJMX0bsWZJ/lV9n/koA==
X-Received: by 2002:a1c:578a:: with SMTP id l132-v6mr6726877wmb.16.1536364557591;
        Fri, 07 Sep 2018 16:55:57 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:c856:97f7:a8a9:88f6])
        by smtp.gmail.com with ESMTPSA id d10-v6sm14672192wrv.70.2018.09.07.16.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 16:55:56 -0700 (PDT)
Date:   Sat, 8 Sep 2018 01:55:54 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH] perf: enum overflow in uapi/linux/perf_event.h
Message-ID: <20180907235552.6a6oytkzzpn4pcgl@ltop.local>
References: <a70172863fa7d3c138f788b18d36524bd45b0a73.1536326078.git.christophe.leroy@c-s.fr>
 <20180907134246.GC24106@hirez.programming.kicks-ass.net>
 <ae32181d-37b2-1a13-3c72-66775e05ff88@c-s.fr>
 <20180907135817.GF24106@hirez.programming.kicks-ass.net>
 <7a086a56-a896-9513-7315-9d0d21b61a44@c-s.fr>
 <20180907184358.pg2ho4m4tc3dpwlw@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907184358.pg2ho4m4tc3dpwlw@ltop.local>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 08:43:59PM +0200, Luc Van Oostenryck wrote:
> On Fri, Sep 07, 2018 at 04:15:33PM +0200, Christophe LEROY wrote:
> > Le 07/09/2018 à 15:58, Peter Zijlstra a écrit :
> > > On Fri, Sep 07, 2018 at 01:50:18PM +0000, Christophe Leroy wrote:
> > > > 
> > > > 
> > > > On 09/07/2018 01:42 PM, Peter Zijlstra wrote:
> > > > > On Fri, Sep 07, 2018 at 01:27:19PM +0000, Christophe Leroy wrote:
> > > > > > On PPC32, enums are 32 bits, so __PERF_SAMPLE_CALLCHAIN_EARLY is
> > > > > > out of scope. The following sparse warning is encountered:
> > > > > > 
> > > > > >     CHECK   arch/powerpc/kernel/process.c
> > > > > > ./include/uapi/linux/perf_event.h:147:56: warning: cast truncates bits from constant value (8000000000000000 becomes 0)
> > > > > 
> > > > > Urgh... what compiler is that? I've not seen anything like that from the
> > > > > build bots.
> > > > > 
> > > > 
> > > > [root@pc16082vm linux-powerpc]# sparse --version
> > > > 0.5.2
> > > > 
> > > > [root@pc16082vm linux-powerpc]# ppc-linux-gcc --version
> > > > ppc-linux-gcc (GCC) 5.4.0
> > > 
> > > Ah, that's a sparse warning. But does your GCC agree? The thing is,
> > > sparse uses the C enum spec, but I suspect GCC uses the C++ enum spec
> > > and it all works fine.
> 
> Sparse is a bit weird about the exact underlying type used for enums.
> 
> > Ah yes, it seems that GCC is happy. So sparse should be fixed instead ?
> 
> I'll investigate (I suppose the same is given on x86-32).


It's definitively a bug in sparse. A relatively nasty one and which
open a can of worms. Fortunately, I had already looked at these
problems in May, I just didn't had the time to push the patches.

-- Luc
