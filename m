Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201E3C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19DE20811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="L95r1pTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19DE20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbeLNKR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:17:26 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38868 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbeLNKR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:17:26 -0500
Received: by mail-qt1-f196.google.com with SMTP id p17so5566247qtl.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 02:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AQQEISGn2DpIR2KD0vFUnYb6s7qpg8qti7n1ddSLkP4=;
        b=L95r1pTY/83+z0nTJFPLWP6vDevKqkJoGUO531DxzB5ki4ln7KusDTcr2+dFDOchQ3
         MFppyV6SpzmrEDKQrash9HLCB8CCvo6PHqPfu+AizcAbOrm2FNvh3pM08/Ya9nYp55Re
         g3YFKxWvVS4ksRaaH/frLNP8ThPteeaSoNFT2FSj7MbCIAbFXsDZnKbOAR8yM8eNYBsa
         FGwdJKauJkzxZQz8+I3uNczi6//xuUciRi3Zcrp3K6sNZ2/3tSpVjwlfCANIRFJXe1UR
         LaHoJORINAVhT5XhaBYF0Y9khilNsZCoRjiEsVS7nolYh667uArdSR2s6iwrGFp66E1u
         cIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AQQEISGn2DpIR2KD0vFUnYb6s7qpg8qti7n1ddSLkP4=;
        b=sb5ESNFqcvrix+Nya8Aag+Xqky5EcfXL/QCw/eFDDLsBiFCO86wJHjwPbYGQcTblHZ
         b2NMEDA9plj3eXmqmM34ZvGZg6cpUIqOJfch1fqq316+IRo2sqJT7Pv/G1KPhtl/SqF9
         /z7Bt2MnfLj8dn8BOOKQ2Q3we9gkRP+XYUD++Bfej539Pkne2DVYFzOjZlIysYjYyu9T
         7WQvF6WKy7hpwpTHla8QH8GHIlF9Hv5Diu1mFcDQqEWrUSlLInWfDxNh/j//VnyqrMDp
         59cvKx9c90KkoBJWXYaP5r7Z/TTRGgJw83E0lVns3u270Uh0M6d64L0L6V8O9gmIbPJE
         qvtw==
X-Gm-Message-State: AA+aEWazDrxTAhx2wTYhmwhrTFviz5WvQLMJKpGIQtSSgWROJ8wj91fe
        KHICdeXUm25xcjQ+wFJyl/UcQK1EcDacSvKsdGe8/A==
X-Google-Smtp-Source: AFSGD/UxRlvoZ94pGtivy+NRUrKGB84WsT9lgPLvHD95JDESlif/9WTzfZGS2IDp9HG7pbdEcCgEuKB3BnxO7b47kow=
X-Received: by 2002:aed:3ae4:: with SMTP id o91mr2122994qte.251.1544782645295;
 Fri, 14 Dec 2018 02:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20181209032715.3466040-1-liuxiaozhou@bytedance.com>
 <CANiq72nqFuJm5f69G-Pc_9QHz+anwaon-WfVsPrkZWah1OP7Fg@mail.gmail.com> <CANiq72=Sim1rmTBqWx6+t4GpRmZoNAhTppvbhEjOo-T2_g0N2A@mail.gmail.com>
In-Reply-To: <CANiq72=Sim1rmTBqWx6+t4GpRmZoNAhTppvbhEjOo-T2_g0N2A@mail.gmail.com>
From:   =?UTF-8?B?5YiY5pmT6Iif?= <liuxiaozhou@bytedance.com>
Date:   Fri, 14 Dec 2018 18:17:14 +0800
Message-ID: <CAEEtttUT4D8z9XeUyZdh4LGnNgUP4cXUdLF=Pk1RWVk43C4jHA@mail.gmail.com>
Subject: Re: [PATCH v2] Compiler Attributes: don't pollute userspace with
 macro definitions
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

On Thu, Dec 13, 2018 at 10:59:10PM +0100, Miguel Ojeda wrote:

> I wonder if we can/should simply move them into the __KERNEL__ &&
> !__ASSEMBLY__ block that is above, instead. It would be simpler to
> read, and there aren't apparently dependencies to those outside it
> that go after the block.

Yes, this is also more accurate. I will send a v3.

> I took a look at where the macros were at each "step", and, on one
> hand, compiler-gcc.h was (and is) included entirely inside it, which
> is from where most of the macros come originally from. On the other
> hand, not all do: __must_check (the generic version, not the one in
> -gcc.h) and noinline_for_stack were defined in __KERNEL__ (only)
> before commit 815f0ddb346c ("include/linux/compiler*.h: make
> compiler-*.h mutually exclusive"). But anyway using those two in
> assembly does not make sense, right?
>
> What do you think?

A simple grep shows no assembly are using those macros. Pretty sure
it is safe to do it this way.


Thanks,
Xiaozhou
