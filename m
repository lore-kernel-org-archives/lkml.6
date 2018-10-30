Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3EAC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC45D205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC45D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeJ3Wd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:33:59 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51892 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbeJ3Wd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:33:59 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9UDeI1x058507;
        Tue, 30 Oct 2018 08:40:18 -0500
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9UDeIaL088424
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Oct 2018 08:40:18 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 30
 Oct 2018 08:40:18 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 30 Oct 2018 08:40:18 -0500
Received: from [172.22.172.64] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9UDeIbU015015;
        Tue, 30 Oct 2018 08:40:18 -0500
Subject: Re: [PATCH v4 2/7] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
To:     Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
CC:     Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <lee.jones@linaro.org>, <tony@atomide.com>
References: <20181023170623.31820-1-dmurphy@ti.com>
 <20181023170623.31820-2-dmurphy@ti.com> <20181024090421.GB24997@amd>
 <e8800c2e-8ada-7a0d-c1a6-14ddcbe1576d@ti.com> <20181024145434.GC9327@bogus>
 <beb1a6e1-8120-be94-b1a4-60ea6721765d@ti.com>
 <ade3121a-58ab-c0c3-6605-cf7d6a638da0@gmail.com> <20181026083703.GB19434@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <bdb73aa2-60d9-3356-f934-091f738e20a0@ti.com>
Date:   Tue, 30 Oct 2018 08:40:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181026083703.GB19434@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All

On 10/26/2018 03:37 AM, Pavel Machek wrote:
> Hi!
> 
>>> Do you have an opinion on this?
>>
>> This is this problem with the Device Tree's scope of responsibility.
>> It is defined as a means for "describing the hardware", but often
>> this rule is abused by the properties that fall into "configuration"
>> category. E.g. default-state, retain-state-suspended from leds-gpio.txt
>> or linux-default-trigger from common LED bindings.
> 
> "retain-state-suspended" is actually hardware property. On PCs,
> (most?) LEDs will go off in suspend. On android phones, LEDs stay on
> while suspended.
> 
> "linux-default-trigger" is actually kind-of hardware property, too. If
> LED has an icon near it (or on it), you want to use that LED in that
> meaning.
> 
> (Thinkpad X60 has "wifi", "bluetooth", "numlock", "capslock", "hdd",
> "power", "battery", "ac" and "sleep" leds. Surely we should use them
> in that meaning?)
> 
> Now, if someone has leds labeled "user 1..user 4" and uses
> "linux-default-trigger" there, that is kind of "more interesting".
> 
> "default-state" is similar (subset of "linux-default-trigger"); you
> don't want power LED to go off during kernel boot...


I just want to follow up here and let you know that I have not abandoned this.
I am trying to rework and fix up the ti lmu binding as asked by Pavel.  Its proving
to be a bit of a challenge based on looking forward to what will be the implementation.

I also did go offline and speak with Tony.  I have a Droid 4 so I can test all of this on
production hardware as well.

Updated patchset will take some time to get out.

Dan

> 
> 								Pavel
> 


-- 
------------------
Dan Murphy
