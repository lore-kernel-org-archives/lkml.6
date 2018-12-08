Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4EDC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 19:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E6520700
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 19:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VfzkZwKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E6520700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeLHTSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 14:18:00 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:41607 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbeLHTSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 14:18:00 -0500
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id wB8JHtHV018493
        for <linux-kernel@vger.kernel.org>; Sun, 9 Dec 2018 04:17:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wB8JHtHV018493
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544296676;
        bh=hCPA0RPn5CtjCd+h5IZiCTDhNEqPtCmsBZgqeWznGo4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VfzkZwKD/q3wwr2duZUJg55E6dEEvCE67LsFedT0UO9lnSf5U+i9lxxQnOsy+qPcB
         fX0olPMiC0zgItLwSVjtLZKzON1Zc5QKx2X8/afsekuWxjvZQgtK8lm4fCnj/EqKxP
         YMofp2yoEbirdGNgmmQpbnBd2rlEVrGEZq3JKcJvF227D58+kcOSU4/hovtFa9RvwQ
         yXUW0h8angnWIfjOtjpXmkELmT/j4cVTkaLl6W923DMiUPQLo/g+kw/RxEDXtzPePy
         yikCRQaWDoH7fndAOGIyFYPFzo2XJ5dXspdF+9RndIyxgCZ4eE9h54UfLhOjQKE54q
         2eEh9l8LVcGmQ==
X-Nifty-SrcIP: [209.85.221.171]
Received: by mail-vk1-f171.google.com with SMTP id q80so1687721vka.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 11:17:56 -0800 (PST)
X-Gm-Message-State: AA+aEWY47iCUQbPWEw5iG/9OQ9tQQaWrTBk/rdcQKefR9epQ8DUlo36C
        dsp4ss7ioWp6kbok+nZbZTH5rXzcE2xp+Y7P97c=
X-Google-Smtp-Source: AFSGD/Uf2k7L99EsX7VN92HWhN+pEIsKdU8v3UiKpW9ugsPMbA3olifTnODlubDe8gPYmC6ZowJiB+UiJ9zrt1X5aRI=
X-Received: by 2002:a1f:4d47:: with SMTP id a68mr2780127vkb.34.1544296674940;
 Sat, 08 Dec 2018 11:17:54 -0800 (PST)
MIME-Version: 1.0
References: <1541990120-9643-1-git-send-email-yamada.masahiro@socionext.com>
 <1541990120-9643-3-git-send-email-yamada.masahiro@socionext.com>
 <87k1lia6bd.fsf@concordia.ellerman.id.au> <CAK7LNARbzF9-ZYvX7U76HqC957Fj=U3rmQfCEYXKqZNV8SFmNg@mail.gmail.com>
 <20181208113313.GD30399@zn.tnic>
In-Reply-To: <20181208113313.GD30399@zn.tnic>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 9 Dec 2018 04:17:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNASJKeozY9+65H6xx1uUhwqL=8TOFCQEU-9Lm+Q6dyyQ_Q@mail.gmail.com>
Message-ID: <CAK7LNASJKeozY9+65H6xx1uUhwqL=8TOFCQEU-9Lm+Q6dyyQ_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86, powerpc: remove -funit-at-a-time compiler option entirely
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Richard Weinberger <richard@sigma-star.at>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,


On Sat, Dec 8, 2018 at 8:34 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Dec 08, 2018 at 03:36:52PM +0900, Masahiro Yamada wrote:
> > x86 maintainers,
> >
> > Ping.
>
> You got the required ACKs. If you want me to carry this one and the
> UML one through the tip tree, lemme know. Or you can do what Richard
> suggested. Your call.


Thank you for your help.
I expect both applied through the tip bot.

Thanks.





> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.



-- 
Best Regards
Masahiro Yamada
