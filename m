Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C6FC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8282247B1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="HQpCVlAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8282247B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934410AbeFVTMC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:12:02 -0400
Received: from mout01.posteo.de ([185.67.36.65]:38462 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934368AbeFVTMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:12:01 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 673A220FCF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 21:11:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1529694719; bh=KtxregzzKBkOWKp8WAZbpARV/DbWhOkGpSPmb6+VfXM=;
        h=Subject:To:Cc:From:Date:From;
        b=HQpCVlAV6ylDxsIN7mDW6e70+ZZV9i0kZWp9ryzI4GvoP6pDcpzCrB2QGt4HzYOI4
         Oq5c+EGCkdHQS6MBSsbMv4ME/m9trhTxkmGCaBAsUkEnbFSM+6a0rvTEGpmjGUryts
         yLaGoruYbolGtK38w06TEQxtHaEkn2lRGF5i085qV8SWA+XX2nGsPy5M/dHJbOieO6
         eMUCIP/SIOJlnrcbUrkLu1+5DWHFR2QHASUHQUWy1V/N/yz1QO9RdqA2ve3agyj5M3
         ZkEMN8lqMlS7f9qYhuM3lyEUaWOzCq7F9lqVq2Q255v3xPknT++z+ZhQLI6POiBbxq
         AfMs+PRFHq7Eg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 41C7V55VJ4z9rxL;
        Fri, 22 Jun 2018 21:11:57 +0200 (CEST)
Subject: Re: [PATCH] staging: rtl8723bs: do not use assignment in if condition
To:     Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20180621182230.27823-1-michael.straube@posteo.de>
 <20180622104007.ob5nt2rip2fu436h@mwanda>
 <d6f21cd91d4e6482b5c5d125607ed75c25e9c7a0.camel@perches.com>
 <20180622105719.pt3lh6fqi2nziqsz@mwanda>
 <28dd699b-3013-c42c-07d5-1117d7ab3622@posteo.de>
 <36a7227189b8c7602dd9ffd21a5369b7029e61f1.camel@perches.com>
From:   Michael Straube <michael.straube@posteo.de>
Message-ID: <2c2a0f79-7970-8c55-6119-189114b279e3@posteo.de>
Date:   Fri, 22 Jun 2018 21:11:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <36a7227189b8c7602dd9ffd21a5369b7029e61f1.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22/18 19:28, Joe Perches wrote:
> On Fri, 2018-06-22 at 14:48 +0200, Michael Straube wrote:
>> On 06/22/18 12:57, Dan Carpenter wrote:
>>> On Fri, Jun 22, 2018 at 03:54:22AM -0700, Joe Perches wrote:
>>>> On Fri, 2018-06-22 at 13:40 +0300, Dan Carpenter wrote:
>>>>> On Thu, Jun 21, 2018 at 08:22:30PM +0200, Michael Straube wrote:
>>>>>> Fix checkpatch error 'do not use assignment in if condition'.
>>>> []
>>>>>> diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
>>>>>> index e55895632921..87a4ced41028 100644
>>>>>> --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
>>>>>> +++ b/
>>>>>> @@ -1181,9 +1181,8 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
>>>>>>    	     (mac[3] == 0xff) && (mac[4] == 0xff) && (mac[5] == 0xff)) ||
>>>>>>    	    ((mac[0] == 0x00) && (mac[1] == 0x00) && (mac[2] == 0x00) &&
>>>>>>    	     (mac[3] == 0x00) && (mac[4] == 0x00) && (mac[5] == 0x00))) {
>>>>
>>>> Should also use is_broadcast_ether_addr and is_zero_ether_addr
>>>>
>>>>>> -		if (np &&
>>>>>> -		    (addr = of_get_property(np, "local-mac-address", &len)) &&
>>>>>> -		    len == ETH_ALEN) {
>>>>>> +		addr = of_get_property(np, "local-mac-address", &len);
>>>>>> +		if (np && addr && len == ETH_ALEN) {
>>>>>
>>>>> You can remove the "np" check.
>>>>>
>>>>> 		if (addr && len == ETH_ALEN) {
>>>>
>>>> It looks more like the rewrite is incorrect
>>>> as np is tested before of_get_property
>>>>
>>>
>>> That's what I was worried about too, but if "np" is NULL then
>>> of_get_property() just returns NULL so it's fine.
>>
>> So it should be this?
>>
>>           if (((mac[0] == 0xff) && (mac[1] == 0xff) && (mac[2] == 0xff) &&
>>                (mac[3] == 0xff) && (mac[4] == 0xff) && (mac[5] == 0xff)) ||
>>               ((mac[0] == 0x00) && (mac[1] == 0x00) && (mac[2] == 0x00) &&
>>                (mac[3] == 0x00) && (mac[4] == 0x00) && (mac[5] == 0x00)) &&
>>               (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac))) {
> 
> No as the mac[] tests are the same as is_<foo>_ether_addr

Ok, I understand now.

> and there's nothing really objectionable about embedding
> the assignment in the if here.
> 
> Output from checkpatch is not gospel and can be ignored
> whenever appropriate.

Ok, good to know.

> 		memcpy(mac_addr, ""\x00\xe0\x4c\x87\x00\x00", ETH_ALEN);
> 
> Although the last memcpy of a fixed mac address could
> probably use eth_random_addr to reduce the likelihood
> of mac address collision so maybe
> 
> 		eth_random_addr(mac_addr);
  
Using a random address would be preffered?


Thanks for your help and patience.
Michael
