Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44148C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31F524FE3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JHEB0TC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31F524FE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753575AbeGBVUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:20:31 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:42848 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753549AbeGBVU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:20:28 -0400
Received: by mail-io0-f194.google.com with SMTP id r24-v6so15944813ioh.9;
        Mon, 02 Jul 2018 14:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WF+I7j7NP5fIo7U+NbJHqd5N1wms+Msn3iHS3Ji5Eqw=;
        b=JHEB0TC1/uZV1RGS/r7DOSXbynbmsBCo2gUvZbAhkkwjtXRCExca8iF8DkLUy5q4VG
         RoLkA67NeF0UHk1/R/EoXFp/5idgyxsoY5j/LFy20eVVL7uRwpHBPJjR9KOcr5aLHyfo
         hvYIqi1cUZIq21vLYBpc5ATo7p/Aalh96psPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WF+I7j7NP5fIo7U+NbJHqd5N1wms+Msn3iHS3Ji5Eqw=;
        b=aQ+poBSzqQDtbqQl/CqarffB4AzkLwHpHCEp6OFh5vMr5Nb2nsXLJNMLxm+SH5AvLH
         DIW4UHd+JBOq058fXqLPZCDzc/Qlbg8ei79Pcl41q6qmvWXBgHESUFPExvrmX5GORL+M
         vIqgY7KZ5Kbl9hG88jcCfDIOOqQNiTiTuIkKJ7Q499HhaVvEmxG47y+VCXVaMXu+KLSI
         nTdfiygdqEiEFB6CwrFn2P4XKr4PrB1ZQxlhLStTuzkPI/FCt+pkEzUmxMDpsEPX4PQ1
         a2Zx8nmgwrZkVE7IOwpuga34GMY8+3tKEpMVQsbgkCSyIEYDsuidOdcOxUuun2oynsTk
         y77Q==
X-Gm-Message-State: APt69E2k44XoPUh2aKElOU2UsAvwVEkBcj21+b41flSLoCe/ILgVGcep
        XWelVAM1W9Sek7OaiyuvUWaYDU/J1UnSmUl3QYo=
X-Google-Smtp-Source: AAOMgpfUimKzH/IeV4De/9ad5LhnUlMw1JbD7WmOia9Li71lSzW6Qu22uQByxstGrbWxrEjIA4fodP7w9fluWFeu8aQ=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr23366644ion.259.1530566427719;
 Mon, 02 Jul 2018 14:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180702204058.819-1-mathieu.desnoyers@efficios.com>
 <CA+55aFzH+4=Aeh_P1ptFn5nVm7yFuEGpxUJ0kNB-sUHVOv8rcw@mail.gmail.com> <1307337131.10790.1530565424717.JavaMail.zimbra@efficios.com>
In-Reply-To: <1307337131.10790.1530565424717.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 14:20:16 -0700
Message-ID: <CA+55aFwuBef8ajmeE-mw=6YHwYOQdnCMir7h2ebWxOzNrSQQFw@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: use __u64 for rseq_cs fields,
 validate abort_ip < TASK_SIZE
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>,
        Christoph Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 2:03 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
>         /* Ensure that abort_ip is not in the critical section. */
>         if (rseq_cs->abort_ip - rseq_cs->start_ip < rseq_cs->post_commit_offset)
>                 return -EINVAL;
> ...
> What underflow issues are you concerned with ?

That.

Looking closer, it looks like what you want to do is

     if (rseq_cs->abort_ip >= rseq_cs->start_ip && rseq_cs->abort_ip <
rseq_cs->start_ip + rseq_cs->post_commit_offset)

but you're not actually verifying that the range you're testing is
even vlid, because "rseq_cs->start_ip + rseq_cs->post_commit_offset"
could be something invalid that overflowed (or, put another way, the
subtraction you did on both sides to get the simplified version
underflowed).

So to actually get the range check you want, you should check the
overflow/underflow condition. Maybe it ends up being

        if (rseq_cs->start_ip + rseq_cs->post_commit_offset < rseq_cs->start_ip)
                return -EINVAL;

after which your simplified conditional looks fine.

But I think you should also do

        if (rseq_cs->start_ip + rseq_cs->post_commit_offset > TASK_SIZE)
                return -EINVAL;

to make sure the range is valid in the first place.

             Linus
