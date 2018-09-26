Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FB9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F2C208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F2C208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbeIZTBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:01:12 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35605 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726915AbeIZTBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:01:11 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8QCi0uc006029;
        Wed, 26 Sep 2018 14:48:17 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mqq3n65nm-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 26 Sep 2018 14:48:16 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 94FE031;
        Wed, 26 Sep 2018 12:48:15 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6D9532C28;
        Wed, 26 Sep 2018 12:48:15 +0000 (GMT)
Received: from [10.201.23.162] (10.75.127.50) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 26 Sep
 2018 14:48:14 +0200
Subject: Re: [PATCH] rpmsg: core: add support to power domains for devices
To:     Suman Anna <s-anna@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Loic Pallardy <loic.pallardy@st.com>
References: <20180615095939.1331-1-srinivas.kandagatla@linaro.org>
 <a80cce14-9e57-32a2-760f-3d29de009f99@ti.com>
 <91dda9df-8074-925d-dcd3-d7c01e6f2363@st.com>
 <9afb010d-397f-2103-6692-bb4ca55b8236@ti.com>
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arnaud.pouliquen@st.com; prefer-encrypt=mutual; keydata=
 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
 8mOik8I/F6EW8XyQAA2P
Message-ID: <4e1b6773-c4da-4638-eee7-2f996d387903@st.com>
Date:   Wed, 26 Sep 2018 14:48:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9afb010d-397f-2103-6692-bb4ca55b8236@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman,


On 09/25/2018 09:02 PM, Suman Anna wrote:
> Hi Arnaud,
> 
>> On 09/25/2018 02:25 AM, Suman Anna wrote:
>>> Hi Srinivas,
>>>
>>> On 06/15/2018 04:59 AM, Srinivas Kandagatla wrote:
>>>> Some of the rpmsg devices need to switch on power domains to communicate
>>>> with remote processor. For example on Qualcomm DB820c platform LPASS
>>>> power domain needs to switched on for any kind of audio services.
>>>> This patch adds the missing power domain support in rpmsg core.
>>>>
>>>> Without this patch attempting to play audio via QDSP on DB820c would
>>>> reboot the system.
>>>>
>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> ---
>>>>  drivers/rpmsg/rpmsg_core.c | 7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>>>> index b714a543a91d..8122807db380 100644
>>>> --- a/drivers/rpmsg/rpmsg_core.c
>>>> +++ b/drivers/rpmsg/rpmsg_core.c
>>>> @@ -15,6 +15,7 @@
>>>>  #include <linux/module.h>
>>>>  #include <linux/rpmsg.h>
>>>>  #include <linux/of_device.h>
>>>> +#include <linux/pm_domain.h>
>>>>  #include <linux/slab.h>
>>>>  
>>>>  #include "rpmsg_internal.h"
>>>> @@ -449,6 +450,10 @@ static int rpmsg_dev_probe(struct device *dev)
>>>>  	struct rpmsg_endpoint *ept = NULL;
>>>>  	int err;
>>>>  
>>>> +	err = dev_pm_domain_attach(dev, true);
>>>> +	if (err)
>>>> +		goto out;
>>>
>>> This patch has broken the virtio-rpmsg stack based rpmsg devices. These
>>> devices are non-DT and the rpmsg_dev_probe() is now failing with -19
>>> (-ENODEV) error code.
>>>
>>> Loic, Arnaud,
>>> Can one of you double-confirm this behavior on ST platforms as well?
>>> The patch came through 4.14.71 stable release and broke our downstream
>>> kernels.
> 
>> I do not reproduce issue on 4.14.0 + your patch,  on my ST platform (not
>> able to test on the LTS branch).
>> By looking the source code, seems that your issue is related to
>> genpd_dev_pm_attach that returns -ENODEV because you have
>> no remoteproc device node...
>> Do you have a rproc node defined in your DT? we have one.
> 
> The dev here is not the remoteproc dev but the rpmsg device which does
> not have an OF node, and so I get the ENODEV due to the check on
> dev->of_node in genpd_dev_pm_attach. I do have DT remoteproc nodes.
> 
> Are you publishing an rpmsg device from the remote side and are they
> being probed? Issue is seen only during the probe phase, you will not
> see any errors if the rpmsg devices are just being published and created.
Sorry something was wrong in my fw used yesterday for testing...so
forget my previous status.

I re-tested it and I have the same issue (-ENODEV) with rpmsg device
probed on ns announcement rpmsg from remote side.
So we confirm the issue.

Regards
Arnaud

> 
> regards
> Suman
> 
>>
>> Regards
>> Arnaud
>>
>>>
>>> regards
>>> Suman
>>>
>>>> +
>>>>  	if (rpdrv->callback) {
>>>>  		strncpy(chinfo.name, rpdev->id.name, RPMSG_NAME_SIZE);
>>>>  		chinfo.src = rpdev->src;
>>>> @@ -490,6 +495,8 @@ static int rpmsg_dev_remove(struct device *dev)
>>>>  
>>>>  	rpdrv->remove(rpdev);
>>>>  
>>>> +	dev_pm_domain_detach(dev, true);
>>>> +
>>>>  	if (rpdev->ept)
>>>>  		rpmsg_destroy_ept(rpdev->ept);
>>>>  
>>>>
>>>
> 
