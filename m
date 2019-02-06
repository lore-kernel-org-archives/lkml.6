Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E24C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B532083B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfBFTYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:24:25 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57326 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfBFTYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:24:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F8C680D;
        Wed,  6 Feb 2019 11:24:24 -0800 (PST)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98CEB3F719;
        Wed,  6 Feb 2019 11:24:22 -0800 (PST)
Subject: Re: [PATCH v4 01/12] Documentation: Document arm64 kpti control
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, stefan.wahren@i2se.com,
        Jonathan Corbet <corbet@lwn.net>, mlangsdo@redhat.com,
        linux-doc@vger.kernel.org, suzuki.poulose@arm.com,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        julien.thierry@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, steven.price@arm.com,
        ykaukab@suse.de, dave.martin@arm.com, shankerd@codeaurora.org
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
 <20190125180711.1970973-2-jeremy.linton@arm.com>
 <20190130180247.15ab0577@donnerap.cambridge.arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <69fceac6-7e83-7b38-44fb-2c02245f51df@arm.com>
Date:   Wed, 6 Feb 2019 13:24:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190130180247.15ab0577@donnerap.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I just realized I replied to this off-list.

On 01/30/2019 12:02 PM, Andre Przywara wrote:
> On Fri, 25 Jan 2019 12:07:00 -0600
> Jeremy Linton <jeremy.linton@arm.com> wrote:
> 
> Hi,
> 
>> For a while Arm64 has been capable of force enabling
>> or disabling the kpti mitigations. Lets make sure the
>> documentation reflects that.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>> b/Documentation/admin-guide/kernel-parameters.txt index
>> b799bcf67d7b..9475f02c79da 100644 ---
>> a/Documentation/admin-guide/kernel-parameters.txt +++
>> b/Documentation/admin-guide/kernel-parameters.txt @@ -1982,6 +1982,12
>> @@ Built with CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y,
>>   			the default is off.
>>   
>> +	kpti=		[ARM64] Control page table isolation of
>> user
>> +			and kernel address spaces.
>> +			Default: enabled on cores which need
>> mitigation.
> 
> Would this be a good place to mention that we enable it when
> CONFIG_RANDOMIZE_BASE is enabled and we have a valid kaslr_offset? I
> found this somewhat surprising, also it's unrelated to the
> vulnerability.

Maybe, but I tend to think since this command line forces it on/off 
regardless of RANDOMIZE_BASE, that a better place to mention that 
RANDOMIZE_BASE forces kpti on is the Kconfig option.

BTW: Thanks for reviewing this.


> 
> Cheers,
> Andre
> 
>> +			0: force disabled
>> +			1: force enabled
>> +
>>   	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled
>> MSRs. Default is 0 (don't ignore, but inject #GP)
>>   
> 

