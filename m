Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A58FC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36B6204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DOD7ILB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36B6204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeJPAlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:41:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34953 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbeJPAlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:41:22 -0400
Received: by mail-qt1-f193.google.com with SMTP id d21-v6so9871978qtq.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E/kai5hXvl/b/6vy2puO8eZlPGRzhrfWJRrl1PLnPy0=;
        b=DOD7ILB89TLUSAlgwXOnR4P4z49JwigeOLcDofWvATAY5DSmOf2V9aFmNxtdyy/Q7S
         0B9YnvTSSyH1GVX7Et8Tzz1PdheHMWe8ci15StOe5TNGwpHlUgSRysGPnn1CMm8MPAJZ
         gRAdhx5h9vC2tFfXjbQEFsP8TcBgwUmPgqsys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E/kai5hXvl/b/6vy2puO8eZlPGRzhrfWJRrl1PLnPy0=;
        b=ReCkf0ZrKCY+a/Q7S8R2pzFHHoVCfVg7KlQ6XF6VOvdLmBvnW+68ypBpoaAMw+jKce
         +VPb6eF+wmzwa/+/dH/b++mzmaND522o1+UxvbyZI4qRah3zzzd7tdEDWfY0KstZzF4R
         d3ERcrdpcVNnbPQI0EtBAz4cID1IFm6tTjSqfEDRfJoISr2Bx8tFaxH5txfQ2BXV6pFi
         hFayjelJJq1Xrhw9rFBlNSEte2jMswRfJ65rg0D25q24yHiiAyQqh0libQ6IzMq7Zgma
         jAJguTFrgqSBkJ3+pL4yDhjPwMC0hpUQBd9CUIjPnDrsAYbmWd+HH22RkLXsVmtIFTOP
         Vr/A==
X-Gm-Message-State: ABuFfoiZrRxqByPCLUcC3weeWdUl6IRO7RmLUfAPmhDi/kbT70BEYySM
        zaHnInbjsMJ+8NGA26TDmCo0rA==
X-Google-Smtp-Source: ACcGV61j8O+MIXtZR582D+jZ3Xag+6qlLydg6Zz9bPnWQkgDDGGylU3f//XmUyhtU8ZizuqX8rnS3Q==
X-Received: by 2002:ac8:1207:: with SMTP id x7-v6mr16772612qti.317.1539622519094;
        Mon, 15 Oct 2018 09:55:19 -0700 (PDT)
Received: from [192.168.48.13] ([168.194.163.81])
        by smtp.gmail.com with ESMTPSA id j57-v6sm7885921qtj.96.2018.10.15.09.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 09:55:17 -0700 (PDT)
Subject: Re: [PATCH] proc: fix proc-self-map-files selftest for arm
To:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
References: <20181011184359.15627-1-rafael.tinoco@linaro.org>
 <20181011205601.GA32757@avx2> <20181011210256.GE2401@uranus.lan>
 <20181011213006.GA13485@avx2> <20181011220009.GF2401@uranus.lan>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Message-ID: <52504bd5-b4ed-518b-f748-c634172c6c68@linaro.org>
Date:   Mon, 15 Oct 2018 13:55:14 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181011220009.GF2401@uranus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/18 7:00 PM, Cyrill Gorcunov wrote:
> On Fri, Oct 12, 2018 at 12:30:06AM +0300, Alexey Dobriyan wrote:
>> On Fri, Oct 12, 2018 at 12:02:56AM +0300, Cyrill Gorcunov wrote:
>>> On Thu, Oct 11, 2018 at 11:56:01PM +0300, Alexey Dobriyan wrote:
>>>>
>>>> As the comment in the beginning says this test is specifically for addresss 0.
>>>> Maybe it should be ifdeffed with __arm__ then.
>>>
>>> Is there some other reason than allocating non-mergable VMA?
>>
>> IIRC the reason is to test address 0 as it is effectively banned
>> for userspace so if it will be broken, it will be broken silently
>> for a long time.
> 
> This is rather a side effect of the test because the primary reason
> was to check procfs numbers conversion, right? Don't get me wrong,
> I don't mind about __arm__ define or similar, this is fine for
> one architecture, but if there comes more we will get a number
> of #ifdefs which is unrelated to procfs numeric routines at all.

That is what I also had in mind, thus the patch. I just realized we had 
another issue on LKFT (our functional tests tool) for 
proc-self-map-files-001.c. Test 001 does pretty much the same as 002, 
but without the MAP_FIXED mmap flag.

Is it okay to consolidate both tests into just 1, and focus in checking 
procfs numbers conversion only, rather than if mapping 0 is allowed or 
not ? Can I send a v2 with that in mind ?

> 
>> As for "unmergeable" libc here doesn't map /dev/zero. I know how to
>> avoid even theoretical breakage by creating binaries by hand but it
>> will be probably too much.
> 
> Sure.
> 

