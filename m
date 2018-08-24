Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34434C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4323208EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOlgSPuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4323208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeHXXIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:08:34 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52964 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeHXXIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:08:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id y139-v6so2540724wmc.2;
        Fri, 24 Aug 2018 12:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qcqo8LngFKrB2fc6lOy4NdDqOdBOc8MukXZdGa29JOE=;
        b=ZOlgSPuBTU1OgEhKETuySBFTftEPMIk87iiAz/8s5ax6vBbRNOIKYPI9kJKHSCBNiP
         n/idrBGFoZ3ttRdq7yDsrsAsB2plWJM4hwlg8lgXVrf3XCGXRTMq0NL1gCbQk3E6QRnl
         uBgwgH7On9LzTlTuCCvEOKl3bsHO0//suKpPvP8FQvI8Jq2+YhqtYCUOfaGEwqzTN8hq
         y8AUkcmQk/gSMFLB0wCFDkfADJTk3ujpn88Obsp9hp1/U2ZKY1e9a5agSwWonktMTjAR
         0rHl1iuehdCgeVneqreC3DuQ8WMUvNoz/FtgZ7O1rhFbok0vQU/FW3MPYuPOoSiKun2d
         wg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qcqo8LngFKrB2fc6lOy4NdDqOdBOc8MukXZdGa29JOE=;
        b=eL07FXu+5glOpVp9g0kSFKBH7dsUpq7A5TMqxVvhgkEe/imZk8B0pDBZLE6mvqs4gt
         ej3ROYS8I+tykFbBwvV8yHFN+/RqkqVhIu29T/tSCSwN1ymhkxPtZ0t3r/Vao1Fmy4p3
         0UbyOQDeRqCzM0Qd42CD3UEYjD76YSP8fVh9n8wkxwemeyrPAFFjTSqN61Mm+6ZBV6e4
         k87X5nS3oG0DB/Wcq38epyELPgz7Jbr3Prr/WDJOKkeysch7Ovv30u9JZmAKbc7VOUJG
         bdPfI7ef8DwswtGpi9GyM0uYgw62rahQ5vchwOxwbOSkx76gWZ+DmGFpKxzmMOpFFmZB
         gQlw==
X-Gm-Message-State: APzg51AASipkBy1UFJ7CBR5X6BA1gpO8AAQOhMZ0MoNSDUBXWsYxz/qU
        O7yFCPReUGmtzh0WuRWqKtEgp2+y
X-Google-Smtp-Source: ANB0VdYRQ8RUYXUrkhk4KKlLPH+qvhANunMlfKRxhPJmcemt25zFE2kBpuEl80K1F2aq09rWYNJcjQ==
X-Received: by 2002:a1c:938a:: with SMTP id v132-v6mr2343911wmd.114.1535139154020;
        Fri, 24 Aug 2018 12:32:34 -0700 (PDT)
Received: from [192.168.1.18] (bga163.neoplus.adsl.tpnet.pl. [83.28.64.163])
        by smtp.gmail.com with ESMTPSA id f18-v6sm7932216wrw.32.2018.08.24.12.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 12:32:33 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] dt-bindings: leds: Add bindings for lm3697 driver
To:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20180817151528.21623-1-dmurphy@ti.com>
 <20180824095515.GB4045@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <e868002d-be40-4049-ab0f-16c4a7b47c89@gmail.com>
Date:   Fri, 24 Aug 2018 21:32:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824095515.GB4045@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 08/24/2018 11:55 AM, Pavel Machek wrote:
> On Fri 2018-08-17 10:15:27, Dan Murphy wrote:
>> Add the device tree bindings for the lm3697
>> LED driver for backlighting and display.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> Some nits are below.
> 
>> +The LM3697 11-bit LED driver provides high-
>> +performance backlight dimming for 1, 2, or 3 series
>> +LED strings while delivering up to 90% efficiency.
> 
> LED core is 8-bit only... 

That's not true since this commit:

commit 1bd465e6b0e2b559db47420fea686507a01cfab0
Author: Guennadi Liakhovetski <lg@denx.de>
Date:   Sat Jan 10 18:54:39 2009 +0000

    leds: allow led-drivers to use a variable range of brightness values

    This patch allows drivers to override the default maximum brightness
value
    of 255.  We take care to preserve backwards-compatibility as much as
    possible, so that user-space ABI doesn't change for existing drivers.
    LED trigger code has also been updated to use the per-LED maximum.

    Signed-off-by: Guennadi Liakhovetski <lg@denx.de>
    Signed-off-by: Richard Purdie <rpurdie@linux.intel.com>


but I missed that max_brightness is not initialized in the driver,
so the core will set it to LED_FULL (255) anyway.

> so full dynamic range can not be currently
> used in linux -- right? Is there any plan to change/fix that?
> 
>> +This device is suitable for Display and Keypad Lighting
> 
> "display and keypad lighting."
> 
>> +Optional properties:
>> +	- enable-gpios : gpio pin to enable/disable the device.
> 
> Remove "." at end of sentence, for consistency. "GPIO"?
> 
>> +All HVLED strings controlled by control bank A
> 
> ":"?
> 
>> +led-controller@36 {
>> +	compatible = "ti,lm3967";
>> +	reg = <0x36>;
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>> +	vled-supply = <&vbatt>;
>> +
>> +	led@0 {
>> +		reg = <0>;
>> +		led-sources = <1 1 1>;
>> +		label = "white:backlight_cluster";
>> +		linux,default-trigger = "backlight";
>> +	};
>> +}
>> +
>> +For more product information please see the link below:
>> +http://www.ti.com/lit/ds/symlink/lm3697.pdf
> 

-- 
Best regards,
Jacek Anaszewski
