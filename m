Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADD4C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BEB218D9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfBHJtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:49:25 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32890 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726081AbfBHJtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:49:24 -0500
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 907D3A851F2BD9D4D5A4;
        Fri,  8 Feb 2019 09:49:23 +0000 (GMT)
Received: from [127.0.0.1] (10.202.226.46) by lhreml703-cah.china.huawei.com
 (10.201.108.44) with Microsoft SMTP Server id 14.3.408.0; Fri, 8 Feb 2019
 09:49:16 +0000
Subject: Re: [PATCH] HISI LPC: Don't fail probe for unrecognised child devices
To:     John Garry <john.garry@huawei.com>, <xuwei5@huawei.com>
CC:     <arm@kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <olof@lixom.net>
References: <1546516622-46343-1-git-send-email-john.garry@huawei.com>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <249f851b-e28c-c5df-7706-f7212162bae7@hisilicon.com>
Date:   Fri, 8 Feb 2019 09:49:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1546516622-46343-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 1/3/2019 11:57 AM, John Garry wrote:
> Currently for ACPI-based FW we fail the probe for an unrecognised child
> HID.
> 
> However, there is FW in the field with LPC child devices having fake HIDs,
> namely "IPI0002", which was an IPMI device invented to support the
> initial out-of-tree LPC host driver, different from the final mainline
> version.
> 
> To provide compatibility support for these dodgy FWs, just discard the
> unrecognised HIDs instead of failing the probe altogether.
> 
> Tested-by: Zengruan Ye <yezengruan@huawei.com>
> Signed-off-by: John Garry <john.garry@huawei.com>

Updated the subject as "bus: hisi_lpc: xxx" to follow the style and
applied to the hisilicon tree.
Thanks!

Best Regards,
Wei

> 
> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
> index d5f8545..19d7b6f 100644
> --- a/drivers/bus/hisi_lpc.c
> +++ b/drivers/bus/hisi_lpc.c
> @@ -522,10 +522,9 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
>  
>  		if (!found) {
>  			dev_warn(hostdev,
> -				 "could not find cell for child device (%s)\n",
> +				 "could not find cell for child device (%s), discarding\n",
>  				 hid);
> -			ret = -ENODEV;
> -			goto fail;
> +			continue;
>  		}
>  
>  		pdev = platform_device_alloc(cell->name, PLATFORM_DEVID_AUTO);
> 

