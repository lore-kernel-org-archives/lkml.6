Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E79C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67310206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KXPNbbWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67310206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeIJMax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:30:53 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52432 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbeIJMax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:30:53 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8A7bN3J064083;
        Mon, 10 Sep 2018 02:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536565043;
        bh=eQCzSjHEVK3Y9GmvRdYK/tYWtrLeefOa77lFW/VBmJg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KXPNbbWBEU958TlmDTODsI3CkXfVmNghDsVzZ1p7qBZmO2eAH1/xAcPoiaEoTz0L3
         yWvhT1RpVscPMUOIvca8YqGfN9IKnTrN7e01FZfuKTG+LNknq8hzbh6umzMUiWRDn/
         sLI947XI43D35Deg1uu+5wMINe3A1PVtMBVmfqSM=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8A7bNqO028198;
        Mon, 10 Sep 2018 02:37:23 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 10
 Sep 2018 02:37:23 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 10 Sep 2018 02:37:23 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8A7bJEh018294;
        Mon, 10 Sep 2018 02:37:20 -0500
Subject: Re: [PATCH 2/5] gpio: davinci: Use dev name for label and automatic
 base selection
To:     Linus Walleij <linus.walleij@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
CC:     Keerthy <j-keerthy@ti.com>, "Andrew F. Davis" <afd@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180831191326.25106-1-afd@ti.com>
 <20180831191326.25106-2-afd@ti.com>
 <2a02c241-ac91-1bac-380d-122858bb03c3@ti.com>
 <CACRpkdYvNeKyfRf5Et5zC4=hcu9cfDubftRFRHtrKLN-5Snd1Q@mail.gmail.com>
 <040ce524-f6e2-81a2-68db-57a645de22ea@ti.com>
 <0e199aa3-2d9d-4e7d-af23-8523722f017a@ti.com>
 <CACRpkdYcuSpfZ0=UFUOx_-5kaAtCA4=AyXmSMbfrcqjf0r_xmQ@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <b1f74d63-c9e8-2a7f-bd13-8f5fff27fc22@ti.com>
Date:   Mon, 10 Sep 2018 13:07:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdYcuSpfZ0=UFUOx_-5kaAtCA4=AyXmSMbfrcqjf0r_xmQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 September 2018 12:55 PM, Linus Walleij wrote:
> On Sat, Sep 8, 2018 at 9:41 PM Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>> On 09/06/2018 09:16 AM, Keerthy wrote:
> 
>>> Okay now its numbered differently:
>>>
>>> cat /sys/class/gpio/gpiochip340/ngpio
>>> 144
>>>
>>> cat /sys/class/gpio/gpiochip272/ngpio
>>> 68
> (...)
> 
> So:
> 
>>>> Are there applications that rely on the sysfs ABI on DaVinci?
>>>>
>>>> In that case base needs to be prerseved.
>>
>> Not only base, but label also - /sys/class/gpio/gpiochip0/label, as this is
>> the way to find proper GPIO chip in sysfs using legacy GPIO ABI.
>>
>> Linus, this platform is old and most of the users do not use new ABI (chardev),
>> so we could try change this, but need to be prepared for regressions reports.
> 
> So what I'm trying to ask you guys is if there are applications that you
> are aware of that use the old ABI, and who will upgrade their
> kernels and be upset.
> 
> We must not break userspace, but as you know if a tree falls in the
> forest and nobody is there to hear it, it doesn't make a sound.
> 
> If you're not aware of any such applications I guess we should try
> changing this.

Personally I am not really aware of any application which relies on the
ABI. I may have some scripts, but I can adjust them. I am also copying
some frequent users of DaVinci in mainline for any comments from them.

Thanks,
Sekhar
