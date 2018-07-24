Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6094ECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1D520852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWW0Zp6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1D520852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388332AbeGXCsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 22:48:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36324 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388267AbeGXCsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 22:48:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id d14-v6so456497pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 18:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XdVS798Ju2Hyug1eNSX0YMXJcbEBDzmh9IAjzKqwFFQ=;
        b=SWW0Zp6UE5togTYcZFwlnrFh8jrABELquR4ZL6BN+YiwDixgZ+uacEFajQ7F3EMUvH
         ikB75B9hLyV2dEC9vHJ5PEs128oUNQ24WKCEGnNJTkhTnURkKcpeCESDvXpKKP68bjAB
         RijhSGUpAosNn2ltOpdsWLbjvFNN0ZshM8U0BsdD/V00jDrantyTWaNX8EpnpaCugbp6
         YD8I1cTZRnS8kLwPUmpJ+SoNwHtGNZWgNsDxgW3pqoElrxJWsDpQSaIGmleLvXq/Dw+S
         8qHQ43qpqFNZw4u0QITT3w5j6l0l6Hn6dpMEezFmjTiQqkQozG6OjH+1jGIuMUmAXVND
         6oxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XdVS798Ju2Hyug1eNSX0YMXJcbEBDzmh9IAjzKqwFFQ=;
        b=b+rrR6auEYMGpotlZ0Cw+CCdvGeSmhTPZPj2BvzKa7e2V9GfStXJiQNosZx/8EMdP3
         R9EI5EKtxqCv2iZbrZneJsloiixDmmQIyuK7KQm56uD3/MHFpA1N9q+7eIMmdOyuun/E
         YCtjLD4I7zjCAHFZJGjwghCjf2O3I/4bnOIfEb/BJ3AnxfGJrgiKpZSENb0bimWNx1wq
         PeptYRRhFBtaKzOt4a9kyRmjGbFf9/8oDdDy71Jjp+tLPngytbWiLppSOAOEVgwLynv0
         kAs2nwVa8RKTHwmu4DCBsudZ5ekzpaeBbseej2hj/tO2l2cjSaiHGLU0ctmplrxjPcgQ
         BO6w==
X-Gm-Message-State: AOUpUlE9opCSZvjBGamfFdKjzc9MB1OowOTE/eaxnqiuYs+LGATPXUlK
        kBG1Gtq99FWJ96pGuW5nxiePWC/UK9Lg1Yx2F44FssLe
X-Google-Smtp-Source: AAOMgpeA80nEwV9q46vtg5VbP16JRIUjGUI5pdU3o1ZY8Fu04R903VyuGVDQP3s+QDSopO/U29QaEKw11der3+5oi4s=
X-Received: by 2002:a62:cd3:: with SMTP id 80-v6mr15750439pfm.184.1532396695052;
 Mon, 23 Jul 2018 18:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180719132834.GF18667@krava> <20180719191253.3843-1-xiyou.wangcong@gmail.com>
 <20180720115217.GQ2494@hirez.programming.kicks-ass.net> <CAM_iQpWVhLZKo9j6COGkvryGrxJq6sEXzh2S-ikza2H3=pAyqw@mail.gmail.com>
 <CAM_iQpV33dj-_bwYp3QJdPKihR8HyPzKMOpi1Lrqm7VtN3bZ8w@mail.gmail.com>
In-Reply-To: <CAM_iQpV33dj-_bwYp3QJdPKihR8HyPzKMOpi1Lrqm7VtN3bZ8w@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 23 Jul 2018 18:44:43 -0700
Message-ID: <CAM_iQpXUsVW7a0+_Z_R-k8xGEQBSKd5Oz7j5+z=G1kQHoDfCqQ@mail.gmail.com>
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

On Mon, Jul 23, 2018 at 6:35 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> Hi, Peter, Andi
>
> While reviewing the deadlock, I find out it looks like we could have the
> following infinite recursion too:
>
> perf_event_account_interrupt()
> __perf_event_account_interrupt()
> perf_adjust_period()
> event->pmu->stop
> x86_pmu_stop()
> x86_pmu.disable()

Hmm, x86_pmu_stop() calls __test_and_clear_bit(), so
we should not call x86_pmu.disable() twice here.



> intel_pmu_disable_event()
> intel_pmu_pebs_disable()
> intel_pmu_drain_pebs_buffer()
> intel_pmu_drain_pebs_nhm()
> <repeat....>
>
> This time is pure hardware events, attr.freq must be non-zero.
>
> And, we could enter this infinite recursion in NMI handler too:
>
> intel_pmu_handle_irq()
> perf_event_overflow()
> __perf_event_overflow()
> __perf_event_account_interrupt()
> ....
>
> Or this is impossible too?
>
> Thanks!
