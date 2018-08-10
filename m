Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C52C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 06:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EB9223E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 06:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EB9223E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbeHJJLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:11:30 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:58057 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeHJJLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:11:30 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178])
        by mwinf5d02 with ME
        id MJiz1y00B3rYXCH03Jj0f0; Fri, 10 Aug 2018 08:43:00 +0200
X-ME-Helo: mail-qk0-f178.google.com
X-ME-Auth: bWF4aS5qb3VyZGFuQHdhbmFkb28uZnI=
X-ME-Date: Fri, 10 Aug 2018 08:43:00 +0200
X-ME-IP: 209.85.220.178
Received: by mail-qk0-f178.google.com with SMTP id c192-v6so5706446qkg.12;
        Thu, 09 Aug 2018 23:43:00 -0700 (PDT)
X-Gm-Message-State: AOUpUlFvQAKmuOP5ihozwFQIH3f2cS9KHefiuZ3n5A4GWNz/LTSI+JAQ
        l46f1ZAy/vzbmE8EmPb9kFrB3wr9Wk5xbTyF43M=
X-Google-Smtp-Source: AA+uWPwfdIpCOuACONcnLpxa1H/8mG0Y+OFGcjq2pvBRxJzYTb2NpMfF3yXyLz2gOPrT522Knnpa6QgLfOSJWc5sFVw=
X-Received: by 2002:a37:b446:: with SMTP id d67-v6mr4760136qkf.104.1533883379178;
 Thu, 09 Aug 2018 23:42:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:278a:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 23:42:58 -0700 (PDT)
In-Reply-To: <fcbfff13-aec5-c571-3a5e-a3d571505342@baylibre.com>
References: <20180807220011.24436-1-maxi.jourdan@wanadoo.fr>
 <20180807220011.24436-4-maxi.jourdan@wanadoo.fr> <3221c65f87f8fd3541e0188186cb0259327cb671.camel@baylibre.com>
 <fcbfff13-aec5-c571-3a5e-a3d571505342@baylibre.com>
From:   Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Date:   Fri, 10 Aug 2018 08:42:58 +0200
X-Gmail-Original-Message-ID: <CAHStOZ5RrB_=vhHwN22ajcbmWW_F04RdJTiE1ZLSDqhvwT5Zkg@mail.gmail.com>
Message-ID: <CAHStOZ5RrB_=vhHwN22ajcbmWW_F04RdJTiE1ZLSDqhvwT5Zkg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ARM64: dts: meson-gx: add dmcbus and canvas nodes.
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-09 9:53 GMT+02:00 Neil Armstrong <narmstrong@baylibre.com>:
> On 08/08/2018 10:41, Jerome Brunet wrote:
>> On Wed, 2018-08-08 at 00:00 +0200, Maxime Jourdan wrote:
>>> Wrap the canvas node in a syscon node.
>>>
>>> Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
>>> ---
>>>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 17 +++++++++++++++++
>>>  1 file changed, 17 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>>> index b8dc4dbb391b..c98198662ae2 100644
>>> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>>> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>>> @@ -423,6 +423,23 @@
>>>                      };
>>>              };
>>>
>>> +            dmcbus: bus@c8838000 {
>>> +                    compatible = "simple-bus";
>>> +                    reg = <0x0 0xc8838000 0x0 0x1000>;
>>> +                    #address-cells = <2>;
>>> +                    #size-cells = <2>;
>>> +                    ranges = <0x0 0x0 0x0 0xc8838000 0x0 0x1000>;
>>> +
>>> +                    sysctrl_DMC: system-controller@0 {
>>> +                            compatible = "amlogic,gx-dmc-sysctrl", "syscon", "simple-mfd";
>>> +                            reg = <0x0 0x0 0x0 0x1000>;
>>> +
>>> +                            canvas: canvas-provider@0 {
>>> +                                    compatible = "amlogic,canvas";
>>
>> If there is only one canvas provider under "sysctrl_DMC" and it has no reg
>> property , you should not put a unit-address (@0) here. (same for the
>> documentation patch)
>>
>> You may have seen unit-address without a reg property used elsewhere (ASoC
>> simple-card, my recent axg-sound-card), when there is multiple node with the
>> same node-name (ex: dai-link).

Ack.

>> As Martin pointed out, the DT spec says we should not use unit-address unless
>> there is a reg property. We did not get Rob's view on this and we might have to
>> update this later on. In your case, unless I missed something, you should
>> definitely not have it
>>
>> nitpick regarding the node-name (canvas-provider). If appropriate, we should try
>> to stick to one of the generic names proposed in the spec. I wonder if the
>> canvas provider could be viewed as a "memory" or "memory-controller"
>
> It's not really a memory or memory-controller, it's a Lookup Table on top of the memory controller,
> nothing really matches here...

Thanks for the comments. It will be "video-lut" as suggested.

>>
>> So, what about this ? Just a proposition, feel free to comment ;)
>>
>>       sysctrl_DMC: system-controller@0 {                                                      compatib
>> le = "amlogic,gx-dmc-sysctrl", "syscon", "simple-mfd";>               reg =
>> <0x0 0x0 0x0 0x1000>;
>>
>>               canvas: memory-controller {
>>                       compatible = "amlogic,canvas";
>>               }
>>
>> [...]
>>
>>
>>> +                            };
>>> +                    };
>>> +            };
>>> +
>>>              hiubus: bus@c883c000 {
>>>                      compatible = "simple-bus";
>>>                      reg = <0x0 0xc883c000 0x0 0x2000>;
>>
>>
>
