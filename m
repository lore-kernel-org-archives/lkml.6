Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35147C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E852147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vhZ5mLvq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfAGVPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:15:15 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34178 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfAGVPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:15:15 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x07LFBWK080570;
        Mon, 7 Jan 2019 15:15:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546895711;
        bh=S+3YYUlO1c/GZgpozimUPey6IMXudPor8xkeuLA1kLE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vhZ5mLvqP2Txx6NqwFI8uNVvF471CZ1yXUa6Rz5GhZcrewUx9MMUvrNUEqILdRjbT
         bgvznJJtI2JF8cH6XJsHd6GEAngtFvzK2M+MEsi6kGdXMOtCjORGADl4u3K5S26yRl
         DPCEKIugb314clSOy4Bha1B+YXW0Nsc4IKMmctfA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x07LFAnF007166
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jan 2019 15:15:11 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 7
 Jan 2019 15:15:10 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 7 Jan 2019 15:15:10 -0600
Received: from [172.22.110.219] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x07LFAhA031539;
        Mon, 7 Jan 2019 15:15:10 -0600
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com>
 <20181219201047.GA23448@amd> <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
 <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
 <a72c11c0-949b-bdbc-df2c-4490e04a1065@gmail.com>
 <986b5105-2fdb-bd25-7c8a-ca8fd1ade821@gmail.com>
 <7f205102-e854-f1cb-cc03-1307d1cddc87@gmail.com>
 <c9f8965a-90f4-b456-8225-c70694c9f071@gmail.com>
 <cf6c0025-36e7-197b-b27a-1f31fb45cc38@gmail.com> <20190104201256.GA2931@amd>
 <a4e3a782-de76-ba91-3727-4db69cf27c3a@gmail.com>
 <90a2ed79-b437-af14-4538-430d8723cc6b@gmail.com>
 <38daf022-e4e4-799d-4c75-ee851315290d@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <0982f9c3-b5df-7131-8d5a-761adefd389d@ti.com>
Date:   Mon, 7 Jan 2019 15:15:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <38daf022-e4e4-799d-4c75-ee851315290d@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 1/7/19 3:13 PM, Jacek Anaszewski wrote:
> Hi Vesa,
> 
> On 1/5/19 1:39 AM, Vesa Jääskeläinen wrote:
>> Hi Jacek,
>>
>> On 04/01/2019 23.37, Jacek Anaszewski wrote:
>>> But, aside from that hypothetic issue, we need a solution for
>>> LEDn_BRIGHTNESS feature of lp5024, i.e. setting color intensity
>>> via a single register write. How would you propose to address that?
>>
>> You could model it to something like this in device tree:
>>
>> led-module @ <i2c-address> {
>>      compatible = "lp5024";
>>
>>      // There is in hardware setup to use either linear or
>>      // logarithmic scaling:
>>      //enable-logarithmic-brightness;
>>
>>      led0 {
>>          // this will create led instance for LED0 in lp5024
>>          label = "lp-led0";
>>
>>          // This specifies LED number within lp5024
>>          led-index = <0>;   // set output-base as 0*3 == 0
>>
>>          element-red {
>>              // refers to OUT0
>>              output-offset = <0>;
>>          };
>>
>>          element-green {
>>              // refers to OUT1
>>              output-offset = <1>;
>>          };
>>
>>          element-blue {
>>              // refers to OUT2
>>              output-offset = <2>;
>>          };
>>
>>      };
>>
>>      led1 {
>>          // this will create led instance for LED1 in lp5024
>>          label = "lp-led1";
>>
>>          // This specifies LED number within lp5024
>>          led-index = <1>;   // set output-base as 1*3 == 3
>>
>>          element-red {
>>              // refers to OUT3
>>              output-offset = <0>;
>>          };
>>
>>          element-green {
>>              // refers to OUT4
>>              output-offset = <1>;
>>          };
>>
>>          element-blue {
>>              // refers to OUT5
>>              output-offset = <2>;
>>          };
>>
>>      };
>>
>>      bank-led {
>>          // this will create led instance for bank leds in lp5024
>>          label = "lp-bank-led";
>>
>>          // configured bank led configuration
>>          led-index = <2 3 4 5 6 7>;
>>          // As here is list of led-indices this entry is
>>          // assumed to be bank configuration. Bank mode is enable
>>          // for the indices.
>>
>>          // set output-base as BANK A
>>
>>          element-red {
>>              // refers to BANK A
>>              output-offset = <0>;
>>          };
>>
>>          element-green {
>>              // refers to BANK B
>>              output-offset = <1>;
>>          };
>>
>>          element-blue {
>>              // refers to BANK C
>>              output-offset = <2>;
>>          };
>>      };
>> };
>>
>> This would then create three led instances and each led instance has brightness setting and that goes straight to hardware.
>>
>> If one would want to override hardware control for brightness then I suppose you would define in led node something like:
>>
>>      brightness-model = "hsl"
>>
>> This would then pick red, green and blue elements for hsl calculations and others color elements for linear. LED specific hardware brightness would then be either 0 or 0xFF depending if all of LED color elements are zero or not.
>>
>> Would that kind of model work?
> 
> I'd prefer to have single RGB LED device. And your DT design
> is unnecessarily complex and a bit confusing.

+1 to that comment

> 
> Also, you provided scarce information about sysfs interface.
> It would be nice to see the sequence of commands.
> 


-- 
------------------
Dan Murphy
