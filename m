Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F63ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34C320849
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Pbv4mDAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34C320849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbeGPOUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:20:11 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:38927 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeGPOUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:20:11 -0400
Received: by mail-io0-f193.google.com with SMTP id e13-v6so37856163iof.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 06:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=+LQPMd7yphzHpob9zy1jy3cSemPJODxQWuXbD7HqplA=;
        b=Pbv4mDAWL+W0dMSS7QHEz2R3NkH4CZ+I8QuDY9UuTJw4MOpVeQk7ngRcdCIky8bvUy
         ZNfPCjubLiHqwrc119FHTwMZkEK46e46uqXfYnu7JmiI0GVKksq2cDXj7EVTPOI97ZUh
         RcS4LlBE8K2Lfk35thyLx32MTGbg3cUF9W14WxrrAjaU+yJtRRR9YLHO1rLgpZhLj7SC
         7q9I9tJQg6lxNVS8tFBStg1ky3b2d2zGH/zwRuHNnbDthjISkl17Ad+15IEJ1OHR/s9B
         GjMUoTY86XUDjt0C5YuyDcdr73E9l21LskdNIzjwXPEWfC/tuke+LEQHOZxH0acTfCNZ
         +6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+LQPMd7yphzHpob9zy1jy3cSemPJODxQWuXbD7HqplA=;
        b=J+5JCnDxcza1pu514HLKR1/XaWWsoazCWiRsuoZlFuHz6H9uvUaN3yAa6UTDWJcA8n
         7nXSioM+OX09AlsmE7JoMmrOaAJq9b7gl5URw7sKFgSeuP8XJ3i+1OTzoxekAGa9aUN1
         KVoZiHu9zFbdcVsF0ez8z4WOZOkhBGuAHQGnMueSOFBrJ9ejDIvik4P2sj68x0hER2cc
         UMlK0SK6wQUGXZ6P0KfIIlYgbihkSCZNNVX5wo6bfhoSEzWPCmtuogBn1VxPv9pCMji2
         /zZ/X+o+feRiToQc9bNV4GpqTGB4wV4WwB993URy2VYHsoHbUv0JGIz1rPiWo1bI3xic
         nhSQ==
X-Gm-Message-State: APt69E365xPim8loE85ZIr4ftg3PDGjpfRswWKcCx1kw+1R+lmZZBnzi
        Z8d1GJMUyt+trewtMGJK5sqXlw==
X-Google-Smtp-Source: AAOMgpfa1W1xgg6r7f8F5pP5OXAz0sT31FC3ubJ7eUcjQlyufLFmgRHFvbD2yFlgto1MNAp+4cEkcw==
X-Received: by 2002:a6b:a715:: with SMTP id q21-v6mr39625422ioe.61.1531749157867;
        Mon, 16 Jul 2018 06:52:37 -0700 (PDT)
Received: from localhost (c-24-118-241-30.hsd1.mn.comcast.net. [24.118.241.30])
        by smtp.googlemail.com with ESMTPSA id z71-v6sm3525943ioz.34.2018.07.16.06.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 06:52:37 -0700 (PDT)
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
        <1531326349.2708.136.camel@baylibre.com>
Date:   Mon, 16 Jul 2018 08:52:36 -0500
In-Reply-To: <1531326349.2708.136.camel@baylibre.com> (Jerome Brunet's message
        of "Wed, 11 Jul 2018 18:25:49 +0200")
Message-ID: <7h7elvmgnv.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Mon, 2018-07-02 at 22:25 +0000, Yixun Lan wrote:
>> From: Xingyu Chen <xingyu.chen@amlogic.com>
>> 
>> Add the DT info for SAR ADC of the Amlogic's Meson-AXG SoC.
>> 
>> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>> Hi kevin
>>   I just re-send this patch which rebased to your khilman/v4.18/integ branch
>>   Thanks
>> Yixun
>> 
>> nothing changed since patch v1 [1]:
>>  -
>> 
>> [1] https://lkml.kernel.org/r/20180326092117.208416-1-yixun.lan@amlogic.com
>> 
>> ---
>>  .../arm64/boot/dts/amlogic/meson-axg-s400.dts |  5 +++++
>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 21 +++++++++++++++++++
>>  2 files changed, 26 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>> index 4b3331fbfe39..6041f68b32ae 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>> @@ -153,3 +153,8 @@
>>  		compatible = "brcm,bcm4329-fmac";
>>  	};
>>  };
>> +
>> +&saradc {
>> +	status = "okay";
>> +	vref-supply = <&vddio_ao18>;
>> +};
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> index 67d7115e4eff..52678a69dbf8 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> @@ -91,6 +91,13 @@
>>  		method = "smc";
>>  	};
>>  
>> +	vddio_ao18: regulator-vddio_ao18 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "VDDIO_AO18";
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +	};
>
> Kevin, Yixun,
>
> I find odd that we are adding a regulator to SoC device tree file.
> Those regulator are usually part of board file
>
> Unless the regulator is actually inside the SoC, this is not the place for it.
>
> Sorry for not catching this earlier.

You're right, I should've noticed this earlier also.

Yixun, can you resend this with the regulators in the board file please?

In the mean time, I've dropped this from v4.19/dt64 branch,

Kevin
