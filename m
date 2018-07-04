Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F20C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1129924732
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CgHkoCrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1129924732
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933274AbeGDGgq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:36:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41394 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752990AbeGDGgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:36:44 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w646ZZMi130969;
        Wed, 4 Jul 2018 01:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530686135;
        bh=1ffa+Jcu6G47eAHvMu2fdD15mC2HBX0p8kKLV9dzkr4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CgHkoCrXlr1lLz0n2sa0sc6UjpQhSIhOlmR5NYez7ac6aUxpCnOPQcUqiKXX2snZR
         jdnJPGb7PUfCEscCn6OQCOaeOWa/5CBa3dn4tbt1BkmprzPKGRrZBSIBd0iPiKZJtw
         G7eRnR8SsYXLYfUrlbDGn19BP2qR2XhWslp2IuDc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w646ZZZb014699;
        Wed, 4 Jul 2018 01:35:35 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 4 Jul
 2018 01:35:35 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 4 Jul 2018 01:35:35 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w646ZU7S003164;
        Wed, 4 Jul 2018 01:35:30 -0500
Subject: Re: [PATCH v3 00/13] ARM: davinci: remove duplicate aemif support
To:     David Lechner <david@lechnology.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180628095748.4462-1-brgl@bgdev.pl>
 <52a274f1-283a-a14a-54f3-4b95b6605c4f@ti.com>
 <59fdc532-bb72-ffae-cfb6-a7f156c14771@lechnology.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <e1222b3c-dfa4-4cb0-eebf-8e2550e9d674@ti.com>
Date:   Wed, 4 Jul 2018 12:05:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <59fdc532-bb72-ffae-cfb6-a7f156c14771@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Monday 02 July 2018 09:02 PM, David Lechner wrote:
> On 07/02/2018 07:28 AM, Sekhar Nori wrote:
>> Hi David, Stephen,
>>
>> On Thursday 28 June 2018 03:27 PM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> This series moves all aemif/nand users to using the ti-aemif platform
>>> driver located in drivers/memory instead of the older API located in
>>> mach-davinci.
>>>
>>> First five patches add necessary changes to the clock driver. Next
>>> seven convert the board files to using the ti-aemif driver. Last patch
>>> removes now dead code.
>>
>> How do you want to handle this series? I can apply the series and
>> provide you an immutable branch on v4.18-rc1 with the clock patches
>> applied if that can work.
> 
> Sounds good to me. But I'm new to this maintainer thing, so maybe
> there is something to consider that I haven't thought of?

I don't think there is more to it. Ultimately there should not be two
commits for the same patch. Either you can apply and share the commit to
use or I can do that as well. I am equally fine either way.

Regards,
Sekhar
