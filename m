Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28508C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D2820892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXpBSLPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D2820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbeLFJOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:14:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36901 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFJOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:14:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so206651wmd.2;
        Thu, 06 Dec 2018 01:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uK9okPm9Mw/4WyB/RnJmeQNoyXRjooQtzepjAV5zljI=;
        b=sXpBSLPf7Iz/kCivuKx53TNjj7sJ1CaH3ZLD04etslXvvod2OzydTmNd+4Y0ajIEGA
         wPaTrpRR8V1i/HOWCU9T5YvvYiIsqtksMfGJV+S6WpMOvQ1z63TMz6Ic5FBSWJhRurOA
         mJNBrbAxf8Z0cuwvXoa8xKWPcMfIOu5cJCOSErKgLP585xg4EReju9hBjaNAvKEnsYvr
         TDTv+MIZkswm6V9J9JGC4l8LKntS/Gn1V9xXq9w7J0+mOSDiHeEYVfJ0RlFJuiO8j6Sc
         Cx/HEyWuylJs+GTnIipUm7xKk/b0FJhEe2ySO9nTg+rgZwkHZ+cUfcFCGwqr4yT07FeT
         LwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uK9okPm9Mw/4WyB/RnJmeQNoyXRjooQtzepjAV5zljI=;
        b=dZBaa6Lbs2jKZ17oK5UUafwM5D6OX4sitYm1UVCfwAuSuJgcpdWoi7CzHvNiXFejii
         GqtZ6tKzcmj/xWTxI1sG4PpqbClIYkGtxv46O1++za2ZAWNUOH+TobPVUZNUVa6naMoB
         fH3NIuaYEiDNjjWztcpVAlSdVWu9KEyRg+awIGEjUBXYR+l+BvGMAtEUE3sjdEQ044C6
         Rbfe79N8fnge9NJGKxbRyFiW3L2KgcXWKDWg0VjPsK/GY+83gYfinsO1skZE/vpMqKPL
         aWsWAF2qPlAAKX/sLFHuecrNLNBiWIcZ/Fc9BMGLGfque8vb1kFwQSHwNKNSH/l5Og1X
         1tOg==
X-Gm-Message-State: AA+aEWakHDHpf0VK4ZCa1ibxwwHpXmlKj5KP1Ia55LqDRs+rSkWQabgW
        /uF0SdOVQfuqXmadEKEVUuY=
X-Google-Smtp-Source: AFSGD/XUFGzkkLudJD4jpR4OZ+WQsvwkGKgbtBMsXEeBE8t5WvWgldTog6ZfMIEPOThP09tm6iE0WA==
X-Received: by 2002:a1c:af89:: with SMTP id y131mr18608376wme.137.1544087658870;
        Thu, 06 Dec 2018 01:14:18 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id h131sm238636wmd.17.2018.12.06.01.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 01:14:18 -0800 (PST)
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
To:     Geert Uytterhoeven <geert@linux-m68k.org>, masonccyang@mxic.com.tw
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>, zhengxunli@mxic.com.tw
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
 <cebe44a3-80be-9091-e70b-acba6f3fff4f@gmail.com>
 <OF0ED3C578.141B72CA-ON4825835A.0025CA62-4825835A.002A7BDF@mxic.com.tw>
 <84e3c55b-687e-28f6-0a7c-1c48c822ef05@gmail.com>
 <OFC9FB54F8.34B3A8B7-ON4825835B.00267480-4825835B.0029455C@mxic.com.tw>
 <CAMuHMdWspyRq_K2Vd6Xk2tqft-oUoMvVhj-zKS-fuhv_edXb8Q@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <915d772b-616b-9f2e-8f4e-16d9d349e0cf@gmail.com>
Date:   Thu, 6 Dec 2018 10:14:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWspyRq_K2Vd6Xk2tqft-oUoMvVhj-zKS-fuhv_edXb8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2018 10:12 AM, Geert Uytterhoeven wrote:
> Hi Mason,
> 
> On Thu, Dec 6, 2018 at 8:31 AM <masonccyang@mxic.com.tw> wrote:
>>>>> Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller driver
>>>>>
>>>>> On 12/03/2018 10:18 AM, Mason Yang wrote:
>>>>>> Add a driver for Renesas R-Car Gen3 RPC SPI controller.
>>>>>>
>>>>>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> 
>>>>>> +   xfercnt = xferpos;
>>>>>> +   rpc->xferlen = xfer[--xferpos].len;
>>>>>> +   rpc->cmd = RPC_SMCMR_CMD(((u8 *)xfer[0].tx_buf)[0]);
>>>>>
>>>>> Is the cast needed ?
>>>>
>>>> yes!
>>>
>>> Why ?
>>
>> Get a compiler warning due to tx_bug is void *, as Geert replied.
>>
>> Using get_unaligned(), patched code would be
>> ---------------------------------------------------------------
>>  rpc->cmd = RPC_SMCMR_CMD(get_unaligned((u8 *)xfer[0].tx_buf));
>> ----------------------------------------------------------------
> 
> Using get_unaligned(0 is a bit strange for accessing a single byte quantity.
> Please keep the normal pointer dereference (including the cast).

Oh, right, for single bytes this is OK.

-- 
Best regards,
Marek Vasut
