Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CEEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E465920856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MFwGV8uH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfAQSeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:34:04 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54329 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfAQSeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:34:04 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so2932432ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 10:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=breSBURX5yC5qdqN2cgp78X74wrLlrVfBw9eeaT7eHc=;
        b=MFwGV8uHHu3xAvXEKpp6ErntEw1D+NzNXptfDZoPJydbDNlrDD9ohPBEyOY6rp+nW7
         zBVl/RMnBqKyMgA3PMeGSw6mZLCBPa1H9TaFM63GcjYhpYFwtVLDs6XSg4ZaFB8d4Gmb
         zH8ZplnrYzM2bbEzPZRq9xIxlElM/LRI1a+m/3xNwIi41auHOmh8JzDj6CgBsdtho1Du
         l1dmh7DOiLFn/V6I9dscih5bqXfpncNv8GkOWFfg8z67Tq2aObZhbJKDsMUUnpRP+QVd
         6JIWzneu9h4Vv2BUsDo2iIFL5OB/8okIlrn2IUxzUA/htXnAJzgzt7QObXgP//erX3+B
         jZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=breSBURX5yC5qdqN2cgp78X74wrLlrVfBw9eeaT7eHc=;
        b=LqbKUhor+UKdH3fGw1IGG3UlkybhdCLKQOcTdu0qqdxnevypGoFGaIeAWUnGr/M6T2
         F2X8hnugQ2ZjIRHqfLg6gQgIYCztkMvdhBder58p8B1KE3w5kxdHuq+ooSg2BXTjpqey
         3GWdeW0san8FaTCz4sM+gYEtcEwKGibbg3e0TFwkig9vF4MhOq9Fxuy9kLwXjvKlM7F5
         guu8GY5vFyU134v/+6jRmJbOBNJYyU3EPQE4ao5qLO2daVvCmw1q4iinAHzeVvhAiKnh
         BcHT2L1Tp6Znt0w7qaXE9FMK5w+BJ15b3RzOvJIAmoO3/MoNiigzxXv8lb6ZGo31bJNB
         QQ1Q==
X-Gm-Message-State: AJcUukevdYQIklxqX+PYWCF6IC5SGOnw7tMYVvtRiAlaF3nYVFxWTFxf
        I8h6KjFvzS8tVctUxpN27w3tdQ/jX6J8MA==
X-Google-Smtp-Source: ALg8bN4YgyP5qJOiiZvC2JS4n2irSRlFZckbDQqny0fIXuPEth8xztATHrzdwDPrmunAW17FapvNoA==
X-Received: by 2002:a24:b951:: with SMTP id k17mr8444931iti.147.1547750043391;
        Thu, 17 Jan 2019 10:34:03 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id e141sm1033179itc.40.2019.01.17.10.34.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 10:34:02 -0800 (PST)
Subject: Re: linux-next: Tree for Jan 16
To:     Guenter Roeck <linux@roeck-us.net>, Ming Lei <ming.lei@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>
References: <20190116173838.042db659@canb.auug.org.au>
 <20190116203547.GA788@roeck-us.net> <20190117084902.GA20220@ming.t460p>
 <20190117103553.GB23565@ming.t460p> <20190117183254.GA17361@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <10619062-9531-e843-1620-7518e27583f8@kernel.dk>
Date:   Thu, 17 Jan 2019 11:34:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117183254.GA17361@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/19 11:32 AM, Guenter Roeck wrote:
> On Thu, Jan 17, 2019 at 06:35:55PM +0800, Ming Lei wrote:
>>>
>>> Hi Guenter,
>>>
>>> Could you share me the .config?
>>
> Any 32 bit configuration from affected architectures should work.
> 
>> From your dmesg log, looks the test is run on i386, so please
>> feel free to try the following patch:
>>
>> https://marc.info/?l=linux-kernel&m=154772088110800&w=2
>>
> Is this still relevant ? Today's image is fine.

The patches were pulled, I think Ming would still appreciate it if
you could test the previous tree with that patch on top.

-- 
Jens Axboe

