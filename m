Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3393DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4CD2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4CD2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbeJ2UPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:15:34 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33830 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeJ2UPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:15:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id z2-v6so8707591qts.1;
        Mon, 29 Oct 2018 04:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1nRKMTCCIGxbujpU4xsFHzeQ9HmHNvipbWBMFC1Eqzc=;
        b=TaCZGShbnkoIVIoRa7OhMEW55McZRajYJtQuBwYYWYtEXon/O4UV/Kmuwj5DQXbhdI
         Q+/PaRShIpJpGt/G8Z2rZpsNfbytIYi9y1CO3xRNKAvnyszCUJLow3x+DjadfhE3MF34
         ifbApUGcquU9q4ngjj5ZFIL6PfBFFy2jaKrnrgWw0lTlm1UG7BMMUiXzP00+pTlKpj2h
         FwyhiHmDg3E7w8LX/vICMHA0hAATyy/D462sTrELWlyR1SBZnoWnZbANmyOfUQAFW0Rb
         lwv7hahI8JaKfvHgpy9udGbKvwH9xlmyZtN+IP3TwvNmCYQ1rzEvKteW3yLImUaknID6
         h0YQ==
X-Gm-Message-State: AGRZ1gIqxtYQxDCgHnlyKKE4txfoNatv+qA77wRr/hSY2yB9SJ37hk1p
        LIR0G259fTVsyDxb0RtOpe1cAqD3G3mLvZBYYoA=
X-Google-Smtp-Source: AJdET5ctcO2L0kH8bJOjQqJnsbftUFOGDCahqLyArvZkIu80PbHZiPeuH3/KAnjDZ4KW9M5DdXeOLPtOf+ep18Y2omE=
X-Received: by 2002:a0c:c68f:: with SMTP id d15-v6mr12269628qvj.40.1540812437852;
 Mon, 29 Oct 2018 04:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
 <CAHk-=whHhzsdgbVwRFB8oGVwnfN551HPQjtvuodf+W5dNHtjuA@mail.gmail.com>
 <CAK8P3a2-wyXxctVtJxniUoeShASMhF-6Z1vyvfBnr6wKJuioAQ@mail.gmail.com> <CAMuHMdU6e8vu_Kak2Avzn2WeTkmc-mjagR5tzX8BxgdH_UcYUA@mail.gmail.com>
In-Reply-To: <CAMuHMdU6e8vu_Kak2Avzn2WeTkmc-mjagR5tzX8BxgdH_UcYUA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Oct 2018 12:27:01 +0100
Message-ID: <CAK8P3a1mnNbMA+qRLKkhwwW_+KzkSfeNA5Nn_zVS1z8OWU+uGg@mail.gmail.com>
Subject: Re: [GIT PULL] C-SKY(csky) Port for Linux 4.20
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guo Ren <ren_guo@c-sky.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        c-sky_gcc_upstream@c-sky.com, guoren1983@gmail.com,
        mrybczyn@kalray.eu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 11:26 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> On Mon, Oct 29, 2018 at 10:45 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > One more general comment: I think this may well be the last new CPU
> > architecture we ever add to the kernel. Both nds32 and c-sky are made
> > by companies that also work on risc-v, and generally speaking risc-v
> > seems to be killing off any of the minor licensable instruction set projects,
> > just like ARM has mostly killed off the custom vendor-specific instruction
> > sets already. If we add another architecture in the future, it may instead
> > be something like the LLVM bitcode or WebAssembly, who knows?
>
> Kalray MPPA?
>

Ok, I stand corrected. I found the sources at [1], which look like they
are getting ready for an initial submission.

       Arnd

[1] https://github.com/kalray/linux_coolidge/commits/kalray-v4.19-rc8
