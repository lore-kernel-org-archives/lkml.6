Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5CBC282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC1320880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfA1Of3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:35:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50916 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfA1Of3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:35:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so14261407wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 06:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rv77hy44p2sg3gTb2aSW49HJj4gb22gH1G7PbZ/cG/A=;
        b=VqPfA0NuXpFPchfzn1fAfD1CiyM8whMKwFjzCYIEMXUhEtSZCKPjBbDR9+FBEnmcw7
         wQVuX3IgEJDh63SFuJUWzk7zmjFaMeHXLizIoKtPJD6pLIdpGTozcPLMjhffrrTpIsSi
         6si5Ww3pxPlLpj8k9WO9ltX59sW4nQnfDyzYEpLMjG6vF8I+MqH9g4H4LjvBnjnt3+bF
         gwUck0i6qGOnu2BhWr/ea0wKYyDtfF3blqrbBZYbrKixwus9lIF7wAj8HnK6FA1Teo8G
         Qpfoh/A493DXsS5JnvIGTvh6iI8PxZIHee/PA5s8hyIxmqBsmhHWLjes9Y/NxCAZorfH
         q78g==
X-Gm-Message-State: AJcUukc6tfx0ParqawRasXzTNGDUkv2Qfgn1wALi/HGRq24eCT174KWT
        sZYGNiUYQLJtOYGPB+kQk7tF+Q==
X-Google-Smtp-Source: AHgI3IZp4B88R+u7zY0SAQ54TWu6mqxtk41L1ifg6Ox8EvLfZHBDrgBoUWFjOo57WK4ETScvWkQ3Pg==
X-Received: by 2002:a1c:c1c9:: with SMTP id r192mr6444912wmf.146.1548686126410;
        Mon, 28 Jan 2019 06:35:26 -0800 (PST)
Received: from [10.200.137.150] (ovpn-brq.redhat.com. [213.175.37.11])
        by smtp.gmail.com with ESMTPSA id n15sm88633065wrt.21.2019.01.28.06.35.25
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 06:35:25 -0800 (PST)
Subject: Re: [RFC][PATCH] Update -Wattribute-alias for gcc9
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Sebor <msebor@gmail.com>
References: <20190125104353.2791-1-labbott@redhat.com>
 <CAK8P3a0xnc7RNbGhG7-hj+ay2keR7dh7MmDiUNKxfewsnatsgA@mail.gmail.com>
 <CANiq72=nMYcohMk29fzs3bMut1PXwfqYLZdbRh_AeTN-Z4FpxQ@mail.gmail.com>
 <AM0PR07MB387404F71D25553702966E27E49B0@AM0PR07MB3874.eurprd07.prod.outlook.com>
 <VI1PR07MB486420A106A8BC85BEE9FB2AE4960@VI1PR07MB4864.eurprd07.prod.outlook.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <2ffaeb04-3d51-fe9b-84b7-e009cb1dffeb@redhat.com>
Date:   Mon, 28 Jan 2019 15:35:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <VI1PR07MB486420A106A8BC85BEE9FB2AE4960@VI1PR07MB4864.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/19 5:28 AM, Bernd Edlinger wrote:
> On 1/25/19 1:24 PM, Bernd Edlinger wrote:
>> On 1/25/19 12:39 PM, Miguel Ojeda wrote:
>>> On Fri, Jan 25, 2019 at 11:58 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>>>
>>>> On Fri, Jan 25, 2019 at 11:43 AM Laura Abbott <labbott@redhat.com> wrote:
>>>>>
>>>>> Commit bee20031772a ("disable -Wattribute-alias warning for
>>>>> SYSCALL_DEFINEx()") disabled -Wattribute-alias with gcc8.
>>>>> gcc9 changed the format of -Wattribute-alias to take a parameter.
>>>>> This doesn't quite match with the existing disabling mechanism
>>>>> so update for gcc9 to match with the default (-Wattribute-alias=1).
>>>>>
>>>>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>>>>> ---
>>>>> This is RFC because it feels ugly. I went ahead and did the obvious fixup
>>>>> but it's worth discussing if we're going to end up with an explosion or
>>>>> if there's a better way to handle this in one macro.
>>>>
>>>> Bernd Edlinger has sent a patch to gcc for this:
>>>> https://gcc.gnu.org/ml/gcc-patches/2019-01/msg01120.html
>>>>
>>>> and Miguel Ojeda said he wanted to send a patch for it to the
>>>> kernel as well, not sure if he wanted to take a different
>>>> approach there, so adding both to Cc here.
>>>
>>> Thanks Arnd (I was working with Martin on the expanded
>>> -Wmissing-attribute warnings, not on this, but thanks nevertheless :).
>>>
>>> Martin/Bernd: from the GCC mailing list I am not sure if we should
>>> expect the old behavior to be maintained or not.
>>>
>>
>> I believe it is not intentional to break the old syntax of the
>> pragma.  There will be new -Wattribute-alias=1 and -Wattribute-alias=2
>> and -Wattribute-alias is easy to retain as an alias for -Wattribute-alias=1.
>> That is what my patch will do.
>>
> 
> Okay, I committed the -Wattribute-alias patch to gcc trunk, now
> as https://gcc.gnu.org/viewcvs/gcc?view=revision&revision=268336 .
> So there will be no need for a workaround on your side.
> 
> Also fixed a few false positive -Waddress-of-packed-member warnings with
> https://gcc.gnu.org/viewcvs/gcc?view=revision&revision=268118 and
> https://gcc.gnu.org/viewcvs/gcc?view=revision&revision=268337 .
> 
> However there remain a lot of warnings from -Waddress-of-packed-member,
> that look more or less valid, has anybody an idea how to handle
> these?
> 
> 
> Bernd.
> 

Thanks, I'll keep an eye out when this lands in Fedora gcc.
I think once everything lands it will be easier to work on
the remaining -Waddress-of-packed-member.

Laura
