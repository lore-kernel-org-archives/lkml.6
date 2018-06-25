Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE121C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F62255B4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BeqZgfbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F62255B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeFYINH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:13:07 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46671 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752169AbeFYINE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:13:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id r17-v6so4817195edo.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 01:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Lrz7IDNN9F6q91QElEF4wxXygs3JeL6JpR2/QXjkpx0=;
        b=BeqZgfbKNAM3+jiwy+ncd2N0Jsj/9eRsxVciYi9jmkrVt/djooDVpC8Kin0GBgyk17
         WGJ/jJR6BrvT7n5wAprBPiNdGuQR1BskCxRv5+bgEUUIjG/XLjq7Gh336DG8mfzvPKdQ
         ucodnU32ZK75IFcyMPiZZco0DVsQ+611mjS3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Lrz7IDNN9F6q91QElEF4wxXygs3JeL6JpR2/QXjkpx0=;
        b=FRazLEfRhhaxhL3fWmrRkRtJhFbmJT8R0uJmB05Wde+P0ASLHy2/2KMfTPtsRPoo18
         +Ki9OLgJKtA46D7HxIDe3EBZZve1EkPRteyFKPQ/PgnL1R/oS1xgPSLPV+GBvopvJVIg
         R5KZWKlZZpBumOhCIbwGvPKqG9nz5ALTDHqWVwN2p0GftO51MTXy3jbJoFjSmLJgdqQW
         hiADZnuVjqdu6tYaFAuGOP4f2mfu3FD4lRMBngxjcAa7M3IoToZK3tAK9I9fJqOl/G4o
         68DhfcN+fztf37RF3GYYKipViq6o/gFXiZmEIQQLM0aZF5gaZRf3ac/7XdMqnYHeilLz
         Ocxg==
X-Gm-Message-State: APt69E20i15l7qMLRYa0h1SBPwJDdLlqZ+Wv759AugBKhmWBjTePHfbw
        FYD/E3WGFPBgE2u6W/tiGV26kQ==
X-Google-Smtp-Source: ADUXVKJJixqUvLOf8xFa6P83H4MxjfbDK4gzMWoMkGo+22HTDE6R9LxC+7y/DvY5DJNBkHHuBUjyBQ==
X-Received: by 2002:a50:b4e2:: with SMTP id x31-v6mr10401988edd.155.1529914383148;
        Mon, 25 Jun 2018 01:13:03 -0700 (PDT)
Received: from [10.176.68.125] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id v8-v6sm6595988edr.48.2018.06.25.01.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 01:13:02 -0700 (PDT)
Subject: Re: [PATCHv2 5/5] arm64: allwinner: a64: Add support for TERES-I
 laptop
To:     Icenowy Zheng <icenowy@aosc.io>, Harald Geyer <harald@ccbib.org>
References: <20180315162510.11669-1-harald@ccbib.org>
 <20180315162510.11669-6-harald@ccbib.org>
 <a7011fe78d171658742406bf01d50b7e3d7eaf1d.camel@aosc.io>
 <E1fX7yK-0000OC-HA@stardust.g4.wien.funkfeuer.at>
 <5B309D37.80207@broadcom.com> <1CF519CD-D44E-4959-8951-27CE710E0984@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>, info@olimex.com,
        linux-wireless@vger.kernel.org
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5B30A40D.3070509@broadcom.com>
Date:   Mon, 25 Jun 2018 10:13:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <1CF519CD-D44E-4959-8951-27CE710E0984@aosc.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/2018 9:47 AM, Icenowy Zheng wrote:
>
>
> 于 2018年6月25日 GMT+08:00 下午3:43:51, Arend van Spriel <arend.vanspriel@broadcom.com> 写到:
>> On 6/24/2018 6:34 PM, Harald Geyer wrote:
>>> Icenowy Zheng writes:
>>>>> 在 2018-03-15四的 16:25 +0000，Harald Geyer写道：
>>>>>>> +&mmc1 {
>>>>>>> +	pinctrl-names = "default";
>>>>>>> +	pinctrl-0 = <&mmc1_pins>;
>>>>>>> +	vmmc-supply = <&reg_aldo2>;
>>>>>>> +	vqmmc-supply = <&reg_dldo4>;
>>>>>>> +	mmc-pwrseq = <&wifi_pwrseq>;
>>>>>>> +	bus-width = <4>;
>>>>>>> +	non-removable;
>>>>>>> +	status = "okay";
>>>>>>> +
>>>>>>> +	rtl8723bs: wifi@1 {
>>>>>>> +		reg = <1>;
>>>>>>> +		interrupt-parent = <&r_pio>;
>>>>>>> +		interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>; /* PL3 */
>>>>>>> +		interrupt-names = "host-wake";
>>>>>>> +	};
>>
>> [...]
>>
>>>>> - This device node has no binding. The "host-wake" interrupt is
>> part of
>>>>>   Broadcom SDIO Wi-Fi binding, rather than a generic one.
>>> I think the general mmc and interrupts bindings apply. And the mmc
>> binding
>>> clearly states that for sub-nodes a compatible string is optional.
>>>
>>> However I just realized that the 'interrupt-names' property is not
>> part
>>> of the general interrupts binding, so I guess at least this property
>> should
>>> be removed.
>>
>> Indeed. If the device just used the SDIO interrupt this is not needed.
>> The Broadcom device can use either SDIO interrupt or a so-called
>> out-of-band host-wake interrupt, which is what the above represents.
>
> RTL8....S is also capable of use OOB interrupt.

Ok. Is it also in-place in this TERES-I laptop? Anyway, if RTL8...S does 
not have a binding specification there is not much to do about it. In my 
opinion it does not make sense to add it to the generic mmc/sdio binding 
as this interrupt does not involve the mmc/sdio hardware hence the term 
OOB. There is generic wifi binding net/wireless/ieee80211.txt in which 
this could be added. Obviously it would just be a binding and no 
guarantee that the actual device driver supports it so the RTL driver 
would need modification for that.

Regards,
Arend

