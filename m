Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939A0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B552083B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t+hVdOMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfBSR0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:26:23 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45424 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfBSR0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:26:22 -0500
Received: by mail-pf1-f196.google.com with SMTP id v21so7535990pfm.12;
        Tue, 19 Feb 2019 09:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bb5pYMy8ySL0xR4FLMl9U7Ahi0lITatwamxK1frRquI=;
        b=t+hVdOMAQQK00bGIQXRpVop4RMqIeH/X2ZmhnAO5ch3DGPd40g5F4Z1j5Oh5x1WWfT
         5HdIxesMAXcHjif9Y1sBTQrG25Xxxvr/2qXCcElMS13bJHjadxeH0lPq3Js6M/L7eX6X
         2jtXQ5SSRPFJ8Q+FbIfk7GW234aBUxolXhGfh/cA8aFzlogbyd6fsDwFrvNAxZcQj7pt
         U14NzJsKYEpH2mOPSj1jROMnhdiymb/K6T0BVeypdSfcNl/kyQISQuZPD/M2Bmd6hq8s
         ZxRE9e7JkF+uFcsah5DJ/egWaImNSI8KFt6PL/hMPjrx+55G4JDV9P4elCGcStyWoFQI
         IpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bb5pYMy8ySL0xR4FLMl9U7Ahi0lITatwamxK1frRquI=;
        b=JXEhBXyWSJPrP2tDFLAqSSoQYq+V9KsoLDXqo+cn9TPnxuCYlPDQke8ggRnhJCUDRV
         USPrr+vNKkUOnls4shLOH3H28TnmVCN3kv6hfFJO46YFhrs7/qcfj9ThSieTeOsLKP4p
         1dSzQ1IDi2e9N300w8+b0/WSsDypWZcnKTUyijxvtJj2mWPWaAhrQINmY+pmTHS6RC17
         NXXDbL8cpGKKc/o66fH5WRFPZwdBuXIH1OvEKHvYeRpvKoyaHR2Vf+0Karj/16knAc2w
         IXE50P7mdJI9nB7JbarPmyrM2lEnW1hX0RIzuN/dwLID/kfMEDsT+HRr2GdoMs9AiGtH
         xWQQ==
X-Gm-Message-State: AHQUAuYykXbK+Ruv/r2pticTP3JTdrS2nA6ZEnJlykKT0FsAudNt5hoM
        5r5QzUnyQwPQviEdm9Lpx/mgRLTO
X-Google-Smtp-Source: AHgI3Ibduqp51Cb3HwBynpkBi2uwHjynBCNiyaVe6E8Jc+SG4r2aHkGdtK4f4T45L7/YQNFVWnAMSA==
X-Received: by 2002:a65:6684:: with SMTP id b4mr25068327pgw.55.1550597181304;
        Tue, 19 Feb 2019 09:26:21 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l28sm26828162pfi.178.2019.02.19.09.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 09:26:20 -0800 (PST)
Subject: Re: [PATCH 4.4 000/143] 4.4.175-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190218133529.099444112@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <fac15d9c-f74c-8896-de27-1636f9ed07b6@roeck-us.net>
Date:   Tue, 19 Feb 2019 09:26:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 5:42 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.175 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 20 13:34:55 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 171 pass: 171 fail: 0
Qemu test results:
	total: 291 pass: 291 fail: 0

Guenter
