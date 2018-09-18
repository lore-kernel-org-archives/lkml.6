Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4BAECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7603A206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EVNzxG/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7603A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbeIRPRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:17:07 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46596 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbeIRPRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:17:07 -0400
Received: by mail-yb1-f196.google.com with SMTP id y20-v6so517138ybi.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 02:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NPf1qltNjOb+zWpab5+bcnbL9EHLdA3PXcd8672h7ao=;
        b=EVNzxG/g4VrzhRgfPAY4QCzkAXl2jzlNpG3BCRwqgr+5wrUOKl/2Dm9WqqfOQXrI6w
         Q3+n05j1/GJuYH7fLsk1xnbHcSwOjf50vFBHLOBTOXocw4VPBRROAdd7ZpzpeyGXDITo
         aS5ivS2z8Zkb7+YDoI17qq0bZ/KRyEcfCmrCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NPf1qltNjOb+zWpab5+bcnbL9EHLdA3PXcd8672h7ao=;
        b=cPaXr/gDje4QJOlUxj57473WuSmhKS59U+S9Q6V8iOQ8dRpv3NDNm60rfNK5vzCR1m
         9qHTEnvjmfEMicx+QOPwCJmpNP1kqluWv7MNjU2fyjXXVy18cOcXSqcoDkSfrQ62B5xT
         js2c+g9C8+ALk30jji2Zo6miKInv4sIctG5v/300hpx/sbJ3wmF2ua+Jlz0aH5wNimNj
         FkZZ0Lfjk42v8ZuCZ8EsUJS4DSMlNysUmsv1sGWYV4vUqcovn7lK0HUId0Zmo4JzbA8V
         twotWlnO3F0DHgsWewzfcVO6O98NwXFCNQvvMCj9EtheV7fJBwRCo9jVZChn4C9syGqZ
         ptrQ==
X-Gm-Message-State: APzg51A6V70qPD5yN0Tqgl2zOXwbMmb6okVBue8WlouUqnk/ofVimCLh
        brmmaUaHlSFMbsBLsJCayOXdbNAyvxHP2C32q2b4kw==
X-Google-Smtp-Source: ANB0VdajltIE0DKUlWeId+xIvkB5AuhJNXqVFTabEbakJgK9RUkmaQJyJpSDkbV/IEPyR1lv9364HApVEVWabBLybO0=
X-Received: by 2002:a25:be41:: with SMTP id d1-v6mr11982126ybm.483.1537263918732;
 Tue, 18 Sep 2018 02:45:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:cc4f:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 02:45:18
 -0700 (PDT)
In-Reply-To: <CAK8P3a3_tzeKf2PFa4LMym3UgBPu380H9LGyGLTDJEu7aNyecQ@mail.gmail.com>
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org>
 <1536036087-15260-3-git-send-email-firoz.khan@linaro.org> <CAK8P3a3_tzeKf2PFa4LMym3UgBPu380H9LGyGLTDJEu7aNyecQ@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 18 Sep 2018 15:15:18 +0530
Message-ID: <CALxhOngq7kjFTA=oQBzV5fEtdtCq6ytb8excP76Gshikq3Q-4A@mail.gmail.com>
Subject: Re: [PATCH 2/4] sparc: Replace NR_SYSCALLS macro with __NR_SYSCALLS
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 September 2018 at 20:59, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Sep 4, 2018 at 6:42 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
>>
>> -#define NR_syscalls            361
>> +#define __NR_syscalls          361
>
> What about the suggestion that was made earlier to enclose this in
> #ifdef __KERNEL__?

The issue, keeping __NR_syscalls in uapi header was pointed out by
Michal Simek (microblaze) and Geert Uytterhoeven (m68k). I replied
them with this suggestion (enclose with #ifdef __KERNEL__). Once
they agree, my next version of patch series will have this change.

- Firoz
