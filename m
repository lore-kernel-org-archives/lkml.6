Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2741439-1527005272-2-7157857415973174834
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES encaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527005271; b=VQHd76SbbFYH8Hmd9VrMhon9LqpZ4QJ0RXh9teUyXzVQYAATaa
    U1HcbP9g2Hj+bAjZysMG7wSLpuo1sZTHygZbJabgmJOKmrLC0rD7qfVvLD957DeU
    ntJBmsOgT3mPXZzM/jNgtPV0HqhTQiGfRdFTamEXHr116JVsV9NcQfpxwG9/dwgr
    zgS75tVq2swdAH/rRYWwNk6MaZi7jmrRWKGYRAa3OwejQBk5l0U7f/BElg1wfjs5
    UwGa1FGFwPDE0dnzaqo/cE5fBBJvkh/shDrDgluHNwn7wR57BNtunS9e1v7gCbbH
    e/HK4nx7NuFl1udaHICnQaOYYOHkrI/k3PMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527005271;
    bh=rwoLVGuIFoMcMIbz6RvoKeJl2l1EC9iWbIFFH9IxfrU=; b=ahkl1elWZ0pB
    zPfDrG52Ud9hdLfkfitiZX+3da5toJzj7t/mUK/M2OenU/LSnGSyjXUqnY/Dbx1t
    LbmiAjdZsqmxMfvuX3Tu8YHymtFCsnltPdYaW4AM5KgKdgYrO+UKVnNZQ44cN0rG
    5/7kuAjvH7QIB53kdmaLVOvvn8aeZAaVAjQLfWSTRDxjUCLnSDw93RwgWL+4Bqzf
    arOwGz8/bMxzVcfSmFRGqKIc9Aa2Q2VNhZGVF1vaN3seQu6/hpOAVufsmqmbuLkb
    irTLYenFo99BheP9ACv2EXOfGmw1BNFNNAVe6eLB9ZnRvx3UDUHuY762VCLI1yWM
    4ojwX10qpg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=embeddedor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=embeddedor.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=embeddedor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=embeddedor.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJe6f2SSStOPdIF3Sgjp3aDtnHbgLvjbEfIIAIWHV6IVA63wwq6RKfsUXP37uBBjjhPBYjZPQFeQzjzg9BBI3ti0oTFD6FaB/CcZd8BjdIUCxzOqatJ7
    sb5KtMasApwkeqRWZuILIqS8+32yu07k+3PZNwQndgHMP1H5UyY9tDmvGcsR1aR/k5ayq6zTb5CEmbKESXItwGMST9IHirE2mEUSoVEOwAGkaIm0WVs7djf8
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=gu6fZOg2AAAA:8 a=VwQbUJbxAAAA:8 a=_Wotqz80AAAA:8 a=UlQ4DScfP6N8OE9gTPEA:9
    a=JpAviR5mw55x815H:21 a=cZ88cPGEufOtUl1H:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
    a=2RSlZUUhi9gRBrsHwhhZ:22 a=AjGcO6oz07-iQ99wixmX:22 a=buJP51TR1BpY-zbLSsyS:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751600AbeEVQHr (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 12:07:47 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.109]:29717 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751453AbeEVQHr (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 22 May 2018 12:07:47 -0400
X-Authority-Reason: nr=8
Subject: Re: [PATCH v3] usbip: vhci_sysfs: fix potential Spectre v1
To: Shuah Khan <shuah@kernel.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180519011342.GA13962@embeddedgus>
 <8d36b487-4187-4aef-1796-af6d10f357d7@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <c8a2fb3c-5947-5b0a-d271-d3d9cbaebe6c@embeddedor.com>
Date: Tue, 22 May 2018 11:07:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <8d36b487-4187-4aef-1796-af6d10f357d7@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.46.223
X-Source-L: No
X-Exim-ID: 1fL9pB-002XGk-To
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.70]) [187.192.46.223]:54136
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/22/2018 10:56 AM, Shuah Khan wrote:
> On 05/18/2018 07:13 PM, Gustavo A. R. Silva wrote:
>> pdev_nr and rhport can be controlled by user-space, hence leading to
>> a potential exploitation of the Spectre variant 1 vulnerability.
>>
>> This issue was detected with the help of Smatch:
>> drivers/usb/usbip/vhci_sysfs.c:238 detach_store() warn: potential spectre issue 'vhcis'
>> drivers/usb/usbip/vhci_sysfs.c:328 attach_store() warn: potential spectre issue 'vhcis'
>> drivers/usb/usbip/vhci_sysfs.c:338 attach_store() warn: potential spectre issue 'vhci->vhci_hcd_ss->vdev'
>> drivers/usb/usbip/vhci_sysfs.c:340 attach_store() warn: potential spectre issue 'vhci->vhci_hcd_hs->vdev'
>>
>> Fix this by sanitizing pdev_nr and rhport before using them to index
>> vhcis and vhci->vhci_hcd_ss->vdev respectively.
>>
>> Notice that given that speculation windows are large, the policy is
>> to kill the speculation on the first load and not worry if it can be
>> completed with a dependent load/store [1].
>>
>> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>> Changes in v3:
>>   - Pass the addresses of pdev_nr and rhport into valid_port and
>>     valid_args.
>>
>> Changes in v2:
>>   - Place the barriers into valid_port.
>>
>>   drivers/usb/usbip/vhci_sysfs.c | 24 ++++++++++++++++--------
>>   1 file changed, 16 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
>> index 4880838..be37aec 100644
>> --- a/drivers/usb/usbip/vhci_sysfs.c
>> +++ b/drivers/usb/usbip/vhci_sysfs.c
>> @@ -10,6 +10,9 @@
>>   #include <linux/platform_device.h>
>>   #include <linux/slab.h>
>>   
>> +/* Hardening for Spectre-v1 */
>> +#include <linux/nospec.h>
>> +
>>   #include "usbip_common.h"
>>   #include "vhci.h"
>>   
>> @@ -205,16 +208,20 @@ static int vhci_port_disconnect(struct vhci_hcd *vhci_hcd, __u32 rhport)
>>   	return 0;
>>   }
>>   
>> -static int valid_port(__u32 pdev_nr, __u32 rhport)
>> +static int valid_port(__u32 *pdev_nr, __u32 *rhport)
>>   {
>> -	if (pdev_nr >= vhci_num_controllers) {
>> -		pr_err("pdev %u\n", pdev_nr);
>> +	if (*pdev_nr >= vhci_num_controllers) {
>> +		pr_err("pdev %u\n", *pdev_nr);
>>   		return 0;
>>   	}
>> -	if (rhport >= VHCI_HC_PORTS) {
>> -		pr_err("rhport %u\n", rhport);
>> +	*pdev_nr = array_index_nospec(*pdev_nr, vhci_num_controllers);
>> +
>> +	if (*rhport >= VHCI_HC_PORTS) {
>> +		pr_err("rhport %u\n", *rhport);
>>   		return 0;
>>   	}
>> +	*rhport = array_index_nospec(*rhport, VHCI_HC_PORTS);
>> +
>>   	return 1;
>>   }
>>   
>> @@ -232,7 +239,7 @@ static ssize_t detach_store(struct device *dev, struct device_attribute *attr,
>>   	pdev_nr = port_to_pdev_nr(port);
>>   	rhport = port_to_rhport(port);
>>   
>> -	if (!valid_port(pdev_nr, rhport))
>> +	if (!valid_port(&pdev_nr, &rhport))
>>   		return -EINVAL;
>>   
>>   	hcd = platform_get_drvdata(vhcis[pdev_nr].pdev);
>> @@ -258,7 +265,8 @@ static ssize_t detach_store(struct device *dev, struct device_attribute *attr,
>>   }
>>   static DEVICE_ATTR_WO(detach);
>>   
>> -static int valid_args(__u32 pdev_nr, __u32 rhport, enum usb_device_speed speed)
>> +static int valid_args(__u32 *pdev_nr, __u32 *rhport,
>> +		      enum usb_device_speed speed)
>>   {
>>   	if (!valid_port(pdev_nr, rhport)) {
>>   		return 0;
>> @@ -322,7 +330,7 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
>>   			     sockfd, devid, speed);
>>   
>>   	/* check received parameters */
>> -	if (!valid_args(pdev_nr, rhport, speed))
>> +	if (!valid_args(&pdev_nr, &rhport, speed))
>>   		return -EINVAL;
>>   
>>   	hcd = platform_get_drvdata(vhcis[pdev_nr].pdev);
>>
> 
> Looks good to me. Thanks for taking care of this.
> 

Glad to help. :)

> Acked-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
> 

Thanks
--
Gustavo
