Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAD2C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A48820873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGoXzpQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A48820873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388053AbeGKNn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:43:56 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33179 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387999AbeGKNn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:43:56 -0400
Received: by mail-pf0-f196.google.com with SMTP id b17-v6so18453323pfi.0;
        Wed, 11 Jul 2018 06:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7X8JOG4yqnCBTMPeN6TZ6IMemR+3gP1Unm6AONrvTBk=;
        b=RGoXzpQ9tepR96jYIz1ZgQFLPOQuak7LfpqwIMTVsXZaOeRkc+KOwCA3dyfJttBoin
         3FtoH2xyD6uHv2IIt7OVxb+oYx8h/rQd/0wLFt479aYQEBHLqHm2ZR9JoomhQ22ZsITg
         GQGaXRpN1xttZgzx/u5fJTIWBBSOGNc8LJ6D+CwIH4N3Y1HSLAkvd8MoMZ2SaXFDw9bw
         43scYw5ybX/IwqqI4G5VEgHPkEGrd7hJuKy0oShqkeDv6D7uN6srtf1FlSJCvyCipBdY
         ZB1cfKGY2+pKGCHCogQU/psO7y2ZExzeU2TdtgrKoLTe9zgaX2FbK2ODjZGBF+A9i0UY
         kmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7X8JOG4yqnCBTMPeN6TZ6IMemR+3gP1Unm6AONrvTBk=;
        b=jIsjiZcDxLCsQvSrqHeBgOmOMTVeXg5q5IZTnv2sBczvxrJi4UVrYF6X99fIXTj6Yl
         DItAy0X27AYo30MFyawemgI+GOAHoKl2LQokIuHHTEILxKHGoRedrxhyj3up2sAXYvYi
         RsU+1/ciGB3KzTIgPp9bnxftyHdInnUAJR1xURw62AV/MZF8XeLNNG1eEdZ5E5tWSxfx
         RM9SlJ4JkpUoZzkbqP0rUhfAAabnUREtz8h/7apFT793j4NzOQCLlS4r0M2EJ6eyQgeE
         vYY+obzuBRWu3lcoyaOa9AVaa+98N7XVBoouAmoY6C9zCZoDTgdFLRTQiaGLmh9ruLI7
         Wp1g==
X-Gm-Message-State: APt69E29pAJav4eRLhTrGIrPnCxWGFjkqtt25cdhUNo9346r2Un/HiMe
        7F2VAwoDHgpanoBdYIzeVGoi+g==
X-Google-Smtp-Source: AAOMgpfkkt/lPd3KYN2gwIPIBAhXl1ZiIW7oTH0GAhI/UjxX2bUNGYc2JRm3lSAIo4bqj3WnFLrY1w==
X-Received: by 2002:a62:5486:: with SMTP id i128-v6mr29773736pfb.166.1531316372319;
        Wed, 11 Jul 2018 06:39:32 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id q5-v6sm4041817pgv.61.2018.07.11.06.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 06:39:31 -0700 (PDT)
Subject: Re: [PATCH 3.18 00/23] 3.18.115-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180710182308.877332304@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <86ace8eb-76e1-b990-a59b-f2b3ea1131e0@roeck-us.net>
Date:   Wed, 11 Jul 2018 06:39:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710182308.877332304@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2018 11:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.115 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jul 12 18:22:59 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 138 pass: 137 fail: 1
Failed builds:
	i386:tools/perf
Qemu test results:
	total: 129 pass: 129 fail: 0

Ignore the perf build error; it only fails to build under certain conditions
(such as building into a separate object directory) and would be difficult
to fix in 3.18. I'll remove it from my 3.18 build tests.

Details are available at http://kerneltests.org/builders/.

Guenter
