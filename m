Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17403C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D1120821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfBELiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:38:14 -0500
Received: from foss.arm.com ([217.140.101.70]:40112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbfBELiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:38:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32C1C80D;
        Tue,  5 Feb 2019 03:38:14 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58DBE3F675;
        Tue,  5 Feb 2019 03:38:12 -0800 (PST)
Subject: Re: [PATCH 3/5] perf/arm-ccn: Fix CPU hotplug race avoidance
To:     robin.murphy@arm.com, will.deacon@arm.com, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, tglx@linutronix.de, bigeasy@linutronix.de
References: <cover.1549299188.git.robin.murphy@arm.com>
 <d1118e5694694ee40d2e784b2af8745f2d1dce0a.1549299188.git.robin.murphy@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <a09e5e4c-f663-8797-0384-fae493ddf29d@arm.com>
Date:   Tue, 5 Feb 2019 11:38:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d1118e5694694ee40d2e784b2af8745f2d1dce0a.1549299188.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/02/2019 17:09, Robin Murphy wrote:
> Like arm-cci, arm-ccn has the same issue where disabling preemption to
> avoid races between registering the PMU device and the hotplug notifier
> can lead to those operations taking mutexes in an invalid context. Fix
> it the same way by disabling hotplug instead of preemption. Since we
> only ever associate the PMU instance with a single CPU, we can also take
> the opportunity to slightly simplify the hotplug handling to track just
> that CPU number instead of a full cpumask.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Suzuki K Poulse <suzuki.poulose@arm.com>
