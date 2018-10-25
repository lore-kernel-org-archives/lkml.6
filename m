Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69D1C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A20A2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A20A2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeJZCag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:30:36 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57548 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbeJZCag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:30:36 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9PHufit035247;
        Thu, 25 Oct 2018 12:56:41 -0500
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9PHufjh067504
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Oct 2018 12:56:41 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 25
 Oct 2018 12:56:40 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 25 Oct 2018 12:56:40 -0500
Received: from [172.22.66.177] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9PHuepe026446;
        Thu, 25 Oct 2018 12:56:40 -0500
Subject: Re: [PATCH v4 2/7] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
To:     Rob Herring <robh@kernel.org>
CC:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, <lee.jones@linaro.org>,
        <tony@atomide.com>
References: <20181023170623.31820-1-dmurphy@ti.com>
 <20181023170623.31820-2-dmurphy@ti.com> <20181024144951.GB9327@bogus>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <10220e05-c4e0-e2a5-a288-836f5b13e112@ti.com>
Date:   Thu, 25 Oct 2018 12:56:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181024144951.GB9327@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rob

Thanks

On 10/24/2018 09:49 AM, Rob Herring wrote:
> On Tue, Oct 23, 2018 at 12:06:18PM -0500, Dan Murphy wrote:
>> The LM3697 is a single function LED driver. The single function LED
>> driver needs to reside in the LED directory as a dedicated LED driver
>> and not as a MFD device.  The device does have common brightness and ramp
>> features and those can be accomodated by a TI LMU framework.
>>
>> The LM3697 dt binding needs to be moved from the ti-lmu.txt and a dedicated
>> LED dt binding needs to be added.  The new LM3697 LED dt binding will then
>> reside in the Documentation/devicetree/bindings/leds directory and follow the
>> current LED and general bindings guidelines.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>
>> v4 - Squashed removal and addition of the dt bindings into a single patch - https://lore.kernel.org/patchwork/patch/998703/
> 
> Still not really the sequence I'd like to see and what I think would 
> help the discussion move along.
> 
> Patch 1: move all the devices out of ti-lmu.txt into the grouping which 
> makes sense. IOW, no functional changes. Probably only strict 
> sub/supersets of each other should be shared.
> 
> Patch 2-N: Make binding changes. Then we discuss things like ramp time 
> properties separately from binding structure.
> 

OK I will re-work the patchset.

Dan

>>
>>  .../devicetree/bindings/leds/leds-lm3697.txt  | 98 +++++++++++++++++++
>>  .../devicetree/bindings/mfd/ti-lmu.txt        | 26 +----
>>  2 files changed, 99 insertions(+), 25 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt


-- 
------------------
Dan Murphy
