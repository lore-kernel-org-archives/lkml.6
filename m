Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A68EC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C9E217CC
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEpNLWWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C9E217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbeHDQt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 12:49:29 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33756 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbeHDQt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 12:49:28 -0400
Received: by mail-oi0-f66.google.com with SMTP id 8-v6so14978875oip.0;
        Sat, 04 Aug 2018 07:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ikKXVzSgGo2I2Zb1hq1JgyDSq7uF1u9+yJzMfCC/ZTc=;
        b=hEpNLWWzLxkLUGsoAsXQP8baLPRwT1xVpCQry6dcs/VXpwEMxDAxEqKxLW8HAiP/66
         AMtU2SeV+Q1ZuYiL/DImuAAVhEMKVS+3CG2RGiOPLMTRA7Rq7qWq3Vw2zZLFQgEc/kKd
         wyw+lz5Q4ojZFGFL+zLASHUzLOadYDN5hGZPqq1sHhSZekxTweXb7YwCtZxutY87pMwg
         aYv9XTyoJoFPzDhhBMpaz2LRe5zPhr4XX8zOEuReMbhb1jCcNINxkHFpfUWetgTRyScV
         IdA4fNq78aPwHvG8tQU1b/GuZESq0ioE5WE+v0BAG31nRjJbN2NTC+7LKcDqJ9tsRZkP
         U51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ikKXVzSgGo2I2Zb1hq1JgyDSq7uF1u9+yJzMfCC/ZTc=;
        b=PGY8lJDYsaTwxK/8HJb7fCtjpBbqmFtyK9XeTullP78ET7XJfNb/vLmpjrKdFolGQJ
         9DUOUUyuAdWjQSWogb3F3C9TPf2lgVkn+M0we22IeabZ1QmrxOh5Fk3sBmF8CDeC5P+C
         E+ndPdlOmXm1Hm1D8cfX26hVWFO1jtkgHJ2H49ZAjyOdNfio7uBpIxLgVvCUeHFqxiRg
         MZPQP1l5qEOAu/14nBuieV7Dmoun+j2EXNTwiL8cQTLZ50ElewQyZHoO6cpqjjzuqsCm
         JYmE15Mu9IcZ2bUodVoJzjIT+k9ENcXvCq1FmlqHXRlIBsLzRwwAbtrZvUbG+cDrVP9k
         UfpQ==
X-Gm-Message-State: AOUpUlHPiWtWku5QyID3O60DGIKTiLI5wfGxwp/zgg24vVyHbvg527fm
        hBq4DvIP8dBUWPKlq9eqHyGazonU
X-Google-Smtp-Source: AAOMgpcl+VMiTIrs3Wrh6gEsvDdGDJ1FmkHFa+idzXAs7VqppptPRoFPsRcAb6dvHdLsLtmjmkZTgw==
X-Received: by 2002:aca:45d6:: with SMTP id s205-v6mr8234157oia.147.1533394112177;
        Sat, 04 Aug 2018 07:48:32 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id w204-v6sm16003496oif.2.2018.08.04.07.48.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 07:48:31 -0700 (PDT)
Subject: Re: [PATCH 4.14 00/23] 4.14.61-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180804082643.641435547@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <715356bb-203a-1720-eaf9-28beb97a4d67@roeck-us.net>
Date:   Sat, 4 Aug 2018 07:48:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180804082643.641435547@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2018 02:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.61 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Aug  6 08:26:30 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 258 pass: 258 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
