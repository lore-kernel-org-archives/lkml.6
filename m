Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172F9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0D72150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FCVrQ7d7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0D72150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeHWXJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 19:09:21 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34749 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeHWXJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 19:09:21 -0400
Received: by mail-io0-f196.google.com with SMTP id c22-v6so5264170iob.1;
        Thu, 23 Aug 2018 12:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8b/yzaXiUCdXSeLQDWlOGszjJPac257AS+z8MSzWMdI=;
        b=FCVrQ7d7KKWB2YZa0sbeNedhXr91AQfRbEPAaEUP/0ggBKR0CTc4/hJuYfuOiPlcEy
         UCu4ydmAIsdFA27YC1QqxaDsidslEMldkJzCl8uT3wMXFHUgUHduq+/jnSxTSr9pq2Md
         g4Seq3pFYwrAPusbcLwxsjGBslfR4WVQvAxzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8b/yzaXiUCdXSeLQDWlOGszjJPac257AS+z8MSzWMdI=;
        b=Ojxhrc1pnYzdh/hL5so8Kkn7tChbhAaPSR4RcSGMhFnGgceTqifzHY90hSlZ8USsi7
         wg1N1wv64ozVpPbYTNB/27chvlI3f0YAcQu6tN2h/ffQta2HiEmU9VenPVQk6uSuul3u
         3dvRpBeiu47VbT0WdcTJLtjEYIEC5r75UpcC7Bt0+OJTDJ8R59SphoWnGQYc+DuPdmgz
         2rZYWynC4ZJUhaGMC8AUza5Ebe5p6DeUXrgDJK7LnkNPRfU5R/5K5k2BHepwBi4fxel8
         jBqEdyS82wowlc0Nao/E8zLme1LdUKKHKYkZ+b4gZM2viz2IIxgJezXbmVjNIuEm5hdc
         Ui7w==
X-Gm-Message-State: APzg51CE3Hfnado8EBrWWBssQuAHEzRxY+E6UN02RXC/hs8C4xRNxgJh
        EIGeaVz4IFMQBwf3ZwhMzdaijg9v6p2Doj061K8=
X-Google-Smtp-Source: ANB0VdYYYtcQ7e4norjeCYN0RiLb+4/xe7+AYmnf1Tr7r8icavzU03NkqUqSW5UZAIxp/lz3gkhSsecFKsLYa60u7PM=
X-Received: by 2002:a6b:7a49:: with SMTP id k9-v6mr9316045iop.238.1535053090083;
 Thu, 23 Aug 2018 12:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180823084709.19717-1-npiggin@gmail.com> <CA+55aFxaiv3SMvFUSEnd_p6nuGttUnv2_O3v_G2zCnnc0pV2pA@mail.gmail.com>
In-Reply-To: <CA+55aFxaiv3SMvFUSEnd_p6nuGttUnv2_O3v_G2zCnnc0pV2pA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Aug 2018 12:37:58 -0700
Message-ID: <CA+55aFwEZftzAd9k-kjiaXonP2XeTDYshjY56jmd1CFBaXmGHA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] minor mmu_gather patches
To:     Nick Piggin <npiggin@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Will Deacon <will.deacon@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 12:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So right now my "tlb-fixes" branch looks like this:
> [..]
>
> I'll do a few more test builds and boots, but I think I'm going to
> merge it in this cleaned-up and re-ordered form.

In the meantime, I decided to push out that branch in case anybody
wants to look at it.

I may rebase it if I - or anybody else - find anything bad there, so
consider it non-stable, but I think it's in its final shape modulo
issues.

              Linus
