Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EAFC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55AE2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ut/eTkuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55AE2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbeKFBWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:22:51 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35476 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729733AbeKFBWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:22:51 -0500
Received: by mail-it1-f194.google.com with SMTP id v11so7141785itj.0;
        Mon, 05 Nov 2018 08:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sDl5xonLW2BPgywXMQRiIC8G9ttF1qEPCCcppREVe4U=;
        b=ut/eTkuSrHQFmdH3VyLvoigk/EYqbKC3XQ/rnEQWKi+KeStGaTaxcmWL77ySEzPizC
         Ek/e7cmfaEBGEXABPipzjqHlNyMaUTftbpjp2osEqUw+DFLh/r0RLY4yg56Qw7uK91Xx
         1Wc68MJmzqupDUdfsRWZnk4JjQMhWZ+ZsthBmQA2V4lIVbptQwqrzW1aKzPYRzmrtjFG
         3HYhu2hq+PNlL1Q4NtfKoZm2bGeSfFkoUC+hKvL86RAE8kvCfjRwHK3GtyjYMBWYZegH
         TxempOKlzgxZ1emDJ+aCpuoEQ2rrhEDhvmEgxvw2rT84xhJj2xD1ogBFarZuhdnYP8+b
         GlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sDl5xonLW2BPgywXMQRiIC8G9ttF1qEPCCcppREVe4U=;
        b=XD3LWYJsiWcgqcyr1wdR7C50QXKwIvMDM7ZRJsCJpyhkuPjekxo/xgORYDnAsmUqpS
         /AJLF4fMPK080UCATfO2InZzlXJiiYg9sn8bCSqrfB8wbzbY6IYl4yOqNEJn/7CMVtrO
         +EkKgIq7lZ01Qt4nNf0Sy95QXmph0x6+0HzE5TSTgvZ8SA2FxqKiKaruCCGdWEH+zDRs
         /A30RK4G2qRDkr/7roz2io4eMmluoBy4nzyweJD3ruF9fnJtjTNwQ0So+SFt8RsmYjdn
         0QEXi0U6KXzzTNaiNjdAmrH74moPnKHslCEo3GNsXSMGHdON0wMFNpZPK3Pn15fyncw3
         jr6g==
X-Gm-Message-State: AGRZ1gKUaZl1sFUuIpZWnRaBg4L0e/JzL1QpuqGE/NgdxXa/JZ+cAbea
        mUX2lQk3PNq56MD4TAspmcVneYsNKQu5SA/sG0Yd5O/hKv4=
X-Google-Smtp-Source: AJdET5fb7N0QRgICTn0umHdMW4BfUdtTMxx5W/sfd9VieLrI1TmtUc6/yH3599I+jNilwK//hXM0FOM7rkXdqGJ+Vl8=
X-Received: by 2002:a24:7acd:: with SMTP id a196-v6mr7048002itc.95.1541433748630;
 Mon, 05 Nov 2018 08:02:28 -0800 (PST)
MIME-Version: 1.0
References: <20181104131444.4049-1-tiny.windzz@gmail.com> <CAEExFWuGN_R=7B4ueAVA8hVoix8ko8zQSXzHxZB5gjwP7jOjpg@mail.gmail.com>
In-Reply-To: <CAEExFWuGN_R=7B4ueAVA8hVoix8ko8zQSXzHxZB5gjwP7jOjpg@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 6 Nov 2018 00:02:14 +0800
Message-ID: <CAEExFWuUt_enePpEOrDksL+j-W+TNzXyWo9b9zfw-ee1usiVWw@mail.gmail.com>
Subject: Re: [PATCH] net: skbuff.h: remove unnecessary unlikely()
To:     davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>, dja@axtens.net,
        ast@kernel.org, sbrivio@redhat.com, pabeni@redhat.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add myself.
-Yangtao
On Mon, Nov 5, 2018 at 9:21 PM Frank Lee <tiny.windzz@gmail.com> wrote:
>
> add netdev@vger.kernel.org
> -- Yangtao
> On Sun, Nov 4, 2018 at 9:14 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
> >
> > WARN_ON() already contains an unlikely(), so it's not necessary to use
> > unlikely.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  include/linux/skbuff.h | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 0ba687454267..7dcfb5591dc3 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -2508,10 +2508,8 @@ int ___pskb_trim(struct sk_buff *skb, unsigned int len);
> >
> >  static inline void __skb_set_length(struct sk_buff *skb, unsigned int len)
> >  {
> > -       if (unlikely(skb_is_nonlinear(skb))) {
> > -               WARN_ON(1);
> > +       if (WARN_ON(skb_is_nonlinear(skb)))
> >                 return;
> > -       }
> >         skb->len = len;
> >         skb_set_tail_pointer(skb, len);
> >  }
> > --
> > 2.17.0
> >
