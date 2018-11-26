Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2102C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FDA20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FDA20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeK0CdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:33:19 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40576 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbeK0CdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:33:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A24B351D;
        Mon, 26 Nov 2018 07:38:51 -0800 (PST)
Received: from [10.1.196.73] (unknown [10.1.196.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C77E3F59C;
        Mon, 26 Nov 2018 07:38:49 -0800 (PST)
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
 <b79804b0-32ee-03f9-fa62-a89684d46be6@arm.com>
 <c6abb754-0d82-8739-fe08-24e9402bae75@intel.com>
 <aae34dde-fa70-870a-9b74-fff9e385bfc9@arm.com>
 <f5315662-5c1a-68a3-4d04-21b4b5ca94b1@intel.com>
 <ac942498-8966-6a9b-0e55-c79ae167c679@arm.com>
 <9015e51a-3584-7bb2-cc5e-25b0ec8e5494@intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <1a9e887b-8087-e897-6195-e8df325bd458@arm.com>
Date:   Mon, 26 Nov 2018 21:08:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9015e51a-3584-7bb2-cc5e-25b0ec8e5494@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/2018 12:51 AM, Dave Hansen wrote:
> On 11/22/18 10:42 PM, Anshuman Khandual wrote:
>> Are we willing to go in the direction for inclusion of a new system
>> call, subset of it appears on sysfs etc ? My primary concern is not
>> how the attribute information appears on the sysfs but lack of it's
>> completeness.
> 
> A new system call makes total sense to me.  I have the same concern
> about the completeness of what's exposed in sysfs, I just don't see a
> _route_ to completeness with sysfs itself.  Thus, the minimalist
> approach as a first step.

Okay if we agree on the need for a new specific system call extracting
the superset attribute information MAX_NUMNODES * MAX_NUMNODES * U64
(u64 packs 8 bit values for 8 attributes or something like that) as we
had discussed before, it makes sense to export a subset of it which can
be faster but useful for the user space without going through a system
call. Do you agree on a (system call + sysfs) approach in principle ?
Also sysfs exported information has to be derived from whats available
through the system call not the other way round. Hence the starting
point has to be the system call definition.
