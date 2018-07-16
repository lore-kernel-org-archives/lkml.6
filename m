Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A60ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC382208FA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC382208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbeGPQbY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:31:24 -0400
Received: from hermes.aosc.io ([199.195.250.187]:57528 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbeGPQbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:31:24 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 9BA6464BDC;
        Mon, 16 Jul 2018 16:02:55 +0000 (UTC)
Date:   Tue, 17 Jul 2018 00:02:42 +0800
In-Reply-To: <20180716155938.GA6947@rob-hp-laptop>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com> <1531479786-4911-8-git-send-email-clabbe@baylibre.com> <20180716155938.GA6947@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3 7/9] dt-bindings: ata: ahci-platform: document port-supply
To:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>
CC:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, wens@csie.org, thierry.reding@gmail.com,
        tj@kernel.org, maxime.ripard@free-electrons.com
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <99FC6EC0-941D-4757-9C7F-57BE2BDBEF91@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年7月16日 GMT+08:00 下午11:59:38, Rob Herring <robh@kernel.org> 写到:
>On Fri, Jul 13, 2018 at 11:03:04AM +0000, Corentin Labbe wrote:
>> This patch document the new optional port-supply
>> 
>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt
>b/Documentation/devicetree/bindings/ata/ahci-platform.txt
>> index 47652521a6ed..40a636b9851e 100644
>> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
>> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
>> @@ -31,6 +31,7 @@ Optional properties:
>>  - dma-coherent      : Present if dma operations are coherent
>>  - clocks            : a list of phandle + clock specifier pairs
>>  - target-supply     : regulator for SATA target power
>> +- port-supply       : regulator for SATA port
>
>Humm, I'm pretty sure that's what target-supply was supposed to be. If 
>anything, need to clearly define what is what.
>
>How does this work with multiple ports?

He wrongly named it. It's for PHY.

>
>>  - phys              : reference to the SATA PHY node
>>  - phy-names         : must be "sata-phy"
>>  - ahci-supply       : regulator for AHCI controller
>
>Also, please group all the supplies together.
>
>> @@ -51,6 +52,7 @@ Sub-nodes required properties:
>>  And at least one of the following properties:
>>  - phys		    : reference to the SATA PHY node
>>  - target-supply     : regulator for SATA target power
>> +- port-supply       : regulator for SATA port
>>  
>>  Examples:
>>          sata@ffe08000 {
>> -- 
>> 2.16.4
>> 
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
