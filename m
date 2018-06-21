Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03962C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A0820837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A0820837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932677AbeFUIjZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:39:25 -0400
Received: from foss.arm.com ([217.140.101.70]:47112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753938AbeFUIjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:39:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 875CD80D;
        Thu, 21 Jun 2018 01:39:00 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4FF43F246;
        Thu, 21 Jun 2018 01:38:55 -0700 (PDT)
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
To:     Wei Xu <xuwei5@hisilicon.com>, Will Deacon <will.deacon@arm.com>
Cc:     catalin.marinas@arm.com, suzuki.poulose@arm.com,
        dave.martin@arm.com, mark.rutland@arm.com, marc.zyngier@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linuxarm <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>, xiexiuqi@huawei.com,
        huangdaode <huangdaode@hisilicon.com>,
        "Chenxin (Charles)" <charles.chenxin@huawei.com>,
        "Xiongfanggou (James)" <james.xiong@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        Zhangyi ac <zhangyi.ac@huawei.com>,
        jonathan.cameron@huawei.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "kongxinwei (A)" <kong.kongxinwei@hisilicon.com>,
        "Liyuan (Larry, Turing Solution)" <Larry.T@huawei.com>,
        libeijian@hisilicon.com
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
Date:   Thu, 21 Jun 2018 09:38:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5B2A7FE1.5040607@hisilicon.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will, Wei,

On 20/06/18 17:25, Wei Xu wrote:
> On 2018/6/20 23:54, James Morse wrote:
> I have disabled CONFIG_ARM64_RAS_EXTN and reverted that commit.
> But I still got the stack overflow issue sometimes.
> Do you have more hint?

> The log is as below:
>     [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x480fd010]
>     [    0.000000] Linux version 4.17.0-45865-g2b31fe7-dirty

Could you reproduce this with v4.17? This says there are ~45,000 extra patches,
and un-committed changes. None of the hashes so far have been commits in
mainline, so we have no idea what this tree is.


> (joyx@Turing-Arch-b) (gcc version 4.9.1 20140505 (prerelease) (crosstool-NG
> linaro-1.13.1-4.9-2014.05 - Linaro GCC 4.9-2014.05)) #10 SMP PREEMPT Wed Jun 20
> 23:59:05 CST 2018

>     [    0.000000] CPU0: using LPI pending table @0x000000007d860000
>     [    0.000000] GIC: PPI11 is secure or misconfigured
>     [    0.000000] arch_timer: WARNING: Invalid trigger for IRQ3, assuming level
> low
>     [    0.000000] arch_timer: WARNING: Please fix your firmware
>     [    0.000000] arch_timer: cp15 timer(s) running at 100.00MHz (virt).

(No idea what these mean, but I doubt they are relevant)


>     [    0.042421] Insufficient stack space to handle exception!
>     [    0.042423] ESR: 0x96000046 -- DABT (current EL)
>     [    0.043730] FAR: 0xffff0000093a80e0
>     [    0.044714] Task stack: [0xffff0000093a8000..0xffff0000093ac000]

This was a level 2 translation fault on a write, to an address that is within
the stack....


>     [    0.051113] IRQ stack: [0xffff000008000000..0xffff000008004000]
>     [    0.057610] Overflow stack: [0xffff80003efce2f0..0xffff80003efcf2f0]
>     [    0.064003] CPU: 0 PID: 12 Comm: migration/0 Not tainted
> 4.17.0-45865-g2b31fe7-dirty #10
>     [    0.072201] Hardware name: linux,dummy-virt (DT)

>     [    0.076797] pstate: 604003c5 (nZCv DAIF +PAN -UAO)
>     [    0.081727] pc : el1_sync+0x0/0xb0

... from the vectors.


>     [    0.085217] lr : kpti_install_ng_mappings+0x120/0x214

What I think is happening is: we come out of the kpti idmap with the stack
unmapped. Shortly after we access the stack, which faults. el1_sync faults as
well when it tries to push the registers to the stack, and we keep going until
we overflow the stack.

I can't reproduce this with kvmtool or qemu in the model.


Thanks,

James
