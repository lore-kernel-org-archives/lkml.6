Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D891C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 13:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A5F20665
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 13:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="C82IdWyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A5F20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeJ1Vyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 17:54:53 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:64017 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeJ1Vyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 17:54:52 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w9SD9wrw001904;
        Sun, 28 Oct 2018 22:09:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w9SD9wrw001904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540732198;
        bh=E6jmfOtoF/c8eLmVqGd5wikx07MJVkzlZFYjWLrlJkU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C82IdWyGknhsYpuYfx+D34qjlSQpCbMId5uLZlQtfxy8JjY/oGBsshnM9cVhG3HgD
         AKBRSbVSyubFOTd3EKHUeMhL6oL7CoL5hG3L2ipkBHGT98wTAy7VBVr7cNxfivKsN3
         F4bbqFDgNFxLM00QpHM3RAHhLCr0i5inUtApzgb21Lu0iRi/oFp/X+gHZghsjGStIf
         R3Bq9tAZ5tvOvHyxjAMWVHWFz8qSqJSTcOu0MpG2JQcPWdYU09WlyUu/J2hjVs3dVz
         A+al1zZ+c2p9Z+mQnCJgsPVFzYdyrLSGN3g3CmdJrtrGwz043q7DIB/jT+PVQjJRe3
         GTJvJIFpBOXRQ==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id w19so2015814uaj.3;
        Sun, 28 Oct 2018 06:09:58 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJeJvd+mloRKGcw2ZxqKdZViVyKhcurxo7KFA2VVANGUOJAskyX
        pDYg70h4FEjkDRsmMUBdbC2/yJ8z7pKyeoEMgjg=
X-Google-Smtp-Source: AJdET5cvLpL5vL3bNXmSOJGTKH04EhCfIfDFvA5+Z1LMMXzyvVdbUVUJwrH/BPMRgq/r/eF2uX/iMgXknHmg0w3HLqA=
X-Received: by 2002:ab0:7646:: with SMTP id s6mr485827uaq.89.1540732197170;
 Sun, 28 Oct 2018 06:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181019124921.13780-1-changbin.du@gmail.com> <20181019124921.13780-5-changbin.du@gmail.com>
 <CAK7LNARW0=0d7m5DAgZOir=h0Y4tssqZoQRGasnGPNnvNf_+pg@mail.gmail.com> <20181028125106.azcn2dxia3snplin@mail.google.com>
In-Reply-To: <20181028125106.azcn2dxia3snplin@mail.google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 28 Oct 2018 22:09:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNARr7bE=DVuzim5771heuN5os0=5-D+jXfUyBb2e1xYoRA@mail.gmail.com>
Message-ID: <CAK7LNARr7bE=DVuzim5771heuN5os0=5-D+jXfUyBb2e1xYoRA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] kernel hacking: new config CC_OPTIMIZE_FOR_DEBUGGING
 to apply GCC -Og optimization
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Changbin,

On Sun, Oct 28, 2018 at 9:52 PM Changbin Du <changbin.du@gmail.com> wrote:

> >
> Thanks for pointing this out and kind suggestions. I have tested with your
> modification. Will update patch serias soon.


I have one more request.

The patch subject
"kernel hacking: new config CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og
optimization"
is too long (83 characters)


I'd like the subject to be within 70 columns or so.

Thanks.




-- 
Best Regards
Masahiro Yamada
