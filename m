Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86227C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 00:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196112083D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 00:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2/oWa6yB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196112083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756989AbeFQAsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 20:48:41 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:45856 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756937AbeFQAsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 20:48:39 -0400
Received: from mail-ua0-f170.google.com (mail-ua0-f170.google.com [209.85.217.170]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w5H0mB0v004562;
        Sun, 17 Jun 2018 09:48:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w5H0mB0v004562
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529196492;
        bh=iWT+tTSsrpMFYGYwoMWDaSnt+43se4NiSQfyANwpKKE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=2/oWa6yBxoLHvoaFhq1fpLpSC8qUPBgJNEua8SsnwJ5RpTxjCzaamcUx5Mvk3zW4D
         8qxpkUYN1Ly7FDJ8HDfPc/uyrhkw7VCH2enT5yy/9FuQ6RWegCTg30mqR0r5/DXKLT
         6POOSjyNZmpgOmGotQnuYxBOWYTXVd4XOQASMGjAVfRbyuGVtR26lhTwdwFdEWDH34
         PP3hS1axIWG1FJW2wdPNXsotnSJsHX0/nnFKGkJkBmfcVQsCdw4wSd8akVimMq+6OA
         o/oNPCgcbTjXf2pPavSu7Rdu5i2981gQ0pJEo2GHxVU/93hxtDLCXX85IYeOMZFz3r
         BFT5cJTuI3NDA==
X-Nifty-SrcIP: [209.85.217.170]
Received: by mail-ua0-f170.google.com with SMTP id d7-v6so8653273uam.13;
        Sat, 16 Jun 2018 17:48:12 -0700 (PDT)
X-Gm-Message-State: APt69E1PiFuKXT+ZVzjkAvH1YRHZBmnRUGjBywZdI5XNn3YY0lYFSNlz
        WSMPf1g3SzpVXKVF9c9oIYIVyMRajC8tAjf9iqs=
X-Google-Smtp-Source: ADUXVKKCLTarztY3R57I8wzVNRdsPg3LyFMkjhB8IGRNeIMYMNE3oNdGrHQkDBZFt+E+R4S85VXO4pnQSwS2xFdXjrg=
X-Received: by 2002:ab0:2e3:: with SMTP id 90-v6mr4363361uah.144.1529196490906;
 Sat, 16 Jun 2018 17:48:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Sat, 16 Jun 2018 17:47:30
 -0700 (PDT)
In-Reply-To: <20180613203614.GB10472@ravnborg.org>
References: <20180612115050.185112-1-namit@vmware.com> <20180612115050.185112-2-namit@vmware.com>
 <CAK7LNATmjTi4Odp5AfbVHCemn7S_tB9nKvgNOf5sp8BiVJma7Q@mail.gmail.com> <20180613203614.GB10472@ravnborg.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 17 Jun 2018 09:47:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNATbDmzgReA0UVbayaFKkC=mXL-psQbiXckuNvjpWyHpcA@mail.gmail.com>
Message-ID: <CAK7LNATbDmzgReA0UVbayaFKkC=mXL-psQbiXckuNvjpWyHpcA@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] Makefile: Prepare for using macros for inline asm
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Nadav Amit <namit@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-14 5:36 GMT+09:00 Sam Ravnborg <sam@ravnborg.org>:
>>
>> > +macros: $(obj)/macros.s
>> > +       @:
>>
>> If you add a phony target, it should be added to 'PHONY'.
>
> Or this part:
>> +archmacros:
>> +       $(Q)$(MAKE) $(build)=arch/x86/kernel macros
>
> could be modified to specify the exact filename so this indirection is not needed.

Yes, it could work.

Actually, two styles co-exist in arch/x86/Makefile.
(archprepare vs archscripts)




-- 
Best Regards
Masahiro Yamada
