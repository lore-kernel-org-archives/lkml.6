Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52011C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197972147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OexxAPHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfBGOUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:20:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39383 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfBGOUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:20:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so4847125pld.6;
        Thu, 07 Feb 2019 06:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MzX3JJKoONCEhEq2a+7DCrEsdrue73mz9cfXQpeKUvI=;
        b=OexxAPHEFauo9ptEgGq14ZF6xFqst8tS/ELf3hTA1is6sVMywQPYPLqDMWjMbo8tFK
         FybYhiosD2MmZi1d9Xeg/gPh5a8zVHpep8Loz/8WRHPmseDA/z+wLciEGU6X5M4YSQfq
         k7zJD6/BZONaSk4xj1dvUTrb9fnoLszqTHqF/2h/Wd0Ftfl7Xlj3vZcRxezLrgIVfZKs
         NrrvICzMx+3BPYXMYBUHKvv1pENg71ooOYqGn0ZSkQFVa37dveWbJ3gHWaEEWHRVPFQJ
         Jhrjfmp7kghVj57lK0y8dI7QBzhJKtXpmcI9WcYcb4YW9COhm5DGjJC5N7PmcjmbJsgW
         vclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MzX3JJKoONCEhEq2a+7DCrEsdrue73mz9cfXQpeKUvI=;
        b=EvYaXMAjMVI+SLb0fb230i41XREQeHCNJqUv2AKQw5/g5bgSolaPAsZa7CAieU2RsD
         E8jTjdkLcjQBFYI+pFQYl/SskskG8QoLP7yUoIdj3xMcPraaAQzMysjxlWdKPd5nXyZ4
         n5+yE1Z6mvx+Y4K4Pg928qI4YIm8Oan/qlhxsa8a6eFubk3tW4qvGcugK+x5ZyloYCnM
         91Sbx4WLeTuTsZQgIp6gnFcgRNoinAzqvo17tU7wjjT+xr4NjTJt5f6vaTlZoBQ8ifiD
         NGT47w9xHoMCfedJFbyXvPzUmdPMKxObr6NXSUtOotBGFM29kawMUqEHIzbDo0Sa/5hd
         wrdQ==
X-Gm-Message-State: AHQUAuZRitWn89PA8bi57cKfYtJ2Giw6f3/d7MIBO81wEZ6Ihze6i+Z+
        ktObfSA1+olQwetJHv2defK7cFtq
X-Google-Smtp-Source: AHgI3IYCVMjxI/1vaUZMDOftqnDNqyXgxZkr3R6dWyMe/6ZtFKHFXC0VgFQjuv2+mcYvrzCXtZkNgw==
X-Received: by 2002:a17:902:2a0a:: with SMTP id i10mr16484022plb.323.1549549246974;
        Thu, 07 Feb 2019 06:20:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s86sm11840661pfi.180.2019.02.07.06.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 06:20:46 -0800 (PST)
Subject: Re: [PATCH 4.4 00/34] 4.4.174-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190207113025.552605181@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2780bab7-047c-33c2-e0dc-cdc0cec46400@roeck-us.net>
Date:   Thu, 7 Feb 2019 06:20:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190207113025.552605181@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/19 3:41 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.174 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Feb  9 11:30:10 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 171 pass: 170 fail: 1
Failed builds:
	x86_64:allyesconfig
Qemu test results:
	total: 291 pass: 291 fail: 0

The build failure is interesting.

Relocation offset doesn't fit in 32 bits
make[3]: *** [arch/x86/boot/compressed/vmlinux.relocs] Error 1
make[3]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [arch/x86/boot/compressed/vmlinux] Error 2
make[1]: *** [bzImage] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [sub-make] Error 2

Unfortunately it doesn't tell me _which_ relocation doesn't fit.

I may have to revert to an older compiler. Wouldn't be the first time.
Let me try...

Guenter
