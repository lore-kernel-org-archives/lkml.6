Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F420ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 05:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E290620849
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 05:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB0qBbAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E290620849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeGUGXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 02:23:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34481 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeGUGXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 02:23:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id y5-v6so8500068pgv.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 22:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XGkMPjcxkwgIVZ2RJOSKuFlr9CV3BB5/D6NVajfpFlA=;
        b=XB0qBbAz+Znfgl9aBLALjXmIwOlkf0NvGPL1nzKTWxVKzblEns4/y1E4kzp/1XgKqZ
         sX1cDXNkWvzKyAi8G1p7HbbrIuHAbTD8Vw6NKajgxs1G9WEZRJkoB4xJwx7xLLIvhwE9
         4Z6c4RqH6cWIAFA6n6EAS/vJUG1w0K+woUNXBIDBwEYYegH9oxJ3J3qpp6kqlVHShivz
         pZeJ3Iq9XcIvtkE3ZfFO+XrWsj6BRPY5f5Vp/91i8e40dVUzWnH1YxULVI5HbYNyoTRU
         BFA+au7nPv74O2fV3nJdM84PWfqYEfU/l0//PlqZW9IdvRrb2+x1hF/1HwwDDBfUw3Ku
         L4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XGkMPjcxkwgIVZ2RJOSKuFlr9CV3BB5/D6NVajfpFlA=;
        b=b88CQfnx0sICw+ryc2RU/SbrHMxfAT23pnIcOcDebQmYuQg0j28tmitJYSLichkOY0
         gnWx3FEizgQRUeGc5FMwNkIY5behhiHK8kQtlZWmLhmlaWz96w2qoYLYepqvafsulR3R
         U5zzRfGEzTgOsiasaMDIvKpIIP0gkG/iRiFs+W47ik4K2tFXLtmiOFF4cFGzj+2QChaP
         3V0qkZpbNpuUjxnr5PhxJD4G+5zrgNgQPsROGnSTQkyk+S3PbR+4mhA+FwlEpFp0eAM1
         0o+H93gyL7suo0RBdiECOUZnxWcEwq8H6wGO/74dH3049tyiLOLgzY4Cm8kWHL+ddvnG
         PAaA==
X-Gm-Message-State: AOUpUlF3SkU4VnfC9YJleuvJyFZVycYYqO46ypWd6qTPO/RTylLz056z
        f5f0klYIJ9hOcIGpg3e9VoDVJ6jS
X-Google-Smtp-Source: AAOMgpfmErR+RfSTFS5rLme84WuQQrXUEeiASmC9KMfMFIqRPusJAtl6ppRtgKdNwZUzq398vbHCXw==
X-Received: by 2002:a63:2359:: with SMTP id u25-v6mr4569371pgm.220.1532151105574;
        Fri, 20 Jul 2018 22:31:45 -0700 (PDT)
Received: from localhost (g152.124-44-9.ppp.wakwak.ne.jp. [124.44.9.152])
        by smtp.gmail.com with ESMTPSA id b128-v6sm4452035pfa.105.2018.07.20.22.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 22:31:45 -0700 (PDT)
Date:   Sat, 21 Jul 2018 14:31:42 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: use the generic dma-noncoherent code for openrisc
Message-ID: <20180721053142.GC9742@lianli.shorne-pla.net>
References: <20180719130232.1819-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719130232.1819-1-hch@lst.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 06:02:28AM -0700, Christoph Hellwig wrote:
> Hi Openrisc maintainers,
> 
> can you review these patches to switch openrisc to use the generic
> dma-noncoherent code?  All the requirements are in mainline already
> and we've switched various architectures over to it already.

Hi Christoph,

Thanks for this, these look good to me.  I don't know much about the dma
infrastructure in the kernel to tell the truth, but the patches do maintain the
original cache flushing and invalidation core logic and I don't see any
problems.

I have applied these and ran my regular tests, but I don't really have any DMA
hardware so the testing doesn't mean much.

For upstreaming, do you want me to send these through the openrisc tree, or do
you want to send with the dma tree?

-Stafford
