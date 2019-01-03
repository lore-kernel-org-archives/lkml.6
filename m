Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74876C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493B320815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732320AbfACQiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:38:21 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52734 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729598AbfACQiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:38:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0303315AD;
        Thu,  3 Jan 2019 08:38:20 -0800 (PST)
Received: from [192.168.100.243] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC3C43F5D4;
        Thu,  3 Jan 2019 08:38:18 -0800 (PST)
Subject: Re: [PATCH v2 1/7] sysfs/cpu: Add "Unknown" vulnerability state
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, marc.zyngier@arm.com, suzuki.poulose@arm.com,
        dave.martin@arm.com, shankerd@codeaurora.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, ykaukab@suse.de,
        julien.thierry@arm.com, mlangsdo@redhat.com, steven.price@arm.com,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>
References: <20190103004921.1928921-1-jeremy.linton@arm.com>
 <20190103004921.1928921-2-jeremy.linton@arm.com>
 <20190103093858.GA10794@kroah.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <c9e08010-3ca0-cb03-e5ad-ab19342ff63b@arm.com>
Date:   Thu, 3 Jan 2019 10:38:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190103093858.GA10794@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2019 03:38 AM, Greg Kroah-Hartman wrote:
> On Wed, Jan 02, 2019 at 06:49:15PM -0600, Jeremy Linton wrote:
>> There is a lot of variation in the Arm ecosystem. Because of this,
>> there exist possible cases where the kernel cannot authoritatively
>> determine if a machine is vulnerable.
> 
> Really?  Why not?  What keeps you from "knowing" this?  Can't the
> developer of the chip tell you?

There tends to be a few cases, possibly incomplete white/black lists, 
firmware that isn't responding correctly, or the user didn't build in 
the code to check the mitigation (possibly because its an embedded 
system and they know its not vulnerable?).

I would hope that it is an exceptional case.

> 
>> Rather than guess the vulnerability status in cases where
>> the mitigation is disabled or the firmware isn't responding
>> correctly, we need to display an "Unknown" state.
> 
> Shouldn't "Unknown" really be the same thing as "Vulnerable"?  A user
> should treat it the same way, "Unknown" makes it feel like "maybe I can
> just ignore this and hope I really am safe", which is not a good idea at
> all.

I tend to agree its not clear what to do with "unknown".

OTOH, I think there is a hesitation to declare something vulnerable when 
it isn't. Meltdown for example, is fairly rare given that it currently 
only affects a few arm parts, so declaring someone vulnerable when they 
likely aren't is going to be just as difficult to explain.


