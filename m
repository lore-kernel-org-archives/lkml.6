Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21AAC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D7920661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="gtjxwFcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D7920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbeLCTrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:47:53 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45506 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeLCTrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:47:52 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so12785410ota.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 11:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WvsfG1Hf59BZmWS8TB3JDmf5aMyusWt2oHRpSFGjJ3E=;
        b=gtjxwFcUFT6V0ldNYyuoz4aNiqOB/417idYjiuI3pfKHWn0ZmVO/azEaeCjlwCNtAG
         paX7HVndWLmoTcnAoidViBq2ih79Tm/F8UAC3ux2rowNcMC47KsHfEPI2i5y1biqa9hK
         g9OZ0WERJYEey5mtntPA4I8yTTBbPU7CWBSwoMmo4ndJ3MeKv5IJNrAkA7V6W2JY+yf1
         CU3qCdXBDKoNJ2RFapZTO1JqSDqfmH243E/imN4chyZW8sV2gXnbNXA/xHrW+qbiD7Pr
         MzGo9xeQAUuZgFpvuy9csZtBctgQ+wvKP9vgBfbfBN0sjWZxlurvv9/OS6kBlGFfpcLS
         SnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WvsfG1Hf59BZmWS8TB3JDmf5aMyusWt2oHRpSFGjJ3E=;
        b=L7v4U6W7hlmmUVB1H2v73O7h9KbxSTt83HCGBTKV2AlzA1p0lYoBV/fN8o+ukKPQLV
         qjjbxffAl3eDXmhVAzGvZsCP61kxN4t/ThmdiI8nGp2vEoEXG3Ex8245iRsvOMjRmLPV
         AklIsFA+SpmVPUc6e9b+fhH7OoXXtZEolFVrNO6xKawSsINPDWYAfz+uLld464b1ID8R
         a/R8kUYnUnPkQ1+VbaEZthLQHpmkqr9USG/eaJzMHMKUxy+fUBePOsNfENt9ZULX1ZSp
         x9TgV1aYtGE1TJr9U+y8MRMcPA+h0+uDsIZfc36pSYfGWH4mSVTqZw0ZwBtCR3nZd/1M
         8YXw==
X-Gm-Message-State: AA+aEWag8ErKCK8U6G8Kp+OuLhSg2+zwfdPMwwsimKQLMXpGtGdA4f5d
        qJ64MJ3iiQ0l1v01ZWDwEPVNcU4hZtBrYQwGBmLm0A==
X-Google-Smtp-Source: AFSGD/WkxJdIhvjdEevLZrw1aKfXTf3SVSuxWmOiDPL+i14uR4vFlT9pxQmGqDv6igVzRvqIh64euiVHP/OIkzKd3TU=
X-Received: by 2002:a9d:7dd5:: with SMTP id k21mr11471267otn.214.1543866469698;
 Mon, 03 Dec 2018 11:47:49 -0800 (PST)
MIME-Version: 1.0
References: <154386493754.27193.1300965403157243427.stgit@ahduyck-desk1.amr.corp.intel.com>
 <154386513120.27193.7977541941078967487.stgit@ahduyck-desk1.amr.corp.intel.com>
In-Reply-To: <154386513120.27193.7977541941078967487.stgit@ahduyck-desk1.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 3 Dec 2018 11:47:37 -0800
Message-ID: <CAPcyv4gZkx9zRsKkVhrmPG7SyjPEycp0neFnECmSADZNLuDOpQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] mm: Add support for exposing if dev_pagemap
 supports refcount pinning
To:     alexander.h.duyck@linux.intel.com
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Barret Rhoden <brho@google.com>,
        KVM list <kvm@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Dave Jiang <dave.jiang@intel.com>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>, rkrcmar@redhat.com,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 11:25 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> Add a means of exposing if a pagemap supports refcount pinning. I am doing
> this to expose if a given pagemap has backing struct pages that will allow
> for the reference count of the page to be incremented to lock the page
> into place.
>
> The KVM code already has several spots where it was trying to use a
> pfn_valid check combined with a PageReserved check to determien if it could
> take a reference on the page. I am adding this check so in the case of the
> page having the reserved flag checked we can check the pagemap for the page
> to determine if we might fall into the special DAX case.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  drivers/nvdimm/pfn_devs.c |    2 ++
>  include/linux/memremap.h  |    5 ++++-
>  include/linux/mm.h        |   11 +++++++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> index 6f22272e8d80..7a4a85bcf7f4 100644
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@ -640,6 +640,8 @@ static int __nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap)
>         } else
>                 return -ENXIO;
>
> +       pgmap->support_refcount_pinning = true;
> +

There should be no dev_pagemap instance instance where this isn't
true, so I'm missing why this is needed?
