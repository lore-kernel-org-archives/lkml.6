Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4060BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE816205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="NCCd/sgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE816205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeH3SBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:01:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35491 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbeH3SBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:01:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so3935316pfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 06:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Opp7/90KgZLyY+6mrs4uBZrkB8MAeRsaRuOg8MZIqwQ=;
        b=NCCd/sgdULlh0dXy3t3REW2/kPqSugZr7dXRGjL0QyoxO98IDuFLESfG7IgdiVEVWl
         sjGdGwrZ511GZgPtBFEvFAI3EbRd1MPlBEBsRGqEVrnurLFWpcIDiLu2CEM9DC9KKe7t
         DXtQU01m3mQuWXwZ3M/ySwV8CjVfX1J2hsgASMSbrbIsVAXxZwgwJwnV6IkmaJxobfOl
         l3OLpR3GgoSLI5GNKcdMcCiUhWUoD0SPEuuk2goinJn3NTnr30YmO7H6wQCk5Xlmf8et
         /qxSIdBpDs2jshmbkhrgi/kkdwV5LYCpdMEwrBJ46y1KKWSrfBd0umE2qkHq8XDQI9Un
         w5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Opp7/90KgZLyY+6mrs4uBZrkB8MAeRsaRuOg8MZIqwQ=;
        b=Mh5XluCT0dPNZe5j6pSvSHEY4H+pxrVV5MHkhB5hrMxRJKvZPFcXYYKYkHLd/8rxbG
         zSUNVi1ZiLBvmPUJl84CsvE8VkWcqz3ZZsTSYS4qR3J1es6NBfI86zqcgosfmgxt2k2H
         Q1vGO7MK0JaraQixIxkDCobCSsTkpPi0YiRQbopKRq9Jv5tAGR97P1/50RNCiG468nLZ
         6ikP6DFltGeLK+PtAsqeziAjYJVHggcSa/J/adKxFJlWd3YAgPgRvSji00fMw03pBO1W
         4CqhlGlK6yZNO3vAaFX5zTGLYhp+UVvkbseDQ2Hy/pw3bN3WyWcPgYWGCMTskWmEBfyv
         SXpg==
X-Gm-Message-State: APzg51AqhNc9W3hh9LWAFBCUgiVZVQz5K3tp38TFIxINKAtUxuxUhygN
        WEqUKHOvpBYSY5II2dqKTFaMQQ==
X-Google-Smtp-Source: ANB0VdbNwj6Ao+Jm4aJbF8+cismAIByBVysr73DhT1C9pGPgU4QyY5wCbUe8KY3Nbw2nh6irffVzzQ==
X-Received: by 2002:a62:1bc2:: with SMTP id b185-v6mr10781246pfb.170.1535637541761;
        Thu, 30 Aug 2018 06:59:01 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id v7-v6sm11739585pgh.57.2018.08.30.06.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 06:59:00 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 222EE3001A3; Thu, 30 Aug 2018 16:58:56 +0300 (+03)
Date:   Thu, 30 Aug 2018 16:58:56 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 0/3] Add restrictions for kexec/kdump jumping between
 5-level and 4-level kernel
Message-ID: <20180830135855.rylamc7mx2ur3tab@kshutemo-mobl1>
References: <20180829141624.13985-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829141624.13985-1-bhe@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:16:21PM +0800, Baoquan He wrote:
> This was suggested by Kirill several months ago, I worked out several
> patches to fix, then interrupted by other issues. So sort them out
> now and post for reviewing.

Thanks for doing this.

> The current upstream kernel supports 5-level paging mode and supports
> dynamically choosing paging mode during bootup according to kernel
> image, hardware and kernel parameter setting. This flexibility brings
> several issues for kexec/kdump:
> 1)
> Switching between paging modes, requires changes into target kernel.
> It means you cannot kexec() 4-level paging kernel from 5-level paging
> kernel if 4-level paging kernel doesn't include changes. 
> 
> 2)
> Switching from 5-level paging to 4-level paging kernel would fail, if
> kexec() put kernel image above 64TiB of memory.

I'm not entirely sure that 64TiB is the limit here. Technically, 4-level
paging allows to address 256TiB in 1-to-1 mapping. We just don't have
machines with that wide physical address space (which don't support
5-level paging too).

What is your reasoning about 64TiB limit?

-- 
 Kirill A. Shutemov
