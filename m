Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A812AC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFF6208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqYhKdzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFF6208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbeLFKEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:04:08 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42588 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFKEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:04:07 -0500
Received: by mail-ed1-f68.google.com with SMTP id j6so243245edp.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 02:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FmslBRqsYlWJhsiCvsBQOFzYvBn8zFzaCsASqLn/a8E=;
        b=cqYhKdzFEGjeyougx7dV6pe0LBdjFNb5glrs21mqBRVUaCra7fp9Y8muFrEB8vmvSU
         wBDeHDQcEvny1SmHaM9ZODEb5CvAONC3OtoU3FRyg70zMdYB3Fs4j7VqAA+cBumgAni0
         mIASSqvIoUEPxzHtyMcF9hd88yau9XEUAMept0jZsJ1Z1N1ilg1XrdhpCxew6s0E6+xm
         mJTficlLkhgEER8d7YgnZiaIZ5KQMywm1Z4toPVhv6v4rKE5aJyXYGEHvIm4Qg7v+ijJ
         j6lqytpKkyhpiWRuUeOZP8lnu7kOsyhmCIU6F/I/l7r+CnUutXTZYrKFaznJcToWMMly
         QvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FmslBRqsYlWJhsiCvsBQOFzYvBn8zFzaCsASqLn/a8E=;
        b=fWuxPrSjQNXGYEB05UZxXdv1TA1KpSRGG5Qp1W508gNJ6COq5mhqW/iP7cVdgdwpJ6
         62cu0ltK6hB/RKgdDEku6GguVFtdjT7qbls/L7OWCvILeCRiNIJpZKFsffFH5S4v2B2d
         iA8QWzcQt0Z/iYxFc1bMU92K/knKXqrzOykyKqZIQzL7HCYEUzj7kEsZs02MTh5e5O5q
         fRBMRaZVFCEzpcUkvmD9GIiG2BIUNBwBEo5Nkzllw4qaQGUEyHN3lurgaFJKbFcRROli
         RGDBwi7TaEyRHU2Joyz0V61/4JoHLnw/ZLRN5JrQ6SREaR435bi8ZLV6Niqiz/ovWHqZ
         7H2g==
X-Gm-Message-State: AA+aEWZIzvuK3QMNa+pf7959zmMkNfHX2OMQI3qDRoK8UT2ZVAPZNanP
        llAQ8Ls6gob906R1G/RkgVCuy3cqERK/70vauw==
X-Google-Smtp-Source: AFSGD/WggysC5RxlxhYnHxtZNhLuCakJXkxDRtqYHEx+W9Fm+bmBD8PW7sXqjJT0B0YFnOo0rizE7N/snpxZ3Q0oSEQ=
X-Received: by 2002:a17:906:d054:: with SMTP id bo20-v6mr1368741ejb.239.1544090645721;
 Thu, 06 Dec 2018 02:04:05 -0800 (PST)
MIME-Version: 1.0
References: <1543892757-4323-1-git-send-email-kernelfans@gmail.com>
 <20181204072251.GT31738@dhcp22.suse.cz> <CAFgQCTv56drDBx-sTr6KdeQNKJnojG3g_a-k8wKe_q2y9w9NtA@mail.gmail.com>
 <20181204085601.GC1286@dhcp22.suse.cz> <CAFgQCTuyKBZdwWG=fOECE6J8DbZJsErJOyXTrLT0Kog3ec7vhw@mail.gmail.com>
 <20181205092148.GA1286@dhcp22.suse.cz> <CAFgQCTtj4m637tAzConCfeWQXSrWeNY-DLD5=f9-ZSmJMRe31Q@mail.gmail.com>
 <186b1804-3b1e-340e-f73b-f3c7e69649f5@suse.cz> <CAFgQCTv5-jeqwRVkJuDHvv0vq6uCzfdV2ZmVAU3eUzn2w2ReEQ@mail.gmail.com>
 <20181206082806.GB1286@dhcp22.suse.cz>
In-Reply-To: <20181206082806.GB1286@dhcp22.suse.cz>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 6 Dec 2018 18:03:53 +0800
Message-ID: <CAFgQCTsMdQSRFruZRGBuo30TjfiQ=sbrf9kUJAGgwN6uw+LsBw@mail.gmail.com>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node offline
To:     mhocko@kernel.org
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> THanks for pointing this out. It made my life easier. So It think the
> bug is that we call init_memory_less_node from this path. I suspect
> numa_register_memblks is the right place to do this. So I admit I
> am not 100% sure but could you give this a try please?
>
Sure.

> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 1308f5408bf7..4575ae4d5449 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -527,6 +527,19 @@ static void __init numa_clear_kernel_node_hotplug(void)
>         }
>  }
>
> +static void __init init_memory_less_node(int nid)
> +{
> +       unsigned long zones_size[MAX_NR_ZONES] = {0};
> +       unsigned long zholes_size[MAX_NR_ZONES] = {0};
> +
> +       free_area_init_node(nid, zones_size, 0, zholes_size);
> +
> +       /*
> +        * All zonelists will be built later in start_kernel() after per cpu
> +        * areas are initialized.
> +        */
> +}
> +
>  static int __init numa_register_memblks(struct numa_meminfo *mi)
>  {
>         unsigned long uninitialized_var(pfn_align);
> @@ -592,6 +605,8 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
>                         continue;
>
>                 alloc_node_data(nid);
> +               if (!end)
> +                       init_memory_less_node(nid);
>         }
>
>         /* Dump memblock with node info and return. */
> @@ -721,21 +736,6 @@ void __init x86_numa_init(void)
>         numa_init(dummy_numa_init);
>  }
>
> -static void __init init_memory_less_node(int nid)
> -{
> -       unsigned long zones_size[MAX_NR_ZONES] = {0};
> -       unsigned long zholes_size[MAX_NR_ZONES] = {0};
> -
> -       /* Allocate and initialize node data. Memory-less node is now online.*/
> -       alloc_node_data(nid);
> -       free_area_init_node(nid, zones_size, 0, zholes_size);
> -
> -       /*
> -        * All zonelists will be built later in start_kernel() after per cpu
> -        * areas are initialized.
> -        */
> -}
> -
>  /*
>   * Setup early cpu_to_node.
>   *
> @@ -763,9 +763,6 @@ void __init init_cpu_to_node(void)
>                 if (node == NUMA_NO_NODE)
>                         continue;
>
> -               if (!node_online(node))
> -                       init_memory_less_node(node);
> -
>                 numa_set_node(cpu, node);
>         }
>  }
> --
Which commit is this patch applied on? I can not apply it on latest linux tree.

Thanks,
Pingfan
