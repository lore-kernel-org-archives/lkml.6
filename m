Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496A9C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125D52085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JvC019wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfAGTe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:34:56 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40942 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfAGTez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:34:55 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x07JYmj8047926;
        Mon, 7 Jan 2019 13:34:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546889688;
        bh=Uy/ZcWTFNH5HLyh0tMS0s1Tk/lSNmTrCtVDE8O3s9KE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JvC019wko1NuEkSWDb/8HrV+Dl8yVp8uaeC5vvlcG/vv36TY7n+iHss9SyBOJz67m
         068r7ZUV0SteYaQXwaVw/knHoCtxwv6JsxDxNzVI2aIv5xO7As0WC+VeQNali1bm7c
         n+9DxQapaCd4M9QNg4cKksL1lkb8XoE9rB3PWLBM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x07JYmxb034850
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jan 2019 13:34:48 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 7
 Jan 2019 13:34:48 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 7 Jan 2019 13:34:48 -0600
Received: from [172.22.110.219] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x07JYl4U016113;
        Mon, 7 Jan 2019 13:34:47 -0600
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
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
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <d73aa021-509d-ad34-5871-76560e868d03@ti.com>
Date:   Mon, 7 Jan 2019 13:34:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <90a2ed79-b437-af14-4538-430d8723cc6b@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vesa

On 1/4/19 6:39 PM, Vesa Jääskeläinen wrote:
> Hi Jacek,
> 
> On 04/01/2019 23.37, Jacek Anaszewski wrote:
>> But, aside from that hypothetic issue, we need a solution for
>> LEDn_BRIGHTNESS feature of lp5024, i.e. setting color intensity
>> via a single register write. How would you propose to address that?
> 
> You could model it to something like this in device tree:
> 
> led-module @ <i2c-address> {
>     compatible = "lp5024";
> 
>     // There is in hardware setup to use either linear or
>     // logarithmic scaling:
>     //enable-logarithmic-brightness;
> 
>     led0 {
>         // this will create led instance for LED0 in lp5024
>         label = "lp-led0";
>        
>         // This specifies LED number within lp5024
>         led-index = <0>;   // set output-base as 0*3 == 0
>        
>         element-red {
>             // refers to OUT0
>             output-offset = <0>;
>         };
>        
>         element-green {
>             // refers to OUT1
>             output-offset = <1>;
>         };
>        
>         element-blue {
>             // refers to OUT2
>             output-offset = <2>;
>         };
>        
>     };   
> 
>     led1 {
>         // this will create led instance for LED1 in lp5024
>         label = "lp-led1";
>        
>         // This specifies LED number within lp5024
>         led-index = <1>;   // set output-base as 1*3 == 3
> 

Can we not use led-sources like I have done already?
I really like to keep the DT nodes simple and re-use nodes that exist if possible.

My code already maps and groups the outputs into the associated banks

Dan
<snip>

-- 
------------------
Dan Murphy
