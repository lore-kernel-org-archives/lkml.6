Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4A9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7E921773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opRTLS98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfBSQyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:54:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34651 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfBSQyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:54:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id d15so3563616plr.1;
        Tue, 19 Feb 2019 08:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i9/tDrwslQAqGDk7uVfzIY6Bi90ZCCqJJ5GTuTnen/Y=;
        b=opRTLS98ouoMf1oDXoHUXBJVrVbmytmQqCzhbrOzzxZlao0PGGHCvQiHeDJg2THcXh
         8nBTKfc6adbpDAqvMCD8RlG6TtQkb65QOtGzRyuXrHc7k0c9QgK6VIoONw9tC51hUKiH
         O7OsE/Tx4E43KefFZZkuS1UgilkA8hBwkdUPe7563qVDWALGnssWXPouln2FZyOYDFCj
         70ROGieySPEJEfJEsCDsFtPXIO7pTRYouy/Dtd4bzNyhLQo21LNbNyZPWbDpmyU7xCpF
         cu87mK2VRKGRaIHT1vMS5St4oXMjyOzV8MI4amaD1bJeSmxH8XKxkpATFRHLs8DEfT1i
         rdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i9/tDrwslQAqGDk7uVfzIY6Bi90ZCCqJJ5GTuTnen/Y=;
        b=PHcAYMb4qV+PtOdkbjH2lP46vYlXoqCmBqKJORljAguQO/geoUEm3BmRiCAevTGfOK
         SVbvYb1QZVUwgJXdvms8w7ITsfRwohDGV61O0wkEkScqzwxg/QWB7ek9DmksHdWRXUUZ
         QtFFcClDFRqWyU/Bam/wXCF3ew6HBtQg4ZDBCGP758din9dlN2sNX8pp6/0JTg5NSStu
         NE2Zt0ERWEUbQcp1v8f0FxOHPgnYVt/cG/cRSJqzTpUQ2v5emMY9nrmNU1UiCTQCogfB
         cxrkzotCZXx/vu2Whto4lmtDB3ffgcU09FOE2h6EY4GavboyoWQO2Mht+JzbbfQVg6za
         6isA==
X-Gm-Message-State: AHQUAuYGpLVb/DFE0+EcyrOqesGm4hO8znA4ndVsO/uQw7YYU7SSYgB/
        WmxohBAbJhv2gkDlCl0UrMXrbbuY
X-Google-Smtp-Source: AHgI3IZvTjf5y3rtxBXo8InOh5d9djZzBi9hXRlRxADA9odULF6QhjTYXT0TphKRZxU2tXlEMU00Fw==
X-Received: by 2002:a17:902:724c:: with SMTP id c12mr22088817pll.110.1550595241320;
        Tue, 19 Feb 2019 08:54:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l19sm34626651pfi.71.2019.02.19.08.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 08:54:00 -0800 (PST)
Subject: Re: [PATCH 3.18 000/108] 3.18.135-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190218133519.525507231@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6e5fe2d6-8829-33d2-ee7c-9977e46f079e@roeck-us.net>
Date:   Tue, 19 Feb 2019 08:53:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 5:42 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.135 release.
> There are 108 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 20 13:34:47 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 226 pass: 226 fail: 0

Guenter
