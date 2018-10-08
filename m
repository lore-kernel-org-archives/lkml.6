Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFADEC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B1A2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GESETvm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B1A2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJIEGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:06:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41630 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIEGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:06:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id l41-v6so9904346qtl.8;
        Mon, 08 Oct 2018 13:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KVHdIBoW+VtQMtUCngKtiMHvuTRci3iWVQDgrtSWFKo=;
        b=GESETvm6XV/hHVXQr72ZRD3wHm70D0IDtlEWpL3iFzNG8sAyyuVePk9bD96wBVtk/F
         lLHKkI8o15AShzB0EMht84fPTbN46aa5bWDjLiG8Enk3Azlv1Y/lbmcsfXFYvFZUGdan
         VXBpCo548msJmtsBsN1k/Ughhhzcxz2zixjBufg58EXnBoNEOaE632Ne1MEFjKBt4IB4
         v6cEtdhuPOCLFczDm4rw9NdAKfcvl6F0wbXIcW9IcCak4Ywg0J/jAmstMLM61qFFY4QZ
         +k4shLBFZV56Hvp5hr4YYjrreU/iA0JoDlGv6LtTGSJp7AlhTh+JMJCGcerw+ZJaQX0i
         /3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KVHdIBoW+VtQMtUCngKtiMHvuTRci3iWVQDgrtSWFKo=;
        b=WVPgMfWFHl/R0T+aHEd2vzGuAivKi1wI5bA+Iuxof5MxVZwu3o/jt+ak14AyBZtecC
         yS1klJYbpr4ERyLl4jcM0E+R63QdbYhI/ahNwZ0LTq8S6SE8wXqcCdKn7LL5LJFAk6fl
         pHJmHN0QYXpG9M2zyB2Bf9h2ymnmSNkHFTB3m4w2zDcuawEjteCIDNcTiamgiaNLyH4k
         M9qITly1E1M7Mtf+fksTFqSl+LrScAELjIJPJIuVzJWK7XzWsXkB0vsWqFrX7j67h7GP
         i1rj2ZIaHedGSwqZjyno+f+erbM4gLLOOdEFEUGyJsT4MmRaLCg/zlhwKqEPMAil735z
         LrWg==
X-Gm-Message-State: ABuFfojA4qQUT2fTUq1FYtdC8rX2XYrGC1w0f9Z362FkMURjengInchY
        AF8t3PFEPNvroEzQ084j6daqm6Ax+/Gg2xs+5/8=
X-Google-Smtp-Source: ACcGV61x+PFgQ27DGxsuhaD0bvqZ3GgLaIjW768lhuwnbXTUoPzKgWFpzPYm+iS2IxodbfsjekyYQp9mCZmBrPSIIAQ=
X-Received: by 2002:ac8:85c:: with SMTP id x28-v6mr21082496qth.90.1539031975339;
 Mon, 08 Oct 2018 13:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181008183001.10406-1-joe@wand.net.nz>
In-Reply-To: <20181008183001.10406-1-joe@wand.net.nz>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 8 Oct 2018 13:52:42 -0700
Message-ID: <CAPhsuW5wNDEEQbHY_zCTcCQ_FKN4poBGq26H2Gksd=QB1SGZow@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next] bpf: fix building without CONFIG_INET
To:     joe@wand.net.nz
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        makita.toshiaki@lab.ntt.co.jp, Lawrence Brakmo <brakmo@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Mathieu Xhonneux <m.xhonneux@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 11:30 AM Joe Stringer <joe@wand.net.nz> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
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
> Wrap the related sections of code in #ifdefs for the config option.
>
> Furthermore, sk_lookup() should always have been marked 'static', this
> also avoids a warning about a missing prototype when building with
> 'make W=1'.
>
> Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Joe Stringer <joe@wand.net.nz>

Acked-by: Song Liu <songliubraving@fb.com>


> ---
> v2: Modify the patch to remove the related code in preprocessor rather
>     than relying on compiler optimizations to remove the code.
> ---
>  net/core/filter.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 30c6b2d3ef16..4bbc6567fcb8 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4817,8 +4817,9 @@ static const struct bpf_func_proto bpf_lwt_seg6_adjust_srh_proto = {
>  };
>  #endif /* CONFIG_IPV6_SEG6_BPF */
>
> -struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
> -                      struct sk_buff *skb, u8 family, u8 proto)
> +#ifdef CONFIG_INET
> +static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
> +                             struct sk_buff *skb, u8 family, u8 proto)
>  {
>         int dif = skb->dev->ifindex;
>         bool refcounted = false;
> @@ -4951,6 +4952,7 @@ static const struct bpf_func_proto bpf_sk_release_proto = {
>         .ret_type       = RET_INTEGER,
>         .arg1_type      = ARG_PTR_TO_SOCKET,
>  };
> +#endif /* CONFIG_INET */
>
>  bool bpf_helper_changes_pkt_data(void *func)
>  {
> @@ -5158,12 +5160,14 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
> @@ -5264,12 +5268,14 @@ sk_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
> 2.17.1
>
