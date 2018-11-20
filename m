Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2100C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 06:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586C5208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 06:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FRM5kFND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586C5208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbeKTRHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 12:07:07 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43078 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeKTRHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 12:07:07 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAK6cklY097420;
        Tue, 20 Nov 2018 00:38:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542695926;
        bh=yCojy9y88a1Eah83UeDo37Pgx5KZWNzr0+PU8Hs5keM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FRM5kFNDo0LIc8FSB/3qKELC9jqxsfXXuUC861SFcA/uGfKjIoYPBNoS88tEw5G4p
         NURjdX7qYRio2QsERdwaIeyo6hbu77EIVDX58nOApPFVlZVQrYsztbhCKFKil62INc
         uBnOX/lVjhDP8HvK3Qj3/fa9l3QrcJqDWepuu91M=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAK6ckQT080583
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Nov 2018 00:38:46 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 20
 Nov 2018 00:38:45 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 20 Nov 2018 00:38:46 -0600
Received: from [172.24.218.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAK6cft2030244;
        Tue, 20 Nov 2018 00:38:42 -0600
Subject: Re: [PATCH 1/3] ARM: davinci: define gpio interrupts as separate
 resources
To:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <stable@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>
References: <20181113135051.15308-1-brgl@bgdev.pl>
 <20181113135051.15308-2-brgl@bgdev.pl>
 <c092b014-d5cf-f1ad-de91-6696b05cdf17@ti.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <63ac671f-b202-2533-3878-af16149fbdbb@ti.com>
Date:   Tue, 20 Nov 2018 12:08:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c092b014-d5cf-f1ad-de91-6696b05cdf17@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/2018 2:22 AM, Sekhar Nori wrote:
> On 13/11/18 7:20 PM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Since commit eb3744a2dd01 ("gpio: davinci: Do not assume continuous
>> IRQ numbering") the davinci GPIO driver fails to probe if we boot
>> in legacy mode from any of the board files. Since the driver now
>> expects every interrupt to be defined as a separate resource, split
>> the definition in devices-da8xx.c instead of having a single continuous
>> interrupt range.
>>
>> Fixes: eb3744a2dd01 ("gpio: davinci: Do not assume continuous IRQ numbering")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> There are a number of other boards that need such fixing too. And the
> commit in question does not do a good job of explaining why it was
> needed in the first place. The description  just repeats what can be
> inferred by reading the patch.

Cc Lokesh

Sekhar,

DT explicitly mentions every IRQ number. The patch in discussion
explicitly calls platform_get_irq for all the interrupts which to me is 
the right thing to do as: platform_get_irq--> 
of_irq_get-->irq_create_of_mapping--> sequence is to be done for every IRQ.

k3-am654 definitely will need explicit calls to platform_get_irq as it 
will be involving interrupt router and interrupt numbers need not be 
continuous.

So i do not think reverting the patch is the right idea.

Regards,
Keerthy

> 
> 
>      gpio: davinci: Do not assume continuous IRQ numbering
> 
>      Currently the driver assumes that the interrupts are continuous
>      and does platform_get_irq only once and assumes the rest are continuous,
>      instead call platform_get_irq for all the interrupts and store them
>      in an array for later use.
> 
>      Signed-off-by: Keerthy <j-keerthy@ti.com>
>      Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
>      Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> 
> Can we revert the offending commit instead?
> 
> Thanks,
> Sekhar
> 
