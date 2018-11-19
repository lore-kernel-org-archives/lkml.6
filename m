Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706BFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 05:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CE72086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 05:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CE72086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbeKSQHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 11:07:03 -0500
Received: from foss.arm.com ([217.140.101.70]:50880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeKSQHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 11:07:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 256D71596;
        Sun, 18 Nov 2018 21:44:31 -0800 (PST)
Received: from [10.162.0.72] (unknown [10.162.0.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE1283F5AF;
        Sun, 18 Nov 2018 21:44:28 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 0/7] ACPI HMAT memory sysfs representation
To:     Dave Hansen <dave.hansen@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20181114224902.12082-1-keith.busch@intel.com>
 <1ed406b2-b85f-8e02-1df0-7c39aa21eca9@arm.com>
 <4ea6e80f-80ba-6992-8aa0-5c2d88996af7@intel.com>
Message-ID: <b79804b0-32ee-03f9-fa62-a89684d46be6@arm.com>
Date:   Mon, 19 Nov 2018 11:14:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4ea6e80f-80ba-6992-8aa0-5c2d88996af7@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/2018 10:25 PM, Dave Hansen wrote:
> On 11/15/18 10:27 PM, Anshuman Khandual wrote:
>> Not able to see the patches from this series either on the list or on the
>> archive (https://lkml.org/lkml/2018/11/15/331). IIRC last time we discussed
>> about this and the concern which I raised was in absence of a broader NUMA
>> rework for multi attribute memory it might not a good idea to settle down
>> and freeze sysfs interface for the user space. 
> 

Hello Dave,

> This *is* the broader NUMA rework.  I think it's just a bit more
> incremental that what you originally had in mind.

IIUC NUMA re-work in principle involves these functional changes

1. Enumerating compute and memory nodes in heterogeneous environment (short/medium term)
2. Enumerating memory node attributes as seen from the compute nodes (short/medium term)
3. Changing core MM to accommodate multi attribute memory (long term)

The first two set of changes can get the user space applications
moving by identifying the right nodes and their attributes through
sysfs interface.

> 
> Did you have an alternative for how you wanted this to look?
> 

No. I did not get enough time this year to rework on the original
proposal I had. But will be able to help here to make this interface
more generic, abstract out these properties which is extensible in
the future.

- Anshuman
