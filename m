Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5DDC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914F820867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914F820867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeLAFrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:47:43 -0500
Received: from foss.arm.com ([217.140.101.70]:34646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbeLAFrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:47:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0597165C;
        Fri, 30 Nov 2018 10:37:32 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 746D23F575;
        Fri, 30 Nov 2018 10:37:31 -0800 (PST)
Subject: Re: Resend: How to handle the SMMU RAS Error in the kernel
To:     gengdongjiu <gengdongjiu@huawei.com>,
        gengdongjiu <gengdj.1984@gmail.com>
Cc:     robin.murphy@arm.com,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        xuqiang36@huawei.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAMj-D2DY_1eZUsbnqurx8j3q04Y8JKiM2CtPv+NTsswydo0TJQ@mail.gmail.com>
 <c8a1d0e7-338b-05e1-2d52-f13223515f49@arm.com>
 <7a93bf1b-7b7b-240e-bc74-68bf0ee18ac9@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <c769e2a5-f176-60fd-bcff-ef00e904736a@arm.com>
Date:   Fri, 30 Nov 2018 18:37:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <7a93bf1b-7b7b-240e-bc74-68bf0ee18ac9@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi gengdongjiu,

On 21/11/2018 08:10, gengdongjiu wrote:
> On 2018/11/20 2:05, James Morse wrote:
>> On 17/11/2018 15:41, gengdongjiu wrote:
>>> In the current kernel, it only handles three kinds of error, which is
>>> memory error, PCIE device and ARM process. But now the SMMU already
>>> support the RAS, how to handle the SMMU RAS error in the kernel?
>>
>> What errors are being detected here?
>>
>> I don't know much about the SMMU, but I think we should start with a list of
>> errors that we want to handle.
> 
> In our platform, the SMMU RAS error mainly include below which flow the SMMU spec:
> 1. one bit ECC error, reported as CE.
> 2. two bits ECC error, reported as UEU.
> 3. fetch error in the SMMUv3 spec, reported as UER.

These are faults, but this isn't enough information for software to act on.

Are these faults in the device, host-memory, or memory that is part of the SMMU?
Was the error discovered during a read/write by the device?, (which one?) Or the
SMMU's page-tables, or command-queue.


> The 2 and 3 should be handled, but I do not know how do recovery to it.

Me neither. If we can come up with the errors that can be detected, we can work
out which ones can be handled.


Thanks,

James
