Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396B1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC91720852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC91720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388443AbeGXDmZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:42:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38531 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388233AbeGXDmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:42:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id t2-v6so2718752edr.5;
        Mon, 23 Jul 2018 19:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AhRYIFEIXLrlkLPabiMlJL8JGRIkDRh9Mrq/mTfQfzI=;
        b=WfL8+0UKUiUqKkyeU5JcX6TH5FyPzljTcgqYjkBKFZksTHoI+R1IqaF8YMWgUmznkO
         s1GGL9SSiRwDKnCECmcMJZbsIgRNdynp67WTsIQrSbqtYV19HRsvOMzculuO9hw92itx
         oX/TJytM8DOgqOkEEBYkmAE1N4ekrKqpGzhotxtEnxx7mC+iAvHYB5gSq7oZTG11pIMj
         dnT+yPbFSM++T1EyutrAxIY+5x4XmXeGYPY8NVrMPSPpDWaS/1TEu7O3pDiJkF/h3AEE
         qyjKO24q+zUuZ006imSV2DO47hkiD4h5iU1+N/uku94QxJewxXLl7FFlJutDZAnPCihu
         SirQ==
X-Gm-Message-State: AOUpUlGWgStNtpSr8qPCbxSHwGsxtN76YznjujsnP2lA1NgojURycLef
        SsLt3t06PX39ZS2P0LexNhRX4HinqJg=
X-Google-Smtp-Source: AAOMgpfvV1Pwy0DF6TtPosNpH1LT9XryB0eyfaioDLpRA7brntTn34bfiuajPSzTE1hu3D1vVV8mrA==
X-Received: by 2002:aa7:d60d:: with SMTP id c13-v6mr16174815edr.301.1532399893204;
        Mon, 23 Jul 2018 19:38:13 -0700 (PDT)
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com. [74.125.82.53])
        by smtp.gmail.com with ESMTPSA id t44-v6sm5644440edh.18.2018.07.23.19.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 19:38:12 -0700 (PDT)
Received: by mail-wm0-f53.google.com with SMTP id l2-v6so11075605wme.1;
        Mon, 23 Jul 2018 19:38:12 -0700 (PDT)
X-Received: by 2002:a1c:3b54:: with SMTP id i81-v6mr720954wma.143.1532399892257;
 Mon, 23 Jul 2018 19:38:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 19:37:51
 -0700 (PDT)
In-Reply-To: <AC678B03-19B7-4110-B333-72188CE71296@aosc.io>
References: <20180724011551.49603-1-icenowy@aosc.io> <20180724011551.49603-4-icenowy@aosc.io>
 <CAGb2v67zR-Q9n7L6CaFKDUJFHFEC_h8-RYxkdyeyJb_GbNmkJw@mail.gmail.com>
 <CEA43CB7-1DA6-4983-BF18-82C4A48FB92B@aosc.io> <CAGb2v64Qae4O430kP30DQNhp0Dt774OHt0nMe35ckp8X=CTFLg@mail.gmail.com>
 <AC678B03-19B7-4110-B333-72188CE71296@aosc.io>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 24 Jul 2018 10:37:51 +0800
X-Gmail-Original-Message-ID: <CAGb2v656oPmAX=_y88b05xqrona3HFtU-VmNQhHxK_n-4gD+aw@mail.gmail.com>
Message-ID: <CAGb2v656oPmAX=_y88b05xqrona3HFtU-VmNQhHxK_n-4gD+aw@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 3/3] arm64: allwinner: dts: h6: add
 Wi-Fi support for Pine H64 model A/B
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 10:28 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
> 于 2018年7月24日 GMT+08:00 上午10:26:02, Chen-Yu Tsai <wens@csie.org> 写到:
>>On Tue, Jul 24, 2018 at 10:23 AM, Icenowy Zheng <icenowy@aosc.io>
>>wrote:
>>>
>>>
>>> 于 2018年7月24日 GMT+08:00 上午10:21:59, Chen-Yu Tsai <wens@csie.org> 写到:
>>>>On Tue, Jul 24, 2018 at 9:15 AM, Icenowy Zheng <icenowy@aosc.io>
>>wrote:
>>>>> The Pine H64 model A has a Wi-Fi module connector and the model B
>>has
>>>>an
>>>>> on-board RTL8723BS Wi-Fi module.
>>>>>
>>>>> Add support for them. For model A, as it's not defaultly present,
>>>>keep
>>>>> it disabled now.
>>>>
>>>>Nope. Pine64 actually has two WiFi/BT modules. And they require
>>>>different
>>>>device tree snippets for both the WiFi and BT side. This is better
>>>>resolved
>>>>with device tree overlays.
>>>>
>>>>I have both, though I've yet found time to work on them.
>>>
>>> I have also both.
>>>
>>> The skeleton here can get the Wi-Fi of both to work.
>>
>>Cool. Then I can put away my RTL module for now. :)
>
> P.S. SDIO is auto detectable, and for BCM chips, the OOB interrupt
> is only a bonus function and it can fall back to standard in-band
> interrupt (which doesn't need special binding, and is currently
> used by mainline r8723bs driver.)

Correct. With BT you'll have serdev device nodes with different
compatibles. Then you'll have to resort to overlays, and you'd probably
end up adding WiFi OOB interrupt bits as well.

So the question remaining is: should we enable the MMC part, along
with power sequencing and regulator supplies, by default? Thinking
more about it, I'm actually OK with it. The board connectors are
clearly marked as being for a WiFi+BT module. The whole space on
the board is surrounded by a box in silkscreen. Sorry for the
initial nack.

Maxime, any thoughts?

>>
>>ChenYu
>>
>>>
>>>>
>>>>ChenYu
>>>>
>>>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>>>> ---
>>>>>  .../allwinner/sun50i-h6-pine-h64-model-b.dts  |  8 +++++
>>>>>  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 29
>>>>+++++++++++++++++++
>>>>>  2 files changed, 37 insertions(+)
>>>>>
>>>>> diff --git
>>>>a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
>>>>b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
>>>>> index d0fcc25efb00..d0f775613c9b 100644
>>>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
>>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
>>>>> @@ -18,3 +18,11 @@
>>>>>                 };
>>>>>         };
>>>>>  };
>>>>> +
>>>>> +&mmc1 {
>>>>> +       status = "okay";
>>>>> +};
>>>>> +
>>>>> +&wifi_pwrseq {
>>>>> +       status = "okay";
>>>>> +};
>>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
>>>>b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
>>>>> index a85867f8b684..75db6d4139bf 100644
>>>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
>>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
>>>>> @@ -40,6 +40,12 @@
>>>>>                         gpios = <&r_pio 0 7 GPIO_ACTIVE_HIGH>; /*
>>PL7
>>>>*/
>>>>>                 };
>>>>>         };
>>>>> +
>>>>> +       wifi_pwrseq: wifi_pwrseq {
>>>>> +               compatible = "mmc-pwrseq-simple";
>>>>> +               reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PL2
>>*/
>>>>> +               status = "disabled";
>>>>> +       };
>>>>>  };
>>>>>
>>>>>  &mmc0 {
>>>>> @@ -50,6 +56,17 @@
>>>>>         status = "okay";
>>>>>  };
>>>>>
>>>>> +&mmc1 {
>>>>> +       pinctrl-names = "default";
>>>>> +       pinctrl-0 = <&mmc1_pins>;
>>>>> +       vmmc-supply = <&reg_cldo2>;
>>>>> +       vqmmc-supply = <&reg_bldo2>;
>>>>> +       mmc-pwrseq = <&wifi_pwrseq>;
>>>>> +       bus-width = <4>;
>>>>> +       non-removable;
>>>>> +       status = "disabled";
>>>>> +};
>>>>> +
>>>>>  &mmc2 {
>>>>>         pinctrl-names = "default";
>>>>>         pinctrl-0 = <&mmc2_pins>;
>>>>> @@ -128,12 +145,24 @@
>>>>>                         };
>>>>>
>>>>>                         reg_cldo2: cldo2 {
>>>>> +                               /*
>>>>> +                                * This regulator is connected with
>>>>CLDO3.
>>>>> +                                * Before the kernel can support
>>>>synchronized
>>>>> +                                * enable of coupled regulators,
>>keep
>>>>them
>>>>> +                                * both always on as a ugly hack.
>>>>> +                                */
>>>>> +                               regulator-always-on;
>>>>>                                 regulator-min-microvolt =
>><3300000>;
>>>>>                                 regulator-max-microvolt =
>><3300000>;
>>>>>                                 regulator-name = "vcc-wifi-1";
>>>>>                         };
>>>>>
>>>>>                         reg_cldo3: cldo3 {
>>>>> +                               /*
>>>>> +                                * This regulator is connected with
>>>>CLDO2.
>>>>> +                                * See the comments for CLDO2.
>>>>> +                                */
>>>>> +                               regulator-always-on;
>>>>>                                 regulator-min-microvolt =
>><3300000>;
>>>>>                                 regulator-max-microvolt =
>><3300000>;
>>>>>                                 regulator-name = "vcc-wifi-2";
>>>>> --
>>>>> 2.18.0
>>>>>
>>>
>>> --
>>> You received this message because you are subscribed to the Google
>>Groups "linux-sunxi" group.
>>> To unsubscribe from this group and stop receiving emails from it,
>>send an email to linux-sunxi+unsubscribe@googlegroups.com.
>>> For more options, visit https://groups.google.com/d/optout.
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
