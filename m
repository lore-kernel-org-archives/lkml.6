Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id ACC61C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5188B20864
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4Bpmf1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5188B20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755717AbeFOGDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 02:03:08 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39451 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755607AbeFOGDG (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 02:03:06 -0400
Received: by mail-wr0-f194.google.com with SMTP id w7-v6so8675771wrn.6
        for <Linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 23:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oykycXql9hS3J2tKYmAyP4wcJsVb+iJQ4H6LRbXGV34=;
        b=X4Bpmf1O88+yomKC+lrJijX6hPqwVIOb+OYOChSs9Y7m1OTWpyTaWPBFpUUl3+onNv
         n21QnYxmX2w9PlZz08NMDGfSuRot5oOMFSeSPGFpw0NZacHtHjEv054Z/HawAlF64rl2
         bFWcAqb9gkPvPbrMXOrg5EWwcvRcZL/LptLJSfgMKyu0eEHa1fFjKVycT7BRJDpX7lTG
         LEhL+3eOLGPhjg2t9AkooyHi5FaozHtoJu4GGV44Txlrrr2bn3Qtbh50tFIEKQtPssHz
         sjgyz89f3w2nJ6kj+hAwQiatQZjcLlhiBZOq1f5C3UD38Vues6MCw+HMjJSACChgWqJA
         2VqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oykycXql9hS3J2tKYmAyP4wcJsVb+iJQ4H6LRbXGV34=;
        b=quXk8RGaBYMTb8GO2o0PNp3M8pQw66q1NctqhOTo+n++/pw1oZoLu+BqWr2yJbPDhz
         BBXXknOiAnX9bkSUIDDZzMzix3LuXVkEStKTpbUW277qPVTDW1h5sCQA892tEqOh6ZRj
         LKkp0l0bB6ylsqDzLkVydotJkies8mgJLuHHy8xlb8upE3Q5co/NRJPpVmNs737atKQE
         RHpbjhIMF2pkR6xWREChcrr/lDvChKcLbqPyFKjFh7elKsxoSmrnAJQujq/hDWR06n1j
         5JeBndehpnLPhpNx/z4eWTxVgSenm8Bj2oNmwkd8oClGMBj/wnZvX+y8xN1U8GjYk2dF
         A9UQ==
X-Gm-Message-State: APt69E1u1m4FT053lTqrKAx1DKozs9NPmZs/rVDyv7Z08k0FI3SZgjcg
        njKbNZE21oMUj6I/fGOSmweK1KBhzcDynG5u4h17dw==
X-Google-Smtp-Source: ADUXVKJtqFy/LU/vQcF2NMKVDf92OUnbSZrxj8p7EBm/Npk26bTXn2VYpYp7Fd5EwYKtVpumrp0VMiBig2GF8L0ymTY=
X-Received: by 2002:adf:a0ee:: with SMTP id n43-v6mr315226wrn.23.1529042585375;
 Thu, 14 Jun 2018 23:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com> <1529057003-2212-2-git-send-email-yao.jin@linux.intel.com>
In-Reply-To: <1529057003-2212-2-git-send-email-yao.jin@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 14 Jun 2018 23:02:53 -0700
Message-ID: <CABPqkBTyEZX7DebLR-nbzXs0ZYGT1xWNmOmvKgRsvr4mxWJg=w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf/core: Use sysctl to turn on/off dropping
 leaked kernel samples
To:     yao.jin@linux.intel.com
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        me@kylehuey.com, LKML <Linux-kernel@vger.kernel.org>,
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

On Thu, Jun 14, 2018 at 7:10 PM Jin Yao <yao.jin@linux.intel.com> wrote:
>
> When doing sampling, for example:
>
> perf record -e cycles:u ...
>
> On workloads that do a lot of kernel entry/exits we see kernel
> samples, even though :u is specified. This is due to skid existing.
>
> This might be a security issue because it can leak kernel addresses even
> though kernel sampling support is disabled.
>
> One patch "perf/core: Drop kernel samples even though :u is specified"
> was posted in last year but it was reverted because it introduced a
> regression issue that broke the rr-project, which used sampling
> events to receive a signal on overflow. These signals were critical
> to the correct operation of rr.
>
> See '6a8a75f32357 ("Revert "perf/core: Drop kernel samples even
> though :u is specified"")' for detail.
>
> Now the idea is to use sysctl to control the dropping of leaked
> kernel samples.
>
> /sys/devices/cpu/perf_allow_sample_leakage:
>
> 0 - default, drop the leaked kernel samples.
> 1 - don't drop the leaked kernel samples.
>
> For rr it can write 1 to /sys/devices/cpu/perf_allow_sample_leakage.
>
> For example,
>
> root@skl:/tmp# cat /sys/devices/cpu/perf_allow_sample_leakage
> 0
> root@skl:/tmp# perf record -e cycles:u ./div
> root@skl:/tmp# perf report --stdio
>
> ........  .......  .............  ................
>
>     47.01%  div      div            [.] main
>     20.74%  div      libc-2.23.so   [.] __random_r
>     15.59%  div      libc-2.23.so   [.] __random
>      8.68%  div      div            [.] compute_flag
>      4.48%  div      libc-2.23.so   [.] rand
>      3.50%  div      div            [.] rand@plt
>      0.00%  div      ld-2.23.so     [.] do_lookup_x
>      0.00%  div      ld-2.23.so     [.] memcmp
>      0.00%  div      ld-2.23.so     [.] _dl_start
>      0.00%  div      ld-2.23.so     [.] _start
>
> There is no kernel symbol reported.
>
> root@skl:/tmp# echo 1 > /sys/devices/cpu/perf_allow_sample_leakage
> root@skl:/tmp# cat /sys/devices/cpu/perf_allow_sample_leakage
> 1
> root@skl:/tmp# perf record -e cycles:u ./div
> root@skl:/tmp# perf report --stdio
>
> ........  .......  ................  .............
>
>     47.53%  div      div               [.] main
>     20.62%  div      libc-2.23.so      [.] __random_r
>     15.32%  div      libc-2.23.so      [.] __random
>      8.66%  div      div               [.] compute_flag
>      4.53%  div      libc-2.23.so      [.] rand
>      3.34%  div      div               [.] rand@plt
>      0.00%  div      [kernel.vmlinux]  [k] apic_timer_interrupt
>      0.00%  div      libc-2.23.so      [.] intel_check_word
>      0.00%  div      ld-2.23.so        [.] brk
>      0.00%  div      [kernel.vmlinux]  [k] page_fault
>      0.00%  div      ld-2.23.so        [.] _start
>
> We can see the kernel symbols apic_timer_interrupt and page_fault.
>
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  kernel/events/core.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 80cca2b..7867541 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7721,6 +7721,28 @@ int perf_event_account_interrupt(struct perf_event *event)
>         return __perf_event_account_interrupt(event, 1);
>  }
>
> +static int perf_allow_sample_leakage __read_mostly;
> +
> +static bool sample_is_allowed(struct perf_event *event, struct pt_regs *regs)
> +{
> +       int allow_leakage = READ_ONCE(perf_allow_sample_leakage);
> +
> +       if (allow_leakage)
> +               return true;
> +
> +       /*
> +        * Due to interrupt latency (AKA "skid"), we may enter the
> +        * kernel before taking an overflow, even if the PMU is only
> +        * counting user events.
> +        * To avoid leaking information to userspace, we must always
> +        * reject kernel samples when exclude_kernel is set.
> +        */
> +       if (event->attr.exclude_kernel && !user_mode(regs))
> +               return false;
> +
And how does that filter PEBS or LBR records?

> +       return true;
> +}
> +
>  /*
>   * Generic event overflow handling, sampling.
>   */
> @@ -7742,6 +7764,12 @@ static int __perf_event_overflow(struct perf_event *event,
>         ret = __perf_event_account_interrupt(event, throttle);
>
>         /*
> +        * For security, drop the skid kernel samples if necessary.
> +        */
> +       if (!sample_is_allowed(event, regs))
> +               return ret;
> +
> +       /*
>          * XXX event_limit might not quite work as expected on inherited
>          * events
>          */
> @@ -9500,9 +9528,39 @@ perf_event_mux_interval_ms_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(perf_event_mux_interval_ms);
>
> +static ssize_t
> +perf_allow_sample_leakage_show(struct device *dev,
> +                              struct device_attribute *attr, char *page)
> +{
> +       int allow_leakage = READ_ONCE(perf_allow_sample_leakage);
> +
> +       return snprintf(page, PAGE_SIZE-1, "%d\n", allow_leakage);
> +}
> +
> +static ssize_t
> +perf_allow_sample_leakage_store(struct device *dev,
> +                               struct device_attribute *attr,
> +                               const char *buf, size_t count)
> +{
> +       int allow_leakage, ret;
> +
> +       ret = kstrtoint(buf, 0, &allow_leakage);
> +       if (ret)
> +               return ret;
> +
> +       if (allow_leakage != 0 && allow_leakage != 1)
> +               return -EINVAL;
> +
> +       WRITE_ONCE(perf_allow_sample_leakage, allow_leakage);
> +
> +       return count;
> +}
> +static DEVICE_ATTR_RW(perf_allow_sample_leakage);
> +
>  static struct attribute *pmu_dev_attrs[] = {
>         &dev_attr_type.attr,
>         &dev_attr_perf_event_mux_interval_ms.attr,
> +       &dev_attr_perf_allow_sample_leakage.attr,
>         NULL,
>  };
>  ATTRIBUTE_GROUPS(pmu_dev);
> --
> 2.7.4
>
