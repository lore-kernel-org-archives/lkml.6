Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AF7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6292173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfBZOkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:40:45 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:36123 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbfBZOkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:40:43 -0500
Received: from webmail.gandi.net (webmail6.sd4.0x35.net [10.200.201.6])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPA id C614524000F;
        Tue, 26 Feb 2019 14:40:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 Feb 2019 15:40:38 +0100
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Rob Herring <robh@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: gpio-charger: Add
 status-gpios property
In-Reply-To: <20190225215316.GA10117@bogus>
References: <20190205190316.19296-1-contact@artur-rojek.eu>
 <20190225215316.GA10117@bogus>
Message-ID: <780b0ff3bb738ab36a5e729f74e6cfb2@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
User-Agent: Roundcube Webmail/1.1.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob.

Thanks for the review.

On 2019-02-25 22:53, Rob Herring wrote:
> On Tue, Feb 05, 2019 at 08:03:15PM +0100, Artur Rojek wrote:
>> Add documentation for the "status-gpios" property.
>> 
>> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
>> ---
>>  .../devicetree/bindings/power/supply/gpio-charger.txt         | 4 
>> ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt 
>> b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
>> index adbb5dc5b6e9..b98a05a4973c 100644
>> --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
>> +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
>> @@ -14,12 +14,16 @@ Required properties :
>>       usb-cdp (USB charging downstream port)
>>       usb-aca (USB accessory charger adapter)
>> 
>> +Optional properties:
>> + - status-gpios: GPIO indicating the charger status
> 
> So when it is asserted it has 'status'? What does status mean?
It is a GPIO indicating whether a battery is charging.
I shall make the description more clear.
> 
>> +
>>  Example:
>> 
>>  	usb_charger: charger {
>>  		compatible = "gpio-charger";
>>  		charger-type = "usb-sdp";
>>  		gpios = <&gpf0 2 0 0 0>;
>> +		status-gpios = <&gpf0 3 0 0 0>;
> 
> Humm, not sure what the thinking for 'gpios' was, but it's wrong and 
> you
> just copied it. If we follow the normal cell encoding with 2 cells, 
> this
> means the property takes 3 gpios (though the last 2 are marked not
> present with 0).
I will replace both of those properties with a valid example.

Artur
> 
> Rob

