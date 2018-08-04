Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BE9C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD3B2183A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHMOO7+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD3B2183A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbeHDQsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 12:48:40 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45198 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbeHDQsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 12:48:40 -0400
Received: by mail-oi0-f65.google.com with SMTP id q11-v6so14852388oic.12;
        Sat, 04 Aug 2018 07:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JrXlp35ML7lCXjccnrUbVIERtrjEl/wF0e2XfQ/Gor8=;
        b=PHMOO7+QAuDurogzVPgheo+19BSIyMD8h04yOKcFoz1m6azmvQyEkbBfhfBpOwK8O7
         yPlWmlUAzOEZpqJtD4L0J5HrFaS6xvZ9XbWUlgKeoKJWJXRUUusYuJXxQCQWLo/VPIhY
         PQxa4QiPpJkM+5QAU++ZnfZDwBWYo/qCgf6frqgNrS7VfhVxcNEPvN9UsZYLPS4RSurX
         Gz4o3DsMe6P6e59GS53xGsGL7Sjl4/bGMRfCUk6cf3hDGR9CfEcC+gEBh17w7D6K50I4
         y9Z1BDH3RkF43kSn6hlbH6GYh/eKXJhJpG2VoIkUikzDaJOh47Wjhmg878wOrA/oXnrh
         tqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JrXlp35ML7lCXjccnrUbVIERtrjEl/wF0e2XfQ/Gor8=;
        b=AeERp0aYUapsu39HE2Ljx8Buqw3l1PjS19JNSRp9xgqpUR34UBEC1VbLIhFionKc/k
         Q6FmTuDOpOK4YEHbdIu6PcDD5Tzs5W/pCUbH7LkkJ/N4+yglBzcMLWwLjulFxlgzm8C7
         oSu41yklIFEQS7Hw/rg4Ga/jWX9twPXSU+hYXbOjWKqsTtUAAaES8+M+C9FK8Bi3w/uG
         0MkDGGMQVi2Vz/F7q/IzbzgE/aAgC5UeWCp3Ko6/ZWl9Emh0GXoKdE7dB7E2iUD8SIrb
         QvD6/kKItgCCm4HUWBF/KarKUPqX/e2Gsj6Nu8gC4lvEdDIUwGtIspHu6Tvc1emVlPG1
         VEyg==
X-Gm-Message-State: AOUpUlHoXIdHS86qlfSXGL1fFYnxKmCcu4c6+zlr8A8eE8DF06U8SL3j
        7VH2QmCHJ6rqw9WSNkaGLJpCpY4c
X-Google-Smtp-Source: AA+uWPzkANEUZ/Pc19Sd0P2RND+Si2z7zLRuF01A3aolnLeCbnC8LRri1ijId7UGTjKiNMTuienieA==
X-Received: by 2002:aca:b208:: with SMTP id b8-v6mr7199851oif.144.1533394063636;
        Sat, 04 Aug 2018 07:47:43 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u144-v6sm5452260oie.14.2018.08.04.07.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 07:47:43 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/32] 4.9.118-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180804082649.908295462@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <eb80422b-d10c-c665-f483-285378fe337c@roeck-us.net>
Date:   Sat, 4 Aug 2018 07:47:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180804082649.908295462@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2018 02:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.118 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Aug  6 08:26:35 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 250 pass: 250 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
