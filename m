Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FCCC43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585D02086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxQOvuMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfALRng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 12:43:36 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38815 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfALRng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 12:43:36 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so8212248plb.5;
        Sat, 12 Jan 2019 09:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MF6zH8K9U7EqpSYMxT9dz5HtlWg6uo53NXcPzBZAPIw=;
        b=CxQOvuMh5kuh8kX65j5P8B7NMsX6zabXi9GLD7zRPjqKJMsdus9qOoBvNIgPkrznAZ
         yYB4I+tT4VkBRUwBr8ib6L0FfX7vTw4LtY1998SHUERC6ARZ5jc6kdt9z/YW8qas8wrJ
         zO1pM4w3hDC4Yp+9mDKq55jDQgQg/csrY7M+hr9wDltJCBrOA2GDjP95rH5RLyNhiWQv
         7RgcaoKg+1clAUBYt2amfCXOl6Gg6uRojiqdijz2vF/+VnCG9E6RC45jdUSKVmqbWVOl
         m4VuP+ncC82anhHNRbbV5Z5GKnKn/ddqxWS2qVavEmd0FYzIBa+RTuAggiUcI2Gkmu1C
         Z2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MF6zH8K9U7EqpSYMxT9dz5HtlWg6uo53NXcPzBZAPIw=;
        b=FIZP+nHO5Eh6b2+RjJxBbF64yL1VN6XLJByqm7Y0g20ULKvdN/QqO7bwaksyaP2MRR
         szrCFhQPXOiSDULh9xSDzAcFFf8AX6s/cf3CVJ4D+5WIUlprLBEHuSU1OHEw/FhM6003
         Kp/iDUTYN9O1519h0X8bbTPa0CkSI4bZ+Etio7ZouEfCRwsEAP3ur/rsfDovhCL64Fxi
         OTQgCUOMxtMV8dUskQHP/o2pl+DDrCxGYUx1eDWjXEPFXGqPqdDkGKpcIwG5R5Aw8HKl
         z8/0L4zl2C1YS9w69poM7R1s1mhxWeCiVSJ5IQjKbgbim9/2NDIPETrTlQztGeIrUSCb
         uQhw==
X-Gm-Message-State: AJcUukdsfsSK/TzBNf+tGqvG1H4eLbzda9VSiZ2uXA0yOMBM0rjOagtf
        XC9Xf/nUhJz9HDE9DAX+l9DrjQDE
X-Google-Smtp-Source: ALg8bN5vKFrOXu6hZrftcbNKjYAghU60CBN6m15QnsK6SgzlD68Ndb/BJewEObvLSp5YHFQwwGS73A==
X-Received: by 2002:a17:902:4523:: with SMTP id m32mr19230955pld.53.1547315014508;
        Sat, 12 Jan 2019 09:43:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x12sm101370376pgr.55.2019.01.12.09.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 09:43:33 -0800 (PST)
Subject: Re: [PATCH 4.9 00/63] 4.9.150-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190111131046.387528003@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e33626f4-2b39-4bea-e602-e4d984fb7343@roeck-us.net>
Date:   Sat, 12 Jan 2019 09:43:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/19 6:14 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.150 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jan 13 13:10:03 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 305 pass: 305 fail: 0

Guenter
