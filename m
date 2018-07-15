Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2148ECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7C920882
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TRJ5QOCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7C920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeGOWbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 18:31:32 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:43001 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeGOWbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 18:31:32 -0400
Received: by mail-ua0-f195.google.com with SMTP id w7-v6so963702uan.9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 15:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEZ6/Ajuv0OCy6BQergp8BDhlZ+DEUMAm2Rc234evXI=;
        b=TRJ5QOCsSJxtBAH5JkhB+bYVYYxJjfwOaXqaDJCYMgOS3oOw3SiaI8UY/XCMKrYh3g
         Hv1lWwjeohEr5yXFbdCz8KCeXWOkmJLBAFdfq9M7AxfSg0cyKCb+slz9KeEFjteqIXE6
         th0sFKvTCv/44zNLFZfpb0mYpxXtt+vN6F2P0jx0rhszsPE+wKKQFLYtM4s1Q20deYul
         8/ujrO1KrIXuAiB6KtrEdK57l58KddheSu5QwT214STErkEouDC4DEs5XBD3soTSR8+W
         fbVff4uvH5zFbNWVHxglp74Urg7vdTnu4mSCc8D/AOxF3B/tKlyMsJzPgG39U4T2a7Dk
         1X0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEZ6/Ajuv0OCy6BQergp8BDhlZ+DEUMAm2Rc234evXI=;
        b=anVu4GmoF0wLp/uCsh7a1EXdMbyjStP+WnEI1pFNrhuIiVjNERmSJjgQKaqktWOooq
         /GkWq8BrmsuC+ypESADMZKj3cD+/o67t8Cu3Ma1h4/c+ZZkUY/Wn0/41dm/+pfAtbwoq
         Tgzkt38nH30ZF25HaZCiv/aPiQA442/T7/QGKs0yeGPY/prOmO1Dnrfx79cZW05DT8tt
         ugHV6ZiaALbuc0wzT2GNL0DkHodkUKBP/eoQeUv1kyJ4SqNohNIDG/DG8koSD4tp479o
         FZG6FMfQcyUHwYJgu6pnoJcKNK9KmJAF7zM9aUMseshalYzAoXQtA1DEEz811P2Rl2kF
         uYxw==
X-Gm-Message-State: AOUpUlFlYfgxgTECZ65loajBPTnnjl4uJWc2q+dN/QmyEOyBBZnNHKtb
        vN9uiWd3RVn3S5+2Xo2BQF6ECWtcFMPZL2Fap6legg==
X-Google-Smtp-Source: AAOMgpe2grqdO3BVcBcYNqLhmDBBigdtfRyhyV8kzZOSTACaXjEb/SBPBfs+mPbOUyZAUKU88cPp/bqNA6FEkMQMwNo=
X-Received: by 2002:a9f:2633:: with SMTP id 48-v6mr9502496uag.182.1531692429211;
 Sun, 15 Jul 2018 15:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180715084524.181717-1-eddieh@google.com>
In-Reply-To: <20180715084524.181717-1-eddieh@google.com>
From:   Eddie Hao <eddieh@google.com>
Date:   Sun, 15 Jul 2018 15:06:58 -0700
Message-ID: <CAPc1Vtq17h3J7zi-F1491TNgx=eqZcg6+aLzO6WbkbxtKSSBng@mail.gmail.com>
Subject: Re: [PATCH] bpf: allow BPF programs access skb_shared_info->gso_segs field
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, forgot to annotate the subject line with bpf-next.

On Sun, Jul 15, 2018 at 1:45 AM Eddie Hao <eddieh@google.com> wrote:
>
> This adds the ability to read gso_segs from a BPF program. This is useful
> for user space monitoring systems to get gso_segs statistics for each
> arbitrary group of flows defined by the BPF program.
>
> Signed-off-by: Eddie Hao <eddieh@google.com>
> ---
>  include/uapi/linux/bpf.h | 1 +
>  net/core/filter.c        | 9 +++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index b7db3261c62d..282085445616 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2266,6 +2266,7 @@ struct __sk_buff {
>         /* ... here. */
>
>         __u32 data_meta;
> +       unsigned short gso_segs;
>  };
>
>  struct bpf_tunnel_key {
> diff --git a/net/core/filter.c b/net/core/filter.c
> index b9ec916f4e3a..f17e249f3fbb 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5820,6 +5820,15 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
>                                       bpf_target_off(struct sock_common,
>                                                      skc_num, 2, target_size));
>                 break;
> +
> +       case offsetof(struct __sk_buff, gso_segs):
> +               BUILD_BUG_ON(FIELD_SIZEOF(struct skb_shared_info, gso_segs) !=
> +                                         sizeof(unsigned short));
> +               off = offsetof(struct sk_buff, end);
> +               off += offsetof(struct skb_shared_info, gso_segs);
> +               *insn++ = BPF_LDX_MEM(BPF_SIZEOF(unsigned short), si->dst_reg,
> +                                                si->src_reg, off);
> +               break;
>         }
>
>         return insn - insn_buf;
> --
> 2.18.0.203.gfac676dfb9-goog
>
