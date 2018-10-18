Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E920EC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AF62145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qi0xw1Yt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AF62145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeJSEBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:01:48 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:54418 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbeJSEBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:01:47 -0400
Received: by mail-it1-f180.google.com with SMTP id l191-v6so1820695ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 12:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qvuhupc0ufzAL7pJWOvYuj39HvVVoJSYt8IIKKRbO8Q=;
        b=qi0xw1YtQaZqUKiN+Z3rq2FKW16LrhR/QKpOwXehGt7nydfkQJZvjlg4YPOrZw/zbb
         DbAviOGW09rc5EVLcgFndp48PZdLq0r8XcDRvF5VsTT8VXuPaDH6QoA6cYKkNLjw3nCw
         AYKUve8eY0C5BBSRmNJoYAQKTAexZCE0oX4BE2a/dcoZ6h4KRLb+tP2w3IV1epxTB11H
         Ni6aaKPygtH8pvnW+OWwm+HMfIKq9kGPNE3ffpbRDyuvTPgv2ozWc4XzRNcLHNvdfGNW
         v5muVr/NbQi+Rd+WLjkqyKpTvWYPL2Wca4nev1yiGs9xuMCwEqaqd5176rggx26nPQl8
         1N7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qvuhupc0ufzAL7pJWOvYuj39HvVVoJSYt8IIKKRbO8Q=;
        b=rDGTbTk17wJL19OOAOgrX3b2yU2SF4xsXNozBTrq+3CX4J3V4Gghw3wNV0H+HFj247
         ENBQfMo22HvayZFFVmICYCDH4vjRjIUxG01e4/YD0kSt6u8f/neoivFFwxLVm+QRw9x5
         eV0rc4licsaCWbz8wPKqCL/3Li3fJP1A8abENgVBSovCdmG6tdBk2LVt8/jCLvSzGLw6
         cyIw/jfdNZFesqxq3oupltbf5gVxxAhbo9qcsIhZ+HTW6/KB8ZhdK3GjkxO4+dpKMF5i
         9oXGeN3WOlzbTwwFdrYLup8NWedP9Irgd6mnFfpS2FevMwLrJG0mgmMmcMyc5XrXVMSr
         WeZA==
X-Gm-Message-State: ABuFfoiMta4bzny9I6darEzOvYRjWcq+LPMvEm6hsw/AqRWvvIJQtjTb
        kMA75HYQTUiwbZJMDCISWIfcCYTWE6o=
X-Google-Smtp-Source: ACcGV61+SWyORRN9mkyAkiB7v8dTia+ymzrsdKp9Ou2o3ymUlAcXiv7HGrhbZON2QFbQVI+CzXToVQ==
X-Received: by 2002:a24:b248:: with SMTP id h8-v6mr1332523iti.106.1539892751256;
        Thu, 18 Oct 2018 12:59:11 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k5-v6sm440638ita.14.2018.10.18.12.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 12:59:10 -0700 (PDT)
Subject: Re: bioset changes in 4.18 broke aha1542
To:     Ondrej Zary <linux@rainbow-software.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <201810182034.51724.linux@rainbow-software.org>
 <ee572ca2-8bbe-cd7d-5c41-8bb2fb5b204d@kernel.dk>
 <201810182155.15935.linux@rainbow-software.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d2684f0b-0b3a-fc0c-badf-57e44d514f40@kernel.dk>
Date:   Thu, 18 Oct 2018 13:59:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <201810182155.15935.linux@rainbow-software.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/18 1:55 PM, Ondrej Zary wrote:
> On Thursday 18 October 2018 20:58:57 Jens Axboe wrote:
>> On 10/18/18 12:34 PM, Ondrej Zary wrote:
>>> Hello,
>>> aha1542 works fine in 4.17 but crashes in 4.18. It's hard to bisect because
>>> of many commits that don't compile.
>>> # only skipped commits left to test
>>> # possible first bad commit: [52190f8abe7f2bf2b4e5f9760cbcc1427ca2136b] fs: convert block_dev.c to bioset_init()
>>> # possible first bad commit: [a47a28b74a5c7c27bf621276b85ad6c124651236] target: convert to bioset_init()/mempool_init()
>>> # possible first bad commit: [6f1c819c219f7841079f0f43ab62727a55b0d849] dm: convert to bioset_init()/mempool_init()
>>> # possible first bad commit: [afeee514ce7f4cab605beedd03be71ebaf0c5fc8] md: convert to bioset_init()/mempool_init()
>>> # possible first bad commit: [d19936a26658a7a53edd5619d631ee2c2c3151a2] bcache: convert to bioset_init()/mempool_init()
>>> # possible first bad commit: [b906bbb6997785d9ea0bd3f5585537afa6257c43] lightnvm: convert to bioset_init()/mempool_init()
>>>
>>> Testing manually, a47a28b74a5c7c27bf621276b85ad6c124651236 works.
>>> 52190f8abe7f2bf2b4e5f9760cbcc1427ca2136b does not compile
>>> 8ac9f7c1fd1d342e82ddf078425423b050652ba0 does not compile
>>> e292d7bc63c8f2adb3dfda27910e805f1b6557f9 does not compile
>>> dad08527525f9a8ac9c7f278864c65f94bc5e9b3 does not compile
>>> 943cf9f3ca16133dbd00f9a4cbfea46512fcb0e8 works
>>> ..
>>> fedc3abe7bd2dcc4c80bcf3cff8708a3908d8219 works
>>> 04c4950d5b373ba712d928592e05e73510785bca crashes
>>
>> It looks like the ISA bioset pool isn't being initialized. You should
>> have messages like this in your dmesg:
>>
>> isa pool size: 16 pages
>>
>> (which you do), but also something on the bioset section. Do you have
>> this one:
>>
>> pool size: 64 pages
>>
>> as well?
>>
> 
> No, it's not there.

Can you attach your .config? I'm guessing CONFIG_HIGHMEM* isn't set.

-- 
Jens Axboe

