Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3591C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7A620B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEilD6dy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7A620B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbeGKHiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:38:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36450 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbeGKHiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:38:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so17048956wro.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6U0pn6AhRTwBzPrYrAqCi9EEGjHJd9DpcVhBe07Rf6M=;
        b=jEilD6dyHTjKhHnFpoQdkQKe0pZ15nbSFQZRAs18W6WZLufKolByMCmIT+vhy1jq5G
         euOBQvzEgzh3nUf+xIX4/OsFKP6jXLYA/ekC5nwLaMQtJRQiKJF2KrdGuwUfUCxDmAg/
         GO0xMq4Q95zzGm6lwTgyz+fhu0XN5dQpv0CjwtrdHsNOF2eZXPF4A6QRoFEz4d4eoP3k
         ittCoMw9lb3lflmL3uUO2DDpyQmWe4c44NqAi0y4Z5Mgxxf/b3fpaPBtsM/ZmLOuJbCh
         kv/9N4IOnfN70mrI5/xwys1Gk1U+SQIOXlI5Wpcla5VtJpTdTnH3nS9MX3iP2br2uCLi
         62Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6U0pn6AhRTwBzPrYrAqCi9EEGjHJd9DpcVhBe07Rf6M=;
        b=UHGKfYrZrb3ff+KiyRzLUXMeoHdigqGfpIv7CDvcNfs4LIP56JJsFtqFE19wyOE5Aa
         JDafKr9KGZ1JtwwxZVZGEDL6OQAtb4HAQFA1+dwpKPoFB/4HCHWZ7mfPu3UGKBlc0mt7
         S+xCQMPobYE9Z3pmAkDMyB+3QfiFES5w8kN+2Kv1gxKspwWj2oPbpVKGbo759h+Wz4ak
         eXPKGdW9lPS4JzwCSpbrWEWw56rERImiUOdYMya5pigdF96OF0fwflyDggAikW5a9+XK
         5qXESmRNDGjE8uyvMwsIYgCRkIDgRP/+QFXoTT/8s3O03Fq4rBlU2txTDYGdHVsKJbfa
         MkkA==
X-Gm-Message-State: APt69E1BUf/Dr96hFze0SCQ51fKygdtajCiY1gl+AU2uWpdxBdKLubxk
        eoU7CoSGjxDLFaTqHYO6ZUULLaNAuBSdB2NeLdg=
X-Google-Smtp-Source: AAOMgpd+CDPYvmJ4ZVSIRloWQ9fvgP+k2mHapVPYAxNAjRBJ8GQ3pd05X8VOdp4n7vtgUqRvExbtFJoYPyf3q6bawnI=
X-Received: by 2002:a5d:4c4c:: with SMTP id n12-v6mr19189950wrt.71.1531294529013;
 Wed, 11 Jul 2018 00:35:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:61c1:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 00:35:28
 -0700 (PDT)
In-Reply-To: <20180710095056.GE14284@dhcp22.suse.cz>
References: <CGME20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29@eucas1p2.samsung.com>
 <20180709121956.20200-1-m.szyprowski@samsung.com> <20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29~-sqTPJKij2939229392eucas1p2j@eucas1p2.samsung.com>
 <CAAmzW4PPNYhUj_MeZox+ddq8MjXqnJs_AJ3xkayf710udD1pSg@mail.gmail.com> <20180710095056.GE14284@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 11 Jul 2018 16:35:28 +0900
Message-ID: <CAAmzW4P1m_T77DfQzDD6ysGaOF46++-0gwRaOajmo6ef=VYp=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/cma: remove unsupported gfp_mask parameter from cma_alloc()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        iommu@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
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

2018-07-10 18:50 GMT+09:00 Michal Hocko <mhocko@kernel.org>:
> On Tue 10-07-18 16:19:32, Joonsoo Kim wrote:
>> Hello, Marek.
>>
>> 2018-07-09 21:19 GMT+09:00 Marek Szyprowski <m.szyprowski@samsung.com>:
>> > cma_alloc() function doesn't really support gfp flags other than
>> > __GFP_NOWARN, so convert gfp_mask parameter to boolean no_warn parameter.
>>
>> Although gfp_mask isn't used in cma_alloc() except no_warn, it can be used
>> in alloc_contig_range(). For example, if passed gfp mask has no __GFP_FS,
>> compaction(isolation) would work differently. Do you have considered
>> such a case?
>
> Does any of cma_alloc users actually care about GFP_NO{FS,IO}?

I don't know. My guess is that cma_alloc() is used for DMA allocation so
block device would use it, too. If fs/block subsystem initiates the
request for the device,
it would be possible that cma_alloc() is called with such a flag.
Again, I don't know
much about those subsystem so I would be wrong.

Thanks.
