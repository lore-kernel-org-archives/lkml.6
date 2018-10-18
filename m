Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46FBC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965E821477
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965E821477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeJRRP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:15:58 -0400
Received: from foss.arm.com ([217.140.101.70]:34752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbeJRRP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:15:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C44480D;
        Thu, 18 Oct 2018 02:15:53 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC0633F5D3;
        Thu, 18 Oct 2018 02:15:51 -0700 (PDT)
Date:   Thu, 18 Oct 2018 10:15:43 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        zhangfx <zhangfx@lemote.com>, wu zhangjin <wuzhangjin@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cacheinfo: Keep the old value if of_property_read_u32
 fails
Message-ID: <20181018091146.GA22021@e107155-lin>
References: <1539739563-1886-1-git-send-email-chenhc@lemote.com>
 <20181017093540.GB16320@e107155-lin>
 <CAAhV-H64KYE6YDLrBuK_oYkyBHe8F_5Ja433tY+Pp841kJw57g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H64KYE6YDLrBuK_oYkyBHe8F_5Ja433tY+Pp841kJw57g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huacai,

On Thu, Oct 18, 2018 at 09:28:11AM +0800, Huacai Chen wrote:
> Hi, Sudeep,
> 
> Please see this call-graph:
> 
> static int detect_cache_attributes(unsigned int cpu)
>         ....
>         ret = populate_cache_leaves(cpu);
>         ....
>         ret = cache_shared_cpu_map_setup(cpu); -->
> cache_setup_of_node() --> cache_of_set_props() -->
> cache_size()/cache_nr_sets
> 
> populate_cache_leaves() is arch-specific, All archs except arm64 have
> provide initial values to cacheinfo:size and cacheinfo:number_of_sets.
> 
> Related files:
> arch/nds32/kernel/cacheinfo.c
> arch/mips/kernel/cacheinfo.c

Only above 2 could be affected, but I want to be sure. I wasn't aware
of MIPS arch setting values elsewhere, assumed DT, my bad.
You have still not answered my question. Which arch are you facing issue ?
Or are you proposing this by code inspection ? I changes look fine, but
want to be sure if the issue you are seeing is in above architectures.

--
Regards,
Sudeep
