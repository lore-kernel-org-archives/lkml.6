Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCE7ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 20:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F3F20873
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 20:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F3F20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbeGNUgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 16:36:14 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:21959 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbeGNUgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 16:36:13 -0400
Received: from belgarion ([90.76.60.200])
        by mwinf5d36 with ME
        id AkFm1y0044KClF603kFmY7; Sat, 14 Jul 2018 22:16:00 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 14 Jul 2018 22:16:00 +0200
X-ME-IP: 90.76.60.200
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, devicetree@vger.kernel.org,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list\:ARM\/FREESCALE IMX \/ MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] ARM: dts: pxa: add mioa701 board description
References: <20180702055733.18578-1-robert.jarzmik@free.fr>
        <20180702055733.18578-2-robert.jarzmik@free.fr>
        <CAL_JsqJU2jyfN3PyvXRCTO4xXQmUbU3tJ0uLok10KONULpJwXg@mail.gmail.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Sat, 14 Jul 2018 22:15:45 +0200
In-Reply-To: <CAL_JsqJU2jyfN3PyvXRCTO4xXQmUbU3tJ0uLok10KONULpJwXg@mail.gmail.com>
        (Rob Herring's message of "Mon, 9 Jul 2018 12:00:26 -0600")
Message-ID: <87lgada80e.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh+dt@kernel.org> writes:

Hi Rob,

>> +       /* compatible = "mitac,mioa701"; */
>> +       compatible = "marvell,pxa270";
>
> Why the comment?
Leftover, I'll remove it.

>> +                       pstore_region:region@0xa2000000 {
>
> Drop the 0x
Done.

>> +                               compatible = "linux,contiguous-memory-region";
>> +                               reg = <0xa2000000 1048576>;
>
> Use hex for the size.
Ok.

>> +               ffuart: uart@40100000 {
>
> Should be "serial@...". You'll have to fix in the base dtsi.
Ok for all of these.
>> +               pxai2c1: i2c@40301680 {
>> +                       mrvl,i2c-fast-mode;
>> +                       pinctrl-names = "default";
>> +                       pinctrl-0 = <&pinctrl_i2c_default>;
>> +                       status = "okay";
>> +
>> +                       mt9m111: camera@5d {
>> +                               compatible = "micron,mt9m111";
>> +                               reg = <0x5d>;
>> +                               gpios = <&gpio 56 GPIO_ACTIVE_HIGH>;
>> +
>> +                               remote = <&pxa_camera>;
>
> Not needed with the graph:
I don't understand that, do you mean the port node is not needed ?

>
>> +                               port {
>> +                                       mt9m111_1: endpoint {
>> +                                               bus-width = <8>;
>> +                                               remote-endpoint = <&pxa_camera>;
>> +                                       };
>> +                               };
>> +                       };
>> +               };
>> +               gpio-keys {
>> +                       compatible = "gpio-keys";
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       autorepeat;
>> +                       pinctrl-names = "default";
>> +                       pinctrl-0 = <&pinctrl_gpiokeys_default>;
>> +                       status = "okay";
>
> Don't need status here? It shouldn't be defined in the base dtsi.
Heuh what ? The status is just above, and gpio-keys is not defined in any dtsi.

>> +
>> +                       button@0 {
>
> If you have unit-address there should also be a reg property. Just
> drop and name the node 'power' or 'power-button'. And similarly for
> the rest.
Ok.

>> +
>> +       regulators {
>> +               compatible = "simple-bus";
>
> Drop this and move children to the top level. This is not an mmio bus.
Ok.

>> +       docg3: flash@0 {
>
> This probably should be a child of the bus controller.
Most certainly yes.

>
>> +               compatible = "m-systems,diskonchip-g3";
>> +               reg = <0x0 0x2000>;
>> +       };
>> +
>> +       panel {
>> +               compatible = "toshiba,ltm0305a776";
>> +               lcd-type = "color-tft";
>
> This should be implied by the compatible.
Mmm no. Actually, this is used by the framebuffer controller, ie. pxafb to set
it up. And I don't think adding a list of panel compatibles in pxafb is a good
idea.
The corresponding code is in : drivers/video/fbdev/pxafb.c, see
"static const char * const lcd_types[]".

>> +               display-timings {
>> +                       native-mode = <&timing0>;
>
> We generally imply this from the compatible (i.e. use simple-panel).
But you suppose there is an actual driver for the panel, right ? But there is
none.

> Could use another level of indentation.
Sure.

>> +       ac_charger: charger@1 {
>
> Drop the unit-address.
Ok.

Thanks for the review.

-- 
Robert
