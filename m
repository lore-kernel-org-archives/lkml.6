Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17575C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF02E21872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKn8VhNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfADViF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:38:05 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46745 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfADViE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 16:38:04 -0500
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so33536956ljh.13;
        Fri, 04 Jan 2019 13:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i/NSCxaveOuhHWFSvU56Hrhcl32v91VeK17YtFmf+iI=;
        b=OKn8VhNlhSs1cCv0r5RGV/quCG0dPoXqhtQueAsWi4SegVGCZE3SoO5H0m4F+64Bzf
         zB/FVB8gLyVx9rTVHcReu0ngkKQ9CT7zObzzo0Yv7o8vPgQgXDzWQqhzmnkTah0jHXzL
         NwvnHYpUaLXJta2wkNJ+0PUR/8r/i78EO5oNQFQGQ6OlHcwVxX+E16fK4sPzxaduuIMO
         HcpqpPsSrxHfT8gR+Ua7Z+S2vcJlHk7sUNyBKNEEZt2cI8psRsNKuo5cAVNAV+kRtN8d
         ZIoQxi6Wu35MEwOd0h0qm+0hJWkOWKEfsJ5gwQbK8ghj5i0rGv2jgi02t4H8iJbEdgTv
         +qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i/NSCxaveOuhHWFSvU56Hrhcl32v91VeK17YtFmf+iI=;
        b=esAR988nkHC8bn3x20NK43y27Tt3+G+fMaLAqY+JqDrNXiyqOxg601QhZYtY6yJhrr
         x/HNacngT6pL2fF+POPBPYtQo7kJlOk1VENmRyZDupVocDZ1fm6FvT9oB3pxdnhpnsc5
         QHGh7Qg8+Rt9m6vyrqcFFn03cedZiUYcBuY/Gj6NOGjbD92WrGbUonF5SegfrLi6bH/d
         UIQ9J0pAaTlOavk58IhFvmEbVhFM082eUfKtfLNP0PPxOhKYXMcZ2/im52Xwj8xv1Ozf
         mAF7/Wh6Kc29JnyvSX8gpHz43wpxgnBUPTJq+4YKW5vHNZDaA4QyFwvAWQVQQHMbTIDF
         4uOg==
X-Gm-Message-State: AJcUukcHCApYNmpmIGYE77s9iJLDc+URJhJ1aBZ9Jss1wKbgP03FL3zV
        R3OSNW6FPx0fMRQPLPfIX91xaQnM
X-Google-Smtp-Source: ALg8bN5cIPKca2QgdO1c9Nn23Zf6lBXCeDCy9uit4+yhfvfN6OYis75TjOPwWARf7K4kZpppbcScVA==
X-Received: by 2002:a2e:4942:: with SMTP id b2-v6mr8154233ljd.168.1546637881849;
        Fri, 04 Jan 2019 13:38:01 -0800 (PST)
Received: from [192.168.1.18] (bgt246.neoplus.adsl.tpnet.pl. [83.28.83.246])
        by smtp.gmail.com with ESMTPSA id r69sm11588556lfi.15.2019.01.04.13.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 13:38:01 -0800 (PST)
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     Pavel Machek <pavel@ucw.cz>
Cc:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com>
 <20181219201047.GA23448@amd> <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
 <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
 <a72c11c0-949b-bdbc-df2c-4490e04a1065@gmail.com>
 <986b5105-2fdb-bd25-7c8a-ca8fd1ade821@gmail.com>
 <7f205102-e854-f1cb-cc03-1307d1cddc87@gmail.com>
 <c9f8965a-90f4-b456-8225-c70694c9f071@gmail.com>
 <cf6c0025-36e7-197b-b27a-1f31fb45cc38@gmail.com> <20190104201256.GA2931@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <a4e3a782-de76-ba91-3727-4db69cf27c3a@gmail.com>
Date:   Fri, 4 Jan 2019 22:37:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190104201256.GA2931@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/19 9:12 PM, Pavel Machek wrote:
> Hi!
> 
>>> I suppose if one would just make it an array of values (separated by
>>> space) and then one file with string array of color element names and on
>>> file with maximum value array it could be within those words.
>>>
>>> The it would be something like:
>>>
>>> $ echo "23 54 32" > color
>>
>> Go ahead, but first convince Pavel, and then Greg :-)
>>
>> I'd personally would not have much against, especially that the
>> list of values will not grow for that one like in case of old patch set
>> [0] where Pavel and Greg thwarted my similar attempt.
> 
> Oh, you can get this past Pavel (and probably Greg) -- if you have a
> good reason. Performance is _not_ a good reason. You don't need to
> change LED color 50000 times a second.

We would need to do some profiling here to check if the problem exists.

But, aside from that hypothetic issue, we need a solution for
LEDn_BRIGHTNESS feature of lp5024, i.e. setting color intensity
via a single register write. How would you propose to address that?

> If you can demonstrate a reasonable design, where user selects color
> from well-known RGB pallete and either kernel or library+kernel acts
> to set that color on the LED, we can talk.
> 
> When user asks for white, it has to be white. Exact color temperature
> does not matter. When user asks for pink, it has to be pink. Again,
> exact color does not matter; different monitors display slightly
> different colors, too
-- 
Best regards,
Jacek Anaszewski
