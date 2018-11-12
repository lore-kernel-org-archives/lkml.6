Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37695C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5322087A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YdGL8brY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5322087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbeKLUb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:31:29 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36452 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbeKLUb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:31:29 -0500
Received: by mail-qk1-f194.google.com with SMTP id o125so12385689qkf.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 02:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lCiHfQcwpczRrYyGJ0o6p5Z32vtQ+3ZGDvbPzXO7FNA=;
        b=YdGL8brYaqqtVdKQJRfYi1TWPuWOWnc09l9QdtM1o2LP8mkpc1y7q/hHr0BP3oqkvL
         IfoNk36V5q5T3ulNKR28e2W/RiF48DoKoEy/Na3qNxYh1MnYvei2gz6Ch6VMhNbrqnXB
         FVWxEgC8bV2FHdyaWw0dLeUtA6WoNP+G6wXIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lCiHfQcwpczRrYyGJ0o6p5Z32vtQ+3ZGDvbPzXO7FNA=;
        b=XGkc+Dqhfm+jGFnH1AEqliXJdx4EbkQ72pNG13/4Z8azfW0k3R50T9mxSMNv6fCeER
         zbL7BxItKvwqnDBPKhVqgoioBWKhIrmYICUsCTUnal5yJnEogsYDNuUE0xUz7ZzMXC48
         zltTMqd35tX3K0Pc06t3PXSNDmlaXylzwCU8gFFsXPlRlPjRFbFCHPXWoG0mulUa7A7r
         H09PX4OMa4Yu/EUAd67iX7aqRIB2h87lPwSeeoe7qnTyTsT4pqSPXvY9N8lTGvnaiAy3
         F04VN46NGqJt/+hGwI3rIl6zsMtEkXFmXLzI0eMQFsES4Qwv7oHW91PICHsBXKEqtZV+
         0c0g==
X-Gm-Message-State: AGRZ1gJ7A93sdT1TJ7qRWtishKEw/AVWyW4iIHuTUZHoajJv6EStVU6p
        E42J4io++Eq5CfFrpebucRkHYg==
X-Google-Smtp-Source: AJdET5d11JG+Klx/N9avmUjp+nthMl0T9TVj5BiItmZFarIe0ZlSrv5dNuiBa8sBOyq1+WcIGA806A==
X-Received: by 2002:ac8:593:: with SMTP id a19mr313238qth.111.1542019129254;
        Mon, 12 Nov 2018 02:38:49 -0800 (PST)
Received: from [192.168.48.13] ([168.181.50.245])
        by smtp.gmail.com with ESMTPSA id p31sm10916158qkh.86.2018.11.12.02.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 02:38:48 -0800 (PST)
Subject: Re: [PATCH 4.9 000/141] 4.9.137-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, ben.hutchings@codethink.co.uk,
        stable@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net,
        Sasha Levin <sashal@kernel.org>
References: <20181111221627.853046496@linuxfoundation.org>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <18c91c75-18c8-21a1-3051-65007bd2f30f@linaro.org>
Date:   Mon, 12 Nov 2018 08:38:44 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/18 8:24 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.137 release.
> There are 141 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Nov 13 22:15:38 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.137-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      Linux 4.9.137-rc1
> 
...
> Prarit Bhargava <prarit@redhat.com>
>      cpupower: Fix coredump on VMWare

Greg, maybe...

commit ef8d3a128c1f1de7ffdedb2f14e846e10fd3fec3
Author: Prarit Bhargava <prarit@redhat.com>
Date:   Mon Oct 8 12:06:19 2018

     cpupower: Fix coredump on VMWare

     [ Upstream commit f69ffc5d3db8f1f03fd6d1df5930f9a1fbd787b6 ]

should be dropped from v4.9 (and v4.4) since it causes:

$ make V=1 -C tools/power/cpupower all

gcc -fPIC -DVERSION=\"4.9.136.142.g36c7703\" -DPACKAGE=\"cpupower\" 
-DPACKAGE_BUGREPORT=\"linux-pm@vger.kernel.org\" -D_GNU_SOURCE -pipe 
-DNLS -Wall -Wchar-subscripts -Wpointer-arith -Wsign-compare 
-Wno-pointer-sign -Wdeclaration-after-statement -Wshadow -O1 -g -DDEBUG 
-I./lib -I ./utils -o utils/helpers/amd.o -c utils/helpers/amd.c
utils/helpers/amd.c: In function ‘decode_pstates’:
utils/helpers/amd.c:106:39: error: ‘union msr_pstate’ has no member 
named ‘fam17h_bits’
    if ((cpu_family == 0x17) && (!pstate.fam17h_bits.en))

Due to nonexistent CPU (flag) support.

Replied to Sasha on specific commits for both, v4.4 and v4.9.

Thanks!
-- 
Rafael D. Tinoco
Linaro Kernel Validation
