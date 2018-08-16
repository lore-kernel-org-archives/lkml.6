Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1533DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF2220C03
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF2220C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390089AbeHPLfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:35:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48004 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389366AbeHPLfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:35:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 3968E26104F
Subject: Re: [PATCH 2/4] dt-bindings: phy-rockchip-inno-usb2: add
 documentation for extcon and utmi-avalid properties.
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, amstan@chromium.org,
        groeck@google.com, kieran.bingham@ideasonboard.com,
        kernel@collabora.com, bleung@chromium.org, heiko@sntech.de,
        devicetree@vger.kernel.org, Frank Wang <frank.wang@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
 <20180815095934.11205-3-enric.balletbo@collabora.com>
 <20180815222157.GA8193@rob-hp-laptop>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <a71af5b8-cdc1-cf26-8c01-beb523e7c332@collabora.com>
Date:   Thu, 16 Aug 2018 10:38:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180815222157.GA8193@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 16/08/18 00:21, Rob Herring wrote:
> On Wed, Aug 15, 2018 at 11:59:32AM +0200, Enric Balletbo i Serra wrote:
>> Commit 98898f3bc83c8 ("phy: rockchip-inno-usb2: support otg-port for
>> rk3399") introduces two new properties. The extcon property is used to
>> detect the cable-state, and the rockchip,utmi-avalid is used to indicate
>> which register should be used to detect the vbus state.
>>
>> Document these properties in the documentation binding.
>>
>> Fixes: 98898f3bc83c8 ("phy: rockchip-inno-usb2: support otg-port for rk3399")
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>  .../devicetree/bindings/phy/phy-rockchip-inno-usb2.txt         | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
>> index 074a7b3b0425..2d4808d3920b 100644
>> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
>> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
>> @@ -23,6 +23,7 @@ Optional properties:
>>  		 register files". When set driver will request its
>>  		 phandle as one companion-grf for some special SoCs
>>  		 (e.g RV1108).
>> + - extcon : phandle to the extcon device for the otg phy.
> 
> extcon is not a good binding. The usb connector binding should be used 
> instead for new users.
> 

Ok, although the extcon thing is implemented in the driver, so I was trying to
just describe how is implemented now, looks like nobody is using it apart from
me (patches not upstreamed yet). I suppose switch to the usb connector binding
will imply some driver modifications. I will take a look.

Thanks,
 Enric

> Rob
> 
