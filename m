Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2215C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B4421901
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390215AbfBMKw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:52:26 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:24171 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729685AbfBMKwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:52:25 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DAg5d6024997;
        Wed, 13 Feb 2019 11:51:48 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qhv0m6nkc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 13 Feb 2019 11:51:47 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 85E553D;
        Wed, 13 Feb 2019 10:51:46 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5F67C4EE6;
        Wed, 13 Feb 2019 10:51:46 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.51) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 13 Feb
 2019 11:51:45 +0100
Subject: Re: [PATCH v2 3/3] pwm: core: add consumer device link
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <tduszyns@gmail.com>, <mark.rutland@arm.com>,
        <alexandre.torgue@st.com>, <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1549901522-15071-1-git-send-email-fabrice.gasnier@st.com>
 <1549901522-15071-4-git-send-email-fabrice.gasnier@st.com>
 <20190211190628.eisyi6wjus4ltrrn@pengutronix.de>
 <b9f1bb5c-36cd-f6e6-e6c6-a0257cf38b7e@st.com>
 <20190212090304.3j4iqj6sodtdvhr7@pengutronix.de>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <72cab2a3-976a-44c6-5596-fd4e443ff2e8@st.com>
Date:   Wed, 13 Feb 2019 11:51:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212090304.3j4iqj6sodtdvhr7@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 10:03 AM, Uwe Kleine-König wrote:
> Hello Fabrice,
> 
> On Tue, Feb 12, 2019 at 09:31:37AM +0100, Fabrice Gasnier wrote:
>> On 2/11/19 8:06 PM, Uwe Kleine-König wrote:
>>> On Mon, Feb 11, 2019 at 05:12:02PM +0100, Fabrice Gasnier wrote:
>>>> @@ -943,6 +950,8 @@ struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
>>>>  	if (!IS_ERR(pwm)) {
>>>>  		*ptr = pwm;
>>>>  		devres_add(dev, ptr);
>>>> +		device_link_add(dev, pwm->chip->dev,
>>>> +				DL_FLAG_AUTOREMOVE_CONSUMER);
>>>
>>> IMHO it's surprising that devm_of_pwm_get() does more than of_pwm_get()
>>> + devres stuff. I'd put device_link_add() into of_pwm_get().
>>
>> Hi Uwe,
>>
>> I also agree with this. But I think this implies modifying the API for
>> of_pwm_get():
>>  /**
>>   * of_pwm_get() - request a PWM via the PWM framework
>> + * @dev: device for PWM consumer
>>   * @np: device node to get the PWM from
>>   * @con_id: consumer name
>>
>> It seems there aren't much of_pwm_get() users currently.
>> Does this look sensible ?
> 
> In my eyes this looks sensible, yes.

Hello Uwe,

I just sent a v3 with that change,

Thanks
Fabrice
> 
> Best regards
> Uwe
> 
