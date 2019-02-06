Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D1CC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8452073F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fEBwnflz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfBFIc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 03:32:58 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60112 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfBFIc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 03:32:58 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x168WbXH043870;
        Wed, 6 Feb 2019 02:32:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549441957;
        bh=55Vm7o10kHXiMpFv4hLjmbPzghYmie6WDJqrneSiVFg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fEBwnflz80fppnkleyHm8z6L752afr1qGRLCc6pTI3gLXZcbt1f8WcMJDKHBgTKzU
         ddD84CnkX1ju4WX0NeJ3LCHKEjvgDBRDXnKOs0fPA7ZuC1Oe0H8BgHKrT+SF7ORbKe
         qhmtYIgBY+HYSSAdM0brqmK/ZGK1ljC2d67kFIxc=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x168WbvT064934
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 02:32:37 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 02:32:37 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 02:32:37 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x168WYaT011064;
        Wed, 6 Feb 2019 02:32:34 -0600
Subject: Re: [PATCH 01/35] ARM: davinci: remove intc_host_map from
 davinci_soc_info struct
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-2-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <249deccf-9a22-f4a5-ec6d-721c0d43e596@ti.com>
Date:   Wed, 6 Feb 2019 14:02:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-2-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On 31/01/19 7:08 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This field is not used by any board. Remove it as part of the interrupt
> support cleanup.

Can you please make sure the patch description is independently readable
without the subject line being read first.

For this and some other patches in this series.

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Thanks,
Sekhar
