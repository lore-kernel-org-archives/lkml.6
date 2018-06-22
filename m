Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B94C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C7C24240
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="phi0K4az"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C7C24240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbeFVMx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:53:56 -0400
Received: from mout01.posteo.de ([185.67.36.65]:40113 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751191AbeFVMxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:53:55 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id EC63C212E3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 14:53:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1529672017; bh=gv5BVZWapw9KKuk+oaQyxAIgt5pHrisEqVAXb/txOS4=;
        h=Subject:To:Cc:From:Date:From;
        b=phi0K4azWXEla1LBSMz9E0f3SLm7DMcQYhpLEO0a2kE2qPpA8irmTdKsJYYSnm6fx
         Sn8k/x4SYW02osrX/9FDalUvNiFbgdi+Hxg1Gk1ciAuAJAfmF74Zz4aWrZYp/EPOhu
         qGIobzxTG2sJr5iFeQN7HeTZaQJRf8z1iCcWdD0SoFrabZfCqXG+/ey88mHmE6oAwf
         vCHxkmUdbgTup+8MSIV8ARvNCkeMra95DNd35yT4Kum+jmKxXhemL+TuYpq1DRCNxE
         /y6oi61/bYVZh8dKt71HDB76qvdNmXDrV/jYOOof9cw05NF8JzhbfZxOnzWKmK2RAK
         d0ZeGFB/NJOpw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 41Byzw1SPMz9rxQ;
        Fri, 22 Jun 2018 14:48:44 +0200 (CEST)
Subject: Re: [PATCH] staging: rtl8723bs: do not use assignment in if condition
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20180621182230.27823-1-michael.straube@posteo.de>
 <20180622104007.ob5nt2rip2fu436h@mwanda>
 <d6f21cd91d4e6482b5c5d125607ed75c25e9c7a0.camel@perches.com>
 <20180622105719.pt3lh6fqi2nziqsz@mwanda>
From:   Michael Straube <michael.straube@posteo.de>
Message-ID: <28dd699b-3013-c42c-07d5-1117d7ab3622@posteo.de>
Date:   Fri, 22 Jun 2018 14:48:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622105719.pt3lh6fqi2nziqsz@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22/18 12:57, Dan Carpenter wrote:
> On Fri, Jun 22, 2018 at 03:54:22AM -0700, Joe Perches wrote:
>> On Fri, 2018-06-22 at 13:40 +0300, Dan Carpenter wrote:
>>> On Thu, Jun 21, 2018 at 08:22:30PM +0200, Michael Straube wrote:
>>>> Fix checkpatch error 'do not use assignment in if condition'.
>> []
>>>> diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
>>>> index e55895632921..87a4ced41028 100644
>>>> --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
>>>> +++ b/
>>>> @@ -1181,9 +1181,8 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
>>>>   	     (mac[3] == 0xff) && (mac[4] == 0xff) && (mac[5] == 0xff)) ||
>>>>   	    ((mac[0] == 0x00) && (mac[1] == 0x00) && (mac[2] == 0x00) &&
>>>>   	     (mac[3] == 0x00) && (mac[4] == 0x00) && (mac[5] == 0x00))) {
>>
>> Should also use is_broadcast_ether_addr and is_zero_ether_addr
>>
>>>> -		if (np &&
>>>> -		    (addr = of_get_property(np, "local-mac-address", &len)) &&
>>>> -		    len == ETH_ALEN) {
>>>> +		addr = of_get_property(np, "local-mac-address", &len);
>>>> +		if (np && addr && len == ETH_ALEN) {
>>>
>>> You can remove the "np" check.
>>>
>>> 		if (addr && len == ETH_ALEN) {
>>
>> It looks more like the rewrite is incorrect
>> as np is tested before of_get_property
>>
> 
> That's what I was worried about too, but if "np" is NULL then
> of_get_property() just returns NULL so it's fine.

So it should be this?

         if (((mac[0] == 0xff) && (mac[1] == 0xff) && (mac[2] == 0xff) &&
              (mac[3] == 0xff) && (mac[4] == 0xff) && (mac[5] == 0xff)) ||
             ((mac[0] == 0x00) && (mac[1] == 0x00) && (mac[2] == 0x00) &&
              (mac[3] == 0x00) && (mac[4] == 0x00) && (mac[5] == 0x00)) &&
             (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac))) {
                 addr = of_get_property(np, "local-mac-address", &len);
                 if (addr && len == ETH_ALEN) {
                         memcpy(mac_addr, addr, ETH_ALEN);
                 } else {
                         mac[0] = 0x00;
                         ...
		}
	}

If yes, I'm not sure how to proceed as these are the very first patches I send.
Should I send a v2 patch with both changes or just a v2 with "np" removed and
another one for adding 'is_broadcast_ether_addr' and 'is_zero_ether_addr' checks?

Regards,
Michael

