Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1F670C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F1C20020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+7Sta9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F1C20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935685AbeFMNsK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:48:10 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43359 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935279AbeFMNsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:48:09 -0400
Received: by mail-pg0-f66.google.com with SMTP id a14-v6so1307198pgw.10;
        Wed, 13 Jun 2018 06:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MqCgEEZ+kVG156NL6oUYOcpyBuyYLQetRujEKs7zvro=;
        b=U+7Sta9ezidgLPV4beyPVOtJc8tT10gAP5xLV0mKVeWkmDMa5mDAVJV+WkFlh8GJ3b
         /uxDBevgIYdvCE2PZtDrSF4dZOfGNjv6E9aGy70zKiAPM4pqsVyH0tMmMsLR8+IUP1C7
         e41cs0ty5SvVTelWLBKGDfohl9wd5+AvYHwNwrnmTdq0qoAe8c6E10jhs4b4CwzyS3jX
         j9ZiaujWJeim/M+qOG30VlpTGlDBOTSt/Mr9EKEvRneCTkEBkxvoPk7kk8hikoqEbXGM
         VRg+NO4C4DLlYmOsU0joSxrqaH+Ru6bJ9RYm+b6k5vldBkKvjvEJdEy6ao5IcX8zghWw
         fyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MqCgEEZ+kVG156NL6oUYOcpyBuyYLQetRujEKs7zvro=;
        b=hIzWoWOzrZF6uoAZASkDCN+GSmK9RvlO+MRBL4sTt6BWXsTqS78q5Rx2nlhUH5Q82n
         w9ZmzEw67KCzLBfshWfjE3XPpTPDWXZjM7rEYrLvXKYy0WZQ9KmeMqPLOuYSFvHdGF0k
         YY85nYPxe0mTEZaXrQu4qm+PEvR+M8XXlagKqzoAqNNxsZQ050Ex2zHlIEZcFGov+udR
         DX7KzUsAizplGHZEc4Y6gHB1eXliildyKOzBS14kmDK2W57Mv2oO7SadbOtVM6Tql7DJ
         pWfr3UZUfs7qaoi8WNzt41tfKumz3ERKxOG6OzU0gEqpEXbEUi6CpZjhql+FGFZIgqO3
         jTCg==
X-Gm-Message-State: APt69E10TzvmnFiDPZ495Icx2A1uMPTLKrgoXgj1KVkpQsXRRRrCSHkF
        AZ4YsZVkwM1OBSC3cQlImB3EtQ==
X-Google-Smtp-Source: ADUXVKJODtto1z9JCmYinsYIPOGlHS84mJ3pqG0rWLGaFCrv2avjInhYC8Zse8OUX18POwDAfxb8Cg==
X-Received: by 2002:a63:b44f:: with SMTP id n15-v6mr4001047pgu.389.1528897688291;
        Wed, 13 Jun 2018 06:48:08 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h27-v6sm7873371pfk.160.2018.06.13.06.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 06:48:07 -0700 (PDT)
Subject: Re: [PATCH 3.18 00/21] 3.18.113-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180612164825.401145490@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <bc0f332d-bb9f-35c6-18b0-8dfd282bbf1c@roeck-us.net>
Date:   Wed, 13 Jun 2018 06:48:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612164825.401145490@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 09:51 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.113 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jun 14 16:48:15 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 138 pass: 136 fail: 2
Failed builds:
	i386:tools/perf
	x86_64:tools/perf
Qemu test results:
	total: 127 pass: 127 fail: 0

The perf test only fails because I run "make tools/perf" instead of
"(cd tools/perf; make)". Fixing this requires the following two patches.

379a9a28a1b4 tools build: No need to make libapi for perf explicitly
16671c1e1cac tools build: Fix Makefile(s) to properly invoke tools build

Details are available at http://kerneltests.org/builders/.

Guenter
