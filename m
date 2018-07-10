Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EB8C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEC120878
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXgqJAVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAEC120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751328AbeGJHTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 03:19:36 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33878 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbeGJHTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 03:19:34 -0400
Received: by mail-wm0-f48.google.com with SMTP id s13-v6so11828114wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 00:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Z2tYrbsLnuBADeDHMudGs5/rH24qfZ58NepYhlwmRiU=;
        b=pXgqJAVM41BYbIhjnqi6JV20t62AYiM4Lr6ZSx8rR769mpO/xHjAr8S8SnVj1fB5Wx
         eeacUBpbIbZVlWpa2Vj6J9/nEQE9U5l6KasQXZ9Fy4+GI1B5TQRXaGkpdgX4B+KAmt+V
         QkoIXL00NLUQikP3lscnT/0GAP8nUuH0zdDdAfdZEmBHxSTCKAjfMTAIY8iXszPhuQtB
         MuHwWamnY06M9FxpcqCTnp6Cti+3RSNpu0ohPigTNz0LQDs9eMKPNtOS4p9WA3hs2PuD
         gZvj49pXacpe/iXeq6K/aBzgdvwrCgRv5wF9XVUid3O0n5YvuvniZT85IlX0M0OJI0f8
         reeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Z2tYrbsLnuBADeDHMudGs5/rH24qfZ58NepYhlwmRiU=;
        b=BTzHP4bK/d5+X7gsc3WQh/rL3+n18eric48mXrNaRbwgV0gAcRGAKzcsit0U5fNwy8
         7vOv+GhOk2N18vfv2/2wfeO+/tYUF6Rth4trgq9cgay2dzPFqalLsuiXP2ElcJQWngje
         Owk5sTpXxRwKVK5MphjI0VqBSYpI2A5ERG1QVDmEQwQP0dol8QuwlkTxd54DQLe4XBWp
         iPbIyhHbZoKDn7WSEt8Ecy40hN8xC6mfsCLARWAqtK0v5hbwDuz81BLnBcS6tDRjbuxO
         LPYBf9nT09ycimYWcW5/tm2hVb7QZcvmwhKfNzf1LP3mY+BJuC1zZei64ACIFkVMOum2
         03rg==
X-Gm-Message-State: APt69E18oQ2YlcsF9J5jpy9T5oa4sp0UHMv5Y7V0rcUzew9k9jeX0qz1
        FjdiTRXJgSPc6T4uBnfrHLh+p6NqWud9nj5fhOQ=
X-Google-Smtp-Source: AAOMgpfDBEx8T4vf0Wdjj48u2KviHPUSGKOzfhFE+7P9DhnD3Dd76UTJhx4K3OARLnJHjGnFWiivoRSmGVb8KaZcw4o=
X-Received: by 2002:a1c:8a04:: with SMTP id m4-v6mr13551984wmd.137.1531207173578;
 Tue, 10 Jul 2018 00:19:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:61c1:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 00:19:32
 -0700 (PDT)
In-Reply-To: <20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29~-sqTPJKij2939229392eucas1p2j@eucas1p2.samsung.com>
References: <CGME20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29@eucas1p2.samsung.com>
 <20180709121956.20200-1-m.szyprowski@samsung.com> <20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29~-sqTPJKij2939229392eucas1p2j@eucas1p2.samsung.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Tue, 10 Jul 2018 16:19:32 +0900
Message-ID: <CAAmzW4PPNYhUj_MeZox+ddq8MjXqnJs_AJ3xkayf710udD1pSg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/cma: remove unsupported gfp_mask parameter from cma_alloc()
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        iommu@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Zankel <chris@zankel.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Marek.

2018-07-09 21:19 GMT+09:00 Marek Szyprowski <m.szyprowski@samsung.com>:
> cma_alloc() function doesn't really support gfp flags other than
> __GFP_NOWARN, so convert gfp_mask parameter to boolean no_warn parameter.

Although gfp_mask isn't used in cma_alloc() except no_warn, it can be used
in alloc_contig_range(). For example, if passed gfp mask has no __GFP_FS,
compaction(isolation) would work differently. Do you have considered
such a case?

Thanks.
