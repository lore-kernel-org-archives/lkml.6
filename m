Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBE4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4032F20866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BlTGINMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391539AbfAPJTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:19:12 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52920 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731474AbfAPJTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:19:12 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0G9IqXY019762;
        Wed, 16 Jan 2019 03:18:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547630332;
        bh=ryocyKXPtCgerhuVhjnNWhnqnxSZKI0umfj2tX6E/Pk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BlTGINMXH7kUtm5oTXnsACSl7Ge8jzeBE2p3CQ9/OExR8/2Q3ty9Uge+iPxuHfyzK
         PLkMhuL9nk2VQzmPJ+CU/PHEkYi4pIdrFfsIEOXn3OrrA/rKUrDe2oAuWhvCscaBn7
         b7clZ8QFygF1PBQFzGjoXtht6ZzJsLg1yhhqTAzc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0G9Iqlc100133
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 03:18:52 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 03:18:52 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 03:18:52 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0G9ImSb027223;
        Wed, 16 Jan 2019 03:18:49 -0600
Subject: Re: [PATCH 02/17] clocksource: davinci-timer: new driver
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190111172134.30147-1-brgl@bgdev.pl>
 <20190111172134.30147-3-brgl@bgdev.pl>
 <08200de1-fde5-c525-c874-c7872259067b@ti.com>
 <CAMRc=McrT4KTW45=3CTBxspVb+z8k=DDjOvKi9NH0aA9eJ8=cQ@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <a7d4994d-7740-c845-da67-9d06e6d874cc@ti.com>
Date:   Wed, 16 Jan 2019 14:48:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=McrT4KTW45=3CTBxspVb+z8k=DDjOvKi9NH0aA9eJ8=cQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/19 10:09 PM, Bartosz Golaszewski wrote:
> pon., 14 sty 2019 o 13:20 Sekhar Nori <nsekhar@ti.com> napisał(a):
>>
>> Hi Bartosz,
>>
>> On 11/01/19 10:51 PM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> Currently the clocksource and clockevent support for davinci platforms
>>> lives in mach-davinci. It hard-codes many things, used global variables,
>>> implements functionalities unused by any platform and has code fragments
>>> scattered across many (often unrelated) files.
>>>
>>> Implement a new, modern and simplified timer driver and put it into
>>> drivers/clocksource. We still need to support legacy board files so
>>> export a config structure and a function that allows machine code to
>>> register the timer.
>>>
>>> We don't check the return values of regmap reads and writes since with
>>> mmio it's only likely to fail due to programmer's errors.
>>>
>>> We also don't bother freeing resources on errors in
>>> davinci_timer_register() as the system won't boot without a timer anyway.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> With this series, DA830 fails to boot. Rest of the devices are okay from
>> boot perspective.
>>
>> DA830 is pretty unique because it uses the same timer-half for both
>> clocksource and clockevent. May be you can set the same configuration on
>> your DA850 to see the same issue? Else, I will enable low-level debug
>> and try to provide more debug data.
>>
> 
> I can't boot da850 with the same config as da830 (0x60 compare
> register, compare irq 74) even with the old timer code. Just to make
> sure: does da830 boot fine with mainline v5.0-rc2?

Yeah, I did check that without the patch DA830 does boot.

Thanks,
Sekhar
