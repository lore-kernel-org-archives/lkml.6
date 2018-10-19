Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1704ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B3C214C3
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B3C214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeJSRYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:24:22 -0400
Received: from foss.arm.com ([217.140.101.70]:49384 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbeJSRYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:24:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FFA480D;
        Fri, 19 Oct 2018 02:19:08 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF85E3F5D3;
        Fri, 19 Oct 2018 02:19:06 -0700 (PDT)
Date:   Fri, 19 Oct 2018 10:18:59 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        zhangfx <zhangfx@lemote.com>, wuzhangjin <wuzhangjin@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cacheinfo: Keep the old value if
 of_property_read_u32fails
Message-ID: <20181019091859.GA17312@e107155-lin>
References: <1539739563-1886-1-git-send-email-chenhc@lemote.com>
 <20181017093540.GB16320@e107155-lin>
 <CAAhV-H64KYE6YDLrBuK_oYkyBHe8F_5Ja433tY+Pp841kJw57g@mail.gmail.com>
 <20181018091146.GA22021@e107155-lin>
 <tencent_618B672134A6B5732D255D23@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_618B672134A6B5732D255D23@qq.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 19, 2018 at 02:23:27PM +0800, 陈华才 wrote:
> Hi, Sudeep,
>
> I use MIPS, and there is no "size" in
> /sys/devices/system/cpu/cpuX/cache/indexX/ file after your patch. Because
> the DT node only has "next-level-cache = <&L2>;"  but has no "size"
> information.
>
Thanks for the confirmation and your time. I was worried if this was ARM64
with local patches.

You can add:
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Also please add:
Fixes: 448a5a552f33 ("drivers: base: cacheinfo: use OF property_read_u32 instead of get_property,read_number")

--
Regards,
Sudeep
