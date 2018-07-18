Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45421ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96002084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ka7UOZzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96002084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbeGRFlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 01:41:47 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49716 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbeGRFlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 01:41:47 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6I55ZPn130340;
        Wed, 18 Jul 2018 00:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531890335;
        bh=3p6gPd2wuwk7Go+9J4flmz3vH0gnvdcNi+sHWkGdR7g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Ka7UOZzk3p5XoTCyRs3B7cG3tTvWJ3ZEw2+h1HKINW4UncCmIRH4s9XizAe6Rjw5E
         bqcSb62jAZmTMGsraIXx9BgrDU9Vu7NWIONE47miMO2LtjAWlK9x1iXsCv+l7R5teJ
         8F3JmEUZ03SV3mGMYWOFoZPrf08QF2FK3lLtvQyk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6I55ZCw025420;
        Wed, 18 Jul 2018 00:05:35 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 18
 Jul 2018 00:05:35 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 18 Jul 2018 00:05:35 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6I55UKY019676;
        Wed, 18 Jul 2018 00:05:31 -0500
Subject: Re: 4.18.0-rc1-next-20180619 boot failed on beagle board x15
To:     Tony Lindgren <tony@atomide.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Tejun Heo <tj@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        <linux-omap@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, <ssantosh@kernel.org>,
        Olof Johansson <olof@lixom.net>, Tero Kristo <t-kristo@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Samuel Morris <samorris@lexmark.com>
References: <20180620102904.GC112168@atomide.com>
 <d5d57b10-facb-d5f7-ad7f-34afae726756@ti.com>
 <CAFY_6qqDcG7+sp7jawhTjuWHizPR75=HUsRJfGPhEPzVE4f5kg@mail.gmail.com>
 <6c15a753-c4a8-ff89-f5c0-0fd19c817c91@ti.com>
 <CAFY_6qq3=+hMLKr0VtCe-witPtV2LTeBSQb3pwqdzysbyiYtMQ@mail.gmail.com>
 <5206d66d-56d0-2edc-8dd0-00eedbaac3db@ti.com>
 <20180702093243.GO112168@atomide.com>
 <CAFY_6qo83Ui6_xRkuTYZUduUJSK2dLKhzd+B_nQ-XW5ciDH-7A@mail.gmail.com>
 <20180717060808.GW99251@atomide.com>
 <20180717180028.0ba098f6@canb.auug.org.au>
 <20180717080335.GD99251@atomide.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <e89cd39c-766c-c8e0-29fb-94c9428102a9@ti.com>
Date:   Wed, 18 Jul 2018 10:35:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180717080335.GD99251@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday 17 July 2018 01:33 PM, Tony Lindgren wrote:
> * Stephen Rothwell <sfr@canb.auug.org.au> [180717 08:03]:
>> Hi Tony,
>>
>> On Mon, 16 Jul 2018 23:08:08 -0700 Tony Lindgren <tony@atomide.com> wrote:
>>>
>>> The following regression is still pending in next, see below.
>>>
>>> * Samuel Morris <samorris@lexmark.com> [180702 13:35]:
>>>> On Mon, Jul 2, 2018 at 5:32 AM, Tony Lindgren <tony@atomide.com> wrote:  
>>>>> Hi,
>>>>>
>>>>> * Roger Quadros <rogerq@ti.com> [180621 14:56]:  
>>>>>> On 21/06/18 17:31, Samuel Morris wrote:  
>>>>>>> On Thu, Jun 21, 2018 at 3:58 AM, Roger Quadros <rogerq@ti.com> wrote:  
>>>>>>>> +Rafael
>>>>>>>>
>>>>>>>> On 20/06/18 18:30, Samuel Morris wrote:  
>>>>>>>>> On Wed, Jun 20, 2018 at 8:58 AM, Roger Quadros <rogerq@ti.com> wrote:  
>>>>>>>>>> Tony,
>>>>>>>>>>
>>>>>>>>>> On 20/06/18 13:29, Tony Lindgren wrote:  
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> * Naresh Kamboju <naresh.kamboju@linaro.org> [180620 05:55]:  
>>>>>>>>>>>> Linux next (4.18.0-rc1-next-20180619) boot failed on beagle board x15.  
>>>>>>>>>>>
>>>>>>>>>>> Bisect points to commit aece27a2f01b ("ata: ahci_platform: allow disabling of
>>>>>>>>>>> hotplug to save power").
>>>>>>>>>>>
>>>>>>>>>>> Reverting the patch makes things work again. Any ideas what
>>>>>>>>>>> might be going wrong here? Things clearly idle but then there
>>>>>>>>>>> seems to be some register access with clocks disabled.  
>>>>>
>>>>> So this issue is still happening as of next-20180702. Can you guys
>>>>> please revert the commit above while working on a better solution?  
>>>>
>>>> That's fine with me. I'm not very familiar with the process here, does
>>>> this require anything on my end? And would that require the
>>>> accompanying patch to be reverted: "ata: ahci: rpm_put port on
>>>> port_stop to match rpm_get in port_start"? There shouldn't be any
>>>> problem leaving that one in, but I just want to know before submitting
>>>> my next patch set.  
>>>
>>> Well usually the maintainer just reverts the regression causing
>>> patch in the related branch and that's it.
>>>
>>> Stephen, can you please revert in next until we hear back from
>>> Tejun?
>>
>> OK, I have reverted that commit from today.  Please let me know when the
>> problem is fixed in the libata tree ...

Hi Stephen,

Thanks for the revert.

commit 1dcbe5f2c615337cb7d4e13fab198ab716180733
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Tue Jul 17 19:02:59 2018 +1000

With the above top commit i confirm that BEAGLE-X15, AM572X-IDK,
AM574X-IDK, DRA7, DRA72 TI platforms booted to prompt.

Regards,
Keerthy

> 
> Thanks!
> 
> Tony
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
