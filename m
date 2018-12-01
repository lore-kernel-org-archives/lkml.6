Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D654C65BAE
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DDF20673
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="kvLOg+Vy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DDF20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeLAMEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:04:06 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44511 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbeLAMEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:04:06 -0500
Received: by mail-ot1-f68.google.com with SMTP id f18so6781465otl.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bRYshC/pQ0qYWjfqH+kV5ROPjGOP9RnyUeFhFlXm0Nk=;
        b=kvLOg+VykFD85Cs3MSzczgd7cE8OVuFUzKtGaXU2nrt/4CFuAKf6rEJBdexLjM37iE
         eWK97PIgqWvotql6dKX5qbVj3AMRyjRlFHToSOiDVON76pQsN6AxZqOuOENvEkYAE3Q8
         Ji1Jeq46Hcg2f5WtDnp1rXsIibZMJSWsKo1eyWsNVUqDd3PNKiVaD7vkWmGqe6czYzNe
         qXH56xfOzbFGa8ktOuuuz/GZhcSATr1Z1GG9YKWDfgG149fUxWoiAJgARIXsFILYZpZa
         drGT7semM2bVAvokB1O2Apt+GRHWLEJMN5e/ZOE684215Uf3713eAj2YDwvISgl9NlRP
         4qDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRYshC/pQ0qYWjfqH+kV5ROPjGOP9RnyUeFhFlXm0Nk=;
        b=LDURY1ftip5oXtAnSlLYJbu56FnH51mauom52hLN3hcPCkTdIwegPfJXB8meJatjK4
         RzWKPfVW+zFrfc9QwhKhios+jFoZt9xyUDTpRIJHBGJ+8OEhpy2zKJJ6s++jb1rR6mbr
         6mrcNfwftegPCyJiZ0hrPafW7hH4v3YVR+ulRn0PP+3CEITyTzqFHP3V5eZA1Uybgfc5
         WMH1UDaUcwDzKROXZroMhlhyquHPQIvalgOywoxHg2QLtGvOX2qsrVBZHK9/qwo3jwLq
         0mOG9o6UZTlloR96fhVS90JoS4gJeUroHtZrz2AXGCw2YTmOkIbJiTnu6Xh0e/CBzAmu
         nLXw==
X-Gm-Message-State: AA+aEWYnwde/FLfU0KfhoBQZL1cU03+Gm5N5psqiiYPnV7wqZZ5hV3PS
        uDoFQfZogH4794sYk0Nfic7+X6GnOk7D3R4G9tuwwg==
X-Google-Smtp-Source: AFSGD/Wv3usxcnLZIpAsHPFAf5cdEwRibKsxWDdz8k0gLb564Mx3fVhcGiQs+xMWpPYdZbUh5ScDgQROCHIym3XnZig=
X-Received: by 2002:a9d:775a:: with SMTP id t26mr4623979otl.32.1543625575051;
 Fri, 30 Nov 2018 16:52:55 -0800 (PST)
MIME-Version: 1.0
References: <20181130225911.2900-1-logang@deltatee.com>
In-Reply-To: <20181130225911.2900-1-logang@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 30 Nov 2018 16:52:43 -0800
Message-ID: <CAPcyv4jHF-3H09Zgtcm_+AVviMAvE1zfEQnoipAakE+o=KMpUg@mail.gmail.com>
Subject: Re: [PATCH] PCI/P2PDMA: Match interface changes to devm_memremap_pages()
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 2:59 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> "mm-hmm-mark-hmm_devmem_add-add_resource-export_symbol_gpl.patch" in the
> mm tree breaks p2pdma. The patch was written and reviewed before p2pdma
> was merged so the necessary changes were not done to the call site in
> that code.
>
> Without this patch, all drivers will fail to register P2P resources
> because devm_memremap_pages() will return -EINVAL due to the 'kill'
> member of the pagemap structure not yet being set.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
