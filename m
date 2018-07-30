Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE76316256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D4F20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHXySuFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D4F20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbeG3SuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:50:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43300 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeG3SuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:50:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id b15-v6so13700439wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 10:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qsF4L83wXKb5uhD2p+RU7glqMFe00963Sr7cybrSN7g=;
        b=pHXySuFQYO5Noctv0LNv/CmpNTvRKXv5/UuLtN8SlhBrigFJFHaFlnpWI2K+xXOjal
         xqW+bcns3De8TZ373nMTszxDUEz3VBFAvnlYtZYB+/FKFI8dw+3WVJU5QO4qoB2CbSEE
         TDYeVUfgdlz3m4jLIlNRnUsMEmAgpTZ9JAeDv1wnn5YbLdK99FGWytBvJI0am4PPHcM0
         MHR8TZgiH3H5oRdho0kPfMAKoq3ID6rm0Z8js+gp5Cb5GzPtwWPW0LAwcRiOK7djTsLi
         9bHONebX7hNh7GOYEq78R06e3X5HC3PQt/pIQQPV/5e3gjepTCof2vYtU/8+quRertfj
         wSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qsF4L83wXKb5uhD2p+RU7glqMFe00963Sr7cybrSN7g=;
        b=GmDy/aqfsRw0if2eAgm0WlcI9R4YWVAoKvcRoYet4iWnLlfqHTiCJoAwLt3AH6ypvh
         olOx5YSO9222ms7q4OVMCMsnBbd8Ram40+im/B6/s/FWKPjmzvSiuUdcGz+3CQmDUnGa
         cch17e4zi4AGzEhRRqbdpsO5MDN7mDWzzG3b0DnsQHU3RJhiCKHrCUKiHR2A8iBZv63e
         E0R3CFFq1TjX+yz+k9GVktzYoCSjuV9bXoJsUVNQvurOtkDvtwOLuFJHsG0BJh3/fR6W
         2UzIBXnGMB8IHJpL7TnyfE0ozyC9Je20FlOom7L1Hh21iKSDbsTjrJW3nYMe2w+10jiF
         v6wA==
X-Gm-Message-State: AOUpUlH2+afu+okFYKRdzdkifsrozGfTiYBhBTZdD9+Qofv/cfEXRAmo
        qzIYDxhzIQn0B0MDIDTfXVOkT3/l
X-Google-Smtp-Source: AAOMgpeS7jNz79zvQ95BJJsraJ6oAcpWTdWyPBnGEQfi6Fb3+gVa0Z4mzSHkv48OkllTijgsofdhHA==
X-Received: by 2002:adf:ad38:: with SMTP id p53-v6mr18904479wrc.10.1532970852438;
        Mon, 30 Jul 2018 10:14:12 -0700 (PDT)
Received: from ?IPv6:2a02:8108:85c0:57c8:32db:916d:97a2:c4eb? ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id a6-v6sm113981wmf.22.2018.07.30.10.14.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 10:14:11 -0700 (PDT)
Subject: Re: [PATCH 8/8] staging: rtl8188eu: use is_broadcast_ether_addr
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180729170851.2581-1-straube.linux@gmail.com>
 <20180729170851.2581-8-straube.linux@gmail.com>
 <07a456ef0b1163115ef9aeb717120c191263fe28.camel@perches.com>
 <90fb5087-22df-0480-548a-7658881181c8@gmail.com>
 <12e1804800e490aa57b51a0e64c6da573d32a3a4.camel@perches.com>
 <85e40925-21aa-1030-24ed-9dce498b98f6@gmail.com>
 <1c0e7b1e14f1bcca152426a7a38c1ec278ca10f4.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <d2fe2762-31ca-7119-047e-c92a80c7f369@gmail.com>
Date:   Mon, 30 Jul 2018 19:14:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1c0e7b1e14f1bcca152426a7a38c1ec278ca10f4.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29/18 22:05, Joe Perches wrote:
> On Sun, 2018-07-29 at 20:21 +0200, Michael Straube wrote:
>> On 07/29/18 19:59, Joe Perches wrote:
>>> On Sun, 2018-07-29 at 19:42 +0200, Michael Straube wrote:
>>>> On 07/29/18 19:21, Joe Perches wrote:
>>>>> On Sun, 2018-07-29 at 19:08 +0200, Michael Straube wrote:
>>>>>> Use is_broadcast_ether_addr instead of checking each byte of the
>>>>>> address array for 0xff. Shortens the code and improves readability.
>>>>>
>>>>> You should show in the commit log that sta_addr is __aligned(2)
>>>>> as required by is_broadcast_ether_addr, otherwise you could be
>>>>> introducing runtime alignment defects.
>>>>>
>>>>
>>>> Ok, sta_addr is used from following structs.
>>>>
>>>> struct ieee_param {
>>>>            u32 cmd;
>>>>            u8 sta_addr[ETH_ALEN];
>>>>            union {
>>>>            ...
>>>>            ...
>>>>            }; u
>>>> };
>>>>
>>>> struct ieee_param_ex {
>>>> 	u32 cmd;
>>>> 	u8 sta_addr[ETH_ALEN];
>>>> 	u8 data[0];
>>>> };
>>>>
>>>> Well, looking at it now, I'm not sure about the alignment anymore
>>>> in the struct that contains the union. Is sta_addr in the first
>>>> struct __aligned(2)?
>>>>
>>>> Should I include the snippets in the commit message, or is just
>>>> writing that sta_addr is __aligned(2) enough? (if it is in the
>>>> first case...)
>>>
>>> It's enough to just state that the uses are properly aligned
>>> as long as you looked and understand that it's required.
>>>
>>
>> Ok, thank you.
>>
>> I looked at it and understand that it's required.
>> But, as mentioned, at second look I'm not sure about the union.
>>
>> I guess I need to read a little more about the alignment of unions.
>> Any hints are welcomed. :)
> 
> The union doesn't matter here.
> Only the locations of sta_addr matter.
> Both follow a u32, so they are also aligned to a u32.
> 
> That is actually not guaranteed by the c standard
> as the u8 array could have arbitrary padding bytes
> inserted between the u32, but no compiler used by
> the kernel does that.
> 

Ah ok, thank you.

Michael

