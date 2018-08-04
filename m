Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3CEC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8818A2183A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVtWEXjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8818A2183A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbeHDQr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 12:47:59 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43521 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbeHDQr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 12:47:59 -0400
Received: by mail-oi0-f65.google.com with SMTP id b15-v6so14875529oib.10;
        Sat, 04 Aug 2018 07:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5HfJCBLdYA7GPBQuQ+DSwXbgVJr4StNXq2eaGmDuHMQ=;
        b=eVtWEXjqsBsqxwqmsbyHP31of5MB7Pa/Cm/cq6t2kL6ZZ/UHEXivDgLHEx7CUPfUty
         Fij9Jky7ISWuldtonVdPlsFUklFzxT0PpvrUarHMsXh5LU6/OGqLMvyuhkuHtwBF9LVl
         +0lvvB8bTYLLEm2oAAuJVeuQqoutPWJEomx3thP5GAzxyZKQ7Ezt5u+gHyHFrP1ydsPJ
         YtHXvtp/Gc60Geh3Tb70zMdbKmK90sr0+olmfkhk1WeHTCS/jphOwgsQW7yc57OaLFxu
         qgLQSUWQYWQx2eqi8cX+2fDG23V4jCCr3llTiodDfA4ZX4wPnyH+o2+SNyMUE+2KDo20
         l2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5HfJCBLdYA7GPBQuQ+DSwXbgVJr4StNXq2eaGmDuHMQ=;
        b=cJRLa/LvhJIrVZHJwOijPGay2/JF7qHi//upaQh9+MRleSHEWv466gEPPQOMikq/yj
         hZqVjIE4AzTpVDwSdSwRIlDb+Cjcjmh8E/Qj+85PnOTLaIvPjXam2SpkoJFcRIZx6wVs
         qdeflrzbeH4y+hvDA1OLmXKc9P6y20QS0AJjYiqXrwg7wMTPN2XgpMERUEcR96arMW9p
         3+Y6tc+p2rKqrXEYaRkTB3Ho4IEP24YkkWsmY797TFYVACnJOfzE/Qze4lZIefibvi+C
         Qd+4XWJ2I7vxXzLsRSEf6PgB+OvtiVRzotpEWjBC/EXqG2ZqVwtiJWS81ldnSgnr6dOk
         jbKg==
X-Gm-Message-State: AOUpUlFZVSGGVIBTkXFirIP5oLnNavYKvHOYJhfZBAU5nEXWovhBikDC
        GqRPCL114ag2JUBiFGQ+G9YYPSC4
X-Google-Smtp-Source: AA+uWPwgy/88o7cVymXhpsccmapqvMNO4WnSqTkr+tKLhnT9tqWVi6oOMbLZW055JOZtPbeKpVHJTQ==
X-Received: by 2002:aca:bdc4:: with SMTP id n187-v6mr7850757oif.3.1533394023237;
        Sat, 04 Aug 2018 07:47:03 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e125-v6sm16080497oig.4.2018.08.04.07.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 07:47:02 -0700 (PDT)
Subject: Re: [PATCH 4.4 000/124] 4.4.146-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180804082702.434482435@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b6620e4b-e362-a951-fd95-da3162a122ec@roeck-us.net>
Date:   Sat, 4 Aug 2018 07:47:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2018 01:59 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.146 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Aug  6 08:26:39 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 226 pass: 226 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
