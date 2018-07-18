Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0395ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A772086D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A772086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbeGRRa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:30:57 -0400
Received: from foss.arm.com ([217.140.101.70]:37738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbeGRRa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:30:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D30D47A9;
        Wed, 18 Jul 2018 09:52:10 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C33D3F318;
        Wed, 18 Jul 2018 09:52:07 -0700 (PDT)
Subject: Re: [PATCH v11 03/15] powerpc, kexec_file: factor out memblock-based
 arch_kexec_walk_mem()
To:     Dave Young <dyoung@redhat.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, bhe@redhat.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
 <20180711074203.3019-4-takahiro.akashi@linaro.org>
 <20180716122623.GB7160@dhcp-128-65.nay.redhat.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <c8c09929-165a-b710-6993-0b149a0c3b99@arm.com>
Date:   Wed, 18 Jul 2018 17:52:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180716122623.GB7160@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave, Akashi,

On 16/07/18 13:26, Dave Young wrote:
> On 07/11/18 at 04:41pm, AKASHI Takahiro wrote:
>> Memblock list is another source for usable system memory layout.
>> So powerpc's arch_kexec_walk_mem() is moved to kexec_file.c so that
>> other memblock-based architectures, particularly arm64, can also utilise
>> it. A moved function is now renamed to kexec_walk_memblock() and merged
>> into the existing arch_kexec_walk_mem() for general use, either resource
>> list or memblock list.
>>
>> A consequent function will not work for kdump with memblock list, but
>> this will be fixed in the next patch.
> 
> If this breaks something, then it would be good to fold the following
> patch in this patch so that bisect can still work?

This patch is just moving code from arch/powerpc that is generic.
powerpc doesn't support kdump via kexec_file, so nothing is damaged by adding
this new code in the next patch.

arm64 would need this kdump support, but it doesn't use it until patch 11.


Thanks,

James
