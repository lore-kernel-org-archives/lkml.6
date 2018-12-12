Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E20BC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649E220835
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="JX1k8/Sx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649E220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbeLLXyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:54:39 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40914 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbeLLXyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:54:38 -0500
Received: by mail-oi1-f194.google.com with SMTP id t204so181591oie.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 15:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E7mdoMuLEW5kIzmk2Ogie0ESsqgQeSFFGnaWUn73X3g=;
        b=JX1k8/SxOV8BTY3/m5T31tYgCrZHhX6a03J8tdt1G+5VkrRdSkL0PNtmbjPxd7VFGx
         alzEU/BHPWk785sT65M9yCqJht00/uFb7l5+xac3/VE+tF3RGHiwrSTFN2W9E9oFPzvp
         5v76FOVbvtC/TTXWzrygTVBGsSZhWolmWVOZ3DkzF1JfzGbOFeYkhlVrfb5i9fSsikZC
         WCpGaJbJnwdv5x4pm122v1RKW8liAy2KxWWEu0FDAcCnYBsqNfQbXGHhk7NFoyfFHvqN
         Aor1h3nMXwpo3lh5SAAOe/b32Wbts7dmspyNa338KfFi3zocz08h3JT0HJ7Ro2yBcaBk
         RQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7mdoMuLEW5kIzmk2Ogie0ESsqgQeSFFGnaWUn73X3g=;
        b=BIz23fQ69VCchSQBCT1hy7lTvTdQ+MHfEGmOk7Qx0zth1yO+n5oU3Z3aYScqPEgw2h
         By50IJ3tsGY5g+srco4UUR/pq3E/ZkTZYFUmSKfBWMUtxRJ1udd0sRKAi0YGEsRJxgo3
         FhdAALsyXbJOKGriyV4afWmdjg/LJb10bisQSWSX+5eXe2uPiIkL9epoWV6NTPD9akKR
         hFjVuy5FuVvjFv0dIjJqS8W4JWpPojzgrq/przPtbW1DzDUfD0Ke5kBvsJP8bNU7DJx0
         kEjMZeSPSZNZZiORN0/GKe8Xoln15Px1X5DvlYg/TwuKYJPLr5BjJDl4s0REjjW1vmCt
         Jb/A==
X-Gm-Message-State: AA+aEWYTxaA/PlQ5pULH1lKoZGmZHPyyMnG6jh6h+px7b5a/HQ9CdwQv
        4+bMRTxAf2TQQ/TXeqJOGahH8LCzQSqZTgKcUxLQZg==
X-Google-Smtp-Source: AFSGD/XTDDdEb39yq92IsxYN8Uy1esXTJMdIzMAYjw8HX9yxp6ZONGK7jfxBZIN4RohxNX5NjqwarDnQEcSeYpK3byM=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr1551320oig.232.1544658877677;
 Wed, 12 Dec 2018 15:54:37 -0800 (PST)
MIME-Version: 1.0
References: <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com>
 <20181207191620.GD3293@redhat.com> <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
 <20181208022445.GA7024@redhat.com> <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com> <CAPcyv4go0Xzhz8rXdfscWuXDu83BO9v8WD4upDUJWb7gKzX5OQ@mail.gmail.com>
 <20181212213005.GE5037@redhat.com> <CAPcyv4gJHeFjEgna1S-2uE4KxkSUgkc=e=2E5oqfoirec84C-w@mail.gmail.com>
 <20181212215348.GF5037@redhat.com> <20181212233703.GB2947@ziepe.ca>
In-Reply-To: <20181212233703.GB2947@ziepe.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 12 Dec 2018 15:54:26 -0800
Message-ID: <CAPcyv4irkynLsEz=HRwLZacnRX6ifNRFX7ibAN_R+9yqR143bQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, tom@talpey.com,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 3:37 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Dec 12, 2018 at 04:53:49PM -0500, Jerome Glisse wrote:
> > > Almost, we need some safety around assuming that DMA is complete the
> > > page, so the notification would need to go all to way to userspace
> > > with something like a file lease notification. It would also need to
> > > be backstopped by an IOMMU in the case where the hardware does not /
> > > can not stop in-flight DMA.
> >
> > You can always reprogram the hardware right away it will redirect
> > any dma to the crappy page.
>
> That causes silent data corruption for RDMA users - we can't do that.
>
> The only way out for current hardware is to forcibly terminate the
> RDMA activity somehow (and I'm not even sure this is possible, at
> least it would be driver specific)
>
> Even the IOMMU idea probably doesn't work, I doubt all current
> hardware can handle a PCI-E error TLP properly.

My thinking here is that we would at least have the infrastructure for
userspace to opt-in to getting the callback, the threat of an IOMMU
forcibly tearing down mappings, and likely some identification for
pages that are revocable. With "long term" pins I would hope to move
any detection of incompatibility to the memory registration phase
rather than something unacceptable like injecting random truncate
failures.
