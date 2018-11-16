Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE333C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32A9206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32A9206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeKPQjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 11:39:06 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46124 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727353AbeKPQjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 11:39:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67DF980D;
        Thu, 15 Nov 2018 22:28:03 -0800 (PST)
Received: from [10.163.1.1] (unknown [10.163.1.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 943DC3F718;
        Thu, 15 Nov 2018 22:28:00 -0800 (PST)
Subject: Re: [PATCH 0/7] ACPI HMAT memory sysfs representation
To:     Keith Busch <keith.busch@intel.com>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20181114224902.12082-1-keith.busch@intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <1ed406b2-b85f-8e02-1df0-7c39aa21eca9@arm.com>
Date:   Fri, 16 Nov 2018 11:57:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181114224902.12082-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/2018 04:19 AM, Keith Busch wrote:
> This series provides a new sysfs representation for heterogeneous
> system memory.
> 
> The previous series that was specific to HMAT that this series was based
> on was last posted here: https://lkml.org/lkml/2017/12/13/968
> 
> Platforms may provide multiple types of cpu attached system memory. The
> memory ranges for each type may have different characteristics that
> applications may wish to know about when considering what node they want
> their memory allocated from. 
> 
> It had previously been difficult to describe these setups as memory
> rangers were generally lumped into the NUMA node of the CPUs. New
> platform attributes have been created and in use today that describe
> the more complex memory hierarchies that can be created.
> 
> This series first creates new generic APIs under the kernel's node
> representation. These new APIs can be used to create links among local
> memory and compute nodes and export characteristics about the memory
> nodes. Documentation desribing the new representation are provided.
> 
> Finally the series adds a kernel user for these new APIs from parsing
> the ACPI HMAT.

Not able to see the patches from this series either on the list or on the
archive (https://lkml.org/lkml/2018/11/15/331). IIRC last time we discussed
about this and the concern which I raised was in absence of a broader NUMA
rework for multi attribute memory it might not a good idea to settle down
and freeze sysfs interface for the user space. 
