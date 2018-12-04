Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3601AC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9CF20672
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IILtLPcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9CF20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbeLDVmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:42:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40867 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeLDVmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:42:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so8867836pfo.7;
        Tue, 04 Dec 2018 13:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HNiKwUdSEHj6MLoOYUPfVBffm3mHQEsPWOPE22EZB0Y=;
        b=IILtLPcjTzQZLCuUEoJdlBMqiMWjmuf6zLKK3ZJZB5XMNGr25wKxgVycxQn1Oqo4j9
         B1zmVYpCcywL+g97b/CZpjnS/RHP3sbZ0Ph1Ej9ddq1yAVedNNTj/Y+fkfGw/ByDlk+4
         OeW6OLrPTtoCwFa669RoZdkLZCgZQlsBltl2dBXKfmKS2aHIdoYektW39f83UtLuuW71
         67XOm7ECTjg6whGTPKnVGF5Ljs/xMM/7uxrOEclh1oTj8qtPDCefBFv1ZEkccWBp0tPz
         b2uFJpbALAcyVl80HRifNpApWBSyBmGp0FU3Yd7kA8+YVNUK69TVPzt9TQr+fcwXAhDr
         2TMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HNiKwUdSEHj6MLoOYUPfVBffm3mHQEsPWOPE22EZB0Y=;
        b=Jy5TBV41wRTq7X5F/dpBqp+41HB8X+EqT5wpExo6LaZ7oTTc+kZx8Mk6v5jI3XZf5H
         E3LEBtGYbXzGjf2GVnulIckFhaYYEOHI3Pf4qzHUpHG5l78IgVzlzYgK6Qcd/6dhHYAA
         844iv8qbTWHI3e6O3c40VJHekraZSJwZyxKKyn1n6ouxdPiExBBhZcSPEq4SENKSsGgA
         8lzzW0hHAyIQqda272Ggk5mG5E4ozWNoqsqAmyVaEOlLORt5aJgTtKv7QOYBdmy0kMmx
         mC1lMLLgka0jy5TNgPqEKGeTpdlFoerweSbVo0fgqXNcWYxC9tlJ62aTrwEippeHDrcx
         +Rsg==
X-Gm-Message-State: AA+aEWbCmKUFKPea68+eCuJLimMrkDIMhuMoj9kaHXEjahqOgD/sWe5e
        /pv7RYWbsU/MYtGov8ZL/DnJsjDI
X-Google-Smtp-Source: AFSGD/WSeWiXkqU50Q61Tf3hHq3MWhzjIklx24WcyNc5nJ4cCj/AxgYdhwXY71/KfGmr9mijDawpjg==
X-Received: by 2002:a63:588:: with SMTP id 130mr17930720pgf.273.1543959725107;
        Tue, 04 Dec 2018 13:42:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h74sm26702294pfd.35.2018.12.04.13.42.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 13:42:04 -0800 (PST)
Subject: Re: [PATCH 4.14 000/146] 4.14.86-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181204103726.750894136@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <068e5e93-9565-e11a-c7ec-d6f1a5fff19c@roeck-us.net>
Date:   Tue, 4 Dec 2018 13:42:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 2:48 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.86 release.
> There are 146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Dec  6 10:36:52 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 175 pass: 175 fail: 0
Qemu test results:
	total: 322 pass: 322 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
