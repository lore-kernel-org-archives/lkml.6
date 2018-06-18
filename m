Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A58C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CD9208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G7xsVsOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CD9208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755216AbeFRHZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 03:25:54 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46563 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755152AbeFRHZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 03:25:52 -0400
Received: by mail-pf0-f196.google.com with SMTP id q1-v6so7707817pff.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 00:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h1+oT04Y8AvLg7YeY7P+voYwFTEiXobEDlodySfKpbY=;
        b=G7xsVsOJmE9knrBzcJvpTH3Zw5s1e1PbUO0Drkd/J7/I+BUP8Q29JSwzWTpPUGjqbz
         XTpn3AX11f8zwxfq5Csb5sGdr+ui2EHqb+JyMzUsow49xYNOu/vgL2w7gC0mcGQjBeXf
         K9UaWbHs1vtyKiHKZd4bGBlVz2RF+Cp0abuYE2yCPOpf2hKi7E9oiFTRP2ZF91VBz8M7
         iDG7/3uzP5j5oFrmZr4huHx6tgCEOhC+IH+AOBhetBCqoPkgE6IN7xKP7tXvLDBnL3Ze
         ynMnvZPOvz6oAD/uBocn+gyetMZzNjU9kSOmSemYGBNeMWMe9jQ9p5/D9KBb6Jbh8pkB
         Jziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h1+oT04Y8AvLg7YeY7P+voYwFTEiXobEDlodySfKpbY=;
        b=Oh1G7HVaiK2JnabH58m/D2+RMIOXVe2FcnC8dt2u2VLlhZ/mwcTEgraUNslFMsN4pD
         ofCO4vFPecWF81dIQLhAB5BuUf8gJdSbmDUcHrTVANkzjVxoY4Y/yEoH9YbuVkPPUSpu
         5YPJiWo+V0Qt7B1uGpCuBLzwQKPw1Q+NuVJtKr64BMnUZapWIDk8oj8zD0Fi6HP5PiAv
         3Jh1HOvo4K3vbzglUWAWSPS389A5gMRrnPn+1R2iozRpSkwfdV4q5ui4ac+DmZv5PbRV
         doG6UgN7mLpB0xRWES0e9v47SVKalRwBi5MncjB3GzvHoi/Jx3AGlDdFNHbSX9Y35H5d
         NVfA==
X-Gm-Message-State: APt69E2wcnRijrX2G1G4xxQF8X3JaCWbQsl9gJ3a4/kaXAmy89B6MUMq
        MA4rie94B/t7WIP+gwVVqski898Xh959p0puAr6L3A07PUU=
X-Google-Smtp-Source: ADUXVKJcqB9RYqfWGNXznwHuKz42Bv49gU/aIF6o20bmElIa3iXq7F+fRiNeN/0IVvSgv/zY5mduFkPupl7tNorQnsY=
X-Received: by 2002:a63:70a:: with SMTP id 10-v6mr10274262pgh.216.1529306751882;
 Mon, 18 Jun 2018 00:25:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Mon, 18 Jun 2018 00:25:31
 -0700 (PDT)
In-Reply-To: <cf1a05d1-0cb2-4fac-84b0-0efd3e0b12ca@googlegroups.com>
References: <001a114387b624fb2e0564614477@google.com> <001a113f64eedee31b05662594bc@google.com>
 <cf1a05d1-0cb2-4fac-84b0-0efd3e0b12ca@googlegroups.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 18 Jun 2018 09:25:31 +0200
Message-ID: <CACT4Y+aBhmF=_j95+cOBH+59+HNGcGKToGv0eg6aWsJhuvpUfg@mail.gmail.com>
Subject: Re: WARNING in xfrm_state_fini (2)
To:     Jason Litzinger <jlitzingerdev@gmail.com>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 6:14 AM, Jason Litzinger
<jlitzingerdev@gmail.com> wrote:
> I've simplified the reproducer provided by syzbot to the included
> version.  The warning is reproduced 100% using the qemu image in the
> syzkaller docs running the latest upstream and net.
>
> As noted on the dashboard, this is similar to [1], in that an entry
> remains in the xfrm_state_walk list, but different because the
> protocol is not 0, it is 43, IPPROTO_ROUTING (and is valid by the fix
> for [1], see 6a53b7593233).
>
> Unfortunately, when a namespace exits, xfrm_state_fini only flushes
> IPSEC protocols.  I don't have enough experience with the xfrm
> subsystem to know whether this is correct, however, dc00a525603650a14
> explicitly allows non ipsec protocols, as well as 0 for "all".
>
> Would it be more appropriate for flush to also flush the non ipsec
> protocols allowed in xfrm_user.c:validate_tmpl (explicitly or with 0)?
>
> If someone with more experience with the subsystem believes that to be
> the case I'm happy to send a patch (against net or ipsec?), otherwise
> I'm going to keep digging to see if a better option presents itself.
>
> Regardless I hope the simplified reproducer might be useful.
>
> -Jason
>
> [1]
> https://syzkaller.appspot.com/bug?id=c922592229951800c197ce48a5eaab8877c33723
>
> * I wasn't subscribed to the list for the original message, so I'm
>   using the GUI to reply...apologies if anything is mangled.

+kernel developers back to CC

Jason did some debugging of this bug and have some questions as to
what's the best way to proceed. Please read the above.
