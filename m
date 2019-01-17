Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B023C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4705120657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QP/tzos8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfAQTNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:13:42 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33706 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfAQTNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:13:41 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so5301570pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 11:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=cwGXchQq9VSMeTDEdusJMMV+0chk4tV4Pl851aWw+oM=;
        b=QP/tzos8z2PCiZaEbY9P1CTcXgp6xLc4IdpJz6lvzxXUrosESQzEKuLGaB5lzckWLA
         ojojarq9uswLxGCXbv2SjaQDMPfkFP6PhdJOI+G40GUp1Prrka2WiZYiSGd/VMBc4Ina
         KzY0OoSxmunAwmoDDicbZ3eW0KzOR95ccejwcCmC5oikXjqm0BNfHsiM5BX2+5ObJjka
         Uv9dx5khSo1qQS8EKxR9a6J2+SpFa7+RFPW2wWRS99tDYIU5bBL1Q7FU/MSVoLiRBtVA
         ZpbIH/e5oGSq60pCkkAeWxfSHnWUT/MhGPBV49W+wqA/0HnPDc7XHTynrdpjnTs/cK3J
         Mx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=cwGXchQq9VSMeTDEdusJMMV+0chk4tV4Pl851aWw+oM=;
        b=r28ArQ7hVbbvzjJ4mIpgMbvqj6DpYNEmImD21AoN5ZWFWrJ1bjUvNmRGlaUPJIMB+/
         nK3vIshUQN8m3t0/Pln3cgI+AMnXBCKzGAlLKZQAFObR8yXmly0XvE5t+kJV9bxWYYfA
         Y3Tv+P4yYYkP1vjzx7nc8JnIut4CRa9SRU/I4gnTEhbGMdheqcDs+/5maS3kn13B6c5K
         cN31ZvfoP4ubAuwdGmwqDgSL9UROaSufzkVejTiWvAl+K2wEaGHXQoBKWF8SgJNl8rHP
         k8kBQo6cpd3n4S6LxSL1I4oAc0GQ6qENO1NB40axn4EBTLss1dwvp8xhMHBj3thUCGJZ
         OTTw==
X-Gm-Message-State: AJcUukdE7crs2OzsadyDH37Zm/XkZOxO9O080g1lxuNAli8zJvj3F1x1
        WMnHghqXjAM89UKvB6HsnnXp8A==
X-Google-Smtp-Source: ALg8bN62QUmUITJOFcU4VmunTRjQDbFtBfadZOcH8G1b/YGRxo5JQXNgchUgt7x6RQ8Ir1j95Irl4Q==
X-Received: by 2002:a62:824c:: with SMTP id w73mr5604118pfd.150.1547752420924;
        Thu, 17 Jan 2019 11:13:40 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:e076:9fe9:59e2:1e0b])
        by smtp.googlemail.com with ESMTPSA id b27sm3753961pfh.113.2019.01.17.11.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 11:13:40 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Jourdan <mjourdan@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson-gx: Add canvas provider node to the vpu
In-Reply-To: <c7502035-0986-5d7d-b2b9-a35056146310@baylibre.com>
References: <20190114162229.5412-1-mjourdan@baylibre.com> <c7502035-0986-5d7d-b2b9-a35056146310@baylibre.com>
Date:   Thu, 17 Jan 2019 11:13:39 -0800
Message-ID: <7ho98fcd24.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 14/01/2019 17:22, Maxime Jourdan wrote:
>> Allows the vpu driver to optionally use a canvas provider node.
>> 
>> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> index 44c5c51ff1fa..9b0ac183ee0c 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> @@ -510,6 +510,7 @@
>>  			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
>>  			#address-cells = <1>;
>>  			#size-cells = <0>;
>> +			amlogic,canvas = <&canvas>;
>>  
>>  			/* CVBS VDAC output port */
>>  			cvbs_vdac_port: port@0 {
>> 
>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Queued for v5.1 (brancH: v5.1/dt64)

Kevin
