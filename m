Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-97873-1523642547-2-16727982335099684337
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523642547; b=KgB7SGOOBROHl8N8jefa9lN5IzNr+9soMLWwp/H0ZV93CHbWTs
    IcksNAfOCYwax0tVHN3jhUv9ztnGdha8Gd3C4VrajfFHNKpc7KuqRYxpHeIBn6lE
    fcmTKOrEHSfYPJNcdmuTo+nmoMuRl4R8ldp8eeOszpxEhJDPUI5aUHbe241VZ2zc
    gtqBx9QErv9Q1QeCDGn5dTwZpZp9ytS90C+REiQJnXQ5+0ULnn9VqCPZqyiH+S/9
    N4Y2bjOau+14f79VZi1ZN5wCANMT+O94BXMFkjtplrnpInWQqycQi0dhgw6q1tM7
    gDJaRLlQjldwqBbaS7ZmHnx4OKLh61sPBzVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523642547;
    bh=tAkvQmAJ0NZqFKp/hHB1SogRpiLU1vazLsjrgj90SVI=; b=H4jf0c5jZzJk
    wWnIStNW1XnXi1LwPUmnF8eXmCtOTMWDUcHiTyALEFW2t4WQFw1WG7swol6wSuvq
    H654CLoivObVd6DmbNboI/XIpe7vO9XvXUzz8vo8ocdZdBHCtXPLER4L9mV2RdyQ
    /TcN97phBeBgBTCXgB2GwVe4lnQPFR3C0fG2E5JLWj9CFEoW4PcpQP9EEiCb1Ysb
    u8BcY12FWaidaPF37KCcqcuGG+xmqsoZeQKaJV9Cp1/jL3IVcaePq3y/fJuLKKn1
    3oH4J72CAgtFDYS+8zOMSYYiGNH8vSukRw5AU5JvrKL/QDvQZiFpidnEFK6/ll6h
    7AtYqqZsOQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=XnPwTGI6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=fV4K5mgu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=XnPwTGI6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=fV4K5mgu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHGKlc34TklLcG0t90+Jxq5tS1/bRTjOZqNS0hjmmi2GfssCCZzkb10o9Jm1OpA+jJ4hLiCrgDyQxc5RKPcFffW0LcJrI9qOnqlsevGiq+pUFN7SQgh4
    +siZgazDDtImNCSj37NZrXSX8o0LYXrPMI1VYK/rlCHdpPkeOns2BQaggftd3vSkuRVhEf5N0ELM7j7wg6F4zyTpd+2l9hoZe014MMsGkPBzUJZwcpJ7DQao
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=LpQP-O61AAAA:8 a=VwQbUJbxAAAA:8 a=FWHfEHzt_SuZZ3cwFa0A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=pioyyrs4ZptJ924tMmac:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750851AbeDMSCN (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 14:02:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44696 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeDMSCM (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 13 Apr 2018 14:02:12 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 56A346072E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v2 2/3] usb: dwc3: Add Qualcomm DWC3 glue driver
To: Jack Pham <jackp@codeaurora.org>
Cc: balbi@kernel.org, robh@kernel.org, andy.gross@linaro.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1523638285-5742-1-git-send-email-mgautam@codeaurora.org>
 <1523638285-5742-3-git-send-email-mgautam@codeaurora.org>
 <20180413173322.GA30306@usblab-sd-06.qualcomm.com>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <076ce053-c51d-0a53-507a-faa7481e8dcc@codeaurora.org>
Date: Fri, 13 Apr 2018 23:32:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413173322.GA30306@usblab-sd-06.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jack,


On 4/13/2018 11:03 PM, Jack Pham wrote:
> Hi Manu,
>
> On Fri, Apr 13, 2018 at 10:21:23PM +0530, Manu Gautam wrote:
>> DWC3 controller on Qualcomm SOCs has a Qscratch wrapper.
>> Some of its uses are described below resulting in need to
>> have a separate glue driver instead of using dwc3-of-simple:
>>  - It exposes register interface to override vbus-override
>>    and lane0-pwr-present signals going to hardware. These
>>    must be updated in peripheral mode for DWC3 if vbus lines
>>    are not connected to hardware block. Otherwise RX termination
>>    in SS mode or DP pull-up is not applied by device controller.
>>  - pwr_events_irq_stat support to check if USB2 PHY is in L2 state
>>    before glue driver proceeds with suspend.
>>  - Support for wakeup interrupts lines that are asserted whenever
>>    there is any wakeup event on USB3 or USB2 bus.
>>  - Support to replace pip3 clock going to DWC3 with utmi clock
>>    for hardware configuration where SSPHY is not used with DWC3.
>>
>> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> <snip>
>
>> +static int dwc3_qcom_register_extcon(struct dwc3_qcom *qcom)
>> +{
>> +	struct device		*dev = qcom->dev;
>> +	struct extcon_dev	*host_edev;
>> +	int			ret;
>> +
>> +	if (!of_property_read_bool(dev->of_node, "extcon"))
>> +		return 0;
>> +
>> +	qcom->edev = extcon_get_edev_by_phandle(dev, 0);
> Are the extcon phandles bound to the glue node? I don't see the
> description in the bindings doc in PATCH 1/3. And if so, would it be
> a duplicate of the child node's extcon binding? Then again, the
> alternative would be to grab it directly from the child (i.e.
> qcom->dwc3->dev.of_node) which I'm not sure is ok to do or not.
>

Yes these are bound to glue node. I missed to add it to documentation, will do
so.
I kept it separate for couple of reasons - one is to not peek too-much into child
node. Another reason is that doing so allows to have extcon in "peripheral"
only mode as well (not just drd mode which is the case with dwc3 core).
It allows to notify h/w when vbus is not there in device mode which IMO is
right thing to do.



-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

