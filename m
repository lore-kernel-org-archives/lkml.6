Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183ADC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D888C2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D888C2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeLEA4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:56:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15639 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726031AbeLEA4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:56:45 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 87E0A876B7E6A;
        Wed,  5 Dec 2018 08:56:41 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Wed, 5 Dec 2018
 08:56:32 +0800
CC:     <liuyu712@hisilicon.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 09/12] usb: dwc3: Registering a role switch in the DRD
 code.
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20181203034515.91412-1-chenyu56@huawei.com>
 <20181203034515.91412-10-chenyu56@huawei.com>
 <20181204105416.GA10657@kuha.fi.intel.com>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <3601762f-f013-05f8-4348-d6267b8f1a9b@huawei.com>
Date:   Wed, 5 Dec 2018 08:56:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181204105416.GA10657@kuha.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/12/4 18:54, Heikki Krogerus wrote:
> On Mon, Dec 03, 2018 at 11:45:12AM +0800, Yu Chen wrote:
>> The Type-C drivers use USB role switch API to inform the
>> system about the negotiated data role, so registering a role
>> switch in the DRD code in order to support platforms with
>> USB Type-C connectors.
>>
>> Cc: Felipe Balbi <balbi@kernel.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Yu Chen <chenyu56@huawei.com>
>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>
>> --
>> v0:
>> The patch is provided by Heikki Krogerus. I modified and test it
>> on Hikey960 platform.
>> --
>> ---
>>  drivers/usb/dwc3/core.h |  2 ++
>>  drivers/usb/dwc3/drd.c  | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 51 insertions(+)
> 
> You need to select USB_ROLE_SWITCH in Kconfig:
> 
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 1a0404fda596..3a0cb9f1f38a 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -42,6 +42,7 @@ config USB_DWC3_DUAL_ROLE
>         bool "Dual Role mode"
>         depends on ((USB=y || USB=USB_DWC3) && (USB_GADGET=y || USB_GADGET=USB_DWC3))
>         depends on (EXTCON=y || EXTCON=USB_DWC3)
> +       select USB_ROLE_SWITCH
>         help
>           This is the default mode of working of DWC3 controller where
>           both host and gadget features are enabled.
> 

OK.

Thanks!

