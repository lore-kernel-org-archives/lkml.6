Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F92C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C551215A5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOFXkeL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C551215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbeHOQHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 12:07:32 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37182 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbeHOQHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 12:07:32 -0400
Received: by mail-pl0-f65.google.com with SMTP id d5-v6so464626pll.4;
        Wed, 15 Aug 2018 06:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EkX9QQPVDnIEzYADZcgnBu1M7QYfQVHrgMfnrD/hVzw=;
        b=bOFXkeL6m9EZmPi1bzvW9bVJRWcje32rY2BXTn+5p4kl1V/2qoJy7jW2mn43JbYrt7
         dQsvyrH2u4WajO6ZIJ3FMIaip5Ecx0fljWmPOV3K2UC+nddDkqSOUiKf7PRQHJIeqKYs
         HnhTi3BdKN+oItskDYJPgKn7ZB1nl/3OxWA6gTDeVvAZ6uHDIWprCT/UVP557sCOTlXO
         cOFEpGl6kOpXclb3qR0u4SY89wFXXrZhNpreNHOSXyQPWxYgAxti7cSj6p3Aqv+RKFo5
         OokTSlEy3XvcWvYWJe7MYdRNO88sbZvP7npeFkUX6T5XyGRzlAP96z2EOtioINqLgJep
         WT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EkX9QQPVDnIEzYADZcgnBu1M7QYfQVHrgMfnrD/hVzw=;
        b=lNLQhJJA0fNlILSOrqX0ZymvuaseT3CwsY4HxbEOimcoJWCJsMcNrQlLNmKwZaL3jv
         9+I/hY+jfA26LuiU56wVswXn+JQjNuuoGcUVWz0loMQEwo35+2eY1KJSu1IgQfplsSCt
         bfFK8NtrX7DMmWt0bA1uWQPbNow+SQzq3QC1og1mCsOUZNHZyvRHDRJQUh5Lp7whHMqb
         QKj8d3B+5khNUSSeOC75jXjMb6yQUYH0dIq+pDQm/tGFsDU+qYdumixSwexMfCMsATYN
         oyRwL2voHxXI/j2hZ0Z/OtFwCJ4O+osY7H1oggq+Ces/xeCeGBB1jt7gHR8ZTewF6m+P
         MBYw==
X-Gm-Message-State: AOUpUlEVtobdYM6q3sHSEDj16gzVcDgh/uO475xvCeIXFu+2xFkKA8rp
        JKysLCHDTmrWhD2lWnE60Q+eVEpT7QI=
X-Google-Smtp-Source: AA+uWPzFs59VbvYh8hlM3gF1hzNRnKAvmaMEgng7bknrIAH0KIm/r/YexI9nGtu4YZmdOkMRp8tuDw==
X-Received: by 2002:a17:902:864b:: with SMTP id y11-v6mr24811568plt.335.1534338924475;
        Wed, 15 Aug 2018 06:15:24 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id f4-v6sm28781065pfj.46.2018.08.15.06.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 06:15:23 -0700 (PDT)
Subject: Re: [PATCH 4.17 00/97] 4.17.15-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180814171433.160434170@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <fb05d2af-0397-137f-48c6-529f74b6c1dd@roeck-us.net>
Date:   Wed, 15 Aug 2018 06:15:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814171433.160434170@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 10:16 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.17.15 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug 16 17:14:15 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.17.14-101-g2293fe70:

Build results:
	total: 134 pass: 132 fail: 2
Failed builds:
	i386:allnoconfig
	x86_64:allnoconfig
Qemu test results:
	total: 302 pass: 302 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
