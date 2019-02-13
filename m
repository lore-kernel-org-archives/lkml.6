Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3941C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD04222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwEfcXRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbfBMMhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:37:36 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:37182 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfBMMhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:37:36 -0500
Received: by mail-wr1-f48.google.com with SMTP id c8so2315270wrs.4;
        Wed, 13 Feb 2019 04:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wZcckwGbNKuxqmiEBKZgD7KWzvad4ZX7KVMbLTqJqug=;
        b=FwEfcXRDbhMdRqqI9EYmprN8T9jkTpsVO9VJBlJiCeInhTaayupzzUv3dSyhpWOsO5
         ZKgP0pE8fHwy5dwPLclhHGrMdmF4hC7RCiYvWeKfgoT3UHJCj2qjMV9P9+Du/Aig7Urc
         DOAv8t3OssnTT6CcjIsGHpb/DJDsK/WymFzfXnG5Nai8xSS0BmrVII/jJRh2AJkQzpWe
         GW59y11Xx026ivfWjzJzBGHyH66XsEDx6UM/+ZVxdcrRd8aCjUO7DSJvDhBL23C/qYW5
         IJeKkAqIgq8/t6TqV1sb7HiIS6R/XWsXfSZqH0rZMDAnJs2H2tsN4fVTGDMFDj5ZuNtc
         HtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wZcckwGbNKuxqmiEBKZgD7KWzvad4ZX7KVMbLTqJqug=;
        b=SNTckPDQ2gtzqpvmFQU3Nzmw5qmZC2XsLuOia1fIeWTwiwLnSRKwLN+7gLx5V2VIi4
         ovqz7pKlgWfIcDo595R1quGO5RdiNqcbpDzYbPhWoy2TZmYy96FbT4aTISWHx/A3v6jr
         jXnpEoIHQm9d9vC8nkUYrrET7zKxTt9GUPgiLhsBuveoXlz3xUxZxwyeciLJNv5p0wm2
         cYK7JBbl4LTfSCixSfOKJJns/ZhLlpsuU7A7IkpXAVl4Jz7mcblsfSnKw+Z//t0l3lbw
         E/Pf6HIlaS273NUf39mT8UbbIz/BJu07jmqkOM4zrAO5uiy43eWcsRzBhu++SXuGTdhg
         bA2w==
X-Gm-Message-State: AHQUAuZKhrERR7j4Jjm0V7x0b5uOJF5R1BitMDzeJHIOSI1Vt+CDcR0+
        bECKJJk+3AdIxt+J4qOZ7UM=
X-Google-Smtp-Source: AHgI3IYbKl5IIpvwv9Yt/ty7IrMhM7ou6eUZKQfyTXofE7Fv8MBoGbp+rRriNv/xQe6gPgy5xdYPGg==
X-Received: by 2002:adf:fbc8:: with SMTP id d8mr247630wrs.318.1550061453962;
        Wed, 13 Feb 2019 04:37:33 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id e9sm28251012wrc.56.2019.02.13.04.37.32
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 04:37:32 -0800 (PST)
Subject: Re: Applied "spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver" to the spi tree
To:     Mark Brown <broonie@kernel.org>, masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        zhengxunli@mxic.com.tw
References: <20190212142236.2807D1128113@debutante.sirena.org.uk>
 <4f91497a-96ee-4c10-436f-4d011edb3834@gmail.com>
 <20190212144359.GD20635@sirena.org.uk> <20190212164940.GI20635@sirena.org.uk>
 <OF9C8DA179.15D69C0A-ON482583A0.00283EB5-482583A0.002E45C8@mxic.com.tw>
 <20190213121635.GD7540@sirena.org.uk>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <acb7940e-df38-97a7-8500-4825fb0f6604@gmail.com>
Date:   Wed, 13 Feb 2019 13:37:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213121635.GD7540@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/19 1:16 PM, Mark Brown wrote:
> On Wed, Feb 13, 2019 at 04:25:32PM +0800, masonccyang@mxic.com.tw wrote:
> 
>> From current mainline branch, MFD seems support the device which is on 
>> the same hardware bus(i.e, I2C, SPI, MMIO and SPMI)for multi-function 
>> by Read/Write the common same registers.
> 
> That's most MFDs but there are some that do some level of enumeration
> (even if it's just looking at the device ID that got registered) to
> decide what subdevices get registered, that's what people are suggesting
> here I think.

Right. Although I think some of the code could be shared between the SPI
and HF modes.

>> I am checking and not sure if MMIO of MFD could support RPC-IF for 
>> different hardware bus on SPI and CFI.
>> I also doubt if this method is a correct solution for RPC-IF works
>> either in SPI mode or CFI mode.
> 
> For MMIO devices MFD just passes through the parent resources.
> 


-- 
Best regards,
Marek Vasut
