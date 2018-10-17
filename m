Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0C2ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6982150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6982150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJQRaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:30:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48732 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbeJQRaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:30:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4364A341;
        Wed, 17 Oct 2018 02:35:44 -0700 (PDT)
Received: from e107155-lin (unknown [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C75CB3F59C;
        Wed, 17 Oct 2018 02:35:42 -0700 (PDT)
Date:   Wed, 17 Oct 2018 10:35:40 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cacheinfo: Keep the old value if of_property_read_u32
 fails
Message-ID: <20181017093540.GB16320@e107155-lin>
References: <1539739563-1886-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539739563-1886-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 09:26:03AM +0800, Huacai Chen wrote:
> Commit 448a5a552f336bd7b847b1951 ("drivers: base: cacheinfo: use OF
> property_read_u32 instead of get_property,read_number") makes cache
> size and number_of_sets be 0 if DT doesn't provide there values. I
> think this is unreasonable so make them keep the old values, which is
> the same as old kernels.
>

What old values does the kernel have ? Which architecture are you referring ?
If DT doesn't have entry then we can't expose sysfs, hence 0.
Please provide more details on the issue you are seeing.

--
Regards,
Sudeep
