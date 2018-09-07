Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43242C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B51206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hyvk9ab7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B51206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeIGMBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:01:35 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39660 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeIGMBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:01:34 -0400
Received: by mail-io1-f66.google.com with SMTP id l7-v6so809095iok.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 00:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bQdvSyJjL7kdNmZznzkwVVDEJIzKHOjKsLidaYwNZSA=;
        b=Hyvk9ab7mcDbLaBQbIHx31rllq1u2zxShTyIG/i+ng9dY6LeYxZHtqnRm3dV++cZnN
         68VLQBkpfX8ximN8yfudWYUwn7bqwnHzsHHHJScLuJJEAjVolZaCnvMYMmDNjT0iGM9h
         +tAPwr3W4QOEkQDiqIwgbqXn+YELtu4Q/Ic2DLbwBlV41lNbSC9h4f+1bH+oTP7QVYNS
         sHa/CzlJrIVzwuzJAoVWut++CIwjPG4LGUG/VWcPC16YrVwTZAKOSFbORP1mkJOxds98
         fJAjFto7Vu/N8FXFKxKcH9kKwYIZv5fr+3pcgCtboCJy4eizzXb/KiYgECIvSxYdQrOV
         WtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQdvSyJjL7kdNmZznzkwVVDEJIzKHOjKsLidaYwNZSA=;
        b=lk7Pp3Gmw/RfWBjqWeMmkELLax6ofyMKLNuTjbCYVzCUdJhoS0DQw0A/Gfn2ChTtp3
         OlRaOvh5SIzohiPniS8JgZ9NIAnToaXuTHUbn/8pdb6zWnMHlF1ndM32BPdl0BrlJHgm
         oMfbpxQWc/0NwNQoBlFR8hgaOor6zozsG+a9zDEJMz7voh9WwI0wgP+U1FYpnDg17FNK
         luRiVM2+YXh0Wh0Uo8F7SebLqfo/JhbfdZArAKBrJ/cpJnNze8MPqHh5WPtWri9otEd4
         xUGLiCxbbanMTLiCTpQU5eZg9M+MfQfy0koFsGH4Vyn975el/MXydk8rdQ/31mIq3+oc
         CKOg==
X-Gm-Message-State: APzg51CVrBrh3hdTR74VW+8cg733LweqdI3URvoAoH6fhBTQlQ1cdWHZ
        kSBAa5gyn5Q6A+2SewGJ1CHhSH+5lgJvR4jNBLG9oQ==
X-Google-Smtp-Source: ANB0VdZKYR30v7D2o3OQw5Ee1L+Fpt6P37VtR8JbS/v7cyCEsbZx9GtjZigT3Uh8hdzrlsOUjrY/Ua1oA7e5lwEG/dk=
X-Received: by 2002:a6b:8fd0:: with SMTP id r199-v6mr4912079iod.118.1536304919347;
 Fri, 07 Sep 2018 00:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180906192034.8467-1-olof@lixom.net> <CANn89i+akEWrHELBkZJQOxok-ZfYy+FNPUWdPEfB6c4YyWLqJA@mail.gmail.com>
 <20180907033257.2nlgiqm2t4jiwhzc@gondor.apana.org.au> <CAOesGMgRrb4D2S_qWwgo00iNxbCL9EEGfhD5Ji-2HMWuZeq0Yw@mail.gmail.com>
 <CANn89iKJcgMWb2Kmk6L9k=NkfBUKZ6BwriWr3O+N5Y0u5dy=9g@mail.gmail.com>
In-Reply-To: <CANn89iKJcgMWb2Kmk6L9k=NkfBUKZ6BwriWr3O+N5Y0u5dy=9g@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 7 Sep 2018 00:21:46 -0700
Message-ID: <CANn89iKgZkfwQ8nAGEfOzubOh69y285TNKB5Q518Wf_phbq2Yg@mail.gmail.com>
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

On Fri, Sep 7, 2018 at 12:03 AM Eric Dumazet <edumazet@google.com> wrote:

> Problem is : we have platforms with more than 100 cpus, and
> sk_memory_allocated() cost will be too expensive,
> especially if the host is under memory pressure, since all cpus will
> touch their private counter.
>
> per cpu variables do not really scale, they were ok 10 years ago when
> no more than 16 cpus were the norm.
>
> I would prefer change TCP to not aggressively call
> __sk_mem_reduce_allocated() from tcp_write_timer()
>
> Ideally only tcp_retransmit_timer() should attempt to reduce forward
> allocations, after recurring timeout.
>
> Note that after 20c64d5cd5a2bdcdc8982a06cb05e5e1bd851a3d ("net: avoid
> sk_forward_alloc overflows")
> we have better control over sockets having huge forward allocations.
>
> Something like :

Or something less risky :

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 7fdf222a0bdfe9775970082f6b5dcdcc82b2ae1a..0aee80b6966cb2898e46350c761f9eb431ff1206
100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -604,7 +604,8 @@ void tcp_write_timer_handler(struct sock *sk)
        }

 out:
-       sk_mem_reclaim(sk);
+       if (tcp_under_memory_pressure(sk))
+               sk_mem_reclaim(sk);
 }

 static void tcp_write_timer(struct timer_list *t)
