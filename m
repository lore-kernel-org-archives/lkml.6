Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81101C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A56425E7D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A56425E7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeGBOl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:41:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33636 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752040AbeGBOl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:41:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9269F80D;
        Mon,  2 Jul 2018 07:41:55 -0700 (PDT)
Received: from [192.168.100.244] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB4073F2EA;
        Mon,  2 Jul 2018 07:41:54 -0700 (PDT)
Subject: Re: [PATCH] ACPI/PPTT: use ACPI ID whenever
 ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        shunyong.yang@hxt-semitech.com, yu.zheng@hxt-semitech.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <1530289077-2444-1-git-send-email-sudeep.holla@arm.com>
 <CAJZ5v0gnspK3soa5j8iqU9QDM78MMBbz8YC9s7TOJ5Qwh7=mZg@mail.gmail.com>
 <3895a0d8-9cca-2512-a06e-0ee2ac7db773@arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <45daa83a-08de-24e5-c3de-35046afa33a1@arm.com>
Date:   Mon, 2 Jul 2018 09:41:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3895a0d8-9cca-2512-a06e-0ee2ac7db773@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/02/2018 04:57 AM, Sudeep Holla wrote:
> 
> 
> On 02/07/18 10:06, Rafael J. Wysocki wrote:
>> On Fri, Jun 29, 2018 at 6:17 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> Currently we use the ACPI processor ID only for the leaf/processor nodes
>>> as the specification states it must match the value of ACPI processor ID
>>> field in the processor’s entry in the MADT.
>>>
>>> However, if a PPTT structure represents processors group, it match a
>>> processor container UID in the namespace and ACPI_PPTT_ACPI_PROCESSOR_ID_VALID
>>> flag describe whether the ACPI processor ID is valid.
>>>
>>> Lets use UID whenever ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set to be
>>> consistent instead of using table offset as it's currently done for non
>>> leaf nodes.
>>>
>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>> ---
>>>   drivers/acpi/pptt.c | 10 ++++++++--
>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> Hi,
>>>
>>> There's ongoing discussion on assigning ID based in OS using simple
>>> counters. It can never be consistent with firmware's view. So if the
>>> firmware provides valid UID for non-processors node, we must use it.
>>
>> OK
>>
>> Do you regard this as a fix for the recently merged PPTT material?  If
>> so, I should apply it as a fix for 4.18.
>>
> 
> Yes, it should be considered as fix IMO.

Do we know which machines are affected?

I'm mostly agnostic to this patch because I believe its effectively a 
NOP. But that said, it could have a functional change, which implies 
there is some risk.
