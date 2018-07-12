Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EADECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F1520871
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="eEISEjN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F1520871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732583AbeGLUko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:40:44 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:39249 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732368AbeGLUko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:40:44 -0400
Received: by mail-qt0-f179.google.com with SMTP id q12-v6so25289302qtp.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 13:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y9P5xpLiZ/YVcqcOKKqGXmgPSSIpSwEhi3IK7bCXLPo=;
        b=eEISEjN/5CiSPfS+EPMbg/JBfochmCt1NQB4vzP6TCgKOvrXYjS0eugc9z0MUBaF5/
         jAPqMq3qASt/y0ZRCLfPhwDbIPxBF8Gs0Xklm6qqkJ7yrfoKGbIufoNHKK/TmY0lbxQ3
         G7Xr0PUPivr75jYHcxXGU/pedktwKMdWchahU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y9P5xpLiZ/YVcqcOKKqGXmgPSSIpSwEhi3IK7bCXLPo=;
        b=jxLaAQWxuxn4s7Y1WthAfZLdi3vmh+S9QSjc7/JhRpUGGO1KBxEATT6iQgWIr/gZvh
         sNJDm+NWn+pLd+/mJy7RaIawKUU5T7Uwy8uQZpEc1QkqNKfplDI/8v8+FP3FqKSas3tN
         Hm5QQ7ZzAlTVOMXdxfBRJsJ2LehaAVIrLA/J7Y6kr23xIOvQTwpmOo3aZvm0cE1eWmAy
         OJGqijS94YioDnkBxjXVJL6HZHKKjmEGtR+PMVcGishxwy74aVm/OemhAbRi9UwgoCi4
         j6yRlmBWx5WCh3KEpleLeqBgf5eiLPsAh9D6oZ39Af74D8olfxgzrOyWAueJWZ6TQkZT
         yryg==
X-Gm-Message-State: AOUpUlGzCsQTllmOQ+ypRTsM2rZIho5hBDKNK6hsikI1GxZ4AzaYnUqD
        XaJGaWRnhAIRCBJOD/jdP1i2Yp9zFZYX7gFhj6UrgQ==
X-Google-Smtp-Source: AAOMgpe5UqILXbAhx3/7o+9HLGHD//gs1ypbUdvfKkuQcIqPEZ+zdyXFeZ4TOGdJ/3yYe0wYoVtbZYkvsMg8aoLHdBA=
X-Received: by 2002:a0c:afb8:: with SMTP id s53-v6mr4107605qvc.164.1531427372938;
 Thu, 12 Jul 2018 13:29:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:33c5:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 13:29:32
 -0700 (PDT)
In-Reply-To: <20180712161538.0737ba7f@gandalf.local.home>
References: <20180628182149.226164-1-joel@joelfernandes.org>
 <20180628182149.226164-5-joel@joelfernandes.org> <20180711124954.GE2476@hirez.programming.kicks-ass.net>
 <20180711090003.42596c2b@gandalf.local.home> <20180711142744.GN3593@linux.vnet.ibm.com>
 <20180711104618.05dc4b46@gandalf.local.home> <20180711205249.GA32091@joelaf.mtv.corp.google.com>
 <20180711232120.5dbfa1c7@vmware.local.home> <20180712042825.GA154647@joelaf.mtv.corp.google.com>
 <20180712093512.1f612a24@gandalf.local.home> <20180712191701.GA107829@joelaf.mtv.corp.google.com>
 <20180712161538.0737ba7f@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 12 Jul 2018 13:29:32 -0700
Message-ID: <CAEXW_YSxxEXF5knSDXsq=dTkZjtw_Qr1voo0A3qqW+KN8LKcMQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/7] tracepoint: Make rcuidle tracepoint callers use SRCU
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 1:15 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 12 Jul 2018 12:17:01 -0700
>> So then, we should use the regular variant for this additional check you're
>> suggesting.
>
> OK, I thought we had a rcu_dereference_notrace() that did checks and
> thought that this followed suit, but it appears there is no such call.
> That's where my confusion was.
>
> Sure, I'll nuke the notrace() portion, thanks.
>
> Also, I've applied 1-3, since 4 and 5 looks to be getting a remake, I'm
> going to remove them from my queue. Please fold the SPDX patch into 5.

Will do, and send out the 4 and 5 shortly with the SPDK folded.

Also the kselftest patches were acked and can be taken independently,
I had reposted them as a separate 2 patch series with some minor
changes based on your suggestions. Could you check them?

thanks!

- Joel
