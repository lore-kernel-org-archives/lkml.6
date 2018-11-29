Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9E4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C2A20832
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1jtNcw/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C2A20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeK2LsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:48:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42735 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbeK2LsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:48:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so85200pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 16:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=wTIVEJtJv5/avaW60+4jG5hER7JhrlIRvpuTz9GqCY0=;
        b=1jtNcw/vSQWvPSDipkdbDLfeRWZrLWdZr0P8P/yWwTYuWUqzF3u47HWoClSKTWPbs9
         hP7UeoS0rCtBrqGWSQny88nwFIofEhSvGposnQI32avQla9Yg7nmLze4qii/mwd+jgiZ
         n7FtLQhgglm2Uc87TYjVMye6gN2xlGl7AYqjXK4i77fWnjH9RKJYRXRNSLBX07/RUpVg
         k7lxLiDxqvW9A3CmNhbKN/dCcLKsl/U/t+q2iEul/J6Q4z8oFeXjQux2N7J+X7/QNyCt
         e002RRdpqTIbw7kR/QyE8LoYE/+RX0KgL9PQuszdE7XS22Dgt8zHmwKkDd01kgdr7Hr7
         vP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wTIVEJtJv5/avaW60+4jG5hER7JhrlIRvpuTz9GqCY0=;
        b=o5SpVGF1eUB94lUa7k/zUSQzSTYq0BgfMEL5t6tm/uToxGF4ipZLrho0c/QiOvssKl
         1hT27MX3PpRcMpWh7eE20Pyot3iZxV3iJuiEFcN0uagrq0PITxeD3+om5hBmdSy6nsZh
         N/7KCKt7Xe7Cl1l9tieDexAcIeEqiw2dLnDRsOyjEqFyx9cPopPA4+pTKxaSkoGGkhdg
         5t4aSKtJD2n0DzF0zTU3owG38aUaCrgzI5C3/AzZMcvNPlCCgL1aRBmPZ+nM5FYQG+pg
         K3H4GOznePGKjp5zEadhREGuawRktOwoj+KnmuQQq5xiIHxAjImpoThooKjfZKxUHppB
         ffaw==
X-Gm-Message-State: AGRZ1gLCHsDwD+Yesji88LPjlj3A4/l64dCmrvJ0NE0lMeWYAwCO/SY7
        F5v/x6Hw9Prgyy+VPJcqIM2RFRySQKQ=
X-Google-Smtp-Source: AJdET5c9imBCvVgftvfxAwgnE4BWW3/uIOPY+cjmZj6+HaEdZuXewlWQ/c5NyPV+6BoHSoQ0NUCnmQ==
X-Received: by 2002:a63:101d:: with SMTP id f29mr35409704pgl.38.1543452282145;
        Wed, 28 Nov 2018 16:44:42 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id p2sm117366pgc.94.2018.11.28.16.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 16:44:41 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        jbrunet@baylibre.com
Cc:     carlo@caione.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ARM: dts: meson: consistently disable pin bias
In-Reply-To: <CAFBinCCDMUem0AJ56jrW2ZQf06Q=O690aRwWY4Ua79np0J+g+w@mail.gmail.com>
References: <20181109140445.17795-1-jbrunet@baylibre.com> <20181109140445.17795-5-jbrunet@baylibre.com> <CAFBinCCDMUem0AJ56jrW2ZQf06Q=O690aRwWY4Ua79np0J+g+w@mail.gmail.com>
Date:   Wed, 28 Nov 2018 16:44:40 -0800
Message-ID: <7h7egwd85j.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> On Fri, Nov 9, 2018 at 3:05 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>>
>> On Amlogic chipsets, the bias set through pinconf applies to the pad
>> itself, not only the GPIO function. This means that even when we change
>> the function of the pad from GPIO to anything else, the bias previously
>> set still applies.
>>
>> As we have seen with the eMMC, depending on the bias type and the function,
>> it may trigger problems.
>>
>> The underlying issue is that we inherit whatever was left by previous user
>> of the pad (pinconf, u-boot or the ROM code). As a consequence, the actual
>> setup we will get is undefined.
>>
>> There is nothing mentioned in the documentation about pad bias and pinmux
>> function, however leaving it undefined is not an option.
>>
>> This change consistently disable the pad bias for every pinmux functions.
>> It seems to work well, we can only assume that the necessary bias (if any)
>> is already provided by the pin function itself.
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Acked-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>
>
> my Odroid-C1 still boots fine from SD card and Ethernet (ping) also still works
>
> Kevin, can you please move this patch from your v4.21/dt64 branch to
> the v4.21/dt (32-bit) branch?
> all other patches from this series are for the 64-bit SoCs, so only
> this single patch has to be moved

Thanks for catching it.

I moved it to the 32-bit branch, and added your ack.

Kevin
