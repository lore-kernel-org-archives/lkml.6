Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930D6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4E221708
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Kwsygxng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4E221708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeI0WpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:45:11 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55236 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI0WpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:45:11 -0400
Received: by mail-it1-f195.google.com with SMTP id f14-v6so8631268ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 09:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O8LnUUrAhYG5Iw5hY02ZjY7QLJyyRorA8PV6hMJ99Sc=;
        b=KwsygxngLTefjMwXLcHnuP/JwvpZCR8fKKXf1dOC0jCLxtUYtWQqaKecvYsArhXSEg
         oDJYTyhhFqKW7MAlw8NUvDGyslGrSWR/awBxLRyIto6mwugHkoJB3tkRhAQp3e9nVYVQ
         bS26eIbi9uwBC6NEDnpwHx9PYU1dyblJcMNmglk6+c+eDACYne5zTq4o+fCFCjfXKahg
         l7gBD7pZv4Ry7n0yYe75o6n4ro5QnQVLShnmINXj9LGvFDlE1QnTFdf13Jls5j/2NwP9
         tbv4Anq4N+60ZEMBMMBTSqfhhDu2yrfeugdwChllDO2yEhSiSLTkpRREKJvjgcJb2+FE
         DMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O8LnUUrAhYG5Iw5hY02ZjY7QLJyyRorA8PV6hMJ99Sc=;
        b=hWnNLQc0XlCL4Gm64UHO/Ppw7/UoPYzv0ID90c4OPZr/fX0TpdxE1J8yLlU2JxriI6
         TEGF5AXbg7F1/5ZC1kRFHUuws8aSW6HzGyeA0AfGbndvV4HCfG+LUNnhGTbY3x7khB3L
         uTSjzvMnbiwWXXdW1zRzbAbBVPvz+aSuNAAHPBgSqw7O6xzSAXGSzVuoKXzVLO4az+R7
         fW/DXskUA1UAwrZUNdnzT28TH5YlqdTDSMjPwLL7ezkmvfPVTTX3fl8HrL5OImthzS3+
         PVDhAz8Bc0wwTtC2oF5/b0Z1FbsoYvrS7Vimver8Q/lcZ/74YMje5tHUI1VtYWtbj4X7
         xPeA==
X-Gm-Message-State: ABuFfohi/9yxeTwrpoDZfdpFPHoTcJfIz06yXaNV76BpkLGXyLU/dLAR
        ISJg9oPst7FZ1Gqg1D8HTXewIA==
X-Google-Smtp-Source: ACcGV60PhwFjFQunoN/BKfwuhOhn/ce4aqyAAQo7lq4MJppngS/oUH9x4sWtGl30a85IVuZ7NVB2Mg==
X-Received: by 2002:a02:b184:: with SMTP id t4-v6mr10721390jah.120.1538065568039;
        Thu, 27 Sep 2018 09:26:08 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id k9-v6sm784843iop.1.2018.09.27.09.26.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 09:26:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g5Z77-0008L9-At; Thu, 27 Sep 2018 10:26:05 -0600
Date:   Thu, 27 Sep 2018 10:26:05 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Matan Barak <matanb@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Huy Nguyen <huyn@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/ucontext: fix building with CONFIG_MMU=n
Message-ID: <20180927162605.GB28301@ziepe.ca>
References: <20180927101017.990471-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927101017.990471-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 12:10:03PM +0200, Arnd Bergmann wrote:
> The zap_vma_ptes() is declared but not defined on NOMMU kernels,
> causing a link error for the newly added uverbs code:
> 
> drivers/infiniband/core/uverbs_main.o: In function `uverbs_user_mmap_disassociate':
> uverbs_main.c:(.text+0x114c): undefined reference to `zap_vma_ptes'
> drivers/infiniband/core/uverbs_main.o: In function `rdma_umap_open':
> uverbs_main.c:(.text+0x53c): undefined reference to `zap_vma_ptes'

I'm a bit surprised by this - the code is not new, it just got moved
out of the drivers, and I don't see any protections there against
CONFIG_MMU ??
 
> To fix this, we can either make uverbs depend on CONFIG_MMU, or try
> to build it anyway. Since this is the only compile-time dependency,
> I decided to allow building it with an extra compile-time check for
> CONFIG_MMU before calling the one function.

Hrm. So this code doesn't work at all on NOMMU, it relies on
remap_pfn_range, which always fails on those kernels, 

Due to this of this the entirety of INFINIBAND_USER_ACCESS is broken.

I think a kconfig change is the better way to go?

Jason
