Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C77C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC9720660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tkvDiDJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC9720660
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeK1Woq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:44:46 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44872 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbeK1Wop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:44:45 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wASBgwFr121174;
        Wed, 28 Nov 2018 05:42:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543405379;
        bh=VXv9cILKOOhGDrJtZMvfwHZzUytHGlB6auBt90YH7Ug=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tkvDiDJXZHk8pdiixb8LYmTvD151Vx6faN53tv3XuYMgNSZNdWZCvv+n8z33xfD/Q
         Z+vFlnErqkj1MIGo0/OjMleeyzzIkt3umPCzLx/R9RYDViDc4uTsxqizTX3G0DgvZA
         e0rQsTqxSNYEp7ECE5Q1/cGOuBX/BOl5mngnKvHg=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wASBgwDT017724
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Nov 2018 05:42:58 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 28
 Nov 2018 05:42:58 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 28 Nov 2018 05:42:58 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wASBgtTk004794;
        Wed, 28 Nov 2018 05:42:56 -0600
Subject: Re: [PATCH 1/2] mfd: ti_am335x_tscadc: Provide unique name for child
 mfd cells
To:     Lee Jones <lee.jones@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181119064236.28902-1-vigneshr@ti.com>
 <20181119064236.28902-2-vigneshr@ti.com> <20181128090726.GS4272@dell>
 <16f2b753-1fde-3d20-6ddf-5dc5e4f13a15@ti.com> <20181128110321.GG4272@dell>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <30d8df49-f39d-8259-773c-23ebad273e96@ti.com>
Date:   Wed, 28 Nov 2018 17:13:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128110321.GG4272@dell>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/11/18 4:33 PM, Lee Jones wrote:
> On Wed, 28 Nov 2018, Vignesh R wrote:
> 
>> Hi,
>>
>> On 28/11/18 2:37 PM, Lee Jones wrote:
>>> On Mon, 19 Nov 2018, Vignesh R wrote:
>>>
>>>> Provide unique names for child mfd cells, this is required in order to
>>>> support registering of multiple instances of same ti_am335x_tscadc IP.
>>>
>>> I don't think it is.  What is the error you are receiving?
>>
>> W/o this patch I get:
>>
>> [    2.296839] sysfs: cannot create duplicate filename '/bus/platform/devices/TI-am335x-adc'
>> [    2.305085] CPU: 0 PID: 31 Comm: kworker/0:1 Not tainted 4.20.0-rc3-next-20181123-00018-g
>> 7791ce8f123f-dirty #182
>> [    2.315254] Hardware name: Texas Instruments AM654 Base Board (DT)
>> [    2.321447] Workqueue: events deferred_probe_work_func
>> [    2.326585] Call trace:
>> [    2.329036]  dump_backtrace+0x0/0x1c0
>> [    2.332699]  show_stack+0x14/0x20
>> [    2.336017]  dump_stack+0x9c/0xbc
>> [    2.339333]  sysfs_warn_dup+0x60/0x78
>> [    2.342995]  sysfs_do_create_link_sd.isra.0+0xdc/0xe8
>> [    2.348042]  sysfs_create_link+0x20/0x40
>> [    2.351963]  bus_add_device+0x68/0x130
>> [    2.355711]  device_add+0x398/0x618
>> [    2.359199]  platform_device_add+0x120/0x290
>> [    2.363469]  mfd_add_device+0x23c/0x2e8
>> [    2.367302]  mfd_add_devices+0xb4/0x158
>> [    2.371136]  ti_tscadc_probe+0x35c/0x4c8
>> [    2.375056]  platform_drv_probe+0x50/0xa0
>> [    2.379062]  really_probe+0x204/0x2a8
>> [    2.382722]  driver_probe_device+0x58/0x100
>> [    2.386903]  __device_attach_driver+0x98/0xf0
>> [    2.391258]  bus_for_each_drv+0x64/0xc8
>> [    2.395091]  __device_attach+0xd8/0x138
>> [    2.398923]  device_initial_probe+0x10/0x18
>> [    2.403103]  bus_probe_device+0x90/0x98
>> [    2.406938]  deferred_probe_work_func+0x74/0xb0
>> [    2.411470]  process_one_work+0x1e0/0x330
>> [    2.415478]  worker_thread+0x238/0x460
>> [    2.419225]  kthread+0x128/0x130
>> [    2.422452]  ret_from_fork+0x10/0x1c
>> [    2.426195] ti_am3359-tscadc: probe of 40210000.tscadc failed with error -1
> 
> That's because of the way the cells are being registered:
> 
>         err = mfd_add_devices(&pdev->dev, pdev->id, tscadc->cells,
>                 tscadc->used_cells, NULL, 0, NULL);
> 
> The cells are not numbered (tscadc->cells->id is always 0) and you are
> forcing the use of the platform ID from the parent platform device
> (with pdev->id here).  Instead you should s/pdev->id/PLATFORM_DEVID_AUTO/
> or number the cells manually. I suggest the former.
> 

Using PLATFORM_DEVID_AUTO works fine. I will post v2 with this change.
Thanks for the suggestion!

Regards
Vignesh

>>>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>>>> ---
>>>>  drivers/mfd/ti_am335x_tscadc.c | 6 ++++--
>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
>>>> index c2d47d78705b..ee08af34f81d 100644
>>>> --- a/drivers/mfd/ti_am335x_tscadc.c
>>>> +++ b/drivers/mfd/ti_am335x_tscadc.c
>>>> @@ -248,7 +248,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>>>>  	if (tsc_wires > 0) {
>>>>  		tscadc->tsc_cell = tscadc->used_cells;
>>>>  		cell = &tscadc->cells[tscadc->used_cells++];
>>>> -		cell->name = "TI-am335x-tsc";
>>>> +		cell->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s:%s",
>>>> +					    dev_name(&pdev->dev), "tsc");
>>>>  		cell->of_compatible = "ti,am3359-tsc";
>>>>  		cell->platform_data = &tscadc;
>>>>  		cell->pdata_size = sizeof(tscadc);
>>>> @@ -258,7 +259,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>>>>  	if (adc_channels > 0) {
>>>>  		tscadc->adc_cell = tscadc->used_cells;
>>>>  		cell = &tscadc->cells[tscadc->used_cells++];
>>>> -		cell->name = "TI-am335x-adc";
>>>> +		cell->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s:%s",
>>>> +					    dev_name(&pdev->dev), "adc");
>>>>  		cell->of_compatible = "ti,am3359-adc";
>>>>  		cell->platform_data = &tscadc;
>>>>  		cell->pdata_size = sizeof(tscadc);
>>>
>>
> 

-- 
Regards
Vignesh
