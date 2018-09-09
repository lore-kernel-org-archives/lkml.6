Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B4FC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 18:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E78520866
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 18:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLf7OaXy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E78520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeIIX3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 19:29:22 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37187 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbeIIX3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 19:29:22 -0400
Received: by mail-it0-f66.google.com with SMTP id h20-v6so25918283itf.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 11:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+LM8DgJEyT1bkkly4woXLFhCYhcFYS+Ps3NyBDgVLRM=;
        b=FLf7OaXyTVfbWQDtBxIzWR7q2k1fq2X4UGwCvHUTbjhM/n/5UHULPsDAgx8Yj8J4S/
         uKApAwEQjsqqz3ep8+zuvlnMMzg5if+R5/9F3Rn8n4x7nWmu9iiqzdiLW3HByeQm5uJD
         EDoOuV6hh1vdLZrwXYrSp5K52EOerTVg6ymHrkrNhIMatjDOA60ygUhcwhQn4L7FbpTx
         oeVvxfwOHtJMOpYraiHkm1llpXR15l75n6BaOnEZZk0gxp/K3dwLzlHSgKormWJDceib
         qli749C3CpbNhbWdTvrOckr+STUqtwQOpIY87lnvxZwINB0S1qQwVTi7fF8f9MfZ/gcT
         7k1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+LM8DgJEyT1bkkly4woXLFhCYhcFYS+Ps3NyBDgVLRM=;
        b=Aunu3WAwqaL7MRXluqfKob9u9lgb+U0tllsG/J3+/64DcE+0YxMXNIMgrUzXNHBtek
         Q0MnTgt3dgM0PlULSGTR69VBab94ah3mzHFaFzCPC2oDO8ExkHFDw7ww9D2PomkYmrTH
         NTu/F4UhEZwx5549bt4hXatuoRea7RaLWXtW9PlPExl/R8FxEGZUcAKID/cp//SIIuyB
         K0HTOHHy+2Etz9+IFW3VkT8PygB0y7oPcbCWq6vFYozLiFZ8/qlAHAjS5DpEvaMZLTEb
         HGNDuW/frF/DvHXemC2eiB4suknGNWiUwFULSYUtyiceKL7echGyAW6PEZtB7IBOpAWz
         /fkA==
X-Gm-Message-State: APzg51DgcwFGQbD8w9MLb31FSCS8JtR33hooM21lL5DA1OUIbvdjE8Iv
        MIAf3By5Mex8kJE/SuSp0C9QaRJiSjsMhuUFH612VQ==
X-Google-Smtp-Source: ANB0VdanN3/pG6sRmPNYiUD2sJJeNn+6MohphHdWyrgLdn94hTpntqOWhHJcrfeN+N5cAVTke59P5QtzfAxctm5Nlwk=
X-Received: by 2002:a24:534c:: with SMTP id n73-v6mr14841350itb.25.1536518328862;
 Sun, 09 Sep 2018 11:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180906192034.8467-1-olof@lixom.net> <CANn89i+akEWrHELBkZJQOxok-ZfYy+FNPUWdPEfB6c4YyWLqJA@mail.gmail.com>
 <20180907033257.2nlgiqm2t4jiwhzc@gondor.apana.org.au> <CAOesGMgRrb4D2S_qWwgo00iNxbCL9EEGfhD5Ji-2HMWuZeq0Yw@mail.gmail.com>
 <CANn89iKJcgMWb2Kmk6L9k=NkfBUKZ6BwriWr3O+N5Y0u5dy=9g@mail.gmail.com>
 <CANn89iKgZkfwQ8nAGEfOzubOh69y285TNKB5Q518Wf_phbq2Yg@mail.gmail.com> <CAOesGMi31UA2d-Bj2jo53Wz_YV424-rD3qk9rS5_-Yng0VC=0w@mail.gmail.com>
In-Reply-To: <CAOesGMi31UA2d-Bj2jo53Wz_YV424-rD3qk9rS5_-Yng0VC=0w@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 9 Sep 2018 11:38:37 -0700
Message-ID: <CANn89iJXfkb5ct-KreHv-oifuCMRFSS1mOiHjkhLnP04eOypBA@mail.gmail.com>
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

On Sat, Sep 8, 2018 at 10:02 AM Olof Johansson <olof@lixom.net> wrote:
>
> Hi,
>
> On Fri, Sep 7, 2018 at 12:21 AM, Eric Dumazet <edumazet@google.com> wrote:
> > On Fri, Sep 7, 2018 at 12:03 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> >> Problem is : we have platforms with more than 100 cpus, and
> >> sk_memory_allocated() cost will be too expensive,
> >> especially if the host is under memory pressure, since all cpus will
> >> touch their private counter.
> >>
> >> per cpu variables do not really scale, they were ok 10 years ago when
> >> no more than 16 cpus were the norm.
> >>
> >> I would prefer change TCP to not aggressively call
> >> __sk_mem_reduce_allocated() from tcp_write_timer()
> >>
> >> Ideally only tcp_retransmit_timer() should attempt to reduce forward
> >> allocations, after recurring timeout.
> >>
> >> Note that after 20c64d5cd5a2bdcdc8982a06cb05e5e1bd851a3d ("net: avoid
> >> sk_forward_alloc overflows")
> >> we have better control over sockets having huge forward allocations.
> >>
> >> Something like :
> >
> > Or something less risky :
>
> I gave both of these patches a run, and neither do as well on the
> system that has slower atomics. :(
>
> The percpu version:
>
>      8.05%  workload         [kernel.vmlinux]
>     [k] __do_softirq
>      7.04%  swapper          [kernel.vmlinux]
>     [k] cpuidle_enter_state
>      5.54%  workload         [kernel.vmlinux]
>     [k] _raw_spin_unlock_irqrestore
>      1.66%  swapper          [kernel.vmlinux]
>     [k] __do_softirq
>      1.55%  workload         [kernel.vmlinux]
>     [k] finish_task_switch
>      1.24%  swapper          [kernel.vmlinux]
>     [k] finish_task_switch
>      1.07%  workload         [kernel.vmlinux]
>     [k] net_rx_action
>
> The first patch from you still has significant amount of time spent in
> the atomics paths (non-inlined versions used):
>
>      7.87%  workload         [kernel.vmlinux]
> [k] __ll_sc_atomic64_sub


The second patch I gave should not enter this path at all, please try it.

>      7.48%  workload         [kernel.vmlinux]
> [k] __do_softirq
>      5.05%  workload         [kernel.vmlinux]
> [k] _raw_spin_unlock_irqrestore
>      2.42%  workload         [kernel.vmlinux]
> [k] __ll_sc_atomic64_add_return
>      1.49%  swapper          [kernel.vmlinux]
> [k] cpuidle_enter_state
>      1.31%  workload         [kernel.vmlinux]
> [k] finish_task_switch
>      1.09%  workload         [kernel.vmlinux]
> [k] tcp_sendmsg_locked
>      1.08%  workload         [kernel.vmlinux]
> [k] __arch_copy_from_user
>      1.02%  workload         [kernel.vmlinux]
> [k] net_rx_action
>
> I think a lot of the overhead from percpu approach can be alleviated
> if we can use percpu_counter_read() instead of _sum() (i.e. no need to
> iterate through the local per-cpu recent delta). I don't know the TCP
> stack well enough to tell where it's OK to use a bit of slack in the
> numbers though -- by default count will at most be off by 32*online
> cpus. Might not be a significant number in reality.
