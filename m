Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD80C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C99020856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xCcOPeCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfAQOXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:23:24 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50288 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfAQOXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:23:24 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0HEN4Ih122041;
        Thu, 17 Jan 2019 08:23:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547734984;
        bh=yYlF0yYzRgm2atfaaMOMxUdIrfbHjXRP2iVMqyQvqUw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xCcOPeCs2eChESF+wGjFMAHN/Hk8M+mxskC4nlcUn/ob1OD8H2XE/I9qq/5KWG8IX
         j7mJ6dC9vn+WD+oOBVS4EQPICRyqP+gSIyjPH3AYnMtjOEAvMCcfL7cT+gWZD/OmLi
         oC2UJ8JqX6vCm0tO6y0rWnS5fJzguyYh1gLje+7s=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0HEN4lG003507
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 08:23:04 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 17
 Jan 2019 08:23:03 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 17 Jan 2019 08:23:03 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0HEN0vi012341;
        Thu, 17 Jan 2019 08:23:00 -0600
Subject: Re: [PATCH 01/17] ARM: dts: da850: fix interrupt numbers for
 clocksource
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <stable@vger.kernel.org>
References: <20190111172134.30147-1-brgl@bgdev.pl>
 <20190111172134.30147-2-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <250a521a-ba07-ba17-83d8-d9ad8f55a460@ti.com>
Date:   Thu, 17 Jan 2019 19:52:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111172134.30147-2-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/19 10:51 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The timer interrupts specified in commit 3652e2741f42 ("ARM: dts:
> da850: Add clocks") are wrong but since the current timer code
> hard-codes them, the bug was never spotted.
> 
> This patch must go into stable since, once we introduce a proper
> clocksource driver, devices with buggy device tree will stop booting.

Is this the case where someone uses device-tree from a stable tree and
kernel from latest mainline?

I have added it to my fixes branch for v5.0 anyway.

Thanks,
Sekhar
