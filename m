Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF892C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB04020879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NESg0scH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB04020879
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeLNKjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:39:51 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48684 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNKju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:39:50 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBEAdhKA069478;
        Fri, 14 Dec 2018 04:39:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544783983;
        bh=5kt/e/4oWWM5JI1RT5CpQyyoSLxuOH5sCEbSV3/qNg4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NESg0scHXTIRRfuz4onLlOCnRdlbqx92tHmiSPpp80vtmTlBko18TOL2zO8clBzyf
         ayY20F5DUw2TJ+/9YucouQQXzK+WQh8SmKLsepIfX6/5rq8hPCHrxBfzWx01JovwPw
         Z1nMT9dY+dOJRA3R41Fp7w29IBkkIZ060Pn+Icn8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBEAdhvL079080
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Dec 2018 04:39:43 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 14
 Dec 2018 04:39:42 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 14 Dec 2018 04:39:42 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBEAdc0x028964;
        Fri, 14 Dec 2018 04:39:38 -0600
Subject: Re: [RFC PATCH v2 08/15] usb:cdns3: Implements device operations part
 of the API
To:     Peter Chen <hzpeterchen@gmail.com>, <pawell@cadence.com>
CC:     <rogerq@ti.com>, <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        <adouglas@cadence.com>, <jbergsagel@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>, <balbi@kernel.org>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-9-git-send-email-pawell@cadence.com>
 <5BFE8883.7090802@ti.com>
 <CAL411-oKvu3EADStit=JtbcxVzM_fFGF2uPn67-wmXxPzUK6GQ@mail.gmail.com>
 <6b19b55c-66d7-439e-df8f-7b311b45af5e@ti.com>
 <BYAPR07MB470972A525D85B03C3037D3BDDA60@BYAPR07MB4709.namprd07.prod.outlook.com>
 <CAL411-oc-_0H88egpHsc06ptL12UsaE63rWwjN7novuFFx_qbA@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <5a41de27-cd1f-0cfd-ccdc-dccbf0854fcb@ti.com>
Date:   Fri, 14 Dec 2018 16:09:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAL411-oc-_0H88egpHsc06ptL12UsaE63rWwjN7novuFFx_qbA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/18 7:04 AM, Peter Chen wrote:
> On Wed, Dec 12, 2018 at 3:49 AM Pawel Laszczak <pawell@cadence.com> wrote:
>>
>> Hi,
>>
>>> On 10/12/18 7:42 AM, Peter Chen wrote:
>>>>>> +static struct usb_ep *cdns3_gadget_match_ep(struct usb_gadget *gadget,
>>>>>> +                                         struct usb_endpoint_descriptor *desc,
>>>>>> +                                         struct usb_ss_ep_comp_descriptor *comp_desc)
>>>>>> +{
>>>>>> +     struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
>>>>>> +     struct cdns3_endpoint *priv_ep;
>>>>>> +     unsigned long flags;
>>>>>> +
>>>>>> +     priv_ep = cdns3_find_available_ss_ep(priv_dev, desc);
>>>>>> +     if (IS_ERR(priv_ep)) {
>>>>>> +             dev_err(&priv_dev->dev, "no available ep\n");
>>>>>> +             return NULL;
>>>>>> +     }
>>>>>> +
>>>>>> +     dev_dbg(&priv_dev->dev, "match endpoint: %s\n", priv_ep->name);
>>>>>> +
>>>>>> +     spin_lock_irqsave(&priv_dev->lock, flags);
>>>>>> +     priv_ep->endpoint.desc = desc;
>>>>>> +     priv_ep->dir  = usb_endpoint_dir_in(desc) ? USB_DIR_IN : USB_DIR_OUT;
>>>>>> +     priv_ep->type = usb_endpoint_type(desc);
>>>>>> +
>>>>>> +     list_add_tail(&priv_ep->ep_match_pending_list,
>>>>>> +                   &priv_dev->ep_match_list);
>>>>>> +     spin_unlock_irqrestore(&priv_dev->lock, flags);
>>>>>> +     return &priv_ep->endpoint;
>>>>>> +}
>>>>> Why do you need a custom match_ep?
>>>>> doesn't usb_ep_autoconfig suffice?
>>>>>
>>>>> You can check if EP is claimed or not by checking the ep->claimed flag.
>>>>>
>>>> It is a special requirement for this IP, the EP type and MaxPacketSize
>>>> changing can't be done at runtime, eg, at ep->enable. See below commit
>>>> for detail.
>>>>
>>>>     usb: cdns3: gadget: configure all endpoints before set configuration
>>>>
>>>>     Cadence IP has one limitation that all endpoints must be configured
>>>>     (Type & MaxPacketSize) before setting configuration through hardware
>>>>     register, it means we can't change endpoints configuration after
>>>>     set_configuration.
>>>>
>>>>     In this patch, we add non-control endpoint through usb_ss->ep_match_list,
>>>>     which is added when the gadget driver uses usb_ep_autoconfig to configure
>>>>     specific endpoint; When the udc driver receives set_configurion request,
>>>>     it goes through usb_ss->ep_match_list, and configure all endpoints
>>>>     accordingly.
>>>>
>>>>     At usb_ep_ops.enable/disable, we only enable and disable endpoint through
>>>>     ep_cfg register which can be changed after set_configuration, and do
>>>>     some software operation accordingly.
>>>
>>> All this should be part of comments in code along with information about
>>> controller versions which suffer from the errata.
>>>
>>> Is there a version of controller available which does not have the
>>> defect? Is there a future plan to fix this?
>>>
>>> If any of that is yes, you probably want to handle this with runtime
>>> detection of version (like done with DWC3_REVISION_XXX macros).
>>> Sometimes the hardware-read versions themselves are incorrect, so its
>>> better to introduce a version specific compatible too like
>>> "cdns,usb-1.0.0" (as hinted to by Rob Herring as well).
>>>
>>
>> custom match_ep is used and works with all versions of the gen1
>> controller. Future (gen2) releases of the controller won’t have such
>> limitation but there is no plan to change current (gen1) functionality
>> of the controller.
>>
>> I will add comment before cdns3_gadget_match_ep function.
>> Also I will change cdns,usb3 to cdns,usb3-1.0.0 and add additional
>> cdns,usb3-1.0.1 compatible.
>>
>> cdns,usb3-1.0.1 will be for current version of controller which I use.
>> cdns,usb3-1.0.0 will be for older version - Peter Chan platform.
>> I now that I have some changes in controller, and one of them require
>> some changes in DRD driver. It will be safer to add two separate
>> version in compatibles.
>>
> 
> Pawel, could we have correct register to show controller version? It is
> better we could version judgement at runtime instead of static compatible.

Agree with detecting IP version at runtime.

But please have some indication of version in compatible string too,
especially since you already know there is going to be another revision
of hardware. It has the advantage that one can easily grep to see which
hardware is running current version of controller without having access
to the hardware itself. Becomes useful later on when its time to
clean-up unused code when boards become obsolete or for requesting
testing help.

Thanks,
Sekhar
