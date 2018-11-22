Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269DEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8805208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8805208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405598AbeKWAIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:08:46 -0500
Received: from foss.arm.com ([217.140.101.70]:48522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729285AbeKWAIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:08:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C21AE3622;
        Thu, 22 Nov 2018 05:29:24 -0800 (PST)
Received: from [10.1.26.189] (p8cg001049571a15.cambridge.arm.com [10.1.26.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB0923F5AF;
        Thu, 22 Nov 2018 05:29:22 -0800 (PST)
Subject: Re: [PATCH 4/7] node: Add memory caching attributes
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181114224921.12123-5-keith.busch@intel.com>
 <91698cef-cdcd-5143-884f-3da5536e156f@arm.com>
 <20181119230600.GC26707@localhost.localdomain>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <731533d5-26e1-ade7-1a63-d1f85461d091@arm.com>
Date:   Thu, 22 Nov 2018 18:59:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181119230600.GC26707@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/2018 04:36 AM, Keith Busch wrote:
> On Mon, Nov 19, 2018 at 09:44:00AM +0530, Anshuman Khandual wrote:
>> On 11/15/2018 04:19 AM, Keith Busch wrote:
>>> System memory may have side caches to help improve access speed. While
>>> the system provided cache is transparent to the software accessing
>>> these memory ranges, applications can optimize their own access based
>>> on cache attributes.
>>
>> Cache is not a separate memory attribute. It impacts how the real attributes
>> like bandwidth, latency e.g which are already captured in the previous patch.
>> What is the purpose of adding this as a separate attribute ? Can you explain
>> how this is going to help the user space apart from the hints it has already
>> received with bandwidth, latency etc properties.
> 
> I am not sure I understand the question here. Access bandwidth and latency
> are entirely attributes different than what this patch provides. If the
> system side-caches memory, the associativity, line size, and total size
> can optionally be used by software to improve performance.

Okay but then does this belong to this series which about memory attributes ?
