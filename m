Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B53C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB82C205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GXx3dpAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB82C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388438AbeGXMzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:55:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38081 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388278AbeGXMzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:55:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so2219471wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 04:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=le4iNKr222Lmspcbm0L50Yvtetw1QADs2y4XQ66WA1c=;
        b=GXx3dpAB6BfONDu3/V0lu1Bkh1CAD1VyluocuEhqiEIUTGq763ACaBbRhxdmvNFljF
         FBq4p1o5u6EQLKlbc6SJDOcN7053jItjNBZ/yIB5Xc0vUjstUXEnOK1l8br51n2p9hDZ
         5cZm51ltGC+EkOrbO1veplEqMdxZgFK0Dxaq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=le4iNKr222Lmspcbm0L50Yvtetw1QADs2y4XQ66WA1c=;
        b=GCYUQddbykDhiToIYnniiAcbbhj3XlZTVuPI/a9PLknd0RqTB7XjNb6Tx5IqWOZTb6
         FfSxJoiYuFm3Ppf2VyAygNHrp9Q6Q0cDLZxqBsM+BbI4IGwQK6G0A2zSSZHcZO05v65l
         ndyYcZ83g13CvlztB564tELD9ewe1avtQDGsn+HvUO7FWMpjGdMajoU9XJo78R/8PYml
         TDTDyhCw3s8flSUokY3rxxv1jZgS0z8QhVHi2FsLX4539RZHKbJ0j43nMwxrFRrdaJIY
         LBvEvR4xPSnVRdrwBXfih3kjUIMjUu1N7BALJL7njKM6bBwpBmxCOZtB03lI5tVHUeYU
         Xnzg==
X-Gm-Message-State: AOUpUlGnHG/M6uiQwlff+YiV1Lcbd85HDR/s0hMuQRtuTzzBSxMcI7nP
        vYyVa7nDQkcPZIBhcMCnmKoh0A==
X-Google-Smtp-Source: AAOMgpd3wr8kE4RY7b8pZtiSmNC9TFisolcsDioL+MXjAJy923hXnfATo3ns3bxFer8p1E7rOb11hA==
X-Received: by 2002:a1c:c64f:: with SMTP id w76-v6mr1833448wmf.3.1532432938843;
        Tue, 24 Jul 2018 04:48:58 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id x129-v6sm2118205wme.11.2018.07.24.04.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 04:48:58 -0700 (PDT)
Subject: Re: [PATCH 04/12] ASoC: dt-bindings: add dt bindings for wcd9335
 audio codec
To:     Mark Brown <broonie@kernel.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
 <20180723155410.9494-5-srinivas.kandagatla@linaro.org>
 <20180724110602.GA2414@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1f700d0e-57f0-9d9d-cb32-a12c4c4b7243@linaro.org>
Date:   Tue, 24 Jul 2018 12:48:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180724110602.GA2414@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/07/18 12:06, Mark Brown wrote:
> On Mon, Jul 23, 2018 at 04:54:02PM +0100, Srinivas Kandagatla wrote:
>> This patch adds bindings for wcd9335 audio codec which can support both SLIMbus
>> and I2S/I2C interface.
> 
> ...
> 
>> +Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC,
>> +It supports both I2S/I2C and SLIMbus audio interfaces.
> 
> This is a standalone audio CODEC but it also has a MFD binding?  I'd
> have just expected a single binding for a single device.
> 
Thanks for the suggestion!

You are right, I should probably remove the mfd bindings totally.
and move them to codec bindings. And register codec and other blocks 
like soundwire controller as mfd cells. like wm8994.

--srini
