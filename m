Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C31C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF30E2086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/dAU1wu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfALRp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 12:45:28 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43709 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfALRp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 12:45:28 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so8414803pfk.10;
        Sat, 12 Jan 2019 09:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AvmmofurWQ3LTXWpLW8ctik9flAqsqq3vbpMJxIrlt0=;
        b=c/dAU1wuNNQuoH8NBAtTdxCen3vw4lELmnyNt5bZw1zRElx5iIFFkBQgeVHvgJPT6A
         SvlklwAmhZABSnrKnVDh8kS4JnRRTEP7Fn4/J7s1V6xSNMvz9UZaIi/A39xLwdQbhYHD
         dr51jwLrIfBDzBNg1KQxqZAScBvQvvDA4xWqU8IOCGLGsyNgow18m+Wp/JEHKfeQjOyu
         Hx3iDLaFVYZjQjb3HegaF5vRzyau+MC2NrEnVfQsYUzJF2hvYJlLVypBU1lToBfIrAhv
         q6OPwzCuCC8ai4Msxg9z/4oNpMvq6+iT9QnyrqeQtZYYj1bRcc7xq8YFQEIUQb2HCps+
         4r6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AvmmofurWQ3LTXWpLW8ctik9flAqsqq3vbpMJxIrlt0=;
        b=TbUdOpPJ8fOyFWZqtPaMiZf91qh9cC2MZwsw7nJaTA9TBRJGoHfbnXCgZ+HD1KgGwZ
         gYQ9EhBnm6Ynom7PrnkbZbsq2hhcuH6yf3ZaS3++G0hJF3SkatwOnaeWKxN4jqHWX/mg
         GRZqriYXeQMLrJ49WDJiGI93lyJfXm8ylxC0RLeOb4JasDhLNvxd+kUv8eKgQ8jQXMtK
         0p6jx1jHjY6GTfVIcazJV6WwRbA0Xozkip21f30jrXFNeLiWvZtkCZe+no82/ghgquXf
         3D0nMXHp60VKxiXIdBcPLJrIYq1n9SJ7+frF54ki4IJxl5aqKkn2TMqz12i3IFUDI4dK
         qYBQ==
X-Gm-Message-State: AJcUukfDGtkyHvrJ/5G6yWRFKxthaddC//ebDwDtRkxMBRWAd8MLMQsE
        dNDhV1t+Jytx/FdCSC1GmoLsEM7v
X-Google-Smtp-Source: ALg8bN7GKxXnNn/GGKJm2qltTq6gcLfNBR5/gqNXbBtTpbuN4HWxlIH6KhuRpzZ65yeG5fSv79dnhQ==
X-Received: by 2002:a63:fa58:: with SMTP id g24mr17053675pgk.390.1547315127123;
        Sat, 12 Jan 2019 09:45:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o66sm155944524pgo.75.2019.01.12.09.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 09:45:26 -0800 (PST)
Subject: Re: [PATCH 4.20 00/65] 4.20.2-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190111131055.331350141@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <109d9c33-04e0-f4b4-f08b-65004b3b771d@roeck-us.net>
Date:   Sat, 12 Jan 2019 09:45:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/19 6:14 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.2 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jan 13 13:10:14 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 332 pass: 332 fail: 0

Guenter
