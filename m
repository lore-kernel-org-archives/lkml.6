Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107ADC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 02:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED7E20684
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 02:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED7E20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeKSNPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 08:15:01 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49996 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbeKSNPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 08:15:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3E6D80D;
        Sun, 18 Nov 2018 18:52:52 -0800 (PST)
Received: from [10.162.0.72] (unknown [10.162.0.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EEB93F5A0;
        Sun, 18 Nov 2018 18:52:50 -0800 (PST)
Subject: Re: [PATCH 1/7] node: Link memory nodes to their compute nodes
To:     Keith Busch <keith.busch@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181115135710.GD19286@bombadil.infradead.org>
 <20181115145920.GG11416@localhost.localdomain>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <e0b99866-b98b-3385-d0c9-96d5a1d74a6d@arm.com>
Date:   Mon, 19 Nov 2018 08:22:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181115145920.GG11416@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/2018 08:29 PM, Keith Busch wrote:
> On Thu, Nov 15, 2018 at 05:57:10AM -0800, Matthew Wilcox wrote:
>> On Wed, Nov 14, 2018 at 03:49:14PM -0700, Keith Busch wrote:
>>> Memory-only nodes will often have affinity to a compute node, and
>>> platforms have ways to express that locality relationship.
>>>
>>> A node containing CPUs or other DMA devices that can initiate memory
>>> access are referred to as "memory iniators". A "memory target" is a
>>> node that provides at least one phyiscal address range accessible to a
>>> memory initiator.
>>
>> I think I may be confused here.  If there is _no_ link from node X to
>> node Y, does that mean that node X's CPUs cannot access the memory on
>> node Y?  In my mind, all nodes can access all memory in the system,
>> just not with uniform bandwidth/latency.
> 
> The link is just about which nodes are "local". It's like how nodes have
> a cpulist. Other CPUs not in the node's list can acces that node's memory,
> but the ones in the mask are local, and provide useful optimization hints.
> 
> Would a node mask would be prefered to symlinks?

Having hint for local affinity is definitely a plus but this must provide
the coherency matrix to the user preferably in the form of a nodemask for
each memory target.
