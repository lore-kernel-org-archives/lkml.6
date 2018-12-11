Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A0FC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C632081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbfO9IKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C632081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbeLKRLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:11:22 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:39029 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbeLKRLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:11:21 -0500
Received: by mail-pg1-f176.google.com with SMTP id w6so6917145pgl.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 09:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8OgCwscLeih7j0CX7Ch9bDbNrTvh+3890LbyGGm3TBU=;
        b=bbfO9IKMuXysWQo3oAkjbPMwLvjexaNrYE0w2YVZeWTJmDjaA2aIRgYSIfXYqa+jID
         5ExQFtHoAYMyVZ5zlZOcqNfLTm/L5C7NgjWWuWrIPT0It9dOztqIRe+MNEfKSIE8GdGx
         OaB8KCwxO/YXiE/hBnPE6OhXsGUO2f2wvzyzHfauQ1EfFAlKTef3WI0lck4pc7OTToMG
         +CoFzCSOGXC8UhucOCvG5XERw48k2KCem/g2YvtMRXGiecjbwANwktlqQjMoihsLKmfF
         nVzxMaX9M1GJKEXYZtkytz3hfHU/ljWxOUr9SrW/t7im7WPzH4HGPafxToiAhXp/LvHb
         VvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8OgCwscLeih7j0CX7Ch9bDbNrTvh+3890LbyGGm3TBU=;
        b=FLpUcIGarcVItSsEBnF6MHON0PpjwRuZbmXVn4WPPVrgTniL0oMbMnR7paISAitcYf
         DLEg1nQfsdG8NLeJDyDCzt108iNHmKHkFBEi5cQFATlHkLrZYc7eVDTtne7K0+M300xi
         yXhI6/x2hCJQvGTY1mqFmdN+GA/VbP+ge+zEz1kVTLw6uIYX8R69sbY2zd5q7fCKv6Ry
         IyCHTBE91xuX3gWtmzLC76wcBJ7tfgiC4W8cqpnrH1f0x9vAYum+moLW2J8LK+bp90FW
         oYgFvTX5mN1Pcu5E1V/qRwEFCK0y6uA5XGOSj4BZd4J/ndjE31yMfen+LHQycqknTJlO
         OYWA==
X-Gm-Message-State: AA+aEWZcbFIWzo+uuQPCxJBJkQ9ZeZTzNeCuK/whpOnjKnH7bst8pTLz
        lPlNdFs3KZu4bF19TZhqAvs=
X-Google-Smtp-Source: AFSGD/VXPscAdNDnCyP4+v8GFcL4GhhJ6zUC+uV6M19+lllbMN4yScolEeqO9Ukz2eEUg5iCPqE6lQ==
X-Received: by 2002:a63:960a:: with SMTP id c10mr15107172pge.106.1544548280110;
        Tue, 11 Dec 2018 09:11:20 -0800 (PST)
Received: from [10.71.1.72] ([12.37.166.69])
        by smtp.gmail.com with ESMTPSA id b27sm21059395pfh.113.2018.12.11.09.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 09:11:19 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: Should this_cpu_read() be volatile?
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20181210085532.GG5289@hirez.programming.kicks-ass.net>
Date:   Tue, 11 Dec 2018 09:11:17 -0800
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <058624AF-3933-4C44-A137-E33FC5180B86@gmail.com>
References: <20181203224920.GQ10377@bombadil.infradead.org>
 <C377D9EF-A0F4-4142-8145-6942DC29A353@gmail.com>
 <EB579DAE-B25F-4869-8529-8586DF4AECFF@gmail.com>
 <20181206102559.GG13538@hirez.programming.kicks-ass.net>
 <55B665E1-3F64-4D87-B779-D1B4AFE719A9@gmail.com>
 <20181207084550.GA2237@hirez.programming.kicks-ass.net>
 <C29C792A-3F47-482D-B0D8-99EABEDF8882@gmail.com>
 <C064896E-268A-4462-8D51-E43C1CF10104@gmail.com>
 <20181208105220.GF5289@hirez.programming.kicks-ass.net>
 <5DE00B41-835C-4E68-B192-2A3C7ACB4392@gmail.com>
 <20181210085532.GG5289@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Dec 10, 2018, at 12:55 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Sun, Dec 09, 2018 at 04:57:43PM -0800, Nadav Amit wrote:
>>> On Dec 8, 2018, at 2:52 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
>>> My patch proposed here:
>>> 
>>> https://marc.info/?l=linux-mm&m=154409548410209
>>> 
>>> would actually fix that one I think, preempt_count() uses
>>> raw_cpu_read_4() which will loose the volatile with that patch.
> 
>> I tested the patch you referenced, and it certainly improves the situation
>> for reads, but there are still small and big issues lying around.
> 
> I'm sure :-(, this has been 'festering' for a long while it seems. And
> esp. on x86 specific code, where for a long time we all assumed the
> various per-cpu APIs were in fact the same (which turns out to very much
> not be true).
> 
>> The biggest one is that (I think) smp_processor_id() should apparently use
>> __this_cpu_read().
> 
> Agreed, and note that this will also improve code generation on !x86.
> 
> However, I'm not sure the current !debug definition:
> 
> #define smp_processor_id() raw_smp_processor_id()
> 
> is actually correct. Where raw_smp_processor_id() must be
> this_cpu_read() to avoid CSE, we actually want to allow CSE on
> smp_processor_id() etc..

Yes. That makes sense.

> 
>> There are all kind of other smaller issues, such as set_irq_regs() and
>> get_irq_regs(), which should run with disabled interrupts. They affect the
>> generated code in do_IRQ() and others.
>> 
>> But beyond that, there are so many places in the code that use
>> this_cpu_read() while IRQs are guaranteed to be disabled. For example
>> arch/x86/mm/tlb.c is full with this_cpu_read/write() and almost(?) all
>> should be running with interrupts disabled. Having said that, in my build
>> only flush_tlb_func_common() was affected.
> 
> This all feels like something static analysis could help with; such
> tools would also make sense for !x86 where the difference between the
> various per-cpu accessors is even bigger.

If something like that existed, it could also allow to get rid of
local_irq_save() (and use local_irq_disable() instead).
