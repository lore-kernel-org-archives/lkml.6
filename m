Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCF4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E768321525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGl49qWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E768321525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbeITXit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:38:49 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33842 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeITXit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:38:49 -0400
Received: by mail-qk1-f193.google.com with SMTP id p84-v6so5594184qke.1;
        Thu, 20 Sep 2018 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J+IM8Bs4Hxgv/xaq0Rp/Kg5fdqMLjnzZsBNu/3Agie8=;
        b=nGl49qWvXIHN2eZgHMYvErx9kwvnOyAIaIlj2FWZ1MCZ9VApM6UQ5pZPlvvb13rD+c
         xS8L3QVD5OvuXkK1M0GHuC23iOxZte9NUVM+Xrys4dbnG7H38SYbHiNT2w9+OacdQGJW
         a02/Cc3kA4RrYDo8WhTakBbmFpW+Nn2RY6iF8feboIGcMAmpwvvaQU1Zl2+GWjreitkK
         wcrxgWnj8j20ZYVwRtAJwAvLQRpmgAILMf3erkCU8/7HUTdczrUTminxml/U5jRbIaC7
         89O/+LZ9gHmGBVPbOUd7x7w3ONWiv78TOExVduldrLJdlP8TJIXDEblov34Uo3n1YAlg
         +asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J+IM8Bs4Hxgv/xaq0Rp/Kg5fdqMLjnzZsBNu/3Agie8=;
        b=hRzsG4EAp871j/61AnoeE9lq1mjGK3WQNqjNLoTwDijxouJfQINPtJWSP2dtsF8QCn
         hYUXo3DlPVfZNw7xbWkZUEV8XNG/PR5USvlmgQOYBw42q72KYlkn9mqUskIXjUwn18oy
         8rlynjoOGG3lffGdjX2wJY6K9/IGvbQTxgknrgwXqIUSYC4lNsmACnyUQA17DHOjAA6N
         6znHSLRbORBbqBvjysyePrwc+9gIhNNrYPiA56jyyXmIdcFwiPD5c89nBEeojTHDkJZQ
         AdHMj9PxwwBxRUUW+CAIQHrGiUMHevPbM8Ynb9VRc36+i+PiFgTMrXM00Du59/qtBMVx
         Ik/w==
X-Gm-Message-State: APzg51AwsCxvwovTRUWp2IESDytRE08JIt9njtph/WrFVmZJSxRz6RW8
        xQIDGABS4XdhxtqcUy4KotGacr+yqMz+3sbAjmg=
X-Google-Smtp-Source: ANB0VdaRfjT06okbCKmlgB9tePMrllM0iSLlRl7ZLo0YXR+rMLeRW6q9EleskuqPWuDw2VORz/c5wEMQKWCK5dArLG8=
X-Received: by 2002:a37:1f9a:: with SMTP id n26-v6mr8842837qkh.120.1537466050732;
 Thu, 20 Sep 2018 10:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <1537436772-42545-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1537436772-42545-1-git-send-email-zhongjiang@huawei.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 20 Sep 2018 10:53:59 -0700
Message-ID: <CAPhsuW47a=6r_O9WRp=BrpOfDfKFFrzvfmdsuAUygZYZXP4sFg@mail.gmail.com>
Subject: Re: [PATCH] bpf: remove redundant null pointer check before consume_skb
To:     zhongjiang@huawei.com
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 3:00 AM zhong jiang <zhongjiang@huawei.com> wrote:
>
> consume_skb has taken the null pointer into account. hence it is safe
> to remove the redundant null pointer check before consume_skb.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  kernel/bpf/sockmap.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/sockmap.c b/kernel/bpf/sockmap.c
> index 488ef96..a9359cb 100644
> --- a/kernel/bpf/sockmap.c
> +++ b/kernel/bpf/sockmap.c
> @@ -590,8 +590,7 @@ static int free_sg(struct sock *sk, int start,
>                 if (i == MAX_SKB_FRAGS)
>                         i = 0;
>         }
> -       if (md->skb)
> -               consume_skb(md->skb);
> +       consume_skb(md->skb);
>
>         return free;
>  }
> @@ -973,8 +972,7 @@ static int bpf_tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>
>                 if (!sg->length && md->sg_start == md->sg_end) {
>                         list_del(&md->list);
> -                       if (md->skb)
> -                               consume_skb(md->skb);
> +                       consume_skb(md->skb);
>                         kfree(md);
>                 }
>         }
> --
> 1.7.12.4
>
