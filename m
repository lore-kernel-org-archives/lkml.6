Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26355C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA084218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="whJWpDHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfBKL4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 06:56:03 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49684 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfBKL4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 06:56:03 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1BBsnQS061107;
        Mon, 11 Feb 2019 05:54:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549886089;
        bh=vQxXiJZZ1F5MCVK783TocOsaPzz5TuS2WCdye/cPx5M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=whJWpDHz9ba97MDOdrgpi4Sr2ANacATMB+iJVknyaMn7dIqgB2uzzOjrUV/z1snvy
         eHqX762Bv6Mo8vvnXxsc3zI0tzXAWjdLtblSGXiaR9ylKCTDlqpWZLVUFTvFtqAhVV
         frOeKiVcCdJUDUj9InFyTf4274Ke3qk+cLaaOk40=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1BBsnWB027909
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Feb 2019 05:54:49 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 11
 Feb 2019 05:54:49 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 11 Feb 2019 05:54:49 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1BBsiIH018724;
        Mon, 11 Feb 2019 05:54:45 -0600
Subject: Re: [PATCH v2 00/33] ARM: davinci: modernize the irq support
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
References: <20190208173458.4801-1-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <50671542-c055-1796-c58e-276ba3d414d0@ti.com>
Date:   Mon, 11 Feb 2019 17:24:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Jason, Marc

Thomas, Jason, Marc,

On 08/02/19 11:04 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This series ports the davinci platform to using SPARSE_IRQ, cleans up
> the irqchip drivers and moves them over to drivers/irqchip.
> 
> The series can be logically split into four parts. The first (1-8) aims
> at introducing support for SPARSE_IRQ. It contains a couple changes
> required for that functionality and the final patch actually selecting
> it.
> 
> Second part (9-19) makes the aintc driver suitable for drivers/irqchip
> and eventually moves it over there.
> 
> Part 3 (20-32) does the same for the cp-intc driver.
> 
> Last patch removes unnecessary code.
> 
> The series has been tested on da850-lcdk (for cp-intc) and
> dm365-evm (for aintc).

With your ack, I would like to try get it merged to v5.1 via ARM SoC tree.

Bartosz, I noticed that Jason and Marc were not originally CCed. You may
have to resend if they don't have the series in their inbox.

Thanks,
Sekhar
