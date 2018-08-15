Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5915C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F60215A5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdPrUk99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F60215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbeHOQC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 12:02:29 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42744 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbeHOQC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 12:02:29 -0400
Received: by mail-pl0-f66.google.com with SMTP id g6-v6so450102plq.9;
        Wed, 15 Aug 2018 06:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=or5SdIqeIfabEuKYgmsE7ZiGRqQNwh6Dl2lkqrE22GE=;
        b=MdPrUk99xW0cjeUDtX41d5Aej64+FndfXjhujqLdyMsFELQk2ESgcHHbCsvG/VK0MC
         IjG52lM2I27dYqZEGbNOOFXXZyMgkPs8NzJc0OINFYXDZzyJfEYuXKvTdyStQkJAqgSZ
         XPVxW1ze1r5zNeam7p6j94msenkpbZIezQnSDoJEnNVBtrLd1ptvTu9oT36pKoEZ2E6F
         W0A2rpXIGKLP5sBLzd7ehUQlCXvpaMd0e5YFb31gVEhk/7/wHn96ukLOwuLquQSjhvOY
         tL4fAXm1tMRRAAvJC0E7CuigucHMNc/Y7/YXlDtSSeNXopGl8Ggs1JEpm+cT0v7GueN5
         Cwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=or5SdIqeIfabEuKYgmsE7ZiGRqQNwh6Dl2lkqrE22GE=;
        b=QO+f3oTkRSUIbxpXFhgNQTWNJPNY2xCEaPs9vcIY6J/6BfFrGL4k5VjaQwIYvkJ0kx
         emkrG4khN1RoSgVRlIGLYuVfa5dCJfClCFC6gEiLZ/wsT9xHMY39qNzkxAgZbHBe/7mz
         9pLCOPPFHQEnaECNoajO9+isUCHHEfeumG+OCAKsxs+ud9xsnsY6/Ctna9+tPzixpV/+
         r2EIfJT4UHNIb48wdmhMMCrE1Lo4RCREh3JW0RdxNBPRbmugB2C7/ygMj425vI3vqH1E
         eJUggt0kJu8OlNDgKM31FpJ1NyEjbZdMQceyX9IWOE+DEgiUrBkm1UgMFfyHYT6FLbSi
         cyVQ==
X-Gm-Message-State: AOUpUlFPAEmgK/fF4sziZXhsbhKl1Z4bc3fI2Lo+yhpoqO/IGjrnBLX/
        E9qQutlr7I2HqSvzjpWoU0/XPraNKlY=
X-Google-Smtp-Source: AA+uWPySFc8oNz32Vg4oEGT0X9caBlwznko/tjnNJi8PZXWqmk9JuqvydynB7mO3gTMPeG1Jqp5fsw==
X-Received: by 2002:a17:902:4503:: with SMTP id m3-v6mr24434760pld.168.1534338622788;
        Wed, 15 Aug 2018 06:10:22 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id v8-v6sm27535272pff.120.2018.08.15.06.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 06:10:22 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/43] 4.4.148-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180814171517.014285600@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e0b69183-c333-829d-c5a4-17271ae6c5ae@roeck-us.net>
Date:   Wed, 15 Aug 2018 06:10:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814171517.014285600@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 10:17 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.148 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug 16 17:14:59 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.4.147-46-g41fa2bf:

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 260 pass: 260 fail: 0

We'll also need https://lore.kernel.org/patchwork/patch/974688/ or an equivalent
after it is available upstream in all stable releases, but that can come later.

Details are available at http://kerneltests.org/builders/.

Guenter
