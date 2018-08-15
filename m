Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C78C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 11:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA68215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 11:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA68215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbeHON7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 09:59:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43356 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbeHON7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 09:59:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 8A187263B04
Subject: Re: [PATCH 2/4] dt-bindings: phy-rockchip-inno-usb2: add
 documentation for extcon and utmi-avalid properties.
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org, amstan@chromium.org,
        groeck@google.com, kieran.bingham@ideasonboard.com,
        kernel@collabora.com, bleung@chromium.org,
        devicetree@vger.kernel.org, Frank Wang <frank.wang@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
 <20180815095934.11205-3-enric.balletbo@collabora.com>
 <2023816.cqyDmH3see@phil>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <37512ec9-8d9a-6c0c-8808-6351b8501002@collabora.com>
Date:   Wed, 15 Aug 2018 13:08:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2023816.cqyDmH3see@phil>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 15/08/18 12:29, Heiko Stuebner wrote:
> Hi Enric,
> 
> Am Mittwoch, 15. August 2018, 11:59:32 CEST schrieb Enric Balletbo i Serra:
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
> That should probably mention that this is the extcon providing the cable-state?

ack.

> 
> 
>>  Required nodes : a sub-node is required for each port the phy provides.
>>  		 The sub-node name is used to identify host or otg port,
>> @@ -45,6 +46,8 @@ Required properties (port (child) node):
>>  Optional properties:
>>   - phy-supply : phandle to a regulator that provides power to VBUS.
>>  		See ./phy-bindings.txt for details.
>> + - rockchip,utmi-avalid : boolean, use the avalid register to get vbus status.
>> +			  Otherwise, use the bvalid register.
> 
> Not having looked to deeply into the usb2 phy, this might raise questions
> on why this is a hardware-description? Is this needed when something is not
> connected on the board?

I asked myself the same question and even I thought in just remove that code.

After some investigation, though, I saw that the UTMI+ specification [1] has two
signals similar to ID signal (page 11), the AValid signal is used to indicate if
the session for an A-peripheral is valid and the BValid signal that is used to
indicate if the session for a B-peripheral is valid. I suppose that use of one
or the other matters in some cases, but AFAICT this is not used and I didn't see
any binding using it.

Maybe someone else can give us more clues on the importance or not of this property?

[1] https://www.nxp.com/docs/en/brochure/UTMI-PLUS-SPECIFICATION.pdf

Enric

> 
> 
> Heiko
> 
> 
