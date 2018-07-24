Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3980ECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD7B20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICW2fcZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD7B20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388283AbeGXCkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 22:40:02 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:39925 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388239AbeGXCkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 22:40:02 -0400
Received: by mail-pg1-f174.google.com with SMTP id g2-v6so1638235pgs.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 18:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wV9FiCwqQUu7Z6OM2OS0MeAybJSOLX0iNkLEmcU6N6k=;
        b=ICW2fcZKRV2HQF4hZQdLB1Pn6Z2FuVRWS5jRW2qnQeUfaTrWknQDQaEjMeW026cO6B
         g4FUYbYKe6W/vXO9BqNUNwlg/e6AV3bBRKIpYt8NTxN5q5DrDAz4kO6jujCknWJv6hJe
         DtpOsEI0Xwht75dhJUwB87dksXW8VhKyc6/y2tAENpmIVA9RXAnaBIHU0ne3HpEvcn8P
         dxf2+5MstGLmUCBqxAQ/TMoRsOnMwWKzVrrB77F8RNnT8ZcyVMQ1hGowXgls05lg+fN2
         OwxumDRnjp6FOQcMDBYuSpgsKRxFtRlc2XmbAFvqFcP+8QboaR5Dk24uolg+v4gKK77n
         8CzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wV9FiCwqQUu7Z6OM2OS0MeAybJSOLX0iNkLEmcU6N6k=;
        b=reM6ORTqqbxhxFPFRvHxyLjV6FJKqKqm6GqlmAvnOpwzS9vRfOev3vKZbZrhNRMaF9
         Druf1LS7Qs4V1rwaJgj5mQIBlB3AEjSIUa5g8WxsqpfbRGShEmPyUAZoh19nXFrTTTKw
         BcHJmvitKUn0DMZ+KX2jBX1b02upF9EqRoRX1e3jH02vmr1K4Qn5fSHu0KpqIb6GVcEO
         gYb4w8HSKHYMaOZvK2THpmH0atnzZz6iwChfTbfP3tgDUrmpQxkqbxtwTDbiUdoF2XTa
         ZU/I7q/vXpzpjZURlrFvcLjaVKBTt/y7R/4sJU0G4GdwnXpvslNFDjWBIf/Wb3Hb2yvv
         iTxg==
X-Gm-Message-State: AOUpUlGeHT9UgSCczNBiybzJxbtIOdIRAawLV3KBdTic7oOTfSzM7Qhi
        MEg72lZRre6rKHqi3iuAGibLE9CkwaR5ckBzRXQ=
X-Google-Smtp-Source: AAOMgpfH1JkF9y9iiov/mr85Gi63YD9wIZ/DzxmbnFVL0JlY4AZWI69+8kctYykfT9t/Q3JOX20VOTL5PF1s0QaiGno=
X-Received: by 2002:a63:5d09:: with SMTP id r9-v6mr14232624pgb.303.1532396166160;
 Mon, 23 Jul 2018 18:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180719132834.GF18667@krava> <20180719191253.3843-1-xiyou.wangcong@gmail.com>
 <20180720115217.GQ2494@hirez.programming.kicks-ass.net> <CAM_iQpWVhLZKo9j6COGkvryGrxJq6sEXzh2S-ikza2H3=pAyqw@mail.gmail.com>
In-Reply-To: <CAM_iQpWVhLZKo9j6COGkvryGrxJq6sEXzh2S-ikza2H3=pAyqw@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 23 Jul 2018 18:35:54 -0700
Message-ID: <CAM_iQpV33dj-_bwYp3QJdPKihR8HyPzKMOpi1Lrqm7VtN3bZ8w@mail.gmail.com>
Subject: Re: [PATCH v2] perf/core: fix a possible deadlock scenario
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter, Andi

While reviewing the deadlock, I find out it looks like we could have the
following infinite recursion too:

perf_event_account_interrupt()
__perf_event_account_interrupt()
perf_adjust_period()
event->pmu->stop
x86_pmu_stop()
x86_pmu.disable()
intel_pmu_disable_event()
intel_pmu_pebs_disable()
intel_pmu_drain_pebs_buffer()
intel_pmu_drain_pebs_nhm()
<repeat....>

This time is pure hardware events, attr.freq must be non-zero.

And, we could enter this infinite recursion in NMI handler too:

intel_pmu_handle_irq()
perf_event_overflow()
__perf_event_overflow()
__perf_event_account_interrupt()
....

Or this is impossible too?

Thanks!
