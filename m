Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8DAC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76F124F2B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQ9U4HUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76F124F2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933981AbeGAQxw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:53:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55305 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753518AbeGAQxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:53:45 -0400
Received: by mail-wm0-f67.google.com with SMTP id v16-v6so6661260wmv.5;
        Sun, 01 Jul 2018 09:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=qQvFbva73hxZqLylG/dNyUUVZrhANwSZ0rahj9f0Hhc=;
        b=BQ9U4HUMYCNR4BiynV+dKBrieB/KUcQpN7YehSA0kTaNDFlKpP2SsSpGc4xB1En8pw
         F4pO9Q1LGgHQSVjYzQ6Xbeh46C8ywnCNdYiPRETCIfgVN8k6gOTAVIaxHl3if6D7NX/9
         qnML65lLHgU32gICcFMAKWMRogmcO/6yZpBvEhRbFt39m5iZpfatHmQF2+BqHaX7XZ9y
         rmI1ryXF6SofY6MSCFBbCIlpjPJLbHpFVzTyBYhlZ6nBbebkbLHFOAGL7grRCWaQqjoZ
         Dj1R1viMUk1eyFDFnAyKrtHAyNbTBkhr7QHhZ9UjfjhfYmY2fwhwaXtX5wKM5rHsrGiZ
         Yrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qQvFbva73hxZqLylG/dNyUUVZrhANwSZ0rahj9f0Hhc=;
        b=sXJeGsh2gjBmKMLMCXj0VN2iWDeZ/rENeqVLzvG07X/wpCCcajGXMSwRo+BXBdQf2O
         PVfA/x4T3VT2zbT6O/oRC2Z1LfDn8pxP9v6WHLXOZXvW8kRWAlovVtJhivEzqHvsgMHC
         LY+pf961L/8gVzBqKf8+bdRqEuNJxNVaXFHAEJg51LJfVYjQaEFAj6GXR5CM83BRsNiX
         3rzSjhAyx4FfSHIEHjjUGvno7OLd++Hnyr6tyDZI+0VP6brLoOxS/snLrbJd9hgyh8WF
         a6pqz9w75xqo0Pn0EAOxu52QPiFvYbyVkzti9c42HmImVjEZUTvJqhk17GEwXDgnFnkP
         8/JQ==
X-Gm-Message-State: APt69E3obcYQs5GLWhrG5HY+3fMTyUhRMCA9plrOT0OzgpXL+8H5jg7+
        HFcVY3Dud4trlGlmRKAylaM=
X-Google-Smtp-Source: AAOMgpew2Hq1/tChMyELoOFDZaYwh61sxFGTRoK+pbQHvUuR2TpqjcKpu5FP0sSm9t/aappl8jjEbg==
X-Received: by 2002:a1c:29c5:: with SMTP id p188-v6mr6146350wmp.45.1530464023491;
        Sun, 01 Jul 2018 09:53:43 -0700 (PDT)
Received: from [192.168.0.103] (p5B3F6705.dip0.t-ipconnect.de. [91.63.103.5])
        by smtp.gmail.com with ESMTPSA id i4-v6sm7160929wmf.4.2018.07.01.09.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 09:53:42 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Add clock driver for Actions S700 SoC
To:     Stephen Boyd <sboyd@kernel.org>, afaerber@suse.de
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, manivannan.sadhasivam@linaro.org, pn@denx.de,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180626192820.28237-3-sravanhome@gmail.com>
 <20180628191805.3722-1-sravanhome@gmail.com>
 <153029392426.143105.1931235700216822088@swboyd.mtv.corp.google.com>
From:   Saravanan Sekar <sravanhome@gmail.com>
Message-ID: <f35c3ea6-7f3f-17d5-f772-803674f18bdb@gmail.com>
Date:   Sun, 1 Jul 2018 18:53:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <153029392426.143105.1931235700216822088@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen


On 06/29/18 19:38, Stephen Boyd wrote:
> Quoting Saravanan Sekar (2018-06-28 12:18:02)
>> Changelog v2:
>> Fixed 0 day compilation warning
>> Modified existing dts Actions S900 clock bindings common to Actions
>> Soc family
>>
>> This patchset adds clock support for Actions Semi OWL series S700 SoC
>> with relevant clock bindings and device tree info.
>>
>> Changed the UART clock using CMU instance and changes are tested in
>> cubieboard7
>>
>> Thanks and regards,
>> Saravanan,
>> Parthiban
>>
>> Saravanan Sekar (3):
>>    arm64: dts: actions: Enable clock controller for S700
>>    clk: actions: Add S700 SoC clock support
>>    dt-bindings: clock: Modify Actions Soc clock bindings
> Normally this patch comes first, and then clk driver, and then dts bits.
> Also, the header file for the #define constants would be part of the
> bindings patch.

I will reorder the commit and split the patch



