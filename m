Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B47BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0792077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WVN9RY++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0792077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeIGLm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:42:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37747 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeIGLm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:42:57 -0400
Received: by mail-io1-f68.google.com with SMTP id v14-v6so775970iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 00:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nWtErmIXaWGrCpe3h5cMQg/Vu8e5hNgD+L7VGkseivA=;
        b=WVN9RY++yUTVvs3c0sbKb2jf/KdIoLqmL6K5Ml8aL9QwjDtIfAgdtkeh/GW6vlHvep
         fuy8SNhPqbov98yhVT5r9ZopbhgqHqOeoT4ZUhSX9W/usV+ZQHxoxSbptmISLbCiDIky
         oa0R+Kvyc1aKu+gq+y/DT8KLVI6lPkVeRlD8jNbAEBfsJIqb950fzkqV8TtOhphrK+dX
         znezKYV4B6t9ZaPpa5k7SDsPKkgyLJSuPXIXOAi11rKadBRFq/qWfULpmlAE0jHmVu0X
         L6As6tYdiuMwx8WKM3w+ahXByxPnbLzfqqFqZqLV8CTyP1w5Zn7b7tvL5dXBfWoG6OjO
         dnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nWtErmIXaWGrCpe3h5cMQg/Vu8e5hNgD+L7VGkseivA=;
        b=FFOHwkAXH7qePtEDqqUI9pgXAmGvzUJGKETUkN+JRDo1IO6rcEYIg4GeAQ4Zi7BRW/
         1M9ku3AxA2t9D/4m7tIMu+YscMGc8VCk5C2537dtda3GaVKgc2o171z32cLNopaaAIOf
         klEipsr4Qe0r1ieKbR44R67iVNYd7mYM7ewtXPkK/kT/sOVRZCALa7k34Fb/hvfjeNx5
         yL3DuCj56kfFgr4QA8PihlqIRzKUcTjGNIZRzAXykFelas/UJmljTRiOlZIhJYEcQoL+
         9QvS+R2dd6IfNUyIT7pPkN8difzlfDsBhcK/OrzmUDex2ni0Y6h97y/0KqBXPf8GPJE/
         Goqw==
X-Gm-Message-State: APzg51CXp5hYEFIbP1/DZSotsUB+416sz0Docb00QKMLbxyA+IVZG+Mh
        PhlbWdYpXTcHT2KUFp4V4+DT6rXrv2gbVOLN+pzEtQ==
X-Google-Smtp-Source: ANB0VdbdA5rd3wcVIbknOg1p6zTUZ1HhPrc+jx3GLYA2hPRAFlUOUaoeFDrmNX/W4BwGipL6BNessRKjWFp5C5K0ebI=
X-Received: by 2002:a6b:f316:: with SMTP id m22-v6mr4566597ioh.271.1536303805673;
 Fri, 07 Sep 2018 00:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180906192034.8467-1-olof@lixom.net> <CANn89i+akEWrHELBkZJQOxok-ZfYy+FNPUWdPEfB6c4YyWLqJA@mail.gmail.com>
 <20180907033257.2nlgiqm2t4jiwhzc@gondor.apana.org.au> <CAOesGMgRrb4D2S_qWwgo00iNxbCL9EEGfhD5Ji-2HMWuZeq0Yw@mail.gmail.com>
In-Reply-To: <CAOesGMgRrb4D2S_qWwgo00iNxbCL9EEGfhD5Ji-2HMWuZeq0Yw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 7 Sep 2018 00:03:13 -0700
Message-ID: <CANn89iKJcgMWb2Kmk6L9k=NkfBUKZ6BwriWr3O+N5Y0u5dy=9g@mail.gmail.com>
Subject: Re: [PATCH] net/sock: move memory_allocated over to percpu_counter variables
To:     Olof Johansson <olof@lixom.net>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Vladislav Yasevich <vyasevich@gmail.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-sctp@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        linux-decnet-user@lists.sourceforge.net,
        kernel-team <kernel-team@fb.com>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 11:20 PM Olof Johansson <olof@lixom.net> wrote:
>
> Hi,
>
> On Thu, Sep 6, 2018 at 8:32 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > On Thu, Sep 06, 2018 at 12:33:58PM -0700, Eric Dumazet wrote:
> >> On Thu, Sep 6, 2018 at 12:21 PM Olof Johansson <olof@lixom.net> wrote:
> >> >
> >> > Today these are all global shared variables per protocol, and in
> >> > particular tcp_memory_allocated can get hot on a system with
> >> > large number of CPUs and a substantial number of connections.
> >> >
> >> > Moving it over to a per-cpu variable makes it significantly cheaper,
> >> > and the added overhead when summing up the percpu copies is still smaller
> >> > than the cost of having a hot cacheline bouncing around.
> >>
> >> I am curious. We never noticed contention on this variable, at least for TCP.
> >
> > Yes these variables are heavily amortised so I'm surprised that
> > they would cause much contention.
> >
> >> Please share some numbers with us.
> >
> > Indeed.
>
> Certainly, just had to collect them again.
>
> This is on a dual xeon box, with ~150-200k TCP connections. I see
> about .7% CPU spent in __sk_mem_{reduce,raise}_allocated in the
> inlined atomic ops, most of those in reduce.
>
> Call path for reduce is practically all from tcp_write_timer on softirq:
>
>                 __sk_mem_reduce_allocated
>                 tcp_write_timer
>                 call_timer_fn
>                 run_timer_softirq
>                 __do_softirq
>                 irq_exit
>                 smp_apic_timer_interrupt
>                 apic_timer_interrupt
>                 cpuidle_enter_state
>
> With this patch, I see about .18+.11+.07 = .36% in percpu-related
> functions called from the same __sk_mem functions.
>
> Now, that's a halving of cycles samples on that specific setup. The
> real difference though, is on another platform where atomics are more
> expensive. There, this makes a significant difference. Unfortunately,
> I can't share specifics but I think this change stands on its own on
> the dual xeon setup as well, maybe with slightly less strong wording
> on just how hot the variable/line happens to be.


Problem is : we have platforms with more than 100 cpus, and
sk_memory_allocated() cost will be too expensive,
especially if the host is under memory pressure, since all cpus will
touch their private counter.

per cpu variables do not really scale, they were ok 10 years ago when
no more than 16 cpus were the norm.

I would prefer change TCP to not aggressively call
__sk_mem_reduce_allocated() from tcp_write_timer()

Ideally only tcp_retransmit_timer() should attempt to reduce forward
allocations, after recurring timeout.

Note that after 20c64d5cd5a2bdcdc8982a06cb05e5e1bd851a3d ("net: avoid
sk_forward_alloc overflows")
we have better control over sockets having huge forward allocations.

Something like :

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 7fdf222a0bdfe9775970082f6b5dcdcc82b2ae1a..7e2e17cde9b6a9be835edfac26b64f4ce9411538
100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -505,6 +505,8 @@ void tcp_retransmit_timer(struct sock *sk)
                        mib_idx = LINUX_MIB_TCPTIMEOUTS;
                }
                __NET_INC_STATS(sock_net(sk), mib_idx);
+       } else {
+               sk_mem_reclaim(sk);
        }

        tcp_enter_loss(sk);
@@ -576,11 +578,11 @@ void tcp_write_timer_handler(struct sock *sk)

        if (((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
            !icsk->icsk_pending)
-               goto out;
+               return;

        if (time_after(icsk->icsk_timeout, jiffies)) {
                sk_reset_timer(sk, &icsk->icsk_retransmit_timer,
icsk->icsk_timeout);
-               goto out;
+               return;
        }

        tcp_mstamp_refresh(tcp_sk(sk));
@@ -602,9 +604,6 @@ void tcp_write_timer_handler(struct sock *sk)
                tcp_probe_timer(sk);
                break;
        }
-
-out:
-       sk_mem_reclaim(sk);
 }
