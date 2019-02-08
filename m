Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD7FC282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF732146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qp5Lk+Fd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfBHNKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:10:45 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35836 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfBHNKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:10:44 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x18D9CMd023141;
        Fri, 8 Feb 2019 07:09:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549631352;
        bh=O8g8S2kcSDX2YUP4kXKQs1K4athPkpJdPZuH4Q8eASE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qp5Lk+FdDR5Ta3QPuiOMnWGc/Zswe0e9RwkT3y1CFx1V1vaNwAKefghnurpCI/Bmg
         PXhWymeQxe40wqM+4o6SjSAL0Ky0pEKVmllHBCWCKJmWhZ2HGS7Kqgf5qWcoPut8vB
         kJYTVU/YnIuSSItfUQ6B1Q2rswRQPKUgL4b7qnTc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x18D9CWM040537
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Feb 2019 07:09:12 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Feb 2019 07:09:11 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Feb 2019 07:09:11 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x18D97tR005676;
        Fri, 8 Feb 2019 07:09:08 -0600
Subject: Re: [PATCH v2 01/12] ARM: dts: da850: fix interrupt numbers for
 clocksource
To:     David Lechner <david@lechnology.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>, <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190204171757.32073-1-brgl@bgdev.pl>
 <20190204171757.32073-2-brgl@bgdev.pl>
 <ce4c305e-7d76-6028-07e4-4922f3c700bf@lechnology.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <4325c375-0519-7775-e4a9-8bd70aa59f94@ti.com>
Date:   Fri, 8 Feb 2019 18:39:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ce4c305e-7d76-6028-07e4-4922f3c700bf@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/19 6:48 AM, David Lechner wrote:
> On 2/4/19 11:17 AM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> The timer interrupts specified in commit 3652e2741f42 ("ARM: dts:
>> da850: Add clocks") are wrong but since the current timer code
>> hard-codes them, the bug was never spotted.
>>
>> This patch must go into stable since, once we introduce a proper
>> clocksource driver, devices with buggy device tree will stop booting.
>>
>> Fixes: 3652e2741f42 ("ARM: dts: da850: Add clocks")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
> 
> Reviewed-by: David Lechner <david@lechnology.com>

This patch is already in ARM SoC. Should be soon in Linus's tree too.

https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/commit/?h=fixes&id=e3966a766865da7ced1dece663697861dd5cf103

Thanks,
Sekhar
