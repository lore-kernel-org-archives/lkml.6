Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0CBC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2292146D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBPIwkPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2292146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbeLGMFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:05:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35699 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeLGMFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:05:35 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so4283532wmh.0;
        Fri, 07 Dec 2018 04:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gn5yqExkx8LVvnPewt7HQgCoJFwOisj7gpd88seTwT0=;
        b=ZBPIwkPeGAFDY7r8g/YJ4qtcJU+DtzWz55YJlO3Kb2cFhj3Yq43xEpXjidkLVWpoXx
         URyC+r1FWFEQz6R3GzNCKHbC9IARrKjHhGnHfhcwjlYoQXH0WDQMWdgpphG8SNaUHXan
         YT6JB4328oMIHyJOyFL0gFHX513T1aczEE5PEVv6U66pHYHF8wsb/qRt9B4Vbatbz1ea
         IZdM8foe7M7EW+ceCObJWWAd8Q+xPFiBakfU96BI5ya7tfSRH9+kXXuuS0AnjHyQvBa6
         OzEoNjFrV2FTfkfNumIzkrIgthcdwIg4FAYZblDRqTlVgUXbUy2P4hi2sDC9EtN2FSCM
         LIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gn5yqExkx8LVvnPewt7HQgCoJFwOisj7gpd88seTwT0=;
        b=MI6zopIHKUwhl7Le9vusTpLWv3Z6OFuAbz/MgMdrwLanqQBcE7lYZAUIgJmhGB76F7
         aqt2Opsof0EcdlnIUkpFSd3Bx/zc8iUHAXOCUOQqHdubNmX99KkuVdOqyOThYH49JuHJ
         4cVrritWzbOD5qmuBuWqN8l5D0v68j2Bzuz9NoqdHbcBeFGhvUYAWqrE3dnrZbwpPyEg
         nliY/nnClP4fqPGX9gMOdVbUGX1u01qySLoVqZaUQxO7gHBWw476uIH2hjfJN1fgweW1
         vwMHBYfgvnthSg7ua/R/UwzsiGzg9j/qUhrUGa+284fES4LGrtWHICjMfOYJ8HwAaSRf
         MTig==
X-Gm-Message-State: AA+aEWbDbdtuiyGC4+agpWlIbHzFBevm26UsLmFrMNAdtF0x0dGd6Fkg
        DEq10+h0y5KsyeNEc+emleD/Qsiq
X-Google-Smtp-Source: AFSGD/VZB2rxzCXcCSQ0y0cRRBaGodg5yRFSzxYxlHnU6fMjU9yiX3JIzCf8QkdgR4CwznivmdaabQ==
X-Received: by 2002:a1c:2457:: with SMTP id k84mr1978795wmk.139.1544184331386;
        Fri, 07 Dec 2018 04:05:31 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id r64sm4295136wmg.5.2018.12.07.04.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 04:05:30 -0800 (PST)
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
To:     masonccyang@mxic.com.tw
Cc:     boris.brezillon@bootlin.com, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, zhengxunli@mxic.com.tw
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
 <cebe44a3-80be-9091-e70b-acba6f3fff4f@gmail.com>
 <OF0ED3C578.141B72CA-ON4825835A.0025CA62-4825835A.002A7BDF@mxic.com.tw>
 <84e3c55b-687e-28f6-0a7c-1c48c822ef05@gmail.com>
 <OFC9FB54F8.34B3A8B7-ON4825835B.00267480-4825835B.0029455C@mxic.com.tw>
 <93bb36af-8bdb-c90e-3777-62fe1a48f76a@gmail.com>
 <OF0CE74C5C.20959BA6-ON4825835C.0026C7BC-4825835C.0028B3A4@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <8517f472-4981-db32-f5d8-056b70584e86@gmail.com>
Date:   Fri, 7 Dec 2018 13:01:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <OF0CE74C5C.20959BA6-ON4825835C.0026C7BC-4825835C.0028B3A4@mxic.com.tw>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2018 08:24 AM, masonccyang@mxic.com.tw wrote:
> 
> Hi Marek,

Hi,

>> >> >> > +
>> >> >> > +         regmap_write(rpc->regmap, RPC_SMWDR0,
>> >> >> > +                 *(u32 *)(tx_buf + pos));
>> >> >>
>> >> >> *(u32 *) cast is probably not needed , fix casts globally.
>> >> >
>> >> > It must have it!
>> >>
>> >> Why ?
>> >
>> > Get a compiler warning due to tx_bug is void *, as Geert replied.
>>
>> The compiler warning is usually an indication that this is something to
>> check, not silence with a type cast.
>>
>> > Using get_unaligned(), patched code would be
>> > -----------------------------------------------------
>> > regmap_write(rpc->regmap, RPC_SMWDR0,
>> >                  get_unaligned((u32 *)(tx_buf + pos)));                
>> > ----------------------------------------------------
>>
>> Do you need the cast if you use get_unaligned() ?
> 
> yes!

Why ? (you can drop one iteration here by explaining why right away,
since I'll ask for that explanation for sure)

>> >> >> > +
>> >> >> > +static const struct regmap_range rpc_spi_volatile_ranges[] = {
>> >> >> > +   regmap_reg_range(RPC_SMRDR0, RPC_SMRDR0),
>> >> >> > +   regmap_reg_range(RPC_SMWDR0, RPC_SMWDR0),
>> >> >>
>> >> >> Why is SMWDR volatile ?
>> >> >
>> >> > No matter is write-back or write-through.
>> >>
>> >> Oh, do you want to assure the SMWDR value is always written directly to
>> >> the hardware ?
>> >
>> > yes,
>> >
>> >>
>> >> btw. I think SMRDR should be precious ?
>> >
>> > so, you think I should drop
>> > regmap_reg_range(RPC_SMWDR0, RPC_SMWDR0)
>>
>> No, I am asking whether SMRDR should be marked precious or not.
>>
> 
> I don't think so,
> precious_reg: the register should not be read outside of
> call from driver, i.e,. a clear on read interrupt status register.

If you read the reg outside of the call from driver, it will mess up the
internal FIFO and the whole driver will get into undefined state, right?
Maybe Mark can chime in ?

>> [...]
>>
>> > CONFIDENTIALITY NOTE:
>> >
>> > This e-mail and any attachments may contain confidential information
>> > and/or personal data, which is protected by applicable laws. Please be
>> > reminded that duplication, disclosure, distribution, or use of this
>> > e-mail (and/or its attachments) or any part thereof is prohibited. If
>> > you receive this e-mail in error, please notify us immediately and
>> > delete this mail as well as its attachment(s) from your system. In
>> > addition, please be informed that collection, processing, and/or use of
>> > personal data is prohibited unless expressly permitted by personal data
>> > protection laws. Thank you for your attention and cooperation.
>> >
>> > Macronix International Co., Ltd.
>>
>> Can you do something about this ^ please ?
>>
> 
> I submit the patch file is by another remote git-server, which
> supports git-format patch, git send-mail and so on.
> But it can't receive email.
> 
> I get/send email are by office PC w/ Notes system and
> this "CONFx NOTE:" is appended automatically by Notes mail-server.
> 
> Please just never mind it.

I am concerned MXIC can sue everyone on the CC list of this email based
solely on your suggestion to ignore this paragraph. That's not a good
position to be in.

-- 
Best regards,
Marek Vasut
