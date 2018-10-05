Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEACC65BBA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5952E21473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jP3WnrDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5952E21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbeJFCDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 22:03:04 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46870 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbeJFCDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 22:03:03 -0400
Received: by mail-qt1-f194.google.com with SMTP id d8-v6so14884626qtk.13;
        Fri, 05 Oct 2018 12:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u9cPvj9b42s+dO43aDqVHK+FB/+nSNmyU4f60k0debg=;
        b=jP3WnrDjDLoFoIHBgfreAGoxXKlCeEu8RjzHrphmfma67sKvhhZPRUIvwxT3GshMUt
         rIIUuKg4pXMFm+Ui23fBJByK5JQd2ri4bOt0srmF5VT8OoP9faPvhQJ4o8DpyLfYYr99
         1fkI38cSMHePvjQbiD0BB5agg4+iEYye68w1Wu+wdzEif81sE47/6LCPGljAxFbsu8N2
         xn3Cv+9w23i3IAd+tjsRmv66bhUvcLKCI5wfCZewbsYrZQUq90J3HYjHWImVfSwfkC6T
         f+bSl3qdfsEtL9wIiFZ4mZc+jiFnBV7eyzoeOPUhvOZXVeIDM+pqiExviw1PWxI6h8t+
         GnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u9cPvj9b42s+dO43aDqVHK+FB/+nSNmyU4f60k0debg=;
        b=buQB5spwYtwqdS06a2JwND2Vt4WyfXi7OmmpTSZU1mVjSWb5Wmrp/vS3tTPPGvJjJu
         wN45j28AcZSIP9VSJmWQ1vXQdTU1/lbHG6w0nr/eV+OP5UBBNyZFaxRmVLceEmDHvI/V
         cVibn5Q1hmilLFjOcnal9BWmVpPaFeLACfzQiFeNCwe9A87rdmSdC7isEE/zH1Zc5ud3
         ZBx0JRQS5o4NelgJR4wu1gsPbyZtjWwhEvDwy6hhClUvdQF5j/H2YUEXaH5ZloJBmYbT
         CNhADUIl3GjYjPjvHm9EXIqzHoxlJrrCzUzFMjfEeDSMHtJShzpgVmv1FsH192hBnZHr
         jdgA==
X-Gm-Message-State: ABuFfogSMfK/AQAJpqI2a4ksQ6FEFjtN3A01CLaP0H3nDrY8ERBe9jJy
        pwr8xLnmjlZKSZE5GJngReXoRANRPpmQIlOGQTkAvQ==
X-Google-Smtp-Source: ACcGV62q8psoKTjuNITqnfoIbTiVGCGU8NK/8KGCmaTKw6KIRGvnUxytRLktVnQUFS4APuWSJ6WwboF0kuoZROwZNzs=
X-Received: by 2002:aed:2259:: with SMTP id o25-v6mr10715700qtc.13.1538766179618;
 Fri, 05 Oct 2018 12:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181005161526.843924-1-arnd@arndb.de>
In-Reply-To: <20181005161526.843924-1-arnd@arndb.de>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 5 Oct 2018 12:02:48 -0700
Message-ID: <CAPhsuW7pg9Wp5am3Kc1t3UoAG1=EYzUeq8E2k7Pmv8yGu9JaEQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix building without CONFIG_INET
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        makita.toshiaki@lab.ntt.co.jp, Lawrence Brakmo <brakmo@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Mathieu Xhonneux <m.xhonneux@gmail.com>, dsahern@gmail.com,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 9:18 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The newly added TCP and UDP handling fails to link when CONFIG_INET
> is disabled:
>
> net/core/filter.o: In function `sk_lookup':
> filter.c:(.text+0x7ff8): undefined reference to `tcp_hashinfo'
> filter.c:(.text+0x7ffc): undefined reference to `tcp_hashinfo'
> filter.c:(.text+0x8020): undefined reference to `__inet_lookup_established'
> filter.c:(.text+0x8058): undefined reference to `__inet_lookup_listener'
> filter.c:(.text+0x8068): undefined reference to `udp_table'
> filter.c:(.text+0x8070): undefined reference to `udp_table'
> filter.c:(.text+0x808c): undefined reference to `__udp4_lib_lookup'
> net/core/filter.o: In function `bpf_sk_release':
> filter.c:(.text+0x82e8): undefined reference to `sock_gen_put'
>
> The compiler can optimize it out and avoid those references for
> the most part, but we are missing a few steps here:
>
> - sk_lookup() should always have been marked 'static', this also
>   avoids a warning about a missing prototype when building with
>   'make W=1'.
> - The BPF_CALL_x() macro needs a little change to allow marking
>   the unneeded BPF call as 'static' and having the compiler
>   drop them.
> - The reference to the bpf_func_proto must be made conditional.
>
> Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/filter.h |  2 +-
>  net/core/filter.c      | 18 +++++++++++-------
>  2 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 6791a0ac0139..d9ec9d908bbe 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -428,9 +428,9 @@ struct sock_reuseport;
>                   u64, __ur_3, u64, __ur_4, u64, __ur_5)
>
>  #define BPF_CALL_x(x, name, ...)                                              \
> +       u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));         \
>         static __always_inline                                                 \
>         u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__));   \
> -       u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));         \
>         u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__))          \
>         {                                                                      \
>                 return ____##name(__BPF_MAP(x,__BPF_CAST,__BPF_N,__VA_ARGS__));\
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 30c6b2d3ef16..dd5fe021f44c 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4817,7 +4817,7 @@ static const struct bpf_func_proto bpf_lwt_seg6_adjust_srh_proto = {
>  };
>  #endif /* CONFIG_IPV6_SEG6_BPF */
>
> -struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
> +static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
>                        struct sk_buff *skb, u8 family, u8 proto)
>  {
>         int dif = skb->dev->ifindex;
> @@ -4902,13 +4902,13 @@ bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
>         return (unsigned long) sk;
>  }
>
> -BPF_CALL_5(bpf_sk_lookup_tcp, struct sk_buff *, skb,
> +static BPF_CALL_5(bpf_sk_lookup_tcp, struct sk_buff *, skb,
>            struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
>  {
>         return bpf_sk_lookup(skb, tuple, len, IPPROTO_TCP, netns_id, flags);
>  }

BPF_CALL_x() has static already (before this patch). We should not
need change that
for all the BPF_CALL_?(). Joe's version looks better to me.

Thanks,
Song

>
> -static const struct bpf_func_proto bpf_sk_lookup_tcp_proto = {
> +static const __maybe_unused struct bpf_func_proto bpf_sk_lookup_tcp_proto = {
>         .func           = bpf_sk_lookup_tcp,
>         .gpl_only       = false,
>         .pkt_access     = true,
> @@ -4920,13 +4920,13 @@ static const struct bpf_func_proto bpf_sk_lookup_tcp_proto = {
>         .arg5_type      = ARG_ANYTHING,
>  };
>
> -BPF_CALL_5(bpf_sk_lookup_udp, struct sk_buff *, skb,
> +static BPF_CALL_5(bpf_sk_lookup_udp, struct sk_buff *, skb,
>            struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
>  {
>         return bpf_sk_lookup(skb, tuple, len, IPPROTO_UDP, netns_id, flags);
>  }
>
> -static const struct bpf_func_proto bpf_sk_lookup_udp_proto = {
> +static const __maybe_unused struct bpf_func_proto bpf_sk_lookup_udp_proto = {
>         .func           = bpf_sk_lookup_udp,
>         .gpl_only       = false,
>         .pkt_access     = true,
> @@ -4938,14 +4938,14 @@ static const struct bpf_func_proto bpf_sk_lookup_udp_proto = {
>         .arg5_type      = ARG_ANYTHING,
>  };
>
> -BPF_CALL_1(bpf_sk_release, struct sock *, sk)
> +static BPF_CALL_1(bpf_sk_release, struct sock *, sk)
>  {
>         if (!sock_flag(sk, SOCK_RCU_FREE))
>                 sock_gen_put(sk);
>         return 0;
>  }
>
> -static const struct bpf_func_proto bpf_sk_release_proto = {
> +static const __maybe_unused struct bpf_func_proto bpf_sk_release_proto = {
>         .func           = bpf_sk_release,
>         .gpl_only       = false,
>         .ret_type       = RET_INTEGER,
> @@ -5158,12 +5158,14 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>         case BPF_FUNC_skb_ancestor_cgroup_id:
>                 return &bpf_skb_ancestor_cgroup_id_proto;
>  #endif
> +#ifdef CONFIG_INET
>         case BPF_FUNC_sk_lookup_tcp:
>                 return &bpf_sk_lookup_tcp_proto;
>         case BPF_FUNC_sk_lookup_udp:
>                 return &bpf_sk_lookup_udp_proto;
>         case BPF_FUNC_sk_release:
>                 return &bpf_sk_release_proto;
> +#endif
>         default:
>                 return bpf_base_func_proto(func_id);
>         }
> @@ -5264,12 +5266,14 @@ sk_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>                 return &bpf_sk_redirect_hash_proto;
>         case BPF_FUNC_get_local_storage:
>                 return &bpf_get_local_storage_proto;
> +#ifdef CONFIG_INET
>         case BPF_FUNC_sk_lookup_tcp:
>                 return &bpf_sk_lookup_tcp_proto;
>         case BPF_FUNC_sk_lookup_udp:
>                 return &bpf_sk_lookup_udp_proto;
>         case BPF_FUNC_sk_release:
>                 return &bpf_sk_release_proto;
> +#endif
>         default:
>                 return bpf_base_func_proto(func_id);
>         }
> --
> 2.18.0
>
