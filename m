Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E2EC7112C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7279020651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7279020651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbeJWBVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:21:41 -0400
Received: from mout.web.de ([212.227.15.14]:37763 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbeJWBVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:21:41 -0400
Received: from [192.168.43.108] ([89.15.236.156]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MIvFp-1gCiqo30LB-002ZC3; Mon, 22
 Oct 2018 19:02:11 +0200
Received: from [192.168.43.108] ([89.15.236.156]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MIvFp-1gCiqo30LB-002ZC3; Mon, 22
 Oct 2018 19:02:11 +0200
Subject: Re: [PATCH] rtc: ds1307: fix ds1339 wakealarm support
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     stable@vger.kernel.org, Andrea Greco <a.greco@4sigma.it>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181022123812.5782-1-smoch@web.de>
 <20181022135757.GQ17341@piout.net>
 <3a6041a9-6fef-c113-5962-caa0a24aca49@web.de>
 <20181022155224.GS17341@piout.net>
From:   Soeren Moch <smoch@web.de>
Message-ID: <b231d7ef-cc42-16d9-756f-cab61d41b04a@web.de>
Date:   Mon, 22 Oct 2018 19:02:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181022155224.GS17341@piout.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Provags-ID: V03:K1:Ip1OQuQS9NFZpAn11jI+zLP6RetjSL7JUlb6RmPh3z+unD/TrBQ
 vbi5dwUYUo8507J0zmMM/uORs/ZxRA1JdqGLj+GhoPxnWNlasipCKC9It+BON/A4o86mlwL
 XQdOXBSOxtKrU+ZVbeJc4tR8Vn5soZ8H+xQ9nFqRSrumEth6juGp7GuBO5KR4J9Vb++QOIp
 svSLdacljb2JcwXgub1aQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M1eBmQlM8+g=:sr/tNT71vwfMfisyAgSgzQ
 cukIgo5lNaPyf11rmVT4uaCjn/zQxR1GMyOH8mzqcK9gA/6BVqoBrw4AVRD+p6KpwXAzGuw4C
 ntUHtExZ+WMJKTwNaYexltXmv7kQ/KQ9qHLMY7ssUeAsl3hlYsz5ySeb6AH54dvscd1Qqdyyl
 G0F3j5bLZN4KCvDYe52gE0vdxKyA2mdRtukPYLGRFK5XSim5b8jXdTdJK+PBnxgWSZWWqOnhn
 ad05c4QpVJylcdYkEV1r0Q5kENSjM9CIN8pjzgB+Cx/2ugmpGprkgBALWNdczzTkv1/HqZHGd
 b88PLXyuXtCgWdIGgroMOBdSjZTj3QPQm0Eekm8fqChH4EzaQPLUeJnC06kPu9sGwuUarlLZI
 GyLL6yYnYQoQhddcsupFh5656iJAZ2axuvTZSBlvBCB17jqhdqnoN1BXBH0rpFgnUwahaUPbB
 +B31tPqHZaBcbUcHUlC11gtWWKK4sA4DuaAwrQanff9Ven3tq/i3HiqT1ZzSekd0V7b55OpY1
 aWWxD7g6BNW93Byr+mMe5v0mO0YYC/2usz1bgy2D6wlsPsXCjvs44HthIc//or0Yh6fxr3tIA
 tVFjYHKd4DDByBDAL+xA88wlwObM5lRllhz63vnt8T60Ea1rY19azGEMUv2SOorhS7KN8DvT9
 5C1VMiKMLzAsTWKCqgFVicsfBoWdvnIEwLCjwnaJAv0BkDashRrGfdqKIgzuNCNs7zaTrCE5y
 6o8H+2OVX6qnntTiwOsObd6wo0nIekYapFwpxgw+6dO4mus1qQAbeWHGYkpckHDTCllNrXjZN
 pOCql2tENr5K8zE1PSGJlt3xPLQfvWH5/W52KBty+/doFuv/eI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 22.10.2018 um 17:52 schrieb Alexandre Belloni:
> On 22/10/2018 16:18:13+0200, Soeren Moch wrote:
>> Hi,
>>
>> Am 22.10.2018 um 15:57 schrieb Alexandre Belloni:
>>> Hello,
>>>
>>> On 22/10/2018 14:38:12+0200, Soeren Moch wrote:
>>>> Commit 51ed73eb998a1c79a2b0e9bed68f75a8a2c93b9b ("rtc: ds1340: Add support
>>>> for trickle charger.") breaks ds1339 wakealarm support by limiting
>>>> accessible registers. Fix this.
>>>>
>>>> Fixes: 51ed73eb998a ("rtc: ds1340: Add support for trickle charger.")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Soeren Moch <smoch@web.de>
>>>> --
>>>> Cc: Andrea Greco <a.greco@4sigma.it>
>>>> Cc: Alessandro Zummo <a.zummo@towertech.it>
>>>> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
>>>> Cc: linux-rtc@vger.kernel.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> ---
>>>>  drivers/rtc/rtc-ds1307.c | 1 -
>>>>  1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
>>>> index 4b2b4627daeb..71396b62dc52 100644
>>>> --- a/drivers/rtc/rtc-ds1307.c
>>>> +++ b/drivers/rtc/rtc-ds1307.c
>>>> @@ -1384,7 +1384,6 @@ static void ds1307_clks_register(struct ds1307 *ds1307)
>>>>  static const struct regmap_config regmap_config = {
>>>>  	.reg_bits = 8,
>>>>  	.val_bits = 8,
>>>> -	.max_register = 0x9,
>>> I would prefer having a different regmap_config for chips that have more
>>> registers. I guess you could put a pointer to a regmap_config in chip_desc.
>>>
>> What looks strange to me, the original patch (according to its
>> description) enabled trickle charger functionality for a single chip.
>> This is something totally different than limiting the register space for
>> all chips that are supported by this driver. So this seems to be an
>> accident to me. And this causes an regression for ds1339, which was
>> supported for years.
>>
>> Are there any advantages for limiting the address space of i2c devices?
> I would think it was done as a facility to debug the feature because
> when max_register is set, regmap will allow you to dump the register
> space.
>
>> If we really need this, can we apply this partial revert as regression
>> fix (also for stable) and implement the address space limitation separately?
>>
> Fine, I'm applying this patch right now.
>
OK, thank you,
Soeren

