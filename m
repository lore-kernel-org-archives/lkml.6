Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4234FC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 14:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFFE2082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 14:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XU0BkJgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFFE2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbeKCXos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 19:44:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44106 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeKCXor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 19:44:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id j13-v6so2328411pff.11;
        Sat, 03 Nov 2018 07:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gLSm0P3372sElAhm4ycRlMVAayB86CNVaExsvu46KF4=;
        b=XU0BkJgXW/mJwKe/Irzb9RrD+FQpwI52T9AlR1+aURvCvqxyFRFCtaEmabhEzAJJ+i
         no/FEfDEIn4s1jWhwLAcwLLXbfX5UbEeUrLU6pxU6ZVRn53oWzX3qliGbUQfkEZ/auwl
         YEcimB04dkSo7it0tDpQgbDoZb8tHc7lbBzrsyIzqBgwigJnKIsVCVvdpxyntiE8ZlZw
         VCzDFGuR8cCcZLLMg2b7m9YUkb6kApRiv2/ehL+Alg9BPSMuf9dDX3PgC4AfIqRN5tUX
         PwLGocRX0bT9ljQFmZ6YBt9dWARRN1QTNk2xH6lzjeG43KKcsMeilRuwUUzxLfhN+xOA
         mNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gLSm0P3372sElAhm4ycRlMVAayB86CNVaExsvu46KF4=;
        b=eTBBbLTOIdNkM0ySy+q9JHXItthn2h3FTeevD7TY7+7d2BjAEfTU7FakS3jilJpIZA
         8t7tlbodHWfIByCPqGzX0SzzZIwu/JkdUIbN3aAw6fHitA4G6YbnmkzHfNSmEDrMvEPq
         hLsP90sA3TAhwoaZkuiNLc4YoYLXurx7RNzC7l8KY4qOUlXKDARSNtflAfFQBpTVShI8
         GKQaXEj0s8crLN/1Ss+awwUTdRnMGdj1rdnM/25vA/pYIOmUHKX6738T7F/O3PbQWjrC
         4/1Mf41oupNnSAV+7NBFPAopPnJ4upBqdsPWy2391JHgfVVN7SNviVMajf+k+GNS32Lv
         J85w==
X-Gm-Message-State: AGRZ1gIMQRtuVFKjdPRox3/CUdOkQV+PW0SCK5O2N0MppVdNjnill0No
        EKT96F2/gc5MFVFVcvK7xiNpvt9K
X-Google-Smtp-Source: AJdET5e2ffQqCw0cRBtpuN9ws8ljchUGv5jyzEDfLI0sSpgaGtzR/a97ncKSZMNGv3oL3xmBMJuIpw==
X-Received: by 2002:a63:d846:: with SMTP id k6mr12989804pgj.251.1541255597365;
        Sat, 03 Nov 2018 07:33:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u124-v6sm62562556pgc.0.2018.11.03.07.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 07:33:16 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/24] 4.19.1-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181102182839.725385066@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7dec17e8-52d9-97eb-02e8-40f13d75b4c5@roeck-us.net>
Date:   Sat, 3 Nov 2018 07:33:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181102182839.725385066@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/18 11:34 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.1 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Nov  4 18:28:10 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 135 pass: 135 fail: 0
Qemu test results:
	total: 316 pass: 316 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
