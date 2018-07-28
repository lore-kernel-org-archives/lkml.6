Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5C7C67790
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 00:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAE220862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 00:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VgrkuMEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AAE220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389163AbeG1CQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 22:16:00 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:32021 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388527AbeG1CQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 22:16:00 -0400
Received: from mail-ua0-f170.google.com (mail-ua0-f170.google.com [209.85.217.170]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w6S0pQ0Z027601;
        Sat, 28 Jul 2018 09:51:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w6S0pQ0Z027601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532739087;
        bh=bhaAELsm5CS/1q96pfgKx2Ukn4asFNw2KvuvznxN5Jw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=VgrkuMEgdtpI41RC+kbPxPz8kJokHRkjjnwFlkIPTAn1pGw2U0FX43HUA9EVfc4g3
         w61fGBrzyIw+PzsFMqgZmon0RbGsmXLVn+azTypU4UzvQC7Q010gAADorwb7GZqGkV
         W6VTPfYDmdXQMJJxQ4DVWe6waj5qfPSWct7rp5+Ow4EylZ7iqAUNiZMwrQg+JS9Fi+
         T/Jj9rMcYsQBwsJKW+dknUa3+QSO1oYPnrf2HEejhjVoM1vbRqdaE0mvhTYVFjCQXZ
         kO9y2K5VKCGQCeJqobQSUc1vOAiOcKxcdSzShp443qVVDAJBR+Xc0R+AKu0mDjOXMN
         NPUeHVQ0A4SUA==
X-Nifty-SrcIP: [209.85.217.170]
Received: by mail-ua0-f170.google.com with SMTP id k25-v6so4473824uao.11;
        Fri, 27 Jul 2018 17:51:27 -0700 (PDT)
X-Gm-Message-State: AOUpUlHFVJDMlLKRq65MiSiWBuFWVuS/ab+RYbOIf8Y+VcK1KF1OEoPj
        jS3nr3TaA7V+Py3mtxhI+8pRiFNOj7Oj4LuChM8=
X-Google-Smtp-Source: AAOMgpfLjzOwQjGUkZARy1ap+qzPBP+oFIZx/0cwm+bYFFbHD6eqLfokv4TITVRTaxvTpaSCJRXCLioyzKhmtVEryVM=
X-Received: by 2002:ab0:4946:: with SMTP id a6-v6mr6190300uad.82.1532739085934;
 Fri, 27 Jul 2018 17:51:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7289:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 17:50:45
 -0700 (PDT)
In-Reply-To: <20180727074854.GA21840@lst.de>
References: <20180724175646.3621-1-hch@lst.de> <CAK7LNARP2HZ8GdsAU8h_b04jLWbvFXTWqiVt2hpE0vJbjP82ZA@mail.gmail.com>
 <20180726172143.GA9836@lst.de> <CAK7LNASd0YCj4wwmT9-6GYiBz=wDoXkmQW2F_5XjbCzS9-weUw@mail.gmail.com>
 <20180727074854.GA21840@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 28 Jul 2018 09:50:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNATnt9ryzMD7=6WNnoJq2B3wT_TJisJgpF=MPFwqF6yP=g@mail.gmail.com>
Message-ID: <CAK7LNATnt9ryzMD7=6WNnoJq2B3wT_TJisJgpF=MPFwqF6yP=g@mail.gmail.com>
Subject: Re: include architecture Kconfig files from top-level Kconfig v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Ley Foon Tan <lftan@altera.com>,
        Michal Simek <monstr@monstr.eu>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-um@lists.infradead.org, linux-arch@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-27 16:48 GMT+09:00 Christoph Hellwig <hch@lst.de>:
> On Fri, Jul 27, 2018 at 10:32:19AM +0900, Masahiro Yamada wrote:
>> This will just add a new unmet dependency warning.
>> CONFIG_PREEMPT_COUNT will be still selected.
>
> True.  I guess we simply need to prohibit CONFIG_DEBUG_ATOMIC_SLEEP
> explicitly if PREEMPT_COUNT isn't supported.  E.g something like this:
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 26d3ff7e3cf4..373ce9fecd7e 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1195,6 +1195,7 @@ config DEBUG_ATOMIC_SLEEP
>         bool "Sleep inside atomic section checking"
>         select PREEMPT_COUNT
>         depends on DEBUG_KERNEL
> +       depends on !ARCH_NO_PREEMPT
>         help
>           If you say Y here, various routines which may sleep will become very
>           noisy if they are called inside atomic sections: when a spinlock is


I will fold this into 07/10.


I see another 'select PREEMPT_COUNT' in
drivers/gpu/drm/i915/Kconfig.debug
but DRM_I915 depends on X86, so this is not
a real problem.



-- 
Best Regards
Masahiro Yamada
