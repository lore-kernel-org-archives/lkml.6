Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B2DC282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A3B20811
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdrM2TLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfBEPMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:12:39 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40886 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbfBEPMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:12:38 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so1500927pgp.7;
        Tue, 05 Feb 2019 07:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fve/+G8vCJDlxNQ16CNseRUifsX3wEprh8c9AQaLS9g=;
        b=fdrM2TLhX09s2tgOZiVJqFVqdJGxTbON8tcJBVfAtpsdc9fwcrL2JL88Rl39bI/47X
         qTC6NAyfaZxtJToYgey96RZCpl2DxI+h+Lkcw7kOb1CB5eeL9MLStkT+FWgSlFYJvuqd
         9UBOGRgxMrq3wRPnJQhaqN7/9IiJR+5P9NkqHoAaG8MAhDKKz+10ao/q9BDYaI+CtNxX
         +VYyg2jgij+TCyR7wgpb6qvmsfSjvtZdrb37d1XpAlj3xmDHoDei7M9FWBAq4r56W5RW
         HTokjFKFbhfmZR3UiOSuH3FrmM1q+g1ZPxnCEUR4daRDlTLoV4Z73ew0b+KbHxr5RvZP
         BJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fve/+G8vCJDlxNQ16CNseRUifsX3wEprh8c9AQaLS9g=;
        b=BIcM3pO3sPcTM1ml8lEOCDR6F2nDzR2EamxFqAIYlzD/auL5MZH7DmDx7K/r6BSCtL
         GxD/dxGKHbGawvOVwC6lBBuhPhw73Hs6keBFx5k7VP2Q742sISsVoh9vJsJ/K5Ai7wD9
         JEUToiS9/60rMeHG4P9Obc7RSZ9s0H28fzjpmWy6WBQ6txGT8Rs15s1LDOjQZ04wyJK7
         PT9O/XnqYcNl2XmrW5INA1iGKl4Gj5QKdFuwl5SYcJpXNnX38qUaheXK/quFexAI05e4
         9OtbLSuC0hYC7Samsl+o4+6baKZeEjBM5UjBCvtGAU83CRWXSUPpBwhu4zd5jQ5G9IXM
         Lf5Q==
X-Gm-Message-State: AHQUAub2CRKmSmZyCZpR4YFzcIJxuwjFAzqN0xIBe0+pQJ/TJ9LZIiuK
        ztt3hU87incYaTZUHDsQ7a9QFb4L
X-Google-Smtp-Source: AHgI3IbJW+O21d1Q9P80K0KZ5+kueEfD8Ov+DC7dGygqdHiCP32n+/2iYaKfwCIc2Hg26WrmHnFcjg==
X-Received: by 2002:a62:5884:: with SMTP id m126mr5460325pfb.177.1549379557849;
        Tue, 05 Feb 2019 07:12:37 -0800 (PST)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id d69sm5564572pfg.168.2019.02.05.07.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 07:12:36 -0800 (PST)
Subject: Re: [PATCH 4.4 00/65] 4.4.173-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190204103610.583715954@linuxfoundation.org>
 <20190204224817.GA12968@roeck-us.net> <20190205144221.GB17950@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e67529ce-2303-2cea-4d44-b80077078f9a@roeck-us.net>
Date:   Tue, 5 Feb 2019 07:12:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190205144221.GB17950@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/19 6:42 AM, Greg Kroah-Hartman wrote:
> On Mon, Feb 04, 2019 at 02:48:17PM -0800, Guenter Roeck wrote:
>> On Mon, Feb 04, 2019 at 11:35:53AM +0100, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 4.4.173 release.
>>> There are 65 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Wed Feb  6 10:35:30 UTC 2019.
>>> Anything received after that time might be too late.
>>>
>>
>> Build results:
>> 	total: 171 pass: 171 fail: 0
>> Qemu test results:
>> 	total: 291 pass: 291 fail: 0 (*)
>>
>> Guenter
>>
>> ---
>> (*) I had to revert to gcc 5.3.0 for sh4 boot tests.
>>      With gcc 8.2.0, most tests stall early in boot.
>>      I didn't try to track down the root cause.
> 
> Is this a new issue?  I don't see any sh-specific patches in this
> series.
> 

I had switched to gcc 8.2.0 last October since images built with gcc 5.3.0
had stopped working in -next at the time (coincidentally with the same
symptoms). Ever since then, I had on-and-off problems where one or two
of the test boots would fail. Usually a re-run would be successful.
I originally blamed qemu and switched between versions, but that didn't help.
This is the first release and branch where 8-10 of the 14 boot tests failed
persistently when building the image with gcc 8.2.0. I finally had the idea
to look at the compiler and, yes, switching back to an older version helped.

I have no idea if gcc or qemu or the code itself is to blame. I am not
sure if anyone would be interested enough to fix the underlying problem.
I just wanted to mention it in case someone does care. If so,
I'll be happy to help tracking it down further.

Thanks,
Guenter
