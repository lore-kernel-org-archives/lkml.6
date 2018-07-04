Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7285CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF1321719
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF1321719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933370AbeGDJi7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:38:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34324 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932655AbeGDJio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:38:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 927FC80D;
        Wed,  4 Jul 2018 02:38:44 -0700 (PDT)
Received: from [10.1.211.34] (e107155-lin.cambridge.arm.com [10.1.211.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E827C3F5AD;
        Wed,  4 Jul 2018 02:38:41 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] ACPI: bus: match of_device_id using acpi device
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
References: <1530609760-8919-1-git-send-email-srinath.mannam@broadcom.com>
 <CAHp75VfPvCD7xpp73jbya4ONN=wxpVGNpOfNeqZYjfyirms0PA@mail.gmail.com>
 <CABe79T7EeyzKS97zeQ5akoSaZX0=hMgHxw4XkLCQW15eRR=14Q@mail.gmail.com>
 <CAHp75Vef97XB-M=+xUxsGqzgPrADcUmLTLRdWE+PcVxtTQLN4g@mail.gmail.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <8518137d-c859-657e-844f-51720f6ef8dd@arm.com>
Date:   Wed, 4 Jul 2018 10:38:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vef97XB-M=+xUxsGqzgPrADcUmLTLRdWE+PcVxtTQLN4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/07/18 10:32, Andy Shevchenko wrote:
> On Wed, Jul 4, 2018 at 6:37 AM, Srinath Mannam
> <srinath.mannam@broadcom.com> wrote:
>> Hi Sudeep, Andy,
>>
>> Yes, This patch is to get of_device_id and then fetch data pointer.
>>
>> To add ACPI support in multiple drivers which are device-tree based
>> and has list of of_device_ids, by using this function
>> very minimal changes and can avoid acpi_device_id list in the driver.
>> I will send driver changes where this function used to add ACPI
>> support in following patches.
>>
>> Below are the changes added to add ACPI support in sdhci iproc driver
>> using this function.
> 
> So, did you get an ACPI ID for it?
> That's how proper ACPI support should be done.
> 
> P.S. What you are trying to do is being discussed with Nikolaus in [1].
> I have to NAK your approach in any case. Sorry.
> 

+1 on NACK for this and anything else that abuse PRP0001 as a short cut
approach.

-- 
Regards,
Sudeep
