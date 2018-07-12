Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCF9C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFBD213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DFBD213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeGLL3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:29:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49884 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeGLL3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:29:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07C217A9;
        Thu, 12 Jul 2018 04:20:19 -0700 (PDT)
Received: from [10.1.210.28] (unknown [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61D043F5B1;
        Thu, 12 Jul 2018 04:20:17 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>, catalin.marinas@arm.com,
        jeremy.linton@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: Re: [RFC PATCH] arm64: topology: Map PPTT node offset to logic
 physical package id
To:     Will Deacon <will.deacon@arm.com>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>
References: <1530177508-15298-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <20180712110628.GA16043@arm.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <bf1406d7-66db-c854-2f3e-b0b47c533bad@arm.com>
Date:   Thu, 12 Jul 2018 12:20:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180712110628.GA16043@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 12/07/18 12:06, Will Deacon wrote:
> On Thu, Jun 28, 2018 at 05:18:28PM +0800, Shunyong Yang wrote:

[..]

>>
>> And as long as the nodes with Physical package field set in PPTT keeps
>> the real hardware order, the logic id can map to hardware package id to
>> some extent.
>>
>> Hope to get feedback from you.
> 
> I'm assuming this is no longer needed now that we have queued the series
> from Sudeep?
> 

The series relating to topology/numa that you have queued helps us to
re-introduces numa mask check that was reverted partial in v4.18 and is
not related to the issue reported or addressed by this patch.

However, there's no proper solution to the issue reported in this thread
and the one from Andrew Jones[1]. The only solution is to rely on ACPI
firmware for that instead of trying to fix in OS and we have already
merged the patch to fix that in acpi/pptt.c (Commit 30998033f62a ("ACPI
/ PPTT: use ACPI ID whenever ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set"))

In short, all the know issues are addressed so far and nothing else
needs to be queued for now.

-- 
Regards,
Sudeep

[1]
https://lore.kernel.org/lkml/20180629180308.zdl4taihzv2zwarc@kamzik.brq.redhat.com/T/#t
