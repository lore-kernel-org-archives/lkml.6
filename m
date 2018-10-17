Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B53ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6382150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6382150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeJQXpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:45:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35956 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeJQXpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:45:43 -0400
Received: by mail-qk1-f195.google.com with SMTP id a85-v6so16774265qkg.3;
        Wed, 17 Oct 2018 08:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oECmHai3diLB8EjjF1TlvsA6aCmdNIvviF0rhK+ZTAM=;
        b=BeZ44vdxbkqDT7yiPUTJxTn9t3IJDJVCa+639sLmtAqUXIVXqBc1e01uffdAxtue1B
         KNnnSqUNJ/TiFj8bRa7ADFyBUL0UaLXPpxawMBxD0ZwwkNiXfU9pXlQbf7OkIhrk0WWp
         A1YhQZsILE9Z9mdxAhJZqqTvju7YnFAW5306dX6xGFhbxFdb5/WjlhofawbtA3sGqphc
         a/14Xx0vQP9uHPavq98ogctr47du5z7tK/RBW+1/eWT9EFzCmKA/f0sbMfJow5cKaHoX
         zWU684SbEvehqdzHRzHERdnNF0qYDRNEanf00coFn22fCT87hKC8YKa37jpy9bpI4/Uz
         gXXw==
X-Gm-Message-State: ABuFfohLTxnGFAmOoB8jcVmGgBSfhrMMMihcAHJCuZE8xpPo2IOl/2Wg
        BbERqtnH47/eJEAb6cknzX4PzcR5/4sfuvoS6Qg=
X-Google-Smtp-Source: ACcGV61zksxYqGUBjbxjl4Qy85JIWzpujsONj/XrFrHseu8oRjzxIDBPsukyXC0nZPDonZ98eNJOa1UV0etVW6A5k74=
X-Received: by 2002:a37:38b:: with SMTP id 133-v6mr25179315qkd.173.1539791364402;
 Wed, 17 Oct 2018 08:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <efa8d7e6a2e6407707b77d9ed0d5bfaeea62692a.1539655732.git.ren_guo@c-sky.com>
In-Reply-To: <efa8d7e6a2e6407707b77d9ed0d5bfaeea62692a.1539655732.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Oct 2018 17:49:08 +0200
Message-ID: <CAK8P3a38Q9y4fBHWA37ikzoPLNtGYNwOApQMr_=9T12pp-tH7Q@mail.gmail.com>
Subject: Re: [PATCH V9 17/21] csky: Misc headers
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 5:29 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds csky registers' definition, bitops, byteorder,
> asm-offsets codes.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
