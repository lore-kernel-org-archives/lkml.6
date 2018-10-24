Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70BEC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CBF2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IAojDesh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CBF2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeJXU4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 16:56:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51512 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbeJXU4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 16:56:08 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9OCS5dW036806;
        Wed, 24 Oct 2018 07:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540384085;
        bh=mBJpeRxIVEzZXoiuV0nV9XYK5aJeUN49B83+QFiWkFw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IAojDeshNxFNydNvxF0zOmENa1EKoN9KfaaZVezEikyJY+xOCNN0hlyxjv87+GU7I
         O2JmJSaOrq/mrOxBX9uw28HN1rUlfNsXriNc7Av4zEEw2uXfVKmM5YqvHklvvogf+B
         WpPmASqOVVMn0X8FASBbSLJqKtzRnyFlTVjNuRfA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9OCS5pl026469;
        Wed, 24 Oct 2018 07:28:05 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 24
 Oct 2018 07:28:04 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 24 Oct 2018 07:28:04 -0500
Received: from [172.22.136.76] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9OCS47s015545;
        Wed, 24 Oct 2018 07:28:04 -0500
Subject: Re: [PATCH v4 1/7] leds: add TI LMU backlight driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, <lee.jones@linaro.org>,
        <tony@atomide.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
References: <20181023170623.31820-1-dmurphy@ti.com>
 <20181024091407.GC24997@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <4afc7944-d6f1-fef1-1ae4-f761e050fec9@ti.com>
Date:   Wed, 24 Oct 2018 07:27:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181024091407.GC24997@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 10/24/2018 04:14 AM, Pavel Machek wrote:
> On Tue 2018-10-23 12:06:17, Dan Murphy wrote:
>> From: Pavel Machek <pavel@ucw.cz>
>>
>> This adds backlight support for the following TI LMU
>> chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
>>
>> It controls LEDs on Droid 4
>> smartphone, including keyboard and screen backlights.
>>
>> Signed-off-by: Milo Kim <milo.kim@ti.com>
>> [add LED subsystem support for keyboard backlight and rework DT
>> binding according to Rob Herrings feedback]
>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>> [remove backlight subsystem support for now]
>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> This is not correct way to sign off a patch.
> 
> What is worse, this is very different from patch I submitted; this
> misses imporant parts while my patch was complete.
> 
> I already submitted better patch for both the driver and device tree
> bindings. Can we go back and apply that?
> 
> Then you can add your changes on top of that, if they actually make
> the situation better.

Thanks for this.  I wanted to make sure not to loose any authorship or credit
in the commit.  Actually removing Milo might help stop getting the bounce back
from the mail daemon.

I was using the RFC patch as my base https://lore.kernel.org/patchwork/patch/978995/

Which contains this sign off.

Dan

> 
> Thanks,
> 								Pavel
> 


-- 
------------------
Dan Murphy
