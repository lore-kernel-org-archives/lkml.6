Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263EDC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62D42505C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3ZftqkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62D42505C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754321AbeF0M4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 08:56:07 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39620 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbeF0M4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 08:56:05 -0400
Received: by mail-wr0-f195.google.com with SMTP id b8-v6so1946796wro.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 05:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rqgmv2bZlKrAs4FEZI93zstm6n9udfV7r4r+9et2LXE=;
        b=t3ZftqkTao4M+f+dO8/vuKlqZ1D6XjRkIJKGAt0Pkw52h75KEPG1qC9sRmxfXf0Gfy
         Lc7M69CE+6pTDIeD/JZhwol5VsoIKdnVT9pX9uMVLMcbopd/o3lCKm/QHJmBBwhlqqgz
         BFmHs4mOgucu0L6IJ+soeb4dCI5oWltev/cpSAZr5WKq2MPtmf9OGABCTZ2tI7rZvZRP
         ufT69j2xRcbzA6melapwkn8+UyqC37nllw1T91NdHvA/0Jgvo0hGcOJ8GytiL3Ydl3Rv
         yva+NEyxol5D7BYcmw89EkWmhOV875lrhvjSzXg7nlxnA0P9z5pTOLEGzI0x5t8mdtKP
         as+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rqgmv2bZlKrAs4FEZI93zstm6n9udfV7r4r+9et2LXE=;
        b=jHdAp5BxxDOEqmTNQU5vuWPPSlKhXpOjgrTW0BJOFio16oxbAdYfc0iNiYBq/7H8/r
         JSB54GoMwyPj98m5dAG5FX0GooNyziDvy+VxRGJAeQ+HWlWMBWsstaHLojatItawnpXH
         jpXdy8Idh2AEPXRpdlPtI7UsodcSoAXIA7Johr3vc83Y6r+qPYJZt4k10Q68ODmE/C1J
         S1qQ8CghwmpqGkF1rHp6c0fyy7BJ3tNTZlT47XLTrT6hDqMpCFNYWi9BIuolqgEnMkac
         ASrLTbOZsTKjUQngnbm6Y4ot4tjCosBDFgvOKWf0vH4HBG6yU9Jj4wYBVBOLe4JQjqGq
         q5UA==
X-Gm-Message-State: APt69E0F1IYUe4v7CKPSSqCEl844h2/EQAhlzrilNWZR1oPmnH7hb0G1
        iXTU0J0LVtcDw4mfuEtKT1rD4zNo
X-Google-Smtp-Source: AAOMgpcifkIQQWy4ka49nbxgqO+PMHnWqpFqf4Rx34vggBa6nU/ZcS+6QT6yyOMn8k2vEtYIn6T5LQ==
X-Received: by 2002:adf:92e7:: with SMTP id 94-v6mr5143232wrn.70.1530104164111;
        Wed, 27 Jun 2018 05:56:04 -0700 (PDT)
Received: from [192.168.1.4] (x4db2cd79.dyn.telefonica.de. [77.178.205.121])
        by smtp.gmail.com with ESMTPSA id o131-v6sm4935888wmo.22.2018.06.27.05.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 05:56:03 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] staging: rtl8723bs: use ether_addr_copy() in
 rtw_macaddr_cfg()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180626081409.9518-1-straube.linux@gmail.com>
 <20180626081409.9518-3-straube.linux@gmail.com>
 <CAHp75Vc3gEyP+h_XtJV7zKZV0J++Nyr04au7Rtu3h5y0JJASXg@mail.gmail.com>
 <37cca7e4-3c1f-b1ab-14b3-fd3dbbae8b01@gmail.com>
 <96782a8bbc8d5a8a911447beda78ca4eed6b9f04.camel@perches.com>
 <2a49e8e7-15ef-af4f-1039-b15ae60df11b@gmail.com>
 <20180627083306.rk3niwazi332rqs5@mwanda>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <6221958a-f817-e01b-7e0f-adbbba9acde4@gmail.com>
Date:   Wed, 27 Jun 2018 14:56:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627083306.rk3niwazi332rqs5@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 27.06.2018 um 10:33 schrieb Dan Carpenter:
> On Tue, Jun 26, 2018 at 10:32:09PM +0200, Michael Straube wrote:
>>
>> On 06/26/18 22:17, Joe Perches wrote:
>>> On Tue, 2018-06-26 at 21:44 +0200, Michael Straube wrote:
>>>> On 06/26/18 19:32, Andy Shevchenko wrote:
>>>>> On Tue, Jun 26, 2018 at 11:14 AM, Michael Straube
>>>>> <straube.linux@gmail.com> wrote:
>>>>>> Use ether_addr_copy() instead of memcpy() to copy the mac address.
>>>>>>
>>>>>
>>>>> Suggested-by ?
>>>>>
>>>>
>>>> I'll add it. Sorry, I was not aware of the Suggested-by tag.
>>>>
>>>>> Btw, ensure that the source and destination buffers are aligned to u16
>>>>> as required by API.
>>>>
>>>> To be honest I'm not sure how to do that excactly.
>>>>
>>>> Use __align(2) in the array declarations? e.g.:
>>>>
>>>>            u8 mac[ETH_ALEN] __align(2);
>>>
>>> All initial function automatics are naturally aligned.
>>>>
>> So there is nothing to change? Now I'm confused.
> 
> Do not add the __align(2), as Joe says, it's not required.  You just
> need to C alignment rules (it's expected/required for this sort of
> patch).
> 
> Like if you have a struct:
> 
> struct foo {
> 	char a;
> 	int b;
> };
> 
> There is going to be a 3 byte gap between a and b because ints are
> normally __align(4).  The exception is when the struct is __packed.  So
> sizeof(struct foo) in this case is going to be 8.  kmalloc() returns
> pointers which are 8 at least byte aligned normally.  See
> ARCH_KMALLOC_MINALIGN.  There is one arch where it's 4 byte aligned?
> 
> So when you would get things which aren't __align(2) is when you have:
> 
> struct bar {
> 	char a[3];
> 	u8 mac[ETH_ALEN];
> };
> 
> Here the struct member before the mac[] is an odd number of char.  Or
> when the struct is packed.
> 
> regards,
> dan carpenter
> 

Thank you for your explanation. I will not add __aligned(2).
The other buffer is u32 aligned:

struct eeprom_priv
{
         u8 bautoload_fail_flag;
         u8 bloadfile_fail_flag;
         u8 bloadmac_fail_flag;
         u8 EepromOrEfuse;

         u8 mac_addr[6]; /* PermanentAddress */

	...

         u32     ocr;

	...
};

Should I add a thanks line to the commit message:

     Thanks to Dan Carpenter, Joe Perches and Andy Shevchenko.

Or would that be considered as too much?

Regards
Michael


