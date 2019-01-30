Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AE8C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3167920989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbfA3PAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:00:32 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55694 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbfA3PAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:00:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CAC7EBD;
        Wed, 30 Jan 2019 07:00:31 -0800 (PST)
Received: from [10.37.9.196] (unknown [10.37.9.196])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D38463F589;
        Wed, 30 Jan 2019 07:00:29 -0800 (PST)
Subject: Re: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
To:     "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
References: <8898674D84E3B24BA3A2D289B872026A6A2C04E6@G01JPEXMBKW03>
From:   James Morse <james.morse@arm.com>
Cc:     'Catalin Marinas' <catalin.marinas@arm.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Mark Rutland' <mark.rutland@arm.com>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        "'will.deacon@arm.com'" <will.deacon@arm.com>
Message-ID: <cb7544e2-bd85-df4c-1f48-0afeedefc962@arm.com>
Date:   Wed, 30 Jan 2019 15:00:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A6A2C04E6@G01JPEXMBKW03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 01/29/2019 12:29 PM, Zhang, Lei wrote:
> On some variants of the Fujitsu-A64FX cores ver(1.0, 1.1),
> memory accesses may cause undefined fault (Data abort, DFSC=0b111111).
> This problem will be fixed by next version of Fujitsu-A64FX.
> 
> This fault occurs under a specific hardware condition
> when a load/store instruction perform an address translation using:
>    case-1  TTBR0_EL1 with TCR_EL1.NFD0 == 1.
>    case-2  TTBR0_EL2 with TCR_EL2.NFD0 == 1.
>    case-3  TTBR1_EL1 with TCR_EL1.NFD1 == 1.
>    case-4  TTBR1_EL2 with TCR_EL2.NFD1 == 1.
> And this fault occurs completely spurious.
> 
> Since TCR_ELx.NFD1 is set to '1' at the kernel in versions
> past 4.17, the case-3 or case-4 may happen.

e03e61c3173c ("arm64: kaslr: Set TCR_EL1.NFD1 when 
CONFIG_RANDOMIZE_BASE=y") ?

So you'd never see it if you disabled CONFIG_RANDOMIZE_BASE?


Thanks,

James
