Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA59C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426D9274CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426D9274CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966489AbeF1OJY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:09:24 -0400
Received: from foss.arm.com ([217.140.101.70]:48160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965506AbeF1OJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:09:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7513318A;
        Thu, 28 Jun 2018 07:09:22 -0700 (PDT)
Received: from [10.1.210.28] (unknown [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16C6E3F5AD;
        Thu, 28 Jun 2018 07:09:20 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: Re: [RFC PATCH] arm64: topology: Map PPTT node offset to logic
 physical package id
To:     Jeremy Linton <jeremy.linton@arm.com>,
        Andrew Jones <drjones@redhat.com>
References: <1530177508-15298-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <cb057c6a-0eb4-581e-c259-7a31545e0ae7@arm.com>
 <20180628115748.kprobde6c3joc6ll@kamzik.brq.redhat.com>
 <f9376e47-e2ae-b2f4-db23-07698364f1bb@arm.com>
 <b9b537e7-8f7b-07cc-a99d-bcaa8f5d60d5@arm.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <e5b44e41-6d5b-2587-2628-3bcfbee4e00b@arm.com>
Date:   Thu, 28 Jun 2018 15:09:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <b9b537e7-8f7b-07cc-a99d-bcaa8f5d60d5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/06/18 14:19, Jeremy Linton wrote:
> Hi,
> 
> On 06/28/2018 07:12 AM, Sudeep Holla wrote:

[...]

>>
>> OK sure. I liked the approach in Shunyong's patch. I was thinking if we
>> can avoid the list and dynamic allocation on each addition and make it
>> more simpler.
>>
> 
> This one reads simpler, but yes I agree we should try to avoid the
> dynamic allocation.
> 
> OTOH, I think that dropping the dynamic allocation leads to an algorithm
> that picks a value and replaces all the matches. Which of course is
> Andrew's patch, although I did have to read it a couple times to get a
> grasp how it works. I'm guessing that is due to the fact that he seems
> to have optimized 3 double loops into a single loop with two individual
> nested loops. AKA its probably more efficient than the naive
> implementation, but readability seems to have suffered a bit in the
> initial version he posted. I'm not sure the optimization is worth it,
> but I'm guessing there is a middle ground which makes it more readable.
> 

Completely agree. RFC from Andrew is not so readable and easy to understand.

-- 
Regards,
Sudeep
