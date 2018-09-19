Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E25ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4C72150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ulBWG03h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4C72150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbeISV2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:28:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41905 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732496AbeISV2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:28:33 -0400
Received: by mail-io1-f65.google.com with SMTP id q4-v6so4885156iob.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 08:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1jUg8O+QagXMLT+7LJz6+6x9bs0L8DRMSRjADEcKfhc=;
        b=ulBWG03hceuJwTF7VKIQDbAmNo2ogaXSh0IeazNk1z318/M+pUQkrEPnLU3rMoZe4c
         KWRTJbOsjU7uFn9yS5Jzgj1bVZTzgAOJA+oOkSXZgLWRlRlNGiZRMvxOEl6ivpYOGC2R
         0ps8os4dONvluaY88EojdKOx1vA/cZi5henGUmnH0uQ/9M9l7RTP8LTSQCJi2X2ap9Vz
         tpeCzLUNwOi4MBYdSGwPh+Y+zo0/phXF1ARMb66nErGFmdnKJj9HZNHXK1tKnHPmlqYX
         c9eX7cZvLWL2iEfI3JbqnyLtPpuNrlyRyWStLyz1IUGHL88J7uG5PG+pZZGM/mR+PjkG
         U94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1jUg8O+QagXMLT+7LJz6+6x9bs0L8DRMSRjADEcKfhc=;
        b=uPa48Czdu8omRD6dhEpiZs5hQDPTkVo84XGYubA8tGNLkNrO/ay8ZznkMirwmlkThM
         O+FlEe6pwT8JtOK01w+sAioZShgRX3JcTd9k9abST68ykSSCphUMKXe9URZlGnZgJGvS
         Zq4N1IGwzvntYQKhYuesEEgc3czusMTUV9OLlFSobBXVuyI9CovybH5KbO2l1XB19iam
         6TCov7hBlynSsypR3H83MxrJVifMJEMZ1Ba8xVNbwkn8U90Ns8CtDy/phq3yZ6AwHaWE
         pI0HU87oPET23pK+YgedSTXaSFTShr3pPQ8AhPHETXKyRw3SD1pImcn3fRenlk4Cjmsg
         o/0Q==
X-Gm-Message-State: APzg51Debix5vBO6V0cWopN7Y92m/MPSDYN+rzjHiKUAQn+NAh+S/NvZ
        NhsHmvxB1F8IEYsty/jfgmI6L5dpPBeZFJitJ4gtAg==
X-Google-Smtp-Source: ANB0VdY/i5biAVsuBSSFkEDa24hCs5LHNjP6sUcT/wgjZR5ZlqQ6IV5DMeMZvpSR4YJIs/ifghP7DIC3GnD/x8zCVbs=
X-Received: by 2002:a6b:5a01:: with SMTP id o1-v6mr31000805iob.73.1537372201161;
 Wed, 19 Sep 2018 08:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <153736009982.24033.13696245431713246950.stgit@localhost.localdomain>
 <CANn89iJ1UnwLFv5+AwXgeb1BUhYg8UJYTJLtiipavJee+2SWxQ@mail.gmail.com> <2fdf2bd7-1cc4-a1e1-15c2-e2badfcd4d59@virtuozzo.com>
In-Reply-To: <2fdf2bd7-1cc4-a1e1-15c2-e2badfcd4d59@virtuozzo.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 19 Sep 2018 08:49:48 -0700
Message-ID: <CANn89iK8X5cW3=YnNRrKo=BVCFJkJ0D22YY_eJFLyGCX+5SxsQ@mail.gmail.com>
Subject: Re: [RFC] net;sched: Try to find idle cpu for RPS to handle packets
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>, tom@quantonium.net,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000f0f2fe05763b5b29"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f0f2fe05763b5b29
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 19, 2018 at 8:41 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 19.09.2018 17:55, Eric Dumazet wrote:
> > On Wed, Sep 19, 2018 at 5:29 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>
> >> Many workloads have polling mode of work. The application
> >> checks for incomming packets from time to time, but it also
> >> has a work to do, when there is no packets. This RFC
> >> tries to develop an idea to queue RPS packets on idle
> >> CPU in the the L3 domain of the consumer, so backlog
> >> processing of the packets and the application can execute
> >> in parallel.
> >>
> >> We require this in case of network cards does not
> >> have enough RX queues to cover all online CPUs (this seems
> >> to be the most cards), and  get_rps_cpu() actually chooses
> >> remote cpu, and SMP interrupt is sent. Here we may try
> >> our best, and to find idle CPU nearly the consumer's CPU.
> >> Note, that in case of consumer works in poll mode and it
> >> does not waits for incomming packets, its CPU will be not
> >> idle, while CPU of a sleeping consumer may be idle. So,
> >> not polling consumers will still be able to have skb
> >> handled on its CPU.
> >>
> >> In case of network card has many queues, the device
> >> interrupts will come on consumer's CPU, and this patch
> >> won't try to find idle cpu for them.
> >>
> >> I've tried simple netperf test for this:
> >> netserver -p 1234
> >> netperf -L 127.0.0.1 -p 1234 -l 100
> >>
> >> Before:
> >>  87380  16384  16384    100.00   60323.56
> >>  87380  16384  16384    100.00   60388.46
> >>  87380  16384  16384    100.00   60217.68
> >>  87380  16384  16384    100.00   57995.41
> >>  87380  16384  16384    100.00   60659.00
> >>
> >> After:
> >>  87380  16384  16384    100.00   64569.09
> >>  87380  16384  16384    100.00   64569.25
> >>  87380  16384  16384    100.00   64691.63
> >>  87380  16384  16384    100.00   64930.14
> >>  87380  16384  16384    100.00   62670.15
> >>
> >> The difference between best runs is +7%,
> >> the worst runs differ +8%.
> >>
> >> What do you think about following somehow in this way?
> >
> > Hi Kirill
> >
> > In my experience, scheduler has a poor view of softirq processing
> > happening on various cpus.
> > A cpu spending 90% of its cycles processing IRQ might be considered 'idle'
>
> Yes, in case of there is softirq on top of irq_exit(), the cpu is not
> considered as busy. But after MAX_SOFTIRQ_TIME (=2ms), ksoftirqd are
> waken up to execute the work in process context, and the processor is
> considered as !idle. 2ms is 2 timer ticks in case of HZ=1000. So, we
> don't restart softirq in case of it was executed for more then 2ms.
>

That's the theory, but reality is very different unfortunately.

If RFS/RPS is setup properly, we really do not hit MAX_SOFTIRQ_TIME condition
unless in some synthetic benchmarks maybe.

> The similar way, single net_rx_action() can't be executed longer
> than 2ms.
>
> Having 90% load in softirq (called on top of irq_exit()) should be
> very unlikely situation, when there are too many interrupts with small
> amount of work, which related softirq calls are doing for each of them.
> I think it had be a problem even in plain napi case, since it would
> worked not like expected.
>
> But anyway. You worry, that during handling of next portion of skbs,
> we find that previous portion of skbs already woken ksoftirqd, and
> we don't see this cpu as idle? Yeah, then we'll try to change cpu,
> and this is not what we want. We want to continue use the cpu, where
> previous portion was handler. Hm, not so fast I'll answer, but certainly,
> this may be handled somehow in more creative way.
>
> > So please run a real workload (it is _very_ uncommon anyone set up RPS
> > on lo interface !)
> >
> > Like 400 or more concurrent netperf -t TCP_RR on a 10Gbit NIC.
>
> Yeah, it's just a simulation of a single irq nic. I'll try on something
> more real hardware.

Also my concern is that you might have results that are tied to a particular
version of process scheduling, platform, workload...

One month later, a small change in process scheduler,
and very different results.

This is why I believe this new feature must be controllable, via a new
tunable (like RPS/RFS are controllable per rx queue)

>
> How do you execute such the tests? I don't see the appropriate parameter
> of netperf. Does this mean just to start 400 copies of netperf? How is
> to aggregate their results in this case?

Yeah, there are various 'super_netperf' scripts available on the net
(almost trivial to write anyway)

( I am attaching one of them)

Thanks.
>
> > Thanks.
> >
> > PS: Idea of playing with L3 domains is interesting, I have personally
> > tried various strategies in the past but none of them
> > demonstrated a clear win.
>
> Thanks,
> Kirill

--000000000000f0f2fe05763b5b29
Content-Type: application/octet-stream; name=super_netperf
Content-Disposition: attachment; filename=super_netperf
Content-Transfer-Encoding: base64
Content-ID: <f_jm9bomkg0>
X-Attachment-Id: f_jm9bomkg0

IyEvYmluL2Jhc2gKCnJ1bl9uZXRwZXJmKCkgewoJbG9vcHM9JDEKCXNoaWZ0Cglmb3IgKChpPTA7
IGk8bG9vcHM7IGkrKykpOyBkbwoJCS4vbmV0cGVyZiAtcyAyICRAIHwgYXdrICcvTWluL3sKCQkJ
aWYgKCFvbmNlKSB7CgkJCQlwcmludDsKCQkJCW9uY2U9MTsKCQkJfQoJCX0KCQl7CgkJCWlmIChO
UiA9PSA2KQoJCQkJc2F2ZSA9ICRORgoJCQllbHNlIGlmIChOUj09NykgewoJCQkJaWYgKE5GID4g
MCkKCQkJCQlwcmludCAkTkYKCQkJCWVsc2UKCQkJCQlwcmludCBzYXZlCgkJCX0gZWxzZSBpZiAo
TlI9PTExKSB7CgkJCQlwcmludCAkMAoJCQl9CgkJfScgJgoJZG9uZQoJd2FpdAoJcmV0dXJuIDAK
fQoKcnVuX25ldHBlcmYgJEAgfCBhd2sgJ3tpZiAoTkY9PTcpIHtwcmludCAkMDsgbmV4dH19IHtz
dW0gKz0gJDF9IEVORCB7cHJpbnRmICIlN3VcbiIsc3VtfScK
--000000000000f0f2fe05763b5b29--
