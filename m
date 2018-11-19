Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D48CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022802075B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q91JQnbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022802075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbeKTHR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:17:59 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33860 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730828AbeKTHR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:17:59 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAJKq7Nv049521;
        Mon, 19 Nov 2018 14:52:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542660727;
        bh=5yG1qYrNlzd6S5CxrDCFGyJ+WD7xwK29xjX5saMuE48=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=q91JQnblm/W9niWFyC0rxlL/Dxd92k1aoj7wNdu+WmzguBmPEqFJMPjaP/Te2j1IN
         h4HBQ2tfZyUie2Kx8SL6hWkvYVgEp+tL/nLNb89u8Ca0fGJgpaqsoG1C30dKBehqR2
         9kBl2+PVURiO47muQHUewSZD0P33jTmZTXj1AzVI=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAJKq7C6105457
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 14:52:07 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 19
 Nov 2018 14:52:06 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 19 Nov 2018 14:52:06 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAJKq3mp009291;
        Mon, 19 Nov 2018 14:52:04 -0600
Subject: Re: [PATCH 1/3] ARM: davinci: define gpio interrupts as separate
 resources
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <stable@vger.kernel.org>
References: <20181113135051.15308-1-brgl@bgdev.pl>
 <20181113135051.15308-2-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <c092b014-d5cf-f1ad-de91-6696b05cdf17@ti.com>
Date:   Tue, 20 Nov 2018 02:22:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181113135051.15308-2-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/18 7:20 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Since commit eb3744a2dd01 ("gpio: davinci: Do not assume continuous
> IRQ numbering") the davinci GPIO driver fails to probe if we boot
> in legacy mode from any of the board files. Since the driver now
> expects every interrupt to be defined as a separate resource, split
> the definition in devices-da8xx.c instead of having a single continuous
> interrupt range.
> 
> Fixes: eb3744a2dd01 ("gpio: davinci: Do not assume continuous IRQ numbering")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are a number of other boards that need such fixing too. And the
commit in question does not do a good job of explaining why it was
needed in the first place. The description  just repeats what can be
inferred by reading the patch.


    gpio: davinci: Do not assume continuous IRQ numbering

    Currently the driver assumes that the interrupts are continuous
    and does platform_get_irq only once and assumes the rest are continuous,
    instead call platform_get_irq for all the interrupts and store them
    in an array for later use.

    Signed-off-by: Keerthy <j-keerthy@ti.com>
    Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>


Can we revert the offending commit instead?

Thanks,
Sekhar
