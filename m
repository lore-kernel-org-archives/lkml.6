Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555F7C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6E92083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6E92083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754362AbeFTPzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:55:07 -0400
Received: from foss.arm.com ([217.140.101.70]:39486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754157AbeFTPzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:55:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D37A280D;
        Wed, 20 Jun 2018 08:55:03 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E6D23F589;
        Wed, 20 Jun 2018 08:54:59 -0700 (PDT)
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     Will Deacon <will.deacon@arm.com>, catalin.marinas@arm.com,
        suzuki.poulose@arm.com, dave.martin@arm.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linuxarm <linuxarm@huawei.com>,
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
From:   James Morse <james.morse@arm.com>
Message-ID: <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
Date:   Wed, 20 Jun 2018 16:54:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5B2A7832.4010502@hisilicon.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On 20/06/18 16:52, Wei Xu wrote:
> On 2018/6/20 22:42, Will Deacon wrote:
>> Hmm, I wonder if this is at all related to RAS, since we've just enabled
>> that and if we take a fault whilst rewriting swapper then we're going to
>> get stuck. What happens if you set CONFIG_ARM64_RAS_EXTN=n in the guest?
> 
> I will try it now.

It's not just the Kconfig symbol, could you also revert:

f751daa4f9d3 ("arm64: Unconditionally enable IESB on exception entry/return for
firmware-first")


(reverts and build cleanly on 4.17)


Thanks,

James
