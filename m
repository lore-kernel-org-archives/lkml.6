Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 54BF9C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04732208D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nhsj8Hw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04732208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935150AbeFMRZH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:25:07 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:35726 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754096AbeFMRZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:25:05 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllnx210.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5DHP5eY026083;
        Wed, 13 Jun 2018 12:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528910705;
        bh=XtXT48RQdCF7i4sfJ7LaE+HyeuEiLReYW1lZY0KOU1c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Nhsj8Hw83IKufuTWJhkf+lxGzsirlYALiGVmbh4YIdmiaOj2iOd01NOz+PELcYuHj
         j65Bejq0zW2i48eq2DHbGAeHc3jNd9sJxq0XqbbOFZotSSXbVarnCWfjUig7Xry8NZ
         wi7vvnTNxgtdm3s+4D7cxBDPxHnO9O4b2JI9SGik=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5DHP4Vb011130;
        Wed, 13 Jun 2018 12:25:04 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 13
 Jun 2018 12:25:04 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 13 Jun 2018 12:25:04 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5DHP4iW002835;
        Wed, 13 Jun 2018 12:25:04 -0500
Subject: Re: [PATCH v4 2/2] gpio: davinci: Do not assume continuous IRQ
 numbering
To:     Keerthy <j-keerthy@ti.com>, <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <t-kristo@ti.com>
References: <1528861237-24254-1-git-send-email-j-keerthy@ti.com>
 <1528861237-24254-2-git-send-email-j-keerthy@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <37cadc4b-7fc6-5909-b499-7e747a7ee1cd@ti.com>
Date:   Wed, 13 Jun 2018 12:25:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528861237-24254-2-git-send-email-j-keerthy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2018 10:40 PM, Keerthy wrote:
> Currently the driver assumes that the interrupts are continuous
> and does platform_get_irq only once and assumes the rest are continuous,
> instead call platform_get_irq for all the interrupts and store them
> in an array for later use.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> Tested for GPIO Interrupts on da850-lcdk board.
> 
> Changes in v4:
> 
>    * Corrected the gpio offset calculation from irq number
>      using the lookup.
> 
> Changes in v3:
> 
>    * Changed irqs type from unsigned to int
> 
> Changes in v2:
> 
>    * Extended the logic of using saved IRQs to unbanked IRQs
>      as per Grygorii's suggestion.
> 
>   drivers/gpio/gpio-davinci.c                | 63 ++++++++++++++++++++----------
>   include/linux/platform_data/gpio-davinci.h |  3 +-
>   2 files changed, 44 insertions(+), 22 deletions(-)
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii
