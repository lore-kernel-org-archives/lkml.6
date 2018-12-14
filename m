Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D197EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0BA206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GxKwElRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbeLNRSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:18:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38081 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbeLNRSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:18:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so6554118wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 09:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Ie++2iWMN6fmCOIEoUf84GkaRSS19+/sYZMqTlzha8w=;
        b=GxKwElRls1YTJA630FqOgZj5mzm2FyOnvOzmKCuepCbYZ7H23sNJMM0+ph02JY4C1M
         TonjrDIJAe84UQXLLeHMMFrxFWxHSws0fG4ODxulk1Lh4Uwrrpo9Dpw+ZzTpte92tLuD
         a5Irf7bUR7nOcCcZ/4en8WoVh7tEZ44UF+aDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ie++2iWMN6fmCOIEoUf84GkaRSS19+/sYZMqTlzha8w=;
        b=gtGIYH0yeF2h6kg5mPw6KIFqYV1xIOD1wlC4uzTn3Om4+qHorpv1hEi9wE7+XmmhV4
         PGkaNK2myXMH7CTpyrGUDvtcSi8K13LJ8t60DZ6JLKJuRX0jmfi0oH8Wao0uxbcMHS0+
         MHsDxT8cC7A6Nh6OYWaAVZTP8mRkmMnKUbP50eolMQm0P90rCz/Tl1pFRE3uy6cXtnhx
         b/peOo4bCm33OIXDkJBzIiOg1Qsm6Sb26B55E9JPsxo8dZ5qo8ei3pycYIGUqsDQ+AdV
         3A8CEOktVDf3VjeJYYYkV1GCM/FrTw3NHgmHYcR6TPtR3K4tfZGuDpBb3Rc/SH63pWCI
         Kqqg==
X-Gm-Message-State: AA+aEWZTZ+2NucklvSxbqFTjUrpwLgP3gmXeclb8JauY3m2Ct6Shkf89
        cP2YJu0NQqGzMWZeBAmqWr14sJv19cg=
X-Google-Smtp-Source: AFSGD/Wu9InxbhkgA4JhDiWpJFYQFGo6F9f9Ux1BFyANNml14BWM+3OnyPC2X9liKY8QH44tPYCQ+w==
X-Received: by 2002:a1c:848c:: with SMTP id g134mr3658607wmd.93.1544807909573;
        Fri, 14 Dec 2018 09:18:29 -0800 (PST)
Received: from [192.168.1.2] (58.red-81-47-145.staticip.rima-tde.net. [81.47.145.58])
        by smtp.gmail.com with ESMTPSA id i192sm5237667wmg.7.2018.12.14.09.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 09:18:28 -0800 (PST)
Subject: Re: [PATCH] checkpatch: add Co-Developed-by to signature tags
To:     Greg KH <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>
Cc:     apw@canonical.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, niklas.cassel@linaro.org
References: <1544792494-15485-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <839c1d04000164e27dff9742e3efc3bcff3025b6.camel@perches.com>
 <20181214161344.GA10654@kroah.com>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <911d67b4-2881-9895-487f-dac352fe8a36@linaro.org>
Date:   Fri, 14 Dec 2018 18:18:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214161344.GA10654@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/18 17:13, Greg KH wrote:
> On Fri, Dec 14, 2018 at 07:52:15AM -0800, Joe Perches wrote:
>> On Fri, 2018-12-14 at 14:01 +0100, Jorge Ramirez-Ortiz wrote:
>>> As per Documentation/process/submitting-patches, Co-developed-by is a
>>> valid signature.
>>>
>>> This commit removes the warning.
>> Your commit message doesn't match your subject.
>>
>> A couple variants have been documented and only
>> one should actually be used.
>>
>> $ git grep -i co-developed-by Documentation/process/
>> Documentation/process/5.Posting.rst: - Co-developed-by: states that the patch was also created by another developer
>> Documentation/process/submitting-patches.rst:12) When to use Acked-by:, Cc:, and Co-Developed-by:
>> Documentation/process/submitting-patches.rst:A Co-Developed-by: states that the patch was also created by another developer
>>
>> $ git log --grep="co-developed-by:" -i | \
>>    grep -ohiP "co-developed-by:" | sort | uniq -c | sort -rn
>>       80 Co-developed-by:
>>       40 Co-Developed-by:
>>
>> So which should it be?
> "Co-developed-by:" please.
>
> Yeah, I wrote the original one wrong here, sorry.
>
>> btw: I prefer neither as I think Signed-off-by: is sufficient.
> Nope, sorry, it is not, we need something like this which is why it was
> added.
>
> thanks,
>
> greg k-h
> .
>
I'll update both
