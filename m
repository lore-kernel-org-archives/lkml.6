Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC42C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409D72241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409D72241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbeKLVkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:40:19 -0500
Received: from foss.arm.com ([217.140.101.70]:34300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728302AbeKLVkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:40:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9271E80D;
        Mon, 12 Nov 2018 03:47:24 -0800 (PST)
Received: from [10.163.1.201] (unknown [10.163.1.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0D023F5A0;
        Mon, 12 Nov 2018 03:47:19 -0800 (PST)
Subject: Re: [RFC] mm: Replace all open encodings for NUMA_NO_NODE
To:     Hans Verkuil <hverkuil@xs4all.nl>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     ocfs2-devel@oss.oracle.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-media@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-rdma@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-block@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-alpha@vger.kernel.org
References: <1541990515-11670-1-git-send-email-anshuman.khandual@arm.com>
 <de754de5-cdf9-87d2-7ab2-a3630c034121@xs4all.nl>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d947edec-8c5a-78d7-4069-687ac4ad7cb8@arm.com>
Date:   Mon, 12 Nov 2018 17:17:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <de754de5-cdf9-87d2-7ab2-a3630c034121@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/2018 02:13 PM, Hans Verkuil wrote:
> On 11/12/2018 03:41 AM, Anshuman Khandual wrote:
>> At present there are multiple places where invalid node number is encoded
>> as -1. Even though implicitly understood it is always better to have macros
>> in there. Replace these open encodings for an invalid node number with the
>> global macro NUMA_NO_NODE. This helps remove NUMA related assumptions like
>> 'invalid node' from various places redirecting them to a common definition.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Build tested this with multiple cross compiler options like alpha, sparc,
>> arm64, x86, powerpc64le etc with their default config which might not have
>> compiled tested all driver related changes. I will appreciate folks giving
>> this a test in their respective build environment.
>>
>> All these places for replacement were found by running the following grep
>> patterns on the entire kernel code. Please let me know if this might have
>> missed some instances. This might also have replaced some false positives.
>> I will appreciate suggestions, inputs and review.
> The 'node' in the drivers/media and the drivers/video sources has nothing to
> do with numa. It's an index for a framebuffer instead (i.e. the X in /dev/fbX).

Thanks for the input. Will drop the changes there.
