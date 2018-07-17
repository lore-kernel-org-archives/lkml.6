Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8582AECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F377120850
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CSJ66PxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F377120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbeGQQBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:01:23 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50823 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbeGQQBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:01:23 -0400
Received: by mail-it0-f66.google.com with SMTP id w16-v6so2373197ita.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=pU4xtnfZya9l98VtI4cVxO1s+FopE79n7hO9JZFxWUw=;
        b=CSJ66PxZkzqPsimI8+ZxSTwUaOOmcYsq2P8BMQlbJtwKuQpENsl+CVkMOT0Pd8vd7s
         QjWi7YsDPOFO2FN9HjrKEpre6M3tmBXtZ7XfX6aXlFSgbmj3vHRtxR9o93NQ8UpSZzPu
         cR75fYIKC8CZvJE5cJEdu/xtBAi+BrxrusSZQIZ4o6iakmbigwAex2IPZ+ZKwBjnpGfH
         pjDSniIULv/4+2XD6x2JMGsThmI0XhFZYYMIlN2Se+Np9ri3dl+KZwqLAof266DfW1mh
         BFrluENVqvaF4X6nx6y73TZwl5PBS0GVh3zqcUszP6yd8Vc8SMFiBPI7T2ewb2YsAoQz
         S2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pU4xtnfZya9l98VtI4cVxO1s+FopE79n7hO9JZFxWUw=;
        b=d32BbJNFDoszIlSidWBNOIHi0TdvlgTMvCmRTXqqpznS5LauhMjQZWcJ5B0lfQlKFm
         a56fGidamC7Ue1Z3a/ryRf0Wo/IKKwMLvQWBC+cgApHcaIR9NjVZEuV/M3mFqdmB6x+n
         LOE8C6JAtO/iu2KXCBDRvASC1V1c4HULrqvGZfg9Kowk3kML0oC0/qDzbekB1OevqFp1
         0LAvLuwHmqV9cr9sNyqhIT2Hnrp/sa2iVAFTZhkxMy3cDfcu3zJZgN/ykJuf/ObVhCmz
         nn5dJDZ6C/eJtoLcQ4AWwL9lDjCsBA90gBsBdjd/9B1EzTifT3txFGczQHsuY111fTtN
         CISA==
X-Gm-Message-State: AOUpUlGKEkXYwXtOMzVN+tEpTB4eAgOFzEr+DNPrZ0WUkw6R9GpPSM+1
        tniqmQVrC/2M5PQIagIYOe9Kcw==
X-Google-Smtp-Source: AAOMgpddSDlbLjLV7pj1fnS0XWrFKhmS0W+pWOvPZxubW2dUGiCSii9wnSXRUcUWz7BzIjZgptsnFw==
X-Received: by 2002:a24:61c4:: with SMTP id s187-v6mr2111912itc.153.1531841292973;
        Tue, 17 Jul 2018 08:28:12 -0700 (PDT)
Received: from localhost (c-24-118-241-30.hsd1.mn.comcast.net. [24.118.241.30])
        by smtp.googlemail.com with ESMTPSA id p21-v6sm585078iog.70.2018.07.17.08.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:28:12 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Yixun Lan <yixun.lan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] ARM64: dts: meson-axg: add saradc support
Organization: BayLibre
References: <20180702222515.13924-1-yixun.lan@amlogic.com>
        <1531326349.2708.136.camel@baylibre.com> <7h7elvmgnv.fsf@baylibre.com>
Date:   Tue, 17 Jul 2018 10:28:11 -0500
In-Reply-To: <7h7elvmgnv.fsf@baylibre.com> (Kevin Hilman's message of "Mon, 16
        Jul 2018 08:52:36 -0500")
Message-ID: <7h4lgxop9w.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> Jerome Brunet <jbrunet@baylibre.com> writes:
>
>> On Mon, 2018-07-02 at 22:25 +0000, Yixun Lan wrote:
>>> From: Xingyu Chen <xingyu.chen@amlogic.com>
>>> 
>>> Add the DT info for SAR ADC of the Amlogic's Meson-AXG SoC.
>>> 
>>> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
>>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>>> ---
>>> Hi kevin
>>>   I just re-send this patch which rebased to your khilman/v4.18/integ branch
>>>   Thanks
>>> Yixun
>>> 
>>> nothing changed since patch v1 [1]:
>>>  -
>>> 
>>> [1] https://lkml.kernel.org/r/20180326092117.208416-1-yixun.lan@amlogic.com
>>> 
>>> ---
>>>  .../arm64/boot/dts/amlogic/meson-axg-s400.dts |  5 +++++
>>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 21 +++++++++++++++++++
>>>  2 files changed, 26 insertions(+)
>>> 
>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>>> index 4b3331fbfe39..6041f68b32ae 100644
>>> --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>>> @@ -153,3 +153,8 @@
>>>  		compatible = "brcm,bcm4329-fmac";
>>>  	};
>>>  };
>>> +
>>> +&saradc {
>>> +	status = "okay";
>>> +	vref-supply = <&vddio_ao18>;
>>> +};
>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>>> index 67d7115e4eff..52678a69dbf8 100644
>>> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>>> @@ -91,6 +91,13 @@
>>>  		method = "smc";
>>>  	};
>>>  
>>> +	vddio_ao18: regulator-vddio_ao18 {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "VDDIO_AO18";
>>> +		regulator-min-microvolt = <1800000>;
>>> +		regulator-max-microvolt = <1800000>;
>>> +	};
>>
>> Kevin, Yixun,
>>
>> I find odd that we are adding a regulator to SoC device tree file.
>> Those regulator are usually part of board file
>>
>> Unless the regulator is actually inside the SoC, this is not the place for it.
>>
>> Sorry for not catching this earlier.
>
> You're right, I should've noticed this earlier also.
>
> Yixun, can you resend this with the regulators in the board file please?
>
> In the mean time, I've dropped this from v4.19/dt64 branch,

Nevermind, Jerome fixed this up already in a series of DT updates for
AXG, so I'll keep it as is.

Thanks Jerome!

Kevin
