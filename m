Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C92C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E4A2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Dqp7wMk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E4A2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeILQYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 12:24:02 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37298 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeILQYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 12:24:02 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8CBJk7I072594;
        Wed, 12 Sep 2018 06:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536751186;
        bh=VB2pWebfnZc31rqDvUyLv6ISL+XK9qa3mINasGMNJTw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Dqp7wMk6mXTdFSAzGE7G0ClvXsmLMF6/eU66WE9qfqiJIP64kEE6mpaeq/OSCavcn
         A0nDAsm0eMbCM7UIKcYwn/wbll8b9EVQ5fiU/SZVBEQnPtD2zxDkWSM6D5I92UYFaM
         mgUqddFF5mlXzUCe5AcbYyhSVCmB1EVoYQt2an6Q=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8CBJkrb032004;
        Wed, 12 Sep 2018 06:19:46 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 12
 Sep 2018 06:19:46 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 12 Sep 2018 06:19:46 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8CBJeVv008921;
        Wed, 12 Sep 2018 06:19:41 -0500
Subject: Re: [PATCH] dt-bindings: power: Introduce suspend states supported
 properties
To:     Sudeep Holla <sudeep.holla@arm.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <t-kristo@ti.com>, <tony@atomide.com>
References: <1536725372-29174-1-git-send-email-j-keerthy@ti.com>
 <781b2eb2-1568-b4e5-46f2-c4612862d728@arm.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <5c49cb0c-a436-c957-e6b3-5f3aa7af92f9@ti.com>
Date:   Wed, 12 Sep 2018 16:49:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <781b2eb2-1568-b4e5-46f2-c4612862d728@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 12 September 2018 04:32 PM, Sudeep Holla wrote:
> 
> 
> On 12/09/18 05:09, Keerthy wrote:
>> Introuduce linux generic suspend states supported properties.
>> It is convenient for the generic suspend path to have
>> the knowledge of the suspend states supported based on the
>> device tree properties based on which it can either be suspended
>> or safely bailed out of suspend if none of the suspend states
>> are supported.
>>
> 
> NACK for any bindings that are linux specific. The suspend feature is so
> platform dependent that I see no need for generic Linux bindings for the
> same.

suspend to mem and suspend to disk are pretty generic states and i agree
implementation is platform dependent so why not have properties that
convey if they are supported?

Is the disagreement over making the properties being linux specific?

> 
> We have power domains and idle states. If you have platforms that
> doesn't support some of the states, just disable them in the DT.
> 
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>  .../devicetree/bindings/power/power-states.txt     | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/power-states.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/power-states.txt b/Documentation/devicetree/bindings/power/power-states.txt
>> new file mode 100644
>> index 0000000..bb80b36
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/power-states.txt
>> @@ -0,0 +1,22 @@
>> +* Generic system suspend states support
>> +
>> +Most platforms support multiple suspend states. Define system
>> +suspend states so that one can target appropriate low power
>> +states based on the SoC capabilities.
>> +
>> +linux,suspend-to-memory-supported
>> +
>> +Upon suspend to memory the system context is saved to primary memory.
>> +All the clocks for all the peripherals including CPU are gated.
>> +
>> +linux,suspend-power-off-supported
>> +
>> +In this case in additon to the clocks all the voltage resources are
>> +turned off except the ones needed to keep the primary memory
>> +and a wake up source that can trigger a wakeup event.
>> +
>> +linux,suspend-to-disk-supported
>> +
>> +Upon suspend to disk that system context is saved to secondary memory.
>> +All the clocks for all the peripherals including CPU are gated. Even
>> +the primary memory is turned off.
>>
> 
> What makes any of the above linux specific. So once again NACK.
> 
> 
