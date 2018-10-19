Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC01DECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8DE21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjddYzfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8DE21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeJTCzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:55:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45735 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbeJTCzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:55:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id f17-v6so6683091wrs.12;
        Fri, 19 Oct 2018 11:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yC1Tn/g5rTujXfB0I2tV/PYrAkUblEJdiF/n1/nMS74=;
        b=cjddYzfjgk8jxW7kLQzP2wiR3pP8AehCrRJG6iegzHKDt8UUhdBolxeKcV1p9M1Gh8
         aN5ZfgJbA8zy2LKyCepenZBW904A42YA74prl32igc81D+Eh54uNti+wVjAx9l0Xb+9t
         r+Cb92Favtvmpy1J9MxTWR6iOvnwZHWTgrPOJNCOC47+RWtQ7CchNKDYe60JlKuGwzut
         hY4PFM1q4ys/i6GCyUZJ0WCE/5vgLcnnaAaAwG4qVHAmb/8CIcoyHLnZZ+YPXkRVQDSF
         C1DlT8BSYUffBj1wwKI0qoASUbBj3ntzNekqdBmnOmGW642pUUmEsDTAzZHwL2Bj0qB7
         O4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yC1Tn/g5rTujXfB0I2tV/PYrAkUblEJdiF/n1/nMS74=;
        b=Rs4BoQDwFxt3w0b2ZAStbbTfvHE/HbCmcThSQ4chk38urkb3eJH4ksGZcKzY1RFD+E
         SSTbVgaVOeJ8Nug8GNCmEzeZbzSfKYD+JffP2Q+3YkVKLUChYM3U3yMetHzL+amwhE1s
         aqP9QG3ZdQMy1boW49pgkf+lAJ2f7mLuCO4Xg63+xn4+CPbDpeL1mykIlgygSgqRvHvc
         GXiORsFS/MTqR/vVEVB9suPXdRsao7BGlp61PKw0afKkcuJ3y72ghJDy1sJWr+qAya+g
         6YXOzWvUFtyoOKXC8xwwGzFoUlA2xv0weMlawFY8vVpK9iEL0iFBYM74a00e2Ypn+Cwy
         ZU8A==
X-Gm-Message-State: ABuFfohgOeXVNmLS0Ba+X5OFH6qO2zBWi41Cm3V7anAxGA/UeekiMtlK
        Cjkaa4gY1eDphfaI+a8cbty0EB5Mwi9R7Olt2RqEmA==
X-Google-Smtp-Source: ACcGV60kJVxw9HuN9tiia5fV3y3qPeSEokd0t3noSta66juZKZnq6PHkNwfRnrY6MQYSDsBoWySRWDVIWG0iOumv2bY=
X-Received: by 2002:a05:6000:8e:: with SMTP id m14mr8947264wrx.302.1539974865860;
 Fri, 19 Oct 2018 11:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20181019182649.24301-1-natechancellor@gmail.com> <3e2e5343-3ead-5b4d-758d-14f04183b39e@gmail.com>
In-Reply-To: <3e2e5343-3ead-5b4d-758d-14f04183b39e@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 19 Oct 2018 11:47:34 -0700
Message-ID: <CAADnVQKyaU=kPZN5+Bi=NJDGh6AMV0HKZoDg+tzLGQdq+L8xaQ@mail.gmail.com>
Subject: Re: [PATCH] bpf/test_run: Add braces to initialization in bpf_prog_test_run_skb
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     natechancellor@gmail.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 11:46 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 10/19/2018 11:26 AM, Nathan Chancellor wrote:
> > Clang warns:
> >
> > net/bpf/test_run.c:120:20: error: suggest braces around initialization
> > of subobject [-Werror,-Wmissing-braces]
> >         struct sock sk = {0};
> >                           ^
> >                           {}
> >
> > Add the braces to properly initialize all subobjects.
> >
> > Fixes: 75079847e9d0 ("bpf: add tests for direct packet access from CGROUP_SKB")
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  net/bpf/test_run.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index 8dccac305268..65e049c61a7a 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -117,7 +117,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
> >       u32 retval, duration;
> >       int hh_len = ETH_HLEN;
> >       struct sk_buff *skb;
> > -     struct sock sk = {0};
> > +     struct sock sk = { { {0} } };
> >       void *data;
> >       int ret;
> >
> >
>
> Strange, I thought this patch was still under discussion.
> Has an old version of it being merged somewhere ?

merged and reverted. This patch is not necessary.
