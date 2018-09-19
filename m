Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952E8ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAB0214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXFfIrbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAB0214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbeISG7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 02:59:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40701 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbeISG7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 02:59:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id s13-v6so1859168pfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 18:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lR+VCDa76RRa5mRVhtuamEUq4gmjXiDM+Ky1MlBWvps=;
        b=HXFfIrbCwmDOVeObDEhhZ1cO5casMkm8IOCA33TJfM7xLrxEUd4KB1Vjc8tbg4dAjo
         aMb7OeTu+7TsjW8wBdGVtd5wqPn2T05ugab30MqTSSD9BZSnveh2YdV4c+UTGCmulSpb
         OpkLyteqr/oSCESfcXe3WAce9UYCbvBpO+Pfl8mcZuCLQ1d8LNO63ClXbBLksubllMAi
         o7MbFb/8Fln3eSJ+pGiKM1qDCwsmTIQiYLEFRY2iWQ2h8FJH+gKIg/RcvNFTYEtrjfrZ
         gADIOKXn16zJGYm8VzgFIf+bilcAXm6zYjv28WNW5WkBMt7CIFiNbkObe87Mj7ABkido
         YoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lR+VCDa76RRa5mRVhtuamEUq4gmjXiDM+Ky1MlBWvps=;
        b=M6was9kYKK7ZIS3wGRsT2PaXXccuCOkLlDJATiFRxLfduZrFcS8pAcDScmPGwfsQMH
         cIYQON+ZqW8ikfmv+adr0l/pFWKSP3TSsK3ZmR3v9gEFfkhNxHnUlYHHuGfFGJIgZIid
         8zW3RTeFiywW3BH4WrLKxxo7O/tmjI48MojenhHZHH7sb4ErRrty5CLeQt4lXgM+ITpx
         57h05vHD9dxL4OJcv5bi4+pbmc5LscWR1AMxx+7vh3aujS6Ed+GQqaIOsHN3a4bu4hBO
         xkvweN2ECNae9Vg80zNCSBR+FQS8UXXo6f1JtA4J0Vdkn7tsxmRtvr5EZWkPhpeBKcN/
         6OtQ==
X-Gm-Message-State: APzg51ARnDnyL8A4QBMElppvbVr24m/S1mWqHuQUFpUvnw7KDTFzHuqV
        DxxQBVRlYMkH4RcQqAtOm2U=
X-Google-Smtp-Source: ANB0VdYPu09jiIk5V15H/lFiq4PPprzQIu4+Z99e34LVfCLhywZfB7fK9wJDSWdM6N/xq8KjnKoLww==
X-Received: by 2002:a63:1d22:: with SMTP id d34-v6mr30654926pgd.133.1537320259544;
        Tue, 18 Sep 2018 18:24:19 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id m25-v6sm23963425pgn.1.2018.09.18.18.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 18:24:18 -0700 (PDT)
Date:   Wed, 19 Sep 2018 11:24:15 +1000
From:   Balbir Singh <bsingharora@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        alexander.h.duyck@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/7] mm, hmm: Replace hmm_devmem_pages_create() with
 devm_memremap_pages()
Message-ID: <20180919012415.GE8537@350D>
References: <153680531988.453305.8080706591516037706.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153680535314.453305.11205770267271657025.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <153680535314.453305.11205770267271657025.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 07:22:33PM -0700, Dan Williams wrote:
> Commit e8d513483300 "memremap: change devm_memremap_pages interface to
> use struct dev_pagemap" refactored devm_memremap_pages() to allow a
> dev_pagemap instance to be supplied. Passing in a dev_pagemap interface
> simplifies the design of pgmap type drivers in that they can rely on
> container_of() to lookup any private data associated with the given
> dev_pagemap instance.
> 
> In addition to the cleanups this also gives hmm users multi-order-radix
> improvements that arrived with commit ab1b597ee0e4 "mm,
> devm_memremap_pages: use multi-order radix for ZONE_DEVICE lookups"
> 
> As part of the conversion to the devm_memremap_pages() method of
> handling the percpu_ref relative to when pages are put, the percpu_ref
> completion needs to move to hmm_devmem_ref_exit(). See commit
> 71389703839e ("mm, zone_device: Replace {get, put}_zone_device_page...")
> for details.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---

Looks like a good cleanup

Acked-by: Balbir Singh <bsingharora@gmail.com>
