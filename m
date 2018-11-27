Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379F6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0242B208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OXSLDTJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0242B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbeK0XI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:08:29 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52358 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbeK0XI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:08:29 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wARCAeJS042039;
        Tue, 27 Nov 2018 06:10:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543320640;
        bh=u+7vsZAf3Bo6cCBerqO/x1IwHIUhj8gZG5b6TujRE1o=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=OXSLDTJS053dwIM4zHfwUz4l/ePm1OS3NLFNaNn08C+sTJKrkDoR29DFN+iNKY6MZ
         n2wR/GSPqvpv1ELTuqmfZOKW110pbN9xzKXIA1n5Y4EXOmVLs2AqZclH9QoCwnn4aA
         6RB4pXrT5B5VDrxYhNHRfyo+3RyfBRZVPd1I6mnc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wARCAeJJ031872
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 06:10:40 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 27
 Nov 2018 06:10:40 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 27 Nov 2018 06:10:40 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wARCAaYW010436;
        Tue, 27 Nov 2018 06:10:37 -0600
Subject: Re: [RFC PATCH v2 05/15] usb:cdns3: Added DRD support
To:     Pawel Laszczak <pawell@cadence.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-6-git-send-email-pawell@cadence.com>
 <5BF8140C.7000605@ti.com>
 <BYAPR07MB470991EB0AE200B6481AEE35DDD70@BYAPR07MB4709.namprd07.prod.outlook.com>
 <BYAPR07MB470901107F1435424D8B0727DDD00@BYAPR07MB4709.namprd07.prod.outlook.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5BFD343C.3010407@ti.com>
Date:   Tue, 27 Nov 2018 14:10:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR07MB470901107F1435424D8B0727DDD00@BYAPR07MB4709.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel,

On 27/11/18 13:29, Pawel Laszczak wrote:
> Hi Roger
> 
>>>> Patch adds supports for detecting Host/Device mode.
>>>> +
>>>> +static int cdns3_otg_get_id(struct cdns3 *cdns)
>>>> +{
>>>> +	int id;
>>>> +
>>>> +	id = readl(&cdns->otg_regs->sts) & OTGSTS_ID_VALUE;
>>>> +	dev_dbg(cdns->dev, "OTG ID: %d", id);
>>>> +	return id;
>>>> +}
>>>> +
>>>> +int cdns3_is_host(struct cdns3 *cdns)
>>>> +{
>>>> +	if (cdns->current_dr_mode == USB_DR_MODE_HOST)
>>>> +		return 1;
>>>
>>> Why do you need this?
>>
>> I assumed that some SoC could have cut DRD /OTG and Device or Host part.
>> In such case the driver cannot be based on ID pin.
>> For only HOST it's not a problem because
>> the standard XHCI driver will be used.  Probably I will remove this fragment.
> 
> I've removed this condition but it is necessary and I've  restored it again. 
> When driver works in only HOST mode then ID is always 0. 
> For current_dr_mode == USB_DR_MODE_HOST driver has to just simple 
> returns 1.  
> current_dr_mode  can be changed from user space depending on dr_mode field. 

OK.

> 
> I have the additional question. Because I have many changes in source code if I should 
> post the next RFC PATCH v3 or should I wait for comments for rest patches ?

I will need a day to review the remaining patches. So maybe it is better to wait?

> 
>>>
>>>> +	else if (cdns->current_dr_mode == USB_DR_MODE_OTG)
>>>> +		if (!cdns3_otg_get_id(cdns))
>>>> +			return 1;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
> Thanks,
> Cheers,
> Pawel
> 

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
