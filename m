Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF1BC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CE320833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="Jv6EZB+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51CE320833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbeGZAcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:32:24 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41718 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731478AbeGZAcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:32:23 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so3911405ply.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3qwtvZ2itKg/E1xGMgR+CHqG7jbL5llXhulnHKdDfXs=;
        b=Jv6EZB+YbWgtA4ruc8HDT6gj5nFiTjrjgM3FHW6GtaqRhIy2RtiTL+m2Ck1lUOcJ0d
         XTpy1LH6y5dDlKeXZI2Zy4bRhHohW32xrfqQllb9G7OvH4xhBYZO6mdUm87aehF1PYh5
         AvRPRpU7eRusCVg+XRORRxjQt/KdUCdkNdhI+wJZ13Eq985H7G3L0mvfWb/3IRehH8kb
         vqMZemj6JnrVZRX7zemU/fScC33boe6kvJTsf3AzcwElu50/I/yNUYhT8Jdlx8QSfVea
         45VK1XMlrfQArpKhJI+aEpQNkiKfhI6DC1t0fT8K8SOjDd0gdn17GSyYew9kXgf+8g/v
         xbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3qwtvZ2itKg/E1xGMgR+CHqG7jbL5llXhulnHKdDfXs=;
        b=EaI352j8eeYw93tCb47n4OKyjN/NLnLRJZZgac2jTrnnmtDcGDgXLBnfCYOOfpNGPH
         cboOBvffrFc1K0p0TTXngR4aR+Jf3S0MrIfvOOc6DHiP4zWoMWdBPxZzcXQoRotRQzal
         8T8B4tGZiUFFMRllvh+NZRIxsPaWBnnYG+KFo807ehhv0tpE8lxykWj2l4hsZJqDku7S
         wj60+jEMYNVzs5g3mQRPXfhTr2jdbvoCG06FcuDHZWfbEqpU52sPmf9xDCI/gsizGYdi
         d8FrzIuVWtgi7hfKxEI7ymzjf4KpKXwiBSKImdtQ9Orzi6+MK7cf3xdOfteB+BJ4Iswo
         /RZQ==
X-Gm-Message-State: AOUpUlFlEBWrcITNe3G3Q3LUJZazw5zc6GWJHI0qjp97n/wVovDpRRDk
        NaF+4c1r7OH52EJo5Zd+u4oQrQ==
X-Google-Smtp-Source: AAOMgpeE2cTvSKOktnPbGVJJyxspkVRf1ORKbncrho1FLeAA+9JxHkUy1nHeXQH6BeaecmhOxwDkgQ==
X-Received: by 2002:a17:902:22cc:: with SMTP id o12-v6mr22463346plg.68.1532560708223;
        Wed, 25 Jul 2018 16:18:28 -0700 (PDT)
Received: from vader ([2620:10d:c090:180::1:8d38])
        by smtp.gmail.com with ESMTPSA id a77-v6sm47028532pfj.38.2018.07.25.16.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 16:18:27 -0700 (PDT)
Date:   Wed, 25 Jul 2018 16:18:26 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20180725231826.GE16847@vader>
References: <20180723194231.3d8f0439@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723194231.3d8f0439@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 07:42:31PM +1000, Stephen Rothwell wrote:
> Hi Andrew,
> 
> After merging the akpm tree, today's linux-next build (sparc (32 bit)
> defconfig) failed like this:
> 
> In file included from kernel/crash_core.c:9:0:
> kernel/crash_core.c: In function 'crash_save_vmcoreinfo_init':
> include/linux/crash_core.h:44:66: error: lvalue required as unary '&' operand
>   vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)&name)
>                                                                   ^
> kernel/crash_core.c:404:2: note: in expansion of macro 'VMCOREINFO_SYMBOL'
>   VMCOREINFO_SYMBOL(swapper_pg_dir);
>   ^~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   e527c514996a ("proc/kcore: add vmcoreinfo note to /proc/kcore")
> 
> It seems that sparc does not declare swapper_pg_dir for 32 but builds,
> they just define it to be NULL.  As do some others:
> 
> $ git grep -w 'define.*swapper_pg_dir'
> arch/arm/include/asm/pgtable-nommu.h:#define swapper_pg_dir ((pgd_t *) 0)
> arch/c6x/include/asm/pgtable.h:#define swapper_pg_dir ((pgd_t *) 0)
> arch/h8300/include/asm/pgtable.h:#define swapper_pg_dir ((pgd_t *) 0)
> arch/m68k/include/asm/pgtable_no.h:#define swapper_pg_dir ((pgd_t *) 0)
> arch/microblaze/include/asm/pgtable.h:#define swapper_pg_dir ((pgd_t *) NULL)
> arch/sparc/include/asm/pgtable_32.h:#define swapper_pg_dir NULL
> arch/xtensa/include/asm/pgtable.h:# define swapper_pg_dir NULL

Mm, I wrongly assumed that this would only be the case for !MMU. Looks
like it's always either NULL or an array, so VMCOREINFO_SYMBOL_ARRAY
should work here. I'll send a new version.
