Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FB9C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D7B20C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQr2FEpn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D7B20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeGLC4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:56:07 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38046 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeGLC4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:56:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so4354185wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 19:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Gp7tHqAGCWAmABqzcrpCR3qiHm0sVZEwlUoIMOPzZ8A=;
        b=KQr2FEpne5CAuFA3j56hHgrxU8RoUgqV7haEpF0z2jMXjvBL+hawjR65iwz+ZyCzmv
         Pl550l8qcJG+66XV6+J2agCgglbdABO3vPQf+zRwaBK55y8D+5CQww7MkUCqBLiJpVjj
         YWjNayGtfACiBWXEpHIlelgLGI17qKexbZPB2QNXqYB8ljlobgif8xiMWAB0DN5eJcEd
         3w5hj8+5sXOtSGKMzpo4AbIffayzT1P2giyIf+nl5cg47rgWg9VRwc4K2yG2U3Ib/qpZ
         k5O62ZHX3J3Yh7PlxEmo1TJ9pJof5AqFrLJ6DrhlE3O3RYjFh7U9AugpA55hYg/Wq9wa
         5vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Gp7tHqAGCWAmABqzcrpCR3qiHm0sVZEwlUoIMOPzZ8A=;
        b=DskaohDGR6X0C1J3Bawvd3vJqXIEpC617wu9TdpXOg+VLnmiWhSk2/ISnUL0NiezRb
         Lt+CTY7IQ9Aco9lNEXKI4r5Kqwbr5lx/q55Z9XbOHOKXTrK1oZK0A25Yqb7Zl4Gd8LJi
         lC+8/lJksp25N6/CugecJ4HoXwYHs97eRbqRQ2iZ19ZfUCb1Xf9se0EQdut6XDOTLTxJ
         DQGRA/9RRqlIN+LB5EToIxYQyjub/Wl0Pk3oSK4Q1AfuPw1jUSw00FdYfD/BhgzVyjH8
         v3le4ETvEOxCZfnLn5+QJUDPZk1ed7xgAd9CzR7tSCxzLtWeYfH0zws3S8mkSgoPOBpB
         iFqw==
X-Gm-Message-State: AOUpUlEClvcqeT4C+vBKaVl2eu2Y4FbuJ8QZcTDL0L3OENbUMOhcrO+Y
        R/aoK5q8BHcO0XXaRktKpHx6bG8pWKluXapAHKo=
X-Google-Smtp-Source: AAOMgpdAKz9xhT5qfnQRtk2mhkGht6KQaWzYJfjjv8kt1QAaT2VjQ1SsRLKeBGfSAKMslghGUaMmAn2g++Q7RAACo3c=
X-Received: by 2002:a1c:6f44:: with SMTP id k65-v6mr92769wmc.19.1531363728324;
 Wed, 11 Jul 2018 19:48:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:61c1:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 19:48:47
 -0700 (PDT)
In-Reply-To: <20180711085407.GB20050@dhcp22.suse.cz>
References: <CGME20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29@eucas1p2.samsung.com>
 <20180709121956.20200-1-m.szyprowski@samsung.com> <20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29~-sqTPJKij2939229392eucas1p2j@eucas1p2.samsung.com>
 <CAAmzW4PPNYhUj_MeZox+ddq8MjXqnJs_AJ3xkayf710udD1pSg@mail.gmail.com>
 <20180710095056.GE14284@dhcp22.suse.cz> <CAAmzW4P1m_T77DfQzDD6ysGaOF46++-0gwRaOajmo6ef=VYp=A@mail.gmail.com>
 <20180711085407.GB20050@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Thu, 12 Jul 2018 11:48:47 +0900
Message-ID: <CAAmzW4M3KADCZD9+B2h7=WsYksGtg-GzYRCJjbqK5Scceynrrg@mail.gmail.com>
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

2018-07-11 17:54 GMT+09:00 Michal Hocko <mhocko@kernel.org>:
> On Wed 11-07-18 16:35:28, Joonsoo Kim wrote:
>> 2018-07-10 18:50 GMT+09:00 Michal Hocko <mhocko@kernel.org>:
>> > On Tue 10-07-18 16:19:32, Joonsoo Kim wrote:
>> >> Hello, Marek.
>> >>
>> >> 2018-07-09 21:19 GMT+09:00 Marek Szyprowski <m.szyprowski@samsung.com>:
>> >> > cma_alloc() function doesn't really support gfp flags other than
>> >> > __GFP_NOWARN, so convert gfp_mask parameter to boolean no_warn parameter.
>> >>
>> >> Although gfp_mask isn't used in cma_alloc() except no_warn, it can be used
>> >> in alloc_contig_range(). For example, if passed gfp mask has no __GFP_FS,
>> >> compaction(isolation) would work differently. Do you have considered
>> >> such a case?
>> >
>> > Does any of cma_alloc users actually care about GFP_NO{FS,IO}?
>>
>> I don't know. My guess is that cma_alloc() is used for DMA allocation so
>> block device would use it, too. If fs/block subsystem initiates the
>> request for the device,
>> it would be possible that cma_alloc() is called with such a flag.
>> Again, I don't know
>> much about those subsystem so I would be wrong.
>
> The patch converts existing users and none of them really tries to use
> anything other than GFP_KERNEL [|__GFP_NOWARN] so this doesn't seem to
> be the case. Should there be a new user requiring more restricted
> gfp_mask we should carefuly re-evaluate and think how to support it.

One of existing user is general DMA layer and it takes gfp flags that is
provided by user. I don't check all the DMA allocation sites but how do
you convince that none of them try to use anything other
than GFP_KERNEL [|__GFP_NOWARN]?

Thanks.
