Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AC5C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 02:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B81D206E0
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 02:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANG45zz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbeLOCHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 21:07:21 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41637 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbeLOCHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 21:07:20 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so3646289pfi.8;
        Fri, 14 Dec 2018 18:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=trG1qsbpUrwMJsbD+W0ZJGrRMYWQc42BUH51qGiPV7I=;
        b=ANG45zz8TOdMP7UrLeY2eLSd4CltEfwUc7JJa5hYNnWXT2MlY1S2fZvAxkoJ4rIgh6
         xNum5bk/c4C107WUyGyTQp9T3isXF7hGaixQk5jiF0vpkQw/sZn69WcDdMqgVumNzdM2
         vYMmsY3ooUmTM5WoR6TjzvsV96K0DljWiv8Sh5ldOMoszf23BpOEuEgNv92gFTXefVYe
         rLJ0w5tm8OgoWMy0CJijJzJjr7/IBxwCVp5/GBBh+jJen4LAgtwlvoh5meqMXvxlZeUW
         +29s/U3YHpdnqXzn5mMHxX1rCQ7/x4QET+a/LYH5jfYBpru618R/V5+atr2Qet4pKW13
         4mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=trG1qsbpUrwMJsbD+W0ZJGrRMYWQc42BUH51qGiPV7I=;
        b=g0Jtud38n4zv8NGKtjqIui60sutUsAUbi1I6duBhqzDz0/ODhlAE9PvLw30gISCfD3
         liDJzL5kybMvjsFD+vyeZ8pRVsXK02r5U1E9tPVTq9aqOoZoJMb38GBQ+Ct+lRChLAaa
         IjzB1HUWdWn0HeewtFR2vxvyPhbJEOgh5ruCu78N/N+5rXEnqHKAfhEAZc9mVZt/9nSj
         0w6dc7OaeIHhWkyMPn0sxxFvgPZ5+tGe14BEozNsK4ypeUH/9uMnP6K2rptmHg6CGlRp
         l2e1P2hfxNMOC2lmSyE51h8vnBzWXXZVSHD6Wd3whIWHK9N8hSPr1y+HHrznwMh7qNz0
         zvng==
X-Gm-Message-State: AA+aEWYiljQdN+xAje/XDeLxFyEDMpzze69mPG+dwjW02I1Q8Wgfhz4s
        hVg7S682BXTp2ANM5bVwItwg2qDX
X-Google-Smtp-Source: AFSGD/WuZdyi01RcEKsntc5n4Eq8NEfNvrJ1MiG0NyYU1qjmU1dOcReNiJgWqk5j8K5/EgIZqdLjSg==
X-Received: by 2002:a63:91c1:: with SMTP id l184mr4774110pge.29.1544839639812;
        Fri, 14 Dec 2018 18:07:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v9sm9789829pfe.49.2018.12.14.18.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 18:07:19 -0800 (PST)
Subject: Re: [PATCH 4.14 00/89] 4.14.89-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181214115729.658859279@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <1f955eca-f4b5-3370-e165-facc1a6519c4@roeck-us.net>
Date:   Fri, 14 Dec 2018 18:07:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/18 3:59 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.89 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Dec 16 11:57:01 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 171 pass: 171 fail: 0
Qemu test results:
	total: 322 pass: 322 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
