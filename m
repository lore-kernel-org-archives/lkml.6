Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F89C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403832086E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEpJE+7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403832086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeIICAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 22:00:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41473 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbeIICAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 22:00:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id s15-v6so8597456pgv.8;
        Sat, 08 Sep 2018 14:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tTXR0VNGLuHc7fbtc+eK2IRnYfzW5p1VPUg23zTbxRw=;
        b=UEpJE+7ef5bRUOl6pc4qphrx/nW8TGwom726kCfFyZvOFJ83XO5ds7CXTH3vQMivNL
         S6hxnFHHDSTe9TM4sch5TzJ/b+UEeO35J0mFQ10utsHD5sBKEWowd8Qa917pYVKGEild
         8YJnHhasFgBpTE077QlrSx+Op/ed+Mroq4fIQWl8CKT8Z8eCWK0JJQnM/NkRxYKJMYby
         jEMBYzKvVwBVH00AhSGfo7euUdN0B8NgDEN1CxK5PsWqEOhU17G/Xf2pHgPem0A+Y+xt
         x+oCa9f9pQqjqrASfDVLfDqf9SdNsEmGB9XQI19yGKI8NdGxyHoAHL8yRTz1/W/goEzj
         5qTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tTXR0VNGLuHc7fbtc+eK2IRnYfzW5p1VPUg23zTbxRw=;
        b=SKT16Uils6eIRhydtktzbjQNIzDDXwSI/NXY7Lb2gzl9q140dIwp/jRINJrbJRTWxf
         o5UR3vqSNzENuQ6OvxOI60GFtY/12nQn6ofybMTiw1NH/vV+vW/8oYM1qCZvS4eY8sIW
         1tSg75nU8kbV8mDd0OH+ThOvk1SO724Spw1AsrVaue+VNVWikfK7s+sCMocZgLRQ/zwi
         +bf8X90NiUrvaR6hkGDEMolBTfV+A5FLhYpfADIs1K1+dlpNCevNvOyG8poUcMsq8x9Z
         TIrNQo0FFemPThnqqlESS6coUc9LyOAF3b93abBG+LojFuOjTEIeB0imS+UuvfKXfORa
         Xyqw==
X-Gm-Message-State: APzg51BB71cyoIUaVUKF6GiPZwNf5+0SwzqKCnJxUfcWbJjDWn32XsIR
        vh6fjPjUQ9DxBejXEunOeHQcmnzy
X-Google-Smtp-Source: ANB0VdaM1saKS3BSAZqr+ThKQU4ujl4VnAq5Tr9tzyib7aZVqtM+znJSS+fqyt2VdISM8hWiEh/+Mw==
X-Received: by 2002:a63:dc17:: with SMTP id s23-v6mr15074126pgg.40.1536441177490;
        Sat, 08 Sep 2018 14:12:57 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z17-v6sm17889972pfl.146.2018.09.08.14.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 14:12:56 -0700 (PDT)
Subject: Re: [PATCH 3.18 00/29] 3.18.122-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180907210909.523240901@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e0e9b658-d740-3306-0da6-25200c0ce0dd@roeck-us.net>
Date:   Sat, 8 Sep 2018 14:12:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907210909.523240901@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 02:10 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.122 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Sep  9 21:08:52 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 139 pass: 138 fail: 1
Failed builds:
	powerpc:allmodconfig
Qemu test results:
	total: 217 pass: 217 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
