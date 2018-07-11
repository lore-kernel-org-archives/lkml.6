Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5EEC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73ACA20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReILmoiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73ACA20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388075AbeGKNog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:44:36 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42630 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387825AbeGKNof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:44:35 -0400
Received: by mail-pl0-f65.google.com with SMTP id f4-v6so4989327plb.9;
        Wed, 11 Jul 2018 06:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XsjcngI87CB/TiRQM/q/fiPsPlKHs+b/QB50q7HX6Ws=;
        b=ReILmoiCOJHGVuwmoYnhSiUMZKbiqU8N1GIjgHemqjo28F+Q7vuLq5tJXBI3rXVTou
         eMB+wGvVSOBGBfihvB9FAONq6rJquwQQuF5/aiAGDk70Zbuxq3b/qVMYcSeeUUWX2JnY
         pQxVBZJTuEJyb1KKzxS889MBo6Ttdo3tCo1smGWmiPLNl5eBfPrcIc5a0FYam/x4Vv9Q
         fvJkVHQY1X1Yfju0zV2FyZtqAstiFoa7EiDIhCPuHrmJK4h7O8T6802X5KtPEvqdfu++
         xQNcD+fVGEBqiaMAR0IxqmSLVKsDJHdsj2sE4X20uKjdAiIHLs1L5S6waWd/VTmPvRul
         2hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XsjcngI87CB/TiRQM/q/fiPsPlKHs+b/QB50q7HX6Ws=;
        b=d0GCWcUvwwQALsLAALcTv7fTUh6HKITZV6yCBSmsW0f9hU9w8C9QGStYK+OzLEszQj
         6tnh+a1WcE/3/f0GlgPRrNTl/hnxnVM2clE9t2680LxDW4cY3xnOZn8wLwnW74ATB90E
         25nKxs20MM6KrkYSPVafxc1bMDgsFWvMfTity3X28Ys0Uikopr2/C2KIvdsv19U8/gsH
         djT1M6vskkcn17f6GW+qPMma1TF5ZmuP4hE6Zj/e08hKNu5R3dkfZta1Ob01mSCvR51X
         7Ur+gFYhUhfO4tFM7sFA4s6xzO66CyVuHobb0Ds0nAUdQjAf5brL18WexaZrDZnZJPYb
         xZug==
X-Gm-Message-State: APt69E3FqbHZjrorrx1ErYw3pysnDgQrtvD1dIB8AHKlujzvPFyECDpj
        CMnvG7jJB3z8FtlkjeReRqP9bg==
X-Google-Smtp-Source: AAOMgpftFUhJY85ic3dCb97v//WWl2rwLp08uxj7BxN1Ls19xNc0IJSSuGt9hmDZDGosPhfsClOMfg==
X-Received: by 2002:a17:902:9a08:: with SMTP id v8-v6mr29064951plp.148.1531316411539;
        Wed, 11 Jul 2018 06:40:11 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g86-v6sm10978797pfd.23.2018.07.11.06.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 06:40:10 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/47] 4.4.140-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180710182337.047502999@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8a7176c5-1b56-1f7f-b60b-37bddd907f58@roeck-us.net>
Date:   Wed, 11 Jul 2018 06:40:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710182337.047502999@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2018 11:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.140 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jul 12 18:23:24 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 138 pass: 138 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
