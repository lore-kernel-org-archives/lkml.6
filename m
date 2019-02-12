Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0D7C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3772081B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zJ/3CJwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfBLIW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:22:27 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47144 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfBLIW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:22:26 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1C8MMwZ018051;
        Tue, 12 Feb 2019 02:22:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549959742;
        bh=2o3vTpwb1kX2SiD5UgKPrKFcr4aM/xnh1ySeJCw2uHM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=zJ/3CJwZVyVvEwZzW8MmA9gF/QyMBNHcOtogMYpe7N653XzXPNalVL8QrLM/4gKOG
         lqKrrDT29LCpd5wtPhUGSVEPNaPUn7kfvOqDfhcFWHeXrLnLxRXqLNxKwXc/e9YZLP
         BJi18EBW5JW6SbaCPrKB+RR7j0zxnpdM9gayNo4U=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1C8MMZQ125960
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Feb 2019 02:22:22 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Feb 2019 02:22:22 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Feb 2019 02:22:22 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1C8MJtX016947;
        Tue, 12 Feb 2019 02:22:20 -0600
Subject: Re: [PATCH] ARM: davinci: da850-evm: use GPIO hogs instead of the
 legacy API
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190205094937.18645-1-brgl@bgdev.pl>
 <CACRpkdb+fBGEv9xvvkC=YFMA5BeNNYCXKHFkRy=a_PS5QCCG6w@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <a5c3ddd6-b7f0-d313-3ca0-54ed014858a5@ti.com>
Date:   Tue, 12 Feb 2019 13:52:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdb+fBGEv9xvvkC=YFMA5BeNNYCXKHFkRy=a_PS5QCCG6w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/19 6:11 PM, Linus Walleij wrote:
> On Tue, Feb 5, 2019 at 10:49 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> In order to drop the hard-coded GPIO base values from the davinci GPIO
>> driver's platform data, we first need to get rid of all calls to the
>> legacy GPIO functions. Convert the mdio configuration to hogging the
>> relevant GPIO line in the da850-evm board file.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied to my v5.1/soc branch.

Thanks,
Sekhar
