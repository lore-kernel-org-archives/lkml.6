Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5FFC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766452152C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gJu9fZKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766452152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732650AbeITSN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:13:27 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:45402 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730984AbeITSN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:13:27 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0DE6110C10A6;
        Thu, 20 Sep 2018 05:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537446611; bh=6/kqXkQ6hcAqIAfartWIq4CDnupVuzUNvb+Lo3AoL5Y=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=gJu9fZKA7NcyryPdmDymYvTYErGtUVWd3G/cmL3pJryPHOBgMh34C5rRDz0iYRJwi
         VWS7lGXEZF6W6bhNObkTO20jajd/GabN5gjnbQgMnvnvrWlw/Oq/omEHVm4QyOqrK7
         pdAPhDb9KTlgojF/KhhIlkbOfQA+TMiKgK7Umk3umc8sGd3EQotQhZnXF7sEfV1tSV
         QagNjSj3DZv/+FqW/koJtA3XptL9meWKJkSvCiF/tWytTZBQlR/XnLij6nQ31prsaI
         OPhN7OkqZJyF90Zfdyi7yzywzMj3FiluWH5WSBwtz4SE2KfhZ3dQQ7kFLgEooQ72/j
         8/coqa9RIF3mA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2019A3129;
        Thu, 20 Sep 2018 05:30:10 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 20 Sep 2018 05:30:09 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 20 Sep 2018 14:30:08 +0200
Received: from [10.107.25.72] (10.107.25.72) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 20 Sep 2018 14:30:08 +0200
Subject: Re: [V2, 1/5] media: platform: Add a DesignWare folder to have
 Synopsys drivers
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Luis Oliveira <Luis.Oliveira@synopsys.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Joao.Pinto@synopsys.com>, <festevam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>
References: <20180920111648.27000-1-lolivei@synopsys.com>
 <20180920111648.27000-2-lolivei@synopsys.com> <5939502.lGiqCuzIrn@avalon>
From:   Luis Oliveira <Luis.Oliveira@synopsys.com>
Message-ID: <2e28c0fd-d9d9-c78a-3163-536e97a17c9b@synopsys.com>
Date:   Thu, 20 Sep 2018 13:30:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5939502.lGiqCuzIrn@avalon>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.72]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-Sep-18 13:26, Laurent Pinchart wrote:
> Hi Luis,
> 
> Thank you for the patch.
> 
> 
> On Thursday, 20 September 2018 14:16:39 EEST Luis Oliveira wrote:
>> This patch has the intention of make the patch series more clear by creating
>> a dwc folder.
>>
>> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
> 
> No issue with the content, but you should fold this in patch 3/5, it doesn't 
> deserve a patch on its own.
> 

Thank you, I will do that in V3.

>> ---
>> Changelog
>> v2:
>> - Fix Kbuild error with no Makefile present
>>
>>  drivers/media/platform/Kconfig      | 1 +
>>  drivers/media/platform/Makefile     | 3 +++
>>  drivers/media/platform/dwc/Kconfig  | 0
>>  drivers/media/platform/dwc/Makefile | 0
>>  4 files changed, 4 insertions(+)
>>  create mode 100644 drivers/media/platform/dwc/Kconfig
>>  create mode 100644 drivers/media/platform/dwc/Makefile
>>
>> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
>> index f627587..f627a27 100644
>> --- a/drivers/media/platform/Kconfig
>> +++ b/drivers/media/platform/Kconfig
>> @@ -137,6 +137,7 @@ source "drivers/media/platform/am437x/Kconfig"
>>  source "drivers/media/platform/xilinx/Kconfig"
>>  source "drivers/media/platform/rcar-vin/Kconfig"
>>  source "drivers/media/platform/atmel/Kconfig"
>> +source "drivers/media/platform/dwc/Kconfig"
>>
>>  config VIDEO_TI_CAL
>>  	tristate "TI CAL (Camera Adaptation Layer) driver"
>> diff --git a/drivers/media/platform/Makefile
>> b/drivers/media/platform/Makefile index 6ab6200..def2f33 100644
>> --- a/drivers/media/platform/Makefile
>> +++ b/drivers/media/platform/Makefile
>> @@ -98,3 +98,6 @@ obj-$(CONFIG_VIDEO_QCOM_VENUS)		+= qcom/venus/
>>  obj-y					+= meson/
>>
>>  obj-y					+= cros-ec-cec/
>> +
>> +obj-y					+= dwc/
>> +
>> diff --git a/drivers/media/platform/dwc/Kconfig
>> b/drivers/media/platform/dwc/Kconfig new file mode 100644
>> index 0000000..e69de29
>> diff --git a/drivers/media/platform/dwc/Makefile
>> b/drivers/media/platform/dwc/Makefile new file mode 100644
>> index 0000000..e69de29
> 

