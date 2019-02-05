Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B679C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C709220821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfBELkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:40:39 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40156 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfBELki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:40:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BA0B80D;
        Tue,  5 Feb 2019 03:40:38 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFDC13F675;
        Tue,  5 Feb 2019 03:40:33 -0800 (PST)
Subject: Re: [PATCH 5/5] perf/arm_dsu: Fix CPU hotplug races
To:     robin.murphy@arm.com, will.deacon@arm.com, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, tglx@linutronix.de, bigeasy@linutronix.de
References: <cover.1549299188.git.robin.murphy@arm.com>
 <d376f6bbd5804616b38145780789785b19a37543.1549299188.git.robin.murphy@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <9fcf862c-0d07-cece-852f-6c09128aa0c5@arm.com>
Date:   Tue, 5 Feb 2019 11:40:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d376f6bbd5804616b38145780789785b19a37543.1549299188.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/02/2019 17:09, Robin Murphy wrote:
> Like other system PMUs which associate themselves with an arbitrary CPU
> for housekeeping purposes, arm_dsu has a race between registering the
> hotplug notifier and registering the PMU device, such that the hotplug
> niotifier can potentially fire and attempt to migrate the PMU context
> before the latter is valid. This is easily resolved by inhibiting
> hotplug until both the notifier and PMU device are successfully set up.
> 
> For the same reason, also suppress any synchronous notifier calls in the
> cleanup path if PMU registration fails.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Should we add :

Fixes: commit 7520fa99246dade7ab6 ("perf: ARM DynamIQ Shared Unit PMU support")

Either way:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
