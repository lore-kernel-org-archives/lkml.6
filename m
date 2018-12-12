Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2749FC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D319720851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="P0FPn9zR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D319720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeLLXhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:37:07 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43300 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbeLLXhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:37:07 -0500
Received: by mail-oi1-f194.google.com with SMTP id u18so138810oie.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 15:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dnYo8JoSoKhBGz6GtORbuxTE9r5YoZqJbV9uHhjW73o=;
        b=P0FPn9zR7u4tZacMfcri7jrKoFAh4rSyyVNpKr/5fEC0scdLF+loUUXYc9Oalox8M4
         +KByWmhGzjtmpdj5OWjJq1RFqzg9QRFkgYIsRyjrrnYy71Dt/nGX1RlHE2ufNYAq1yto
         wGM28aepS4eOqlfE3aR6fwXVAMOVAr83pw+k/+ZmoSo+Zr3lJWpcjdCWddVi6k6vSuQ0
         uBlhsrFJZLHVPO0gVe6T7HtSZ3uPeT0Crue2rj3FRLSGp755nEru7Srm751KB6M+ARQf
         mWQBhZ11bVlto/MTi6n/Unc0VkLoJgOwVIp20VbWlVsZujw+JrEbq9DeJT9EGdagJlFl
         VuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dnYo8JoSoKhBGz6GtORbuxTE9r5YoZqJbV9uHhjW73o=;
        b=KW+QQTa+U9D+7Vxt5bxuzMHCPBuISMSQorJo5hMkBDQlNZpdJr6jOL/CdxqTR1WrNa
         n7LGbfW649Mj9qE6uWMPFeh8eIT4InMwBIdWkQgonXExXbMGQeaqttcGVzP9jQVV0tN1
         c4COJnJXMuYA7tGW6Qxs6GN9A2wN61t0yQA96HBs6Q0qXFn+Yroiv8U1xtAoCa0f2DA3
         oHmHBTXh5gYTJcF30G4aPjnFtH++wWV6DRRxNu0QRMwAw5Eix/GCnJy3X9Iu2xc/BQRx
         ky4B5pzmHEuNYSvmro/nJllzE2oZ86F9LEnhgZKcJxCTErBumkZKhNY8abEbwXyaNWl7
         16pg==
X-Gm-Message-State: AA+aEWbNGGoj8t/H5Jh6lSF0LIq16tK51d0Lr6csDZ4Mw/BAMtKVRcXN
        /L7bKM1OKNYP6WpyPgKM1takZw==
X-Google-Smtp-Source: AFSGD/W54SnB33++uXU6G9N7pxdQ4/skHhFphFK1LTzwHN9ATtlzT+eXKBdiyij0FgMD4YDaKBRKQw==
X-Received: by 2002:aca:a897:: with SMTP id r145mr1661138oie.253.1544657825642;
        Wed, 12 Dec 2018 15:37:05 -0800 (PST)
Received: from ziepe.ca ([217.140.111.136])
        by smtp.gmail.com with ESMTPSA id m89sm114651otc.35.2018.12.12.15.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 15:37:04 -0800 (PST)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gXE3r-0000s2-RC; Wed, 12 Dec 2018 16:37:03 -0700
Date:   Wed, 12 Dec 2018 16:37:03 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
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
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181212233703.GB2947@ziepe.ca>
References: <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com>
 <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
 <20181208022445.GA7024@redhat.com>
 <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com>
 <CAPcyv4go0Xzhz8rXdfscWuXDu83BO9v8WD4upDUJWb7gKzX5OQ@mail.gmail.com>
 <20181212213005.GE5037@redhat.com>
 <CAPcyv4gJHeFjEgna1S-2uE4KxkSUgkc=e=2E5oqfoirec84C-w@mail.gmail.com>
 <20181212215348.GF5037@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212215348.GF5037@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 04:53:49PM -0500, Jerome Glisse wrote:
> > Almost, we need some safety around assuming that DMA is complete the
> > page, so the notification would need to go all to way to userspace
> > with something like a file lease notification. It would also need to
> > be backstopped by an IOMMU in the case where the hardware does not /
> > can not stop in-flight DMA.
> 
> You can always reprogram the hardware right away it will redirect
> any dma to the crappy page.

That causes silent data corruption for RDMA users - we can't do that.

The only way out for current hardware is to forcibly terminate the
RDMA activity somehow (and I'm not even sure this is possible, at
least it would be driver specific)

Even the IOMMU idea probably doesn't work, I doubt all current
hardware can handle a PCI-E error TLP properly. 

On some hardware it probably just protects DAX by causing data
corruption for RDMA - I fail to see how that is a win for system
stability if the user obviously wants to use DAX and RDMA together...

I think your approach with ODP only is the only one that meets your
requirements, the only other data-integrity-preserving approach is to
block/fail ftruncate/etc.

> From my point of view driver should listen to ftruncate before the
> mmu notifier kicks in and send event to userspace and maybe wait
> and block ftruncate (or move it to a worker thread).

We can do this, but we can't guarantee forward progress in userspace
and the best way we have to cancel that is portable to all RDMA
hardware is to kill the process(es)..

So if that is acceptable then we could use user notifiers and allow
non-ODP users...

Jason
