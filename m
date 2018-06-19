Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBBDC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8572075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjPDZnEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8572075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966984AbeFSQup (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:50:45 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36712 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966267AbeFSQum (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:50:42 -0400
Received: by mail-wr0-f196.google.com with SMTP id f16-v6so374923wrm.3
        for <Linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rVFgyP1KE5xMBXN+HpLu/MN57VafxmiU4QyvRo+QvzI=;
        b=gjPDZnEbLICQF0itOEfGvi2+AylPkREn0tqFV7BvquM/kCA4Qcfyf89NzPvGMWtN9s
         4rTRJbjwAlf4vWqUjxm+aDK/fAzV/eYW9kSB5h2AMW7FnuSdPV7n3+0GosfGfBdiV7Cq
         i2jFX1TBK9FsZpcuxLOEcTxdAODaNwL0QM3lI2CwQ8lHwCjk4rwCFCOB0nklubgJC+HB
         VWPizoxL7doIWw5av/a1I5KBvHVxiDyS2uOSlvkIhs2xgzV8FM9n7kvOQlQkYhRchHlO
         1yOZb+bjndAhnf8OdY/nQuAjiFXmoOwRxb1QhupQw+mjrC0uDPHfLaV7XWydn5gZMUWV
         0ywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rVFgyP1KE5xMBXN+HpLu/MN57VafxmiU4QyvRo+QvzI=;
        b=UNYB7ijoUZaSu7YypoPiMZPeYahG/kxpAxf91CNbqH7UURLwcK2oqWx9was3mQ+/zq
         nuEAG2m5gcxNVq+byLW5dfxZUBk+KGF0YkFr0xqctEgdxKKLeHqI6uznIcM13BzgQZlO
         j88LC9kUwL66J598YTcc5gOJSqvy+nRO2Vy0JBvdVWqamXXiK10t/TBXX+Ebqepn+5wo
         22Zqnv4Qjy3Z3qGXOcn0ZrRTbzoldazVX4UQCG1RNEnT8LwIkZxTGFtGHVOYuGO8PJNW
         +fey1b9kuQPjVCq4PK3krplNsMqdOmA4U5YTm4KZAhohsNq2HICV/izeVlZWJQZZowEf
         FhtQ==
X-Gm-Message-State: APt69E00IRcjEjxSSYoHoZrJrWaKyK5sy1KWdlxx8F9/U97if7enEFuG
        5hdArIYlUGPewERwZ6v6cMUZrr0pmCiuKzyGI8WtTg==
X-Google-Smtp-Source: ADUXVKK2Bq36ZjP+UT8zio09hTJTYxzUpIUh+u+Ekzi+6X1MpT0c0ywImzt2XTJBsiiMkzZwhCNOlQU3P5BzqryQfNQ=
X-Received: by 2002:adf:a0ee:: with SMTP id n43-v6mr15494976wrn.23.1529427041070;
 Tue, 19 Jun 2018 09:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
 <1529057003-2212-2-git-send-email-yao.jin@linux.intel.com>
 <CABPqkBRoecNKQEuJaEw1E+1a5KF-aTucAWK+St8A15FU9dsZsw@mail.gmail.com> <5ee8dba2-3346-615c-84a2-3a65203c06a8@linux.intel.com>
In-Reply-To: <5ee8dba2-3346-615c-84a2-3a65203c06a8@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 19 Jun 2018 09:50:29 -0700
Message-ID: <CABPqkBSqbTmw4bha6bXXLcEYH3Qj4KwAFNLjp8F=pCJM8t4k=A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf/core: Use sysctl to turn on/off dropping
 leaked kernel samples
To:     yao.jin@linux.intel.com
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kyle Huey <me@kylehuey.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Will Deacon <will.deacon@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 12:15 AM Jin, Yao <yao.jin@linux.intel.com> wrote:
>
>
>
> On 6/15/2018 1:59 PM, Stephane Eranian wrote:
> > On Thu, Jun 14, 2018 at 7:10 PM Jin Yao <yao.jin@linux.intel.com> wrote:
> >>
> >> When doing sampling, for example:
> >>
> >> perf record -e cycles:u ...
> >>
> >> On workloads that do a lot of kernel entry/exits we see kernel
> >> samples, even though :u is specified. This is due to skid existing.
> >>
> >> This might be a security issue because it can leak kernel addresses even
> >> though kernel sampling support is disabled.
> >>
> >> One patch "perf/core: Drop kernel samples even though :u is specified"
> >> was posted in last year but it was reverted because it introduced a
> >> regression issue that broke the rr-project, which used sampling
> >> events to receive a signal on overflow. These signals were critical
> >> to the correct operation of rr.
> >>
> >> See '6a8a75f32357 ("Revert "perf/core: Drop kernel samples even
> >> though :u is specified"")' for detail.
> >>
> >> Now the idea is to use sysctl to control the dropping of leaked
> >> kernel samples.
> >>
> >> /sys/devices/cpu/perf_allow_sample_leakage:
> >>
> >> 0 - default, drop the leaked kernel samples.
> >> 1 - don't drop the leaked kernel samples.
> >>
> >> For rr it can write 1 to /sys/devices/cpu/perf_allow_sample_leakage.
> >>
> >> For example,
> >>
> >> root@skl:/tmp# cat /sys/devices/cpu/perf_allow_sample_leakage
> >> 0
> >> root@skl:/tmp# perf record -e cycles:u ./div
> >> root@skl:/tmp# perf report --stdio
> >>
> >> ........  .......  .............  ................
> >>
> >>      47.01%  div      div            [.] main
> >>      20.74%  div      libc-2.23.so   [.] __random_r
> >>      15.59%  div      libc-2.23.so   [.] __random
> >>       8.68%  div      div            [.] compute_flag
> >>       4.48%  div      libc-2.23.so   [.] rand
> >>       3.50%  div      div            [.] rand@plt
> >>       0.00%  div      ld-2.23.so     [.] do_lookup_x
> >>       0.00%  div      ld-2.23.so     [.] memcmp
> >>       0.00%  div      ld-2.23.so     [.] _dl_start
> >>       0.00%  div      ld-2.23.so     [.] _start
> >>
> >> There is no kernel symbol reported.
> >>
> >> root@skl:/tmp# echo 1 > /sys/devices/cpu/perf_allow_sample_leakage
> >> root@skl:/tmp# cat /sys/devices/cpu/perf_allow_sample_leakage
> >> 1
> >> root@skl:/tmp# perf record -e cycles:u ./div
> >> root@skl:/tmp# perf report --stdio
> >>
> >> ........  .......  ................  .............
> >>
> >>      47.53%  div      div               [.] main
> >>      20.62%  div      libc-2.23.so      [.] __random_r
> >>      15.32%  div      libc-2.23.so      [.] __random
> >>       8.66%  div      div               [.] compute_flag
> >>       4.53%  div      libc-2.23.so      [.] rand
> >>       3.34%  div      div               [.] rand@plt
> >>       0.00%  div      [kernel.vmlinux]  [k] apic_timer_interrupt
> >>       0.00%  div      libc-2.23.so      [.] intel_check_word
> >>       0.00%  div      ld-2.23.so        [.] brk
> >>       0.00%  div      [kernel.vmlinux]  [k] page_fault
> >>       0.00%  div      ld-2.23.so        [.] _start
> >>
> >> We can see the kernel symbols apic_timer_interrupt and page_fault.
> >>
> > These kernel symbols do not match your description here. How much skid
> > do you think you have here?
> > You're saying you are at the user level, you get a counter overflow,
> > and the interrupted IP lands in the kernel
> > because you where there by the time the interrupt is delivered. How
> > many instructions does it take to get
> > from user land to apic_timer_interrupt() or page_fault()? These
> > functions are not right at the kernel entry,
> > I believe. So how did you get there, the skid must have been VERY big
> > or symbolization has a problem.
> >
>
> I'm testing with the latest perf/core branch (4.17+). Again I test with
> Linux's vmstat (not test with my application).
>
> perf record -e cycles:u vmstat 1
> perf script -F ip
>
>       7f84e2b0bc30
>       7f84e2b0bc30
>       7f84e2b0bc30
>       7f84e2b0bc30
>   ffffffffb7a01070
>       7f84e2b243f0
>       7f84e2b11891
>       7f84e2b27f5e
>       7f84e25a3b26
>       7f84e25680f5
>
> cat /proc/kallsyms  | grep page_fault
> ....
> ffffffffb7a01070 T page_fault
> ffffffffb7a010a0 T async_page_fault
> ....
>
> So one sample (ip ffffffffb7a01070) hits on page_fault.
>
> Maybe you can have a try too. :)
>
Ok, I tried and checked! These symbols are all in entry_64.S, these
are the first instructions executed on the timer intr or fault.
So it looks normal that they show up due to the interrupt skid, even
if the skid is 1 cycle.
PEBS, especially when using precise=1 could also show these symbols.

>
> Thanks
> Jin Yao
>
> >> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> >> ---
> >>   kernel/events/core.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 58 insertions(+)
> >>
> >> diff --git a/kernel/events/core.c b/kernel/events/core.c
> >> index 80cca2b..7867541 100644
> >> --- a/kernel/events/core.c
> >> +++ b/kernel/events/core.c
> >> @@ -7721,6 +7721,28 @@ int perf_event_account_interrupt(struct perf_event *event)
> >>          return __perf_event_account_interrupt(event, 1);
> >>   }
> >>
> >> +static int perf_allow_sample_leakage __read_mostly;
> >> +
> >> +static bool sample_is_allowed(struct perf_event *event, struct pt_regs *regs)
> >> +{
> >> +       int allow_leakage = READ_ONCE(perf_allow_sample_leakage);
> >> +
> >> +       if (allow_leakage)
> >> +               return true;
> >> +
> >> +       /*
> >> +        * Due to interrupt latency (AKA "skid"), we may enter the
> >> +        * kernel before taking an overflow, even if the PMU is only
> >> +        * counting user events.
> >> +        * To avoid leaking information to userspace, we must always
> >> +        * reject kernel samples when exclude_kernel is set.
> >> +        */
> >> +       if (event->attr.exclude_kernel && !user_mode(regs))
> >> +               return false;
> >> +
> >> +       return true;
> >> +}
> >> +
> >>   /*
> >>    * Generic event overflow handling, sampling.
> >>    */
> >> @@ -7742,6 +7764,12 @@ static int __perf_event_overflow(struct perf_event *event,
> >>          ret = __perf_event_account_interrupt(event, throttle);
> >>
> >>          /*
> >> +        * For security, drop the skid kernel samples if necessary.
> >> +        */
> >> +       if (!sample_is_allowed(event, regs))
> >> +               return ret;
> >> +
> >> +       /*
> >>           * XXX event_limit might not quite work as expected on inherited
> >>           * events
> >>           */
> >> @@ -9500,9 +9528,39 @@ perf_event_mux_interval_ms_store(struct device *dev,
> >>   }
> >>   static DEVICE_ATTR_RW(perf_event_mux_interval_ms);
> >>
> >> +static ssize_t
> >> +perf_allow_sample_leakage_show(struct device *dev,
> >> +                              struct device_attribute *attr, char *page)
> >> +{
> >> +       int allow_leakage = READ_ONCE(perf_allow_sample_leakage);
> >> +
> >> +       return snprintf(page, PAGE_SIZE-1, "%d\n", allow_leakage);
> >> +}
> >> +
> >> +static ssize_t
> >> +perf_allow_sample_leakage_store(struct device *dev,
> >> +                               struct device_attribute *attr,
> >> +                               const char *buf, size_t count)
> >> +{
> >> +       int allow_leakage, ret;
> >> +
> >> +       ret = kstrtoint(buf, 0, &allow_leakage);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       if (allow_leakage != 0 && allow_leakage != 1)
> >> +               return -EINVAL;
> >> +
> >> +       WRITE_ONCE(perf_allow_sample_leakage, allow_leakage);
> >> +
> >> +       return count;
> >> +}
> >> +static DEVICE_ATTR_RW(perf_allow_sample_leakage);
> >> +
> >>   static struct attribute *pmu_dev_attrs[] = {
> >>          &dev_attr_type.attr,
> >>          &dev_attr_perf_event_mux_interval_ms.attr,
> >> +       &dev_attr_perf_allow_sample_leakage.attr,
> >>          NULL,
> >>   };
> >>   ATTRIBUTE_GROUPS(pmu_dev);
> >> --
> >> 2.7.4
> >>
