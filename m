Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1572C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A40520869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A40520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388784AbeKGAKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:10:35 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59736 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbeKGAKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:10:35 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA6EisSd061067;
        Tue, 6 Nov 2018 08:44:54 -0600
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA6Eis5H087228
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Nov 2018 08:44:54 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 6 Nov
 2018 08:44:54 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 6 Nov 2018 08:44:54 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA6EipJS016928;
        Tue, 6 Nov 2018 08:44:52 -0600
Subject: Re: [RFC PATCH v1 03/14] usb:cdns3: Driver initialization code.
To:     Pawel Laszczak <pawell@cadence.com>, <gregkh@linuxfoundation.org>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
 <1541267487-3664-4-git-send-email-pawell@cadence.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adouglas@cadence.com>, <jbergsagel@ti.com>, <peter.chen@nxp.com>,
        <pjez@cadence.com>, <kurahul@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5BE1A8E3.6000705@ti.com>
Date:   Tue, 6 Nov 2018 16:44:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1541267487-3664-4-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/11/18 19:51, Pawel Laszczak wrote:
> Patch adds core.c and core.h file that implements initialization
> of platform driver and adds function responsible for selecting,
> switching and running appropriate Device/Host mode.
> 
> Patch also adds gadget.c, host.c, gadget-export.h, host-export.h.
> These files contains templates functions used during initialization.
> The implementation will be added in next patches.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/Kconfig         |  20 ++
>  drivers/usb/cdns3/Makefile        |   4 +
>  drivers/usb/cdns3/core.c          | 373 ++++++++++++++++++++++++++++++
>  drivers/usb/cdns3/core.h          |  88 +++++++
>  drivers/usb/cdns3/gadget-export.h |  27 +++
>  drivers/usb/cdns3/gadget.c        |  36 +++
>  drivers/usb/cdns3/host-export.h   |  30 +++
>  drivers/usb/cdns3/host.c          |  28 +++
>  8 files changed, 606 insertions(+)
>  create mode 100644 drivers/usb/cdns3/core.c
>  create mode 100644 drivers/usb/cdns3/core.h
>  create mode 100644 drivers/usb/cdns3/gadget-export.h
>  create mode 100644 drivers/usb/cdns3/gadget.c
>  create mode 100644 drivers/usb/cdns3/host-export.h
>  create mode 100644 drivers/usb/cdns3/host.c
> 


<snip>

> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> new file mode 100644
> index 000000000000..e7159c474308
> --- /dev/null
> +++ b/drivers/usb/cdns3/core.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cadence USBSS DRD Driver.
> + *
> + * Copyright (C) 2017 NXP
> + * Copyright (C) 2018 Cadence.
> + *
> + * Authors: Peter Chen <peter.chen@nxp.com>
> + *          Pawel Laszczak <pawell@cadence.com>
> + */
> +#include <linux/usb/otg.h>
> +
> +#ifndef __LINUX_CDNS3_CORE_H
> +#define __LINUX_CDNS3_CORE_H
> +
> +struct cdns3;
> +enum cdns3_roles {
> +	CDNS3_ROLE_HOST = 0,
> +	CDNS3_ROLE_GADGET,
> +	CDNS3_ROLE_END,
> +	CDNS3_ROLE_OTG,
> +};
> +
> +/**
> + * struct cdns3_role_driver - host/gadget role driver
> + * @start: start this role
> + * @stop: stop this role
> + * @suspend: suspend callback for this role
> + * @resume: resume callback for this role
> + * @irq: irq handler for this role
> + * @name: role name string (host/gadget)
> + */
> +struct cdns3_role_driver {
> +	int (*start)(struct cdns3 *cdns);
> +	void (*stop)(struct cdns3 *cdns);
> +	int (*suspend)(struct cdns3 *cdns, bool do_wakeup);
> +	int (*resume)(struct cdns3 *cdns, bool hibernated);
> +	irqreturn_t (*irq)(struct cdns3 *cdns);

Why does role driver need hook to irq handler?

Can't each driver host or gadget handle it's respective irq
on its own? If the same IRQ line is used it could be requested
as a shared IRQ.

> +	const char *name;
> +};
> +

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
