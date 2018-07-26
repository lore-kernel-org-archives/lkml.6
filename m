Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8519C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED112083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED112083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbeGZOqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:46:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55806 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730175AbeGZOqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:46:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4D7915A2;
        Thu, 26 Jul 2018 06:29:57 -0700 (PDT)
Received: from [10.4.12.116] (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 636043F6A8;
        Thu, 26 Jul 2018 06:29:56 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Wong <WILLW@xilinx.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v2] firmware/psci: add support for SYSTEM_RESET2
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
References: <1525186288-536-1-git-send-email-sudeep.holla@arm.com>
 <1525257003-8608-1-git-send-email-sudeep.holla@arm.com>
 <34a420e1-9d2a-b838-dce2-71de408043da@xilinx.com>
 <3e7235c7-d2c2-29f6-6bec-ae21cb841731@arm.com>
 <0fce3ee6-873e-154f-b61e-546d9da338df@xilinx.com>
 <8b08583c-121f-347a-700a-17b5d7784309@arm.com>
 <d2eaaf6d-01f9-2daa-ea1f-3396e3b93104@xilinx.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <74f80458-2d04-c161-c82d-55739e46e661@arm.com>
Date:   Thu, 26 Jul 2018 14:29:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d2eaaf6d-01f9-2daa-ea1f-3396e3b93104@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Sorry somehow missed this email.

On 19/07/18 11:47, Michal Simek wrote:
> On 9.7.2018 15:21, Sudeep Holla wrote:

[...]

>>
>> I think with efi_reboot, if user execute the command "reboot warm", it
>> will set REBOOT_WARM. I was thinking something similar for psci too. I
>> can drop REBOOT_SOFT if that's not correct.
> 
> Have you found more details about efi_reboot and passing information in
> case of reboot warm?
> 

I was just referring to drivers/firmware/efi/reboot.c- function efi_reboot.

Anyways the function reboot_setup in kernel/reboot.c sets the reboot
mode parsing the string passed by the user(e.g.: warm, cold, hard, gpio,
soft,..etc it just scans the first character TBH)

-- 
Regards,
Sudeep
