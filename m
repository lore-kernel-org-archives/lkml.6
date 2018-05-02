Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1359032-1525294607-2-13659078949377953320
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525294606; b=Mq8sG2tRynLpHC0rODDafhyZRTJFPR2BWyVWHu6KR+ON55LgOA
    xAEoYuywFFsUeQNKjlk7gjR+dNIOwIMWJeCRzdC9FboR4rmiowDyP+N3oyYU8cWW
    xdzhuQ6vgtBTI4IAzzFa0MRx90kEZAFkieUez+JJIapsGUjeiujqHF/WK8xPffpV
    lBgN3nsHFPcx/5Kfgz1zNNx+XOk7SZNd70LIBTDOjBztoEHtvJ8JRxXVo9TrKRXX
    F71Ruic5T2eSbdMy0CFJO4YTODcZI4LrqY4HN/s9uLUYG9kIgkayI+OA3Mtv3ecm
    TkPTMe7DMBd7wIRi5Ty1kWdHiE2Xk+05ZO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:references:date
    :in-reply-to:message-id:mime-version:content-type:sender
    :list-id; s=fm2; t=1525294606; bh=Yk+wJ/9RjLk1QQvxLuCpPyCmxjY3q5
    r4CNXWpI356A0=; b=dDvFm6APrErXBjz7cd9g0gIFE7CW7S8+2/gO8AM/1Ppuq3
    GIw4QAL856tA/KD5DWYcz7j9yimv1DzVuNEyqFjG68WBLUc+yo80LTVCjCErmwgu
    IU7iWclPGe8EPfaLCEJL6tk+vBgyYjf5RrNHa5n42uiuQ2GRsgMrGkbLqWdIbUtT
    huiyC7UpNZ2zFcn/dd8/KOc09g+gYXLj8PUJzpKs2GscaV4iDcJ3z+ZrmGnL4CBQ
    w1zCobNsR+VKwAx4haiZ7t+6Lu1HKfkV6derZCncPm1ncOIVPCCF/8yiv8gTQ2Hy
    q9rmMFhpscuCNHzxeTUfQCkY5d++YP8yY/DtmRLA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOENdI3WxuMx2Vk7/I0FJnTrw8Y8jpdjYwX8AalAKRsafkvVFgizcMPk09fkClOMgdyAEYtZYF51v4qxB1okfvaCodmbKMsndjwjZmPp8RunO2icff87
    zma7pK2cbe06JMDB/20oBbdzCdIpeSZd9MkksBiKuJzgZLYqgSqD2upZCiyPQ1fmKy28enY1JAQx9ihqrd9RALns5RwK0ucv+1vRGG/AaveTSciG8Poi4Nu5
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=MvuuwTCpAAAA:8
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=i3X5FwGiAAAA:8
    a=FRkhqeDs70ChltBhwFAA:9 a=dVHiktpip_riXrfdqayU:22 a=AjGcO6oz07-iQ99wixmX:22
    a=mmqRlSCDY2ywfjPLJ4af:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751181AbeEBU4n (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 16:56:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751148AbeEBU4m (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 2 May 2018 16:56:42 -0400
From: Jeff Moyer <jmoyer@redhat.com>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: dan.j.williams@intel.com, stable@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH] pmem: fix badblocks population for raw mode
References: <20180425161125.8082-1-toshi.kani@hpe.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Date: Wed, 02 May 2018 16:56:41 -0400
In-Reply-To: <20180425161125.8082-1-toshi.kani@hpe.com> (Toshi Kani's message
        of "Wed, 25 Apr 2018 10:11:25 -0600")
Message-ID: <x49o9hx7p4m.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Toshi Kani <toshi.kani@hpe.com> writes:

> pmem_attach_disk() calls nvdimm_badblocks_populate() with resource
> range uninitialized in the case of raw mode.  This leads the pmem
> driver to hit MCE despite of ARS reporting the range bad.
>
> Initialize 'bb_res' for raw mode.
>
> Fixes: e8d513483300 ("memremap: change devm_memremap_pages interface to use struct dev_pagemap")
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

> ---
>  drivers/nvdimm/pmem.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 9d714926ecf5..2d7875209bce 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -367,9 +367,11 @@ static int pmem_attach_disk(struct device *dev,
>  		addr = devm_memremap_pages(dev, &pmem->pgmap);
>  		pmem->pfn_flags |= PFN_MAP;
>  		memcpy(&bb_res, &pmem->pgmap.res, sizeof(bb_res));
> -	} else
> +	} else {
>  		addr = devm_memremap(dev, pmem->phys_addr,
>  				pmem->size, ARCH_MEMREMAP_PMEM);
> +		memcpy(&bb_res, res, sizeof(bb_res));
> +	}
>  
>  	/*
>  	 * At release time the queue must be frozen before
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
