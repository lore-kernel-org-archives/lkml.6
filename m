Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBDAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C71A2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b3U0MEN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404479AbfBNOKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:10:53 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52392 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404363AbfBNOKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:10:53 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1EE9ftD083829;
        Thu, 14 Feb 2019 08:09:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550153381;
        bh=zAnODo8dan1Tq3vxAiXyvXop/CnoTloqocY1b7KMDYQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=b3U0MEN5sK5uZvW3sFmoUA9kwNXT0FFz3qP+OoXy+qQ6nSGlt1FYvWUNzaVva60ld
         DTzn2WTnQRQWwup/o01IsGTfR0Pm7LRdEF8AyCPIzlF2AChMYZNbwLypZs/mEOAzN2
         eRVmitoCUT3sPLoUg5jdsl0K/Q84bOG29E/ktHx0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1EE9fAL067306
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Feb 2019 08:09:41 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 14
 Feb 2019 08:09:40 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 14 Feb 2019 08:09:40 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1EE9aKc006201;
        Thu, 14 Feb 2019 08:09:37 -0600
Subject: Re: [PATCH v3 01/37] input: davinci_keyscan: remove unnecessary
 includes
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20190212103835.7768-1-brgl@bgdev.pl>
 <20190212103835.7768-2-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <5ece9908-86e1-c96e-f6fb-a08261b7f419@ti.com>
Date:   Thu, 14 Feb 2019 19:39:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212103835.7768-2-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Dmitry for his ack

On 12/02/19 4:07 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The mach/ and asm/ includes are not needed in davinci_keyscan, but they
> will cause build problems once we make mach/irqs.h a private header for
> mach-davinci.
> 
> Remove all unused header includes.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/input/keyboard/davinci_keyscan.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/input/keyboard/davinci_keyscan.c b/drivers/input/keyboard/davinci_keyscan.c
> index b20a5d044caa..b4db72f833ca 100644
> --- a/drivers/input/keyboard/davinci_keyscan.c
> +++ b/drivers/input/keyboard/davinci_keyscan.c
> @@ -32,10 +32,6 @@
>  #include <linux/errno.h>
>  #include <linux/slab.h>
>  
> -#include <asm/irq.h>
> -
> -#include <mach/hardware.h>
> -#include <mach/irqs.h>
>  #include <linux/platform_data/keyscan-davinci.h>
>  
>  /* Key scan registers */
> -- 
> 2.20.1
> 

