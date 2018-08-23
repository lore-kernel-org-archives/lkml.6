Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B94FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B342086D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXy8RTsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B342086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732745AbeHWMPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:15:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40865 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbeHWMPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:15:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id z25-v6so2238712pgu.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 01:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8GXxtPdBNmvqGpTBgHHAglhjJ/igVIOM0Ya9cZjoLnw=;
        b=NXy8RTsGvlTCM11EZ4R2JPSVjSwVnrFxBsCXyXfA1kL1NbfEgzb8oXW83EMtZFkUZr
         +MmHe6/FbUCdIZ22dZGYMB6hTBrVc6SzXTy1a8xWWkwGEJaUh/qrxqWmGB5xX2Uq389f
         5xiuL0DaidsHmfU9z1GMA6NXyA5Jj+82fq2OYtlV2pKmWnTv99chWf0XiOtWwm9QX/IP
         has10nfLX+Mjv/OKmaYCN/stVHVZzC2+V4zxGYCDVTk+0fmXe8qHdIvATBDrwrwOFhVG
         sqDZ6CvER/BnsSyHtXy8AuikXY/ViWPc8ebjIIPu+9ZZJvAI6/9RGxEQi3dpRRXUVpMu
         hbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8GXxtPdBNmvqGpTBgHHAglhjJ/igVIOM0Ya9cZjoLnw=;
        b=Mq3aKapTgz95tYipxaXA7tU6L1m1GADNMtOmfulG0crbejHr3CM9KgmaXCBSmGlbq1
         Qaqy30Osq9NyJzlw5LqmgHOUPAAEgyHH1AGX1wgjEugxb6ncOLtE4lBC3C/I5tv1GSyJ
         3pfN864ikWBFUXRRdjKKBeiJLOCKKSsotrj/nTpsHk+7/LULad6eDpZCcww2vvKcwunt
         OqR8uk2ElREFNfJo0YAu4WONYwZv5eaFhGR9SjEAHdF7xgLjxXz5qjBh+yNdfauQJH+T
         bueQ0ne2d9y2yY5N9eAVoaS6fNs6sKXbNMytXQj5E01wZDSF7uQpfe7pF8j4G0tPG19R
         gW6g==
X-Gm-Message-State: AOUpUlGecyXBJwdHk+M8rT2tm8Sy2gUe2lKs5rnvDJOz5/SRSd42QoED
        25CIg7yLyHNqmHPjLffebVU=
X-Google-Smtp-Source: AA+uWPwObwXtEOebV995uz4KK9DnLHIQ9cgRpQqeK+GmqmS/vo71fePa8GMNBAX2rY22jeE08qJcEg==
X-Received: by 2002:a63:be4a:: with SMTP id g10-v6mr52140410pgo.378.1535014017442;
        Thu, 23 Aug 2018 01:46:57 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id x10-v6sm5197706pge.23.2018.08.23.01.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 01:46:56 -0700 (PDT)
Date:   Thu, 23 Aug 2018 18:46:48 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, luto@kernel.org, x86@kernel.org,
        bp@alien8.de, will.deacon@arm.com, riel@surriel.com,
        jannh@google.com, ascannell@google.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for
 RCU_TABLE_FREE
Message-ID: <20180823184648.0439a473@roar.ozlabs.ibm.com>
In-Reply-To: <20180822154046.823850812@infradead.org>
References: <20180822153012.173508681@infradead.org>
        <20180822154046.823850812@infradead.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2018 17:30:15 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Jann reported that x86 was missing required TLB invalidates when he
> hit the !*batch slow path in tlb_remove_table().
> 
> This is indeed the case; RCU_TABLE_FREE does not provide TLB (cache)
> invalidates, the PowerPC-hash where this code originated and the
> Sparc-hash where this was subsequently used did not need that. ARM
> which later used this put an explicit TLB invalidate in their
> __p*_free_tlb() functions, and PowerPC-radix followed that example.

So this is interesting, I _think_ a145abf12c did fix this bug for
powerpc, but then it seem to have been re-broken by a46cc7a90f
because that one defers the flush back to tlb_flush time. There
was quite a lot of churn getting the radix MMU off the ground at
that point though so I'm not 100% sure.

But AFAIKS powerpc today has this same breakage, and this patch
should fix it.

I have a couple of patches that touch the same code I'll send, you
might have some opinions on them.

Thanks,
Nick

