Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387D9C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB1D206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="PHgdoWRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB1D206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbeLCWYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:24:20 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37591 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCWYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:24:20 -0500
Received: by mail-qk1-f195.google.com with SMTP id 131so8425698qkd.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 14:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5Qg81U+ca65JeAAqq1YakJhxYwuFlumKDwYG7cVu3Tg=;
        b=PHgdoWRL8TZXfFZNYAig82LEES6/Czv/U+5esE0BmBow2Kocx7ZibBiCsVatbAwMaB
         Wr7w6lKYr14y+wyNRy76NuInPz9ZF5235l2w8DaPSMCoqFppQ+hXeAAXcobhHUfquPLf
         CMaxpYo/2Lxn63eianndOOecCrcqfQHognYdAqli3eRLCu+bDsNfkoAHnQtbg3A7+gYn
         WFUzGvqS89r7h4vSTbpBLPBspIm1xOQeskpxZ8U5m1ohWeoEFDmBqEuJ+qS17cJtcjPh
         oZy+mSnNL3ugAFgrxkHwfjmlpkck+Qiqazqpeh3oYzpkAbGxJjeFqu99s7KA5PRqwArK
         rihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Qg81U+ca65JeAAqq1YakJhxYwuFlumKDwYG7cVu3Tg=;
        b=AqKlqDIKtSSva3r0IXGvknVD6aifzyI9Z42dzXMvceWjQgA5cnmiCpfSOdvm2/KZtS
         KMRjRUTZ3THIIFFaxXysQLNLUmadROn5FGwt+NMhPOu/AiClAvJbg98iYaYRDBJCXAA2
         jXmgCyjTHDTjYxYXBi6oK57dc0nsiYF+vta9GgEn2WoZYhvKwH1fBZ15zhOPARal6TSJ
         AhnUaNB4Jb2S++665y7LV4b/ucORf54w//1Snhv+RxHbaDVuxO1lxjjh3Ct4K61PXhgp
         WkWTdyVnh878bS63Si/illdwiqHul3kGMobjnX6LVlI6/0Z3NWyg7rXyzVHHPr+UOKXf
         YnUA==
X-Gm-Message-State: AA+aEWZlunfqL/U6YAtrKURw2yievcte4F6b5ZzzsTWzWOaxSAhNesYf
        37xQJSCHUZ3ZD6QAQtv4Mlp4iiwbIWLtHA==
X-Google-Smtp-Source: AFSGD/UpDy6lMDJrG9loWlVpLvJR7kt985EHx0qBJP1XCqaPyFmU5cnT1l4iK2rXeGuQJyDQ1yREwQ==
X-Received: by 2002:a37:cf9b:: with SMTP id v27mr16179832qkl.160.1543875858364;
        Mon, 03 Dec 2018 14:24:18 -0800 (PST)
Received: from [192.168.0.189] (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id y2sm11441367qtb.88.2018.12.03.14.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 14:24:17 -0800 (PST)
Subject: Re: [PATCH v3 4/4] ARM: dts: imx5: add gpu nodes
To:     Fabio Estevam <festevam@gmail.com>
Cc:     freedreno@lists.freedesktop.org,
        Chris Healy <Chris.Healy@zii.aero>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20181203211816.5129-1-jonathan@marek.ca>
 <20181203211816.5129-4-jonathan@marek.ca>
 <CAOMZO5B18DyZ0zvit6AgaueMifnMf2ctSo7pE_XndRpt7+bnLw@mail.gmail.com>
From:   Jonathan marek <jonathan@marek.ca>
Message-ID: <3e8d1f9e-ffb4-dd6a-0a68-f59b4c1134a0@marek.ca>
Date:   Mon, 3 Dec 2018 17:21:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAOMZO5B18DyZ0zvit6AgaueMifnMf2ctSo7pE_XndRpt7+bnLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2018 05:16 PM, Fabio Estevam wrote:
> Hi Jonathan,
> 
> Thanks for working on this. Really nice to see GPU support for mx51/mx53!
> 
> On Mon, Dec 3, 2018 at 7:21 PM Jonathan Marek <jonathan@marek.ca> wrote:
> 
> Please add a commit log.
> 
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> 
>> ---
>>   arch/arm/boot/dts/imx51.dtsi | 17 +++++++++++++++++
>>   arch/arm/boot/dts/imx53.dtsi | 17 +++++++++++++++++
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
>> index 67d462715..e9a7bbce9 100644
>> --- a/arch/arm/boot/dts/imx51.dtsi
>> +++ b/arch/arm/boot/dts/imx51.dtsi
>> @@ -628,5 +628,22 @@
>>                                  clock-names = "ipg", "ahb";
>>                          };
>>                  };
>> +
>> +               gpu: gpu@30000000 {
> 
> We put the peripheral nodes in address order, so this one should go
> prior to the IPU node.
> 
>> +                       compatible = "amd,imageon-200.1", "amd,imageon";
> 
> I can't find the dt-bindings for these compatible entries. Have you
> documented them?
> 

It is the same as qcom,adreno which is documented here:

Documentation/devicetree/bindings/display/msm/gpu.txt

I guess I should add amd,imageon there.

>> +                       reg = <0x30000000 0x20000>;
>> +                       reg-names = "kgsl_3d0_reg_memory";
>> +                       interrupts = <12>;
>> +                       interrupt-names = "kgsl_3d0_irq";
>> +                       clocks = <&clks IMX5_CLK_GPU3D_GATE>, <&clks IMX5_CLK_GARB_GATE>;
>> +                       clock-names = "core_clk", "mem_iface_clk";
>> +
>> +                       qcom,gpu-pwrlevels {
>> +                               compatible = "qcom,gpu-pwrlevels";
>> +                               qcom,gpu-pwrlevel@0 {
> 
> You could drop this @0
> 
