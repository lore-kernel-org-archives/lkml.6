Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB00C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0891B20C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZWK26af"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0891B20C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388155AbeGKNq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:46:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34134 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388058AbeGKNq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:46:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id y5-v6so2927027pgv.1;
        Wed, 11 Jul 2018 06:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YAgkobCfPs6YMK3cS9zY1fEkgbtGPiLMbKm4a6gklXI=;
        b=UZWK26af+9xb3BV/2YR6/uqy5xeaTMWwRbUppjNIgunSbr65FuBY1VTKgvdtmKw/4d
         hPSQeeTCvrmI3VgrrvqL4KGvDBeQ+DfbQHnYP91nAFPIQ/elgwjv6lzq40nPfOXJDG5U
         rd+Sk6342CumvbeBP9puXWtGplB/hhi9egdEtQ18mjgX1qGZZ6pb5dt+ozFt8xRSmqWv
         NOw3NVBXMbCl8wkJ7n5+1YdobYfSmfaPp1UDpSx7dSoSZdcWCxX1CQEakVyJEvzST5Zg
         FTzu5BG0xMIzK5siubrCverwGB7nrw5StPw3yZA0beyK8Pywj0GCXLktL8Qp5Fje3a6E
         pewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YAgkobCfPs6YMK3cS9zY1fEkgbtGPiLMbKm4a6gklXI=;
        b=KiKXOgMoMH/rG9+tinWXSB6oBW3cIWYEyVrChucnergukBcwodSCtBOYwG9JPKb2U3
         6tkmLNqL+gMUpW4k888UBNeSH7Rd0H8WDGtKX/7VhbWyDKjBkbewDz6CNtPpPy9LgDeE
         9KhBzt6zFY+omSylVTLn2YDuHAeDxs6QT0au1OSR9u3koZSMOvbEB1/gWeBLjNwVQVsR
         0VYavMfwioBXjb+c6zkx8mSh2/C+h1f75IIKyCOEEJk9wDfheAq+r0Kj0BZc23pRe2zG
         3Q6grchTqSZmu/rKalZ/OQ9n73aIolI3xsHtDi3VX6DryIPjgHdN/eKcC0V10+jcPPZz
         2a4Q==
X-Gm-Message-State: APt69E0BySgUX0Q6tgsxguGivGU0AsO+fSbCM5c+qplDZ3VcmDJYG3qw
        qtz/RBwoXZn8Epg2X5kGUlaVZQ==
X-Google-Smtp-Source: AAOMgpePEKGXXV5UsVv0HcKbEJ9UShpjqEHaLSiOXuaAet8wLlcIOZ5JE1L9VBfqmdAgFF7zWIe6aw==
X-Received: by 2002:a62:d34a:: with SMTP id q71-v6mr29952208pfg.17.1531316521262;
        Wed, 11 Jul 2018 06:42:01 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id c12-v6sm18729266pfl.20.2018.07.11.06.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 06:42:00 -0700 (PDT)
Subject: Re: [PATCH 4.17 00/56] 4.17.6-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180710182503.544433950@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <45974726-40ba-b32b-a2b2-45ba08520678@roeck-us.net>
Date:   Wed, 11 Jul 2018 06:41:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710182503.544433950@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2018 11:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.17.6 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jul 12 18:24:40 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 134 pass: 134 fail: 0
Qemu test results:
	total: 158 pass: 158 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
