Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0675FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC03520840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPQpH+ZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC03520840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeKIXy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:54:56 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42552 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbeKIXy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:54:56 -0500
Received: by mail-pf1-f196.google.com with SMTP id u10-v6so980200pfn.9;
        Fri, 09 Nov 2018 06:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pmAdXquxkxZxb6T8lDEg5l5UxW6ISzVvStIP2BqLico=;
        b=mPQpH+ZMpkITX8Xvaw+zA6/J0Vo+cLyzlVXsooo0w9Hyb0Dd9BUF9Pg/qJguMLlLoY
         KWx6awv6EidEq0gP/w4r21NHmqh3CivftHisA4JufM6kOb67flHPQUJ6VgAzuxwll5uJ
         kehK+2+7krnaUXpqy95IZ63n+bgYTqNi2+w/BKLjefbIHTl74FTP7BQaD+/70R4Mc3mM
         HD3qup14bjb6dlUcAxNRY3x+1kBPfGIoCAaQizlpiAhayttaoNlkLNGdaBinKkLMrcXR
         vC3A7UZ4xa+YD8LbfScZhAfgvhhL9dU7CwXAyA/ahSdOEzF2tLGzOdqro7JhR0/xt172
         Fong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pmAdXquxkxZxb6T8lDEg5l5UxW6ISzVvStIP2BqLico=;
        b=bbl280yobyyLtny68Wxi/+utHP/hyBliKnUVzCNakW4602NRwJ+L8Rf1lilOuUVBLA
         IbrpEFIqnjczql0r3BxXZ+BNOhheJNwcrwUf0Pw2XQE1eXuI8sskOn6PmpIf2fEfW1Uz
         bmZNps14VWOHeBG117VA9ryPgLFYdxsWSHO16j1mtjt8dgDUgy3V/AqGG/2wpw68HgD2
         A2LlmxmD8CtsSw8E/RhniB3fEBmyMGilywxJNLoGWTm/qQnbizYzT/Oa7tmU9umxyFCx
         TPkFu6hSKptL9gY9LMgikd7XV6Q9PvkLxB86G3VVcbxgoKB5gHC361DGFAEYKa37DgTh
         ZZAQ==
X-Gm-Message-State: AGRZ1gJFDjY5lj9K6uR9x2YkGu4MkR2C7p6gUD2in2rYVXMj/Yu26nn9
        anlv7ke5AIQEVhjnLlij3fGhfNAx
X-Google-Smtp-Source: AJdET5cM8UwzsxnkmkXJJ3uMYBSee2ZG2t5C8UwLNE3OhNj6j6X4vogIsDeUStwG9q3+f6P+g1xMYQ==
X-Received: by 2002:a63:6ec4:: with SMTP id j187-v6mr7778736pgc.3.1541772849028;
        Fri, 09 Nov 2018 06:14:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g27-v6sm17350244pfj.162.2018.11.09.06.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 06:14:07 -0800 (PST)
Subject: Re: [PATCH 4.4 000/114] 4.4.163-stable review
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181108215059.051093652@linuxfoundation.org>
 <86d97b16-dbbc-27bd-ad7b-9a96210070a4@roeck-us.net>
Message-ID: <2c7054eb-6ad9-6531-c9c9-025f59070c74@roeck-us.net>
Date:   Fri, 9 Nov 2018 06:14:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <86d97b16-dbbc-27bd-ad7b-9a96210070a4@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/18 5:50 AM, Guenter Roeck wrote:
> On 11/8/18 1:50 PM, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 4.4.163 release.
>> There are 114 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Sat Nov 10 21:50:28 UTC 2018.
>> Anything received after that time might be too late.
>>
> 
> Building i386:allnoconfig ... failed
> --------------
> Error log:
> kernel/built-in.o: In function `cpu_startup_entry':
> (.text+0x1a2e9): undefined reference to `cpuidle_devices'
> make[1]: *** [vmlinux] Error 1
> make: *** [sub-make] Error 2
> 
> 
> Bisect results:
> 
> # bad: [70cfa9ca6595d3238b36b9f6b36cf6e18dfd2c3b] Linux 4.4.163-rc1
> # good: [24c2342b8e51ab3185e68470709904150a1e3ee0] Linux 4.4.162
> git bisect start 'HEAD' 'v4.4.162'
> # good: [008f87b2e9c5db7dd3756832a9e449415d837c7d] ixgbe: fix RSS limit for X550
> git bisect good 008f87b2e9c5db7dd3756832a9e449415d837c7d
> # good: [5d92c564ec3dd9a5833974f3ce113cc7a94e0f6a] mtd: spi-nor: Add support for is25wp series chips
> git bisect good 5d92c564ec3dd9a5833974f3ce113cc7a94e0f6a
> # good: [71fba871e4a07400eb1400b1e6b45ca3a5487834] rtnetlink: Disallow FDB configuration for non-Ethernet device
> git bisect good 71fba871e4a07400eb1400b1e6b45ca3a5487834
> # good: [4d1024282b1259209bb4601f4b51dce367cf8a02] IB/ucm: Fix Spectre v1 vulnerability
> git bisect good 4d1024282b1259209bb4601f4b51dce367cf8a02
> # good: [fe9d47ae282ebd2bb10a36ec2bace1afd0ba050e] Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15IGM
> git bisect good fe9d47ae282ebd2bb10a36ec2bace1afd0ba050e
> # bad: [573e8431fe60169157440664f74c6af254b3b00e] x86/percpu: Fix this_cpu_read()
> git bisect bad 573e8431fe60169157440664f74c6af254b3b00e
> # good: [be0ac51f4181a18c458080d79919aeee17ce0c68] sched/fair: Fix throttle_list starvation with low CFS quota
> git bisect good be0ac51f4181a18c458080d79919aeee17ce0c68
> # first bad commit: [573e8431fe60169157440664f74c6af254b3b00e] x86/percpu: Fix this_cpu_read()
> 
> Full results will follow later, after builds are complete.
> 
> Guenter

Upstream commit 9bd616e3dbed ("cpuidle: Do not access cpuidle_devices
when !CONFIG_CPU_IDLE") should fix the problem.

Guenter
