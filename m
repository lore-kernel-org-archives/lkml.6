Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8777FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382E222560
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="kL43z3FA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382E222560
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934772AbeGFTiY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:38:24 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39735 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934695AbeGFTiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:38:23 -0400
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so25453930oib.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 12:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1u/XYC07FNpuBRN2RLZvULedlI+TqP3G/W045jk5gbA=;
        b=kL43z3FAKXArq+D8rH1JJiYGPceXWDMTA7ljjCvoEmKOOXBNPZtKbn/TcWq4ap2pQN
         +yrzp3AuxuvMVH0nAdh4HYKh/yoS9/WIO8qVt9x3/g9Byw1cOj4Gk6/dwArChFCDjJ+5
         Qb8OzxpnX00scGgwgemsi28WSBacrsQ1kmQwxHRrhp/qEWfQZH60IHAMIya+AMpNhY3Z
         OvuQpVCHV8+QWogggTY4TBAT0/q3cdwLWA7Ul5xkjwQ4Y7FV6CObU+VlVQZYrpLXXTlv
         cJMwemYgNkYsmXjvd21dQOIVoUxenS6Xady4Uy5m8/TBFzwOnI/nPfokKC9XHX7iKqhV
         wWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1u/XYC07FNpuBRN2RLZvULedlI+TqP3G/W045jk5gbA=;
        b=TfPyd2PSQ6H9D9zvfKOoUkRFiUSB99PcoA5OYxUx1gQ/tOkCMDa2WksvMRlYq+7UF5
         4RBzOzEN2TOkEWRzi45ljiOHAGV5VSxu/H1upsjTbyVw+kfeKsFCHygl2eFNAbuqewBJ
         yGzOTLAz81d+UDkgIrmMpk8S96RM+biD25qFcMLQRWFQlQV0+IDtrVulYkIOcKhBpU7D
         ABVeDWVYhJUazeVxo9xxXN4V1t6W58DX8hzobfsTIpj54qeGws302aJURYPl/9jp77vj
         vOLAMwF4yX9jhZlAMkgxJUU+M1/h7tgQ9lERgteqykhw7litPC//3bVn3wYwOizk37e5
         DG/w==
X-Gm-Message-State: APt69E0YPiIqF3UQlNoZqGmgoyQooQstzwUyL1vnmBajJcqS0cS9kPyG
        8lPJug/tSaMYu6jIEyIyllDkxqP5g6F2uz8crCHdVw==
X-Google-Smtp-Source: AAOMgpcUFDYTw1dOZKe4xf2zp0hHXJOtf8x/k7XuJf2gxZeW8EGomyHjiIHctu4LMWdM+cKlvYcqRhd6uerGUDmrDHI=
X-Received: by 2002:aca:5f56:: with SMTP id t83-v6mr13540526oib.115.1530905902926;
 Fri, 06 Jul 2018 12:38:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 12:38:22 -0700 (PDT)
In-Reply-To: <20180706082911.13405-2-aneesh.kumar@linux.ibm.com>
References: <20180706082911.13405-1-aneesh.kumar@linux.ibm.com> <20180706082911.13405-2-aneesh.kumar@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 6 Jul 2018 12:38:22 -0700
Message-ID: <CAPcyv4gjrsswcakSog7jxT+agH7NrBEvwxe9jT0ycU3RZV5sWA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm/pmem: Add memblock based e820 platform driver
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oliver <oohall@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 1:29 AM, Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
> This patch steal system RAM and use that to emulate pmem device using the
> e820 platform driver.
>
> This adds a new kernel command line 'pmemmap' which takes the format <size[KMG]>
> to allocate memory early in the boot. This memory is later registered as
> persistent memory range.
>
> Based on original patch from Oliver OHalloran <oliveroh@au1.ibm.com>
>
> Not-Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  drivers/nvdimm/Kconfig        |  13 ++++
>  drivers/nvdimm/Makefile       |   1 +
>  drivers/nvdimm/memblockpmem.c | 115 ++++++++++++++++++++++++++++++++++
>  3 files changed, 129 insertions(+)
>  create mode 100644 drivers/nvdimm/memblockpmem.c
>
[..]
> +/*
> + * pmemmap=ss[KMG]
> + *
> + * This is similar to the memremap=offset[KMG]!size[KMG] paramater
> + * for adding a legacy pmem range to the e820 map on x86, but it's
> + * platform agnostic.

The current memmap=ss!nn option is a non-stop source of bugs and
fragility. The fact that this lets the kernel specify the base address
helps, but then this is purely just a debug facility because
memmap=ss!nn is there to cover platform firmware implementations that
fail to mark a given address range as persistent.

If this is just for debug, why not use qemu? If this is not for debug
what are these systems that don't have proper firmware support?
