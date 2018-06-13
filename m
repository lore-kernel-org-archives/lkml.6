Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 88840C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C92F20020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHuAF3dy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C92F20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935752AbeFMNtv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:49:51 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42742 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935515AbeFMNtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:49:47 -0400
Received: by mail-pf0-f193.google.com with SMTP id w7-v6so1453773pfn.9;
        Wed, 13 Jun 2018 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s6BHol3jiFjhAgLezsUz+PzeUHzeL/fhpE6r2Hoey5g=;
        b=AHuAF3dyEsFTTLzMO7LAtXGdlobndpV3KvMN5ttCH07UejulipTHluR6jqQu26T4MN
         naHQG0vic3iwV5rVotmqYSOyhQTZ4kPGiUsz2GvQhBqHzW+O8iPxFsgW4X4eK1eelkHc
         nQn0TwrvAANjsBcwByl8s6NsoMnnZ94T6YEHkjj6+beJw3BAaJW3R8SiSeFjgfWj5OfL
         np7Mgp+PV/Ik0xkaqrtaLJb7agRh6eA8kn3yDUnTgkyjl3wExqKGUyZqoVxrz3NkRT9y
         umKddIb3bAn85LQd28J2CRbXdL1Z/qz98Go1gj53ZDUdx+RHYpCqQ/krWay87ZtmDn9s
         593w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s6BHol3jiFjhAgLezsUz+PzeUHzeL/fhpE6r2Hoey5g=;
        b=SJvynOW0p2Yf2vn6Tre4A4VGW1M5jy1NlQwVr758ze/IYf1sX8m6wWJjrN5s0j0TC7
         chIye8BRaZ8hgEixC3B91q6/QgB4MQfkUV9kgBOG0wPi8zF7e1mEz2jIKJ2u2o8yklJD
         vqU8zlI/OENGshahQXUbOX2sBfs6iOwwoRa+EkcRtkwc+N3rKhPgYZBWHhJepqTztA60
         reuMqnPLXZ52zPOSRobF+i1XS2b3I8vY2VmRn6GKTGPGFug+BfmeiGX7TClokJCxXvoy
         XXIjQYEz2kIXcG0DLNjii3hsIU6kUbponZ/Zg73Q/RkK4JNWEdipaDDux7GE8KmemTQi
         DrGQ==
X-Gm-Message-State: APt69E3fWIu6TvaPZQzYG+U7A+zkgYNeFXBD/Io3yxqbeotlHnll513e
        YEkgzJVZu3LQa55LZ27thpw4xg==
X-Google-Smtp-Source: ADUXVKKfLK59aQvIoSNHia393b9IxRiSiUvvQ8Tja2uBYGmUvPmMZOlNDhiQtk3a6V3zHJWgGEnKJA==
X-Received: by 2002:a62:8995:: with SMTP id n21-v6mr5003383pfk.83.1528897787152;
        Wed, 13 Jun 2018 06:49:47 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id p3-v6sm3457222pga.72.2018.06.13.06.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 06:49:46 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/31] 4.9.108-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180612164620.797338191@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9873d4d3-c08a-4467-0584-4b1d30c9c7ab@roeck-us.net>
Date:   Wed, 13 Jun 2018 06:49:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612164620.797338191@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 09:46 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.108 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jun 14 16:46:09 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 147 pass: 147 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
