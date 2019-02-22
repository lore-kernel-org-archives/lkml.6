Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AA6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B60A20823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QpQ52P97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfBVHhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:37:12 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:37957 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbfBVHhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:37:12 -0500
Received: by mail-qk1-f201.google.com with SMTP id x63so932142qka.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 23:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zMCaZGGs0VGrMBMBdtbATYBFBxB6/I2Tvcxewdqs3qI=;
        b=QpQ52P97ld/uG16cg3CpqmSWXiyG5IaMHboDbULgIfix9np1VlGX2MNOfzBAqnNqGf
         9tpPXT+FdP8ZKn7AS4/d00UqcchTszfsb59Lyq9qd1jdJb482TYPsIJ2Es1OxPgfrL/E
         oEQLh/Gj5Auxkp/UfPtbx1OoAIpJ/3PG/vKJ/d/Ufg+iKA64HpXzZBYY99svkQ4WRxJt
         Pv1loOW1C6T235seUPVocFs4c1pxZ97ozagyVZFarf1dOYmHgVtEQNs+9/ecAqCuY1aR
         ueI9Rs0eY/A+pVgMgHZwLuxkxx4oM3FcpzKu04uq90Sg/5wkmB9FxYAKdAzBnFU+UEux
         pbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zMCaZGGs0VGrMBMBdtbATYBFBxB6/I2Tvcxewdqs3qI=;
        b=Xx4eOOjZbc/w2l6P6g++sbzu/4E0YXZu7HWJ5KscZQnQ1/guKYZ2mjcGY/rkwS59bk
         D4IRXyASlxQQZkMWC55rcPQ4dQwaeks/zRXPf19DPGSf5HpjUGbyQonOm/kqa8tSdGa1
         ybLwgL1H/fnE3wPc/NtAMN7Ddn7SjByxeTyJi9fQQ/sOgJrVkpszZvB+xQVZPohXW6zg
         L7iweanyaUdxZCKAmB3m9IyWRZRCy3IQeLs8LPXI/bMhWhVPjaOIVbyhHH1YXwBRyUwh
         4EBiN6yOe7qasaVdgxLAfjt6N7tU3SU5u0YDr32KphRmoyXUgQF8DApiqgLTetNfkN9C
         Ib8w==
X-Gm-Message-State: AHQUAuZ0Wi8WKHsIEbGH+czygir0Og4748cF/jrXQZxda/hrIPmiSLCC
        y8xacTdJsIIHebQZZm1xvzo0OHHQll0=
X-Google-Smtp-Source: AHgI3IarKMOcGs4MGziDE6Elk5q9c137KN9q1hn1+GeEHIOZlKrLwvdvYyYDk91ikEQAOgKGXIxBoMkvMdk=
X-Received: by 2002:ac8:2fb7:: with SMTP id l52mr1527108qta.29.1550821031050;
 Thu, 21 Feb 2019 23:37:11 -0800 (PST)
Date:   Fri, 22 Feb 2019 07:36:58 +0000
In-Reply-To: <fe6dcb4e-03c4-0bbf-c51f-5964b20593dd@linux.intel.com>
Message-Id: <20190222073658.66798-1-xmdong@google.com>
Mime-Version: 1.0
References: <fe6dcb4e-03c4-0bbf-c51f-5964b20593dd@linux.intel.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: RE: [PATCH] iommu/vt-d: Handle hotplug devices' default identity
 mapping setting
From:   James Dong <xmdong@google.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jis Ben <jisben@google.com>, James Dong <xmdong@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolu:

Sorry that my last reply email seems not text format. Resend it now.

Thanks for your comments and your patch. Please find below our responses to
each of your comments:

> What does "I/O operation won't work" exactly mean here? Do you see any
> IOMMU fault message? Or, something doesn't work as expected?

Yes, DMAR fault messages as following came out:
[  354.939896] DMAR: DMAR:[DMA Read] Request device [03:00.1]fault addr 1fdfe80000 
[  354.939896] DMAR:[fault reason 02] Present bit in context entry is clear


> Do you mind checking this?
>
> index 6ecdcf8fc8c0..f62f30bc1339 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2632,6 +2632,9 @@ static struct dmar_domain 
> *find_or_alloc_domain(struct device *dev, int gaw)
>                          goto out;
>          }
> 
> +       if (!iommu_should_identity_map(dev, 0))
> +               return si_domain;
> +
>          /* Allocate and initialize new domain for the device */
>          domain = alloc_domain(0);
>          if (!domain)

Tried this patch, and the same DMAR fault message came out.

Guess it is because of the iommu code path for hotplug devices. If a hotplug
device is rescanned after removal, iommu_bus_notifier will be called as part
of the notifier chains to handle BUS_NOTIFY_ADD_DEVICE event. Along the code
path, intel_iommu_ops->add_device() created an iommu group for this hotplug
device, but failed to create an iommu domain because of the default domain
type IOMMU_DOMAIN_IDENTITY imposed by current IOMMU command line option got
declined by intel_iommu_ops->domain_alloc().

Since si_domain is type of "struct dmar_domain", which is platform dependent,
it is hard to make this change in intel_iommu_ops->domain_alloc().

In your patch, function find_or_alloc_domain() is not in the code path of
BUS_NOTIFY_ADD_DEVICE event notifier chain.

Please let us know if your have more concerns and suggestions.

Best Regards,
James
