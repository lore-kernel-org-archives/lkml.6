Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56747C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 19:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DB0204EC
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 19:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fXoHEZ0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DB0204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeIIA2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 20:28:16 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56414 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeIIA2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 20:28:16 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w88JfNaL096671;
        Sat, 8 Sep 2018 14:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536435683;
        bh=M4AbwOVF+EzbeySV6RM5ruffOLRhgMJN/YlhNmis+MY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fXoHEZ0FjZqa/OUewADZu18pje4fKX5BnhcPjZOD29YtH6RY6y8irfpagP7myLNS0
         qzAieWY/MjirW/dYiYKVWurolJQ9ydX4hvK9Hs2wwBNJ6uhQwSLeqeSON5tjpabRv7
         eOVlqXXlPlX6+XgLO/kdXOKgik4goYyJ5MQP/3uU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w88JfNda010494;
        Sat, 8 Sep 2018 14:41:23 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Sat, 8 Sep
 2018 14:41:23 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Sat, 8 Sep 2018 14:41:23 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w88JfMLQ027102;
        Sat, 8 Sep 2018 14:41:22 -0500
Subject: Re: [PATCH 2/5] gpio: davinci: Use dev name for label and automatic
 base selection
To:     Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     "Andrew F. Davis" <afd@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180831191326.25106-1-afd@ti.com>
 <20180831191326.25106-2-afd@ti.com>
 <2a02c241-ac91-1bac-380d-122858bb03c3@ti.com>
 <CACRpkdYvNeKyfRf5Et5zC4=hcu9cfDubftRFRHtrKLN-5Snd1Q@mail.gmail.com>
 <040ce524-f6e2-81a2-68db-57a645de22ea@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <0e199aa3-2d9d-4e7d-af23-8523722f017a@ti.com>
Date:   Sat, 8 Sep 2018 14:41:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <040ce524-f6e2-81a2-68db-57a645de22ea@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2018 09:16 AM, Keerthy wrote:
> 
> 
> On Wednesday 05 September 2018 04:07 PM, Linus Walleij wrote:
>> On Mon, Sep 3, 2018 at 7:40 AM Keerthy <j-keerthy@ti.com> wrote:
>>> On Saturday 01 September 2018 12:43 AM, Andrew F. Davis wrote:
>>>> Use dev_name to get a unique label and use -1 for a base to get our
>>>> selection automatically. We pull in all GPIOs per chip now so this
>>>> does not have the effect of out of order labels like before.
>>>>
>>>> We do these both together so we can drop all the static data in one
>>>> patch. This also lets us normalize the return paths as we don't need
>>>> any cleanup after this change.
>>>
>>> echo 28 > /sys/class/gpio/export
>>> / # echo 28 > /sys/class/gpi[   12.839205] export_store: invalid GPIO 28
>>> o/export
>>> echo 2 > /sys/class/gp[   22.165728] export_store: invalid GPIO 2
>>> io/export
>>> / # echo 1 > /sys/class/gp[   25.961392] export_store: invalid GPIO 1
>>> io/export
>>> / # echo 3 > /sys/class/gp[   29.981918] export_store: invalid GPIO 3
>>> io/export
>>>
>>> Export fails with this patch. I am testing this on keystone-k2g-evm.
>>
>> I think the GPIO got a new number didn't it?
>>
>> Did you check the gpio file in debugfs to see which number
>> it got.
> 
> Okay now its numbered differently:
> 
> cat /sys/class/gpio/gpiochip340/ngpio
> 144
> 
> cat /sys/class/gpio/gpiochip272/ngpio
> 68

could you or Andrew provide content of /debug/gpio before/after?
And ls /sys/class/gpio/?
> 
> So gpio bank2 and bank1 have different gpio numbers. Is that acceptable?
> 
>>
>> This is sadly the global numberspace that we are tying to
>> get rid of (new apps/scripts should use the chardev).
>>
>> Are there applications that rely on the sysfs ABI on DaVinci?
>>
>> In that case base needs to be prerseved.

Not only base, but label also - /sys/class/gpio/gpiochip0/label, as this is
the way to find proper GPIO chip in sysfs using legacy GPIO ABI.

Linus, this platform is old and most of the users do not use new ABI (chardev),
so we could try change this, but need to be prepared for regressions reports.

-- 
regards,
-grygorii
