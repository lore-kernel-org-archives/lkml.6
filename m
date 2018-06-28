Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290BBC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1226272D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1226272D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935182AbeF1QYa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:24:30 -0400
Received: from foss.arm.com ([217.140.101.70]:49988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935059AbeF1QYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:24:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A9BA18A;
        Thu, 28 Jun 2018 09:24:23 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 562633F266;
        Thu, 28 Jun 2018 09:24:20 -0700 (PDT)
Date:   Thu, 28 Jun 2018 17:24:17 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Wangxuefeng (E)" <wxf.wang@hisilicon.com>
Cc:     "xuwei (O)" <xuwei5@huawei.com>,
        "will.deacon" <will.deacon@arm.com>,
        "james.morse" <james.morse@arm.com>,
        "catalin.marinas" <catalin.marinas@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Zhangyi ac <zhangyi.ac@huawei.com>,
        "suzuki.poulose" <suzuki.poulose@arm.com>,
        "marc.zyngier" <marc.zyngier@arm.com>,
        "Xiongfanggou (James)" <james.xiong@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "dave.martin" <dave.martin@arm.com>,
        "Liyuan (Larry, Turing Solution)" <Larry.T@huawei.com>,
        Libeijian <libeijian@hisilicon.com>,
        Zhangxiquan <zhangxiquan@hisilicon.com>,
        dingshuai <dingshuai1@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: Re: =?utf-8?B?562U5aSNOiBLVk0gZ3Vlc3Qgc29t?=
 =?utf-8?Q?etimes_failed_to_boot_because_of_kernel_stac?= =?utf-8?Q?k?=
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
Message-ID: <20180628162417.s4mcoaow3dgpodew@lakrids.cambridge.arm.com>
References: <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <5B2B6DEA.2090100@hisilicon.com>
 <5B3274FC.7000206@hisilicon.com>
 <20180626174746.GO23375@arm.com>
 <5B338F7B.9070500@hisilicon.com>
 <20180627132826.GB30631@arm.com>
 <5B34F5C0.9090001@hisilicon.com>
 <20180628153425.rm5fd6dxb53n226z@lakrids.cambridge.arm.com>
 <etPan.5b3507f7.914aa16.1d6b@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <etPan.5b3507f7.914aa16.1d6b@localhost>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 04:08:24PM +0000, Wangxuefeng (E) wrote:
> Hi, mark
>      Your means is that DMB must  make sure the completion of prior load/store
> or CMO  and make sure the data is visible to all obsevers (no matter device or
> cacheable).   DMB not only keep order?

Not quite -- DMB does not guarantee completion.

However, DMB must guarantee that loads/stores and CMOs are ordered on
the bus, all the way to the PoC.

Thanks,
Mark.
