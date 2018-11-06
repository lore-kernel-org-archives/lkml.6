Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB254C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FEB22086C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5gdAdiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FEB22086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbeKGJOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:14:24 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42206 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbeKGJOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:14:24 -0500
Received: by mail-pl1-f196.google.com with SMTP id t6-v6so6966378plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 15:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q+CEES5h0JL0Tuv/sb8uQK8wxR455Qy9YIh0JD58t9A=;
        b=f5gdAdiW7Z7128rh1bo9mCtdQ3PH4OeWhl+9HCktQkTLMAOtGVSKHAqL34wFqPku2b
         GYViIb5ZFtf+DXjlSE5ehH9X0f5pF/kax11LQlnxUIaBLwuHYcunJvWfJjoOr0DpQup3
         z7ashTpL+l3KCxh1iYbix20tKTp5Gvjv5uFSeQxLs/hzfVvxF68W6NVju9k372p4wdcl
         yaV4xrGWP878LQHhy0/ZANTtV1Jv0rYD2P1KMeELcbip9EMBrXrJVCVs77bNWswii/Ud
         9xZeVmEiNnSGF5QU7Wxv/tyJR1F/CjzLxbXvBp8mx7RznKRXHUowJoBG00HP3Wje1Ozd
         lDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q+CEES5h0JL0Tuv/sb8uQK8wxR455Qy9YIh0JD58t9A=;
        b=IwgRow5On3uBKKzyz8yc3O6T/3h/laguiwqkgp1cY+MYTHWDfB77vc1PySu2FYvuKc
         VM+PArqBxREZLN564uUuWKAUB5+/qTW9hdojY6xuAXtHoN89Bvs0Zd8cl8dbbAMUVEy0
         /dCmIDg1c2wpvCou9gOANvOY9PVR3zcKfhRos1f0CeI58879kvx/nnJ5CzWT3Ps7ZaY4
         YO93Qsd1AN0CYI6HmmVWs9faqNYSFFfaEMyclkcmspBT6CyzFfkFic1jfvkCbwk7iBw9
         J2tidF7Jk9SzyjxFb248MEdKm+AxaaAxdht7zxS1wDNl+bxONFylKHg6qlpeyd9xgmUn
         8FiA==
X-Gm-Message-State: AGRZ1gKCe2w9IraXzOm2cDlMmUZF57EQMgXK3xED0L+qcnT6Z1+6OMvG
        ue/GXZfpQQ8kTNzNqfDgqJ+tXBTC
X-Google-Smtp-Source: AJdET5eFET5FIYZFquIfEJAPsiXBtSNO/GX2Gr/CVEmoLxR+FHrxyRt/umu7yhnoenJ2bHfwZBf1cQ==
X-Received: by 2002:a17:902:654a:: with SMTP id d10-v6mr27217536pln.302.1541547999399;
        Tue, 06 Nov 2018 15:46:39 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id i2-v6sm45830648pgq.35.2018.11.06.15.46.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 15:46:38 -0800 (PST)
Date:   Tue, 6 Nov 2018 15:46:35 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Zero pages manually in a length of scatterlist
Message-ID: <20181106234633.GA11429@Asurada-Nvidia.nvidia.com>
References: <20181101213500.21800-1-nicoleotsuka@gmail.com>
 <20181104155001.GA25794@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181104155001.GA25794@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Sun, Nov 04, 2018 at 07:50:01AM -0800, Christoph Hellwig wrote:
> On Thu, Nov 01, 2018 at 02:35:00PM -0700, Nicolin Chen wrote:
> > The __GFP_ZERO will be passed down to the generic page allocation
> > routine which zeros everything page by page. This is safe to be a
> > generic way but not efficient for iommu allocation that organizes
> > contiguous pages using scatterlist.
> > 
> > So this changes drops __GFP_ZERO from the flag, and adds a manual
> > memset after page/sg allocations, using the length of scatterlist.
> > 
> > My test result of a 2.5MB size allocation shows iommu_dma_alloc()
> > takes 46% less time, reduced from averagely 925 usec to 500 usec.
> 
> And in what case does dma_alloc_* performance even matter?

Honestly, this was amplified by running a local iommu benchmark
test. Practically dma_alloc/free() should not be that stressful,
but we cannot say the performance doesn't matter at all, right?
Though many device drivers pre-allocte memory for DMA usage, it
could matter where a driver dynamically allocates and releases.

And actually I have a related question for you: I saw that the
dma_direct_alloc() cancels the __GFP_ZERO flag and does manual
memset() after allocation. Might that be possibly related to a
performance concern? Though I don't see any performance keyword
for that part of code, especially seems that memset() was there
from the beginning.

Thanks
Nicolin
