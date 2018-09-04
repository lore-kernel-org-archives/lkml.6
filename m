Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71743C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1362A20652
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQfxeajo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1362A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeIEDRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 23:17:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44734 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIEDRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 23:17:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id ba4-v6so2297268plb.11;
        Tue, 04 Sep 2018 15:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=knOsNOvau3DljxGtJIZmQLN4yQKIU+MDrm6YdNG5Sdc=;
        b=jQfxeajoovFkV8dR9hHUntgSlF5ZKKxxhZZvNyCBXs0LvIpuHFDuaRiVfF7CCyp2cH
         yk8fuMe7bJz7a6F7ZZjx7i2StS0h5K8CY89nxCmTpr7XdjFMJrY9/7VngaXAwgQFsnE/
         D3vAAVZvHVCTYTrIoloFbNCmbZXxZsBvKXhN4f2JReaeR12e/8VeG4ktqUYLxyLHuYFC
         8GhHFcUfD2Jf9j32xT+TMfwBUlLkVEXNiYNSqfrdZXk+eu2CRWcPV8QL01LrLtgnpnnn
         WsWssiDRmOfsHxCtHSVtJMvmCWTktoSScVRuyGOLj9LJzzUIJYZZJoOpdf6yvGUkPfus
         Uc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=knOsNOvau3DljxGtJIZmQLN4yQKIU+MDrm6YdNG5Sdc=;
        b=ftW6/CrXB/ZdiG9fG03NZxOioY0WamSHrYCvpL9jHRn6fjff/U84SOdwbKBNONsxt0
         afycDY3pdkx/zzJrt04FZdKms/oNfzNEJDFniPxDcUshN2xe2KaLOSmtUoVJLwtLR+FX
         hpHYM/c8L+pbjQibhKtBv/IS+9ZKezImd+bf6mRa3SJ+rUNqkodtImpfsFAsxLz6j8iI
         KM9SgADm4Xs/x0rijOK1J6tPSBBa1sbkmQ+OuC1iY1xThJdRgLx+f834xu7U7hx2UdH2
         smZIMP56wOIU2twMYXckDq3gbPCyil7ORUljKpyy/kHNhrmcXDlkN3T0wf6lqOVLsTh1
         OarA==
X-Gm-Message-State: APzg51C8Ve+VaiaZYDKIMA7Lc3NJt9FXZ9bRdAnAnWlloF0CJBqmcs7x
        PEe3MQqcZZf8klrjWTqWdRdkOKgH
X-Google-Smtp-Source: ANB0VdZGaJOXLV91cPJLc3uT0XzDMq527hPFbX8njVPD1I1CYeCat02dH3HPZdk/eGtZjlzmy4piaQ==
X-Received: by 2002:a17:902:8b86:: with SMTP id ay6-v6mr36043532plb.25.1536101415352;
        Tue, 04 Sep 2018 15:50:15 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id y128-v6sm91328pfb.56.2018.09.04.15.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 15:50:14 -0700 (PDT)
Subject: Re: [PATCH 3.18 00/56] 3.18.121-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180903164924.078355019@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <918b2a4c-5591-895b-0a32-c39242d59653@roeck-us.net>
Date:   Tue, 4 Sep 2018 15:50:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2018 09:48 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.121 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep  5 16:49:09 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 139 pass: 139 fail: 0
Qemu test results:
	total: 217 pass: 217 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
