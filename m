Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F6AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08B720874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="CA2ytGX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08B720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937852AbeFSMlO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:41:14 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:59171 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937705AbeFSMlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi; s=20161220;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=p8B03IrnyXBr1eOP0RVpxdq/IYMxi9/ZBsvHbatMTCI=;
        b=CA2ytGX7o0vN0T2WWx0qwdHeDre8tBoYbNPTha/bs1guWec9js5ilLgQu/g8W1K+nrCxFMnLfw+7tEoUhnkBwUffDhH5lUY1bG/85sXGwE9V8UbD+fwBSHbtyUfPzJFS+hlsneObc7sG64ehXLuPTOrDrbm8LnnDfXuj0NI3b4L4zI1Ssls+5Y2Ih0QnJQTGgisfSHW7941mw/BIdWpeR1Z/2ilRZCRdS76vdHBA9Tc2OmQvaxYpHRmOQad+tDOahWI0oP9EjIr9MXbSltavYQPxiyc1N1jEy6WHWPRpfBBfcgy9PCCYYUgfuJ8DQoSwULvw6ac+TUkxO3xPT2yw3Q==;
Received: from [193.209.96.43] (helo=[10.21.26.144])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1fVFwX-0002iw-Qx; Tue, 19 Jun 2018 15:41:05 +0300
Subject: Re: [PATCH 1/8] dt-bindings: tegra186-hsp: Add shared interrupts
To:     Jon Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, jassisinghbrar@gmail.com,
        gregkh@linuxfoundation.org, thierry.reding@gmail.com
Cc:     araza@nvidia.com, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180508114403.14499-1-mperttunen@nvidia.com>
 <20180508114403.14499-2-mperttunen@nvidia.com>
 <2bed23e6-19d5-66f8-774e-d613a91b1607@nvidia.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <3b5708ef-c82f-c4b2-da50-2cb2afa3edb2@kapsi.fi>
Date:   Tue, 19 Jun 2018 15:41:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2bed23e6-19d5-66f8-774e-d613a91b1607@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 193.209.96.43
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.2018 18:15, Jon Hunter wrote:
> 
> On 08/05/18 12:43, Mikko Perttunen wrote:
>> Non-doorbell interrupts are routed through "shared interrupts". These
>> interrupts can be mapped to various internal interrupt lines. Add
>> interrupt properties for shared interrupts to the tegra186-hsp device
>> tree bindings.
> 
> Reading the Tegra documentation, although the doorbells have dedicated 
> interrupts, it appears that the doorbell interrupts can also be routed 
> via these shared interrupts.

Thanks, I changed the text slightly to account for this.

> 
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>>   Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt | 
>> 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt 
>> b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
>> index b99d25fc2f26..9edcdf82d719 100644
>> --- a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
>> +++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
>> @@ -21,6 +21,8 @@ Required properties:
>>       Contains a list of names for the interrupts described by the 
>> interrupt
>>       property. May contain the following entries, in any order:
>>       - "doorbell"
>> +    - "sharedN", where 'N' is a number from zero up to the number of
>> +      external interrupts supported by the HSP instance minus one.
>>       Users of this binding MUST look up entries in the interrupt 
>> property
>>       by name, using this interrupt-names property to do so.
>>   - interrupts
> 
> How is the mapping of shared-mailboxes interrupts to the actual 
> 'sharedN' interrupt managed?

Currently the driver always uses shared0 for mailbox-full interrupt, and 
nothing else, which is what downstream does as well. It's difficult to 
do anything else as we can trample on some other driver's configuration..

> 
> Cheers
> Jon
> 

Thanks,
Mikko
