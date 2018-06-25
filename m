Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B075AC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6057025538
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GFtdEe/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6057025538
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752433AbeFYHn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:43:58 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36233 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752344AbeFYHn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:43:56 -0400
Received: by mail-qk0-f194.google.com with SMTP id a132-v6so46848qkg.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 00:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=I99/LG5SZmhtNn/cdGl1eNxQ8gd/b+pZwKJxtFXU+pQ=;
        b=GFtdEe/sFAsgLyhpQn7o+jDgFQ1sg6WEJABveUDwRE34A1icSp+6yIKi+omXOyJweL
         qZ+0D1uKhH8A3vAozOcoejvo3XyQcXKVL6P50GVYlRQiB/WizwRi+4lTFHqM+ZFWAVdC
         bQWLoe7QPkdiQ9LOv38RCjQBrZKPUs2wwK1WA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=I99/LG5SZmhtNn/cdGl1eNxQ8gd/b+pZwKJxtFXU+pQ=;
        b=XJg+fVmKKEfTjOTLEm5pAA2oQbtTOvtf2z7wwX10tUEON40K2/FRlM5hHYWSeBixcr
         56/e/YKggxAmZV4gHCnlqEpSiFoiepj09yBu5vFM+rBL2WnJ/jOOaeAkOEMF/DEQf3OE
         AhOtnSWFczIcXyYoS1gAaVHHgcX9HHnw0ucWgjnsqsrmoOLh5zsGf+TlrmEk13cvvsjU
         uVUe2GaSXKb8N/PyUFsCoASWCqd8b0cTUfGmUYDPnqpjF5xr5AlMM2xS3uQw1Ie/7WYh
         cFkXVSJa5yUpvXNtgHBr8IS5XHvtYQT/fp8/EvMzZRjjNJXg65TgW5HDI94dwtaFTKnf
         oPAg==
X-Gm-Message-State: APt69E0W5G0MNMOcwd3lxzuTQRLgnS5/UilQD4JQ8OrdukFQhhyAi7AM
        LAoQxyMRl405af+YuJ/GBKqW/mREcxM=
X-Google-Smtp-Source: ADUXVKJy1U5qsidVYtJlYZbEAS5wVvvZ/ndjMvOilETxato+QDEH8tSrHhe6H315R1sns79l49cJEw==
X-Received: by 2002:a37:7e04:: with SMTP id z4-v6mr9337922qkc.66.1529912635444;
        Mon, 25 Jun 2018 00:43:55 -0700 (PDT)
Received: from [10.176.68.125] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id h67-v6sm9045298qkc.77.2018.06.25.00.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 00:43:54 -0700 (PDT)
Subject: Re: [PATCHv2 5/5] arm64: allwinner: a64: Add support for TERES-I
 laptop
To:     Harald Geyer <harald@ccbib.org>, Icenowy Zheng <icenowy@aosc.io>
References: <20180315162510.11669-1-harald@ccbib.org>
 <20180315162510.11669-6-harald@ccbib.org>
 <a7011fe78d171658742406bf01d50b7e3d7eaf1d.camel@aosc.io>
 <E1fX7yK-0000OC-HA@stardust.g4.wien.funkfeuer.at>
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
Message-ID: <5B309D37.80207@broadcom.com>
Date:   Mon, 25 Jun 2018 09:43:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <E1fX7yK-0000OC-HA@stardust.g4.wien.funkfeuer.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/2018 6:34 PM, Harald Geyer wrote:
> Icenowy Zheng writes:
>> >在 2018-03-15四的 16:25 +0000，Harald Geyer写道：
>>> > >+&mmc1 {
>>> > >+	pinctrl-names = "default";
>>> > >+	pinctrl-0 = <&mmc1_pins>;
>>> > >+	vmmc-supply = <&reg_aldo2>;
>>> > >+	vqmmc-supply = <&reg_dldo4>;
>>> > >+	mmc-pwrseq = <&wifi_pwrseq>;
>>> > >+	bus-width = <4>;
>>> > >+	non-removable;
>>> > >+	status = "okay";
>>> > >+
>>> > >+	rtl8723bs: wifi@1 {
>>> > >+		reg = <1>;
>>> > >+		interrupt-parent = <&r_pio>;
>>> > >+		interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>; /* PL3 */
>>> > >+		interrupt-names = "host-wake";
>>> > >+	};

[...]

>> >- This device node has no binding. The "host-wake" interrupt is part of
>> >  Broadcom SDIO Wi-Fi binding, rather than a generic one.
> I think the general mmc and interrupts bindings apply. And the mmc binding
> clearly states that for sub-nodes a compatible string is optional.
>
> However I just realized that the 'interrupt-names' property is not part
> of the general interrupts binding, so I guess at least this property should
> be removed.

Indeed. If the device just used the SDIO interrupt this is not needed. 
The Broadcom device can use either SDIO interrupt or a so-called 
out-of-band host-wake interrupt, which is what the above represents.

Regards,
Arend
