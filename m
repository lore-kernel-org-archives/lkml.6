Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AD2ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DB9207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FDOXIkEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DB9207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeJYBcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:32:12 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37364 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeJYBcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:32:12 -0400
Received: by mail-it1-f195.google.com with SMTP id e74-v6so7518918ita.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 10:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gR2Bj4WAQmDwc1oDRZRdDoWI4pRtnltVoo/lphnLRaI=;
        b=FDOXIkEfzrUqbPJsFxNaAL2h1QIGP8Fzj4KQNzGAFw/+CVBDR2q+yHYNoYt8OgvZlS
         BgP+TXPj8eP7tSgb2IPng+9aVnLqVJtoebtOleuf4Rc/1KefpNF4qi+8QhZwu5KeNOrg
         baDgu0QTzaeWKmAnNThFYY1HgLU1oZ9FAefIZ2trtDPwVNkQSav5htzN9/vX6YV5kAW1
         h4SkPUnYkbnvCyFBqKP6hKRsamUTTMDNh+J6Sr+OizotuEmGyYntKd2enOuxHYN82I+R
         Gv/7v31HajedNONoIx35gfOSqlwmC6UelK+Mxt2dUz/OU49W7yDKGjYTKUfSLqgJZUbn
         0jaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gR2Bj4WAQmDwc1oDRZRdDoWI4pRtnltVoo/lphnLRaI=;
        b=UJeImGD0eSABSSF/OzDHq7vYkkooMUjb6NgG8gosS5knP0K5at2uEk0xwcVglOUhf8
         h6foUzjsMHtBLcUUrsuuDYgaYE4Ux0DRIp2/J8mvU1Vkcyf2oACQuBAQ6rGysFrkWxAv
         n48mZkJIvjvJ2xYpo/nwDqYNmcYlCZkUESallXzjUO5ZODLC9+2xhkHY4Vcj25JnHUbd
         hu3NgC61UkADrsptlbsn1fYbJtiYhhOZZvxVwoQmGefsKIujm17X4YmxdfR8JniuwzZ+
         6Gju7849GqS1y0m5NzPy0RJEjdYVlPywaZEQl57XTlhY9ijnQIAQJU4S0MR5NiHMOHMm
         Ke6w==
X-Gm-Message-State: AGRZ1gIDSM5NQHLY8jaq/Oe8zWLwgDHYMOmuH3rW82JhbqxnyinNNA1K
        ER4Xjm48Lisp8eK9BEQQySFOdopJE4LT+3K3BPHt/A==
X-Google-Smtp-Source: AJdET5cB8B0+o4ZBPtyBmGACkQUg99lxTbKrj0/E8zMe9Sng71mj7E3Wyi+C2cf+eRRQhfuBjJHUpf+27CKOcyvyqww=
X-Received: by 2002:a24:6486:: with SMTP id t128-v6mr2112018itc.136.1540400600921;
 Wed, 24 Oct 2018 10:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181024154729.5312-1-wanghaifine@gmail.com> <20181024155739.GA25314@1wt.eu>
 <60f08664db5751949ddfb34666bfda77f99682f1.camel@perches.com>
 <20181024163230.GA25382@1wt.eu> <bbc4eba31b89cb487962c0a5980a12c53b1aa58b.camel@perches.com>
In-Reply-To: <bbc4eba31b89cb487962c0a5980a12c53b1aa58b.camel@perches.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 24 Oct 2018 10:03:08 -0700
Message-ID: <CANn89iLH=VP1i=KS5QV1x41EpQM5-o1TJfDh01Y++bMpFpfBRg@mail.gmail.com>
Subject: Re: [PATCH] Change judgment len position
To:     joe@perches.com
Cc:     Willy Tarreau <w@1wt.eu>, wanghaifine@gmail.com,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 9:54 AM Joe Perches <joe@perches.com> wrote:

> I think if the point is to test for negative numbers,
> it's clearer to do that before using min_t.and it's
> probably clearer not to use min_t at all.
>

...

>
>         if (len > sizeof(int))
>                 len = sizeof(int);

It is a matter of taste really, I know some people (like me) sometimes
mixes min() and max()

I would  suggest that if someones wants to change the current code, a
corresponding test
would be added in tools/testing/selftests/net
