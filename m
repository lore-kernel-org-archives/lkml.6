Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34707C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05752186C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQWi0Cw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05752186C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbeHDQuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 12:50:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36477 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbeHDQuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 12:50:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so4735898pfo.3;
        Sat, 04 Aug 2018 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4ymj4Q6wWgOAvQbTy75axQ/yRvuTb9Er87LeIb8CpZ0=;
        b=nQWi0Cw4wpbTHyAnKxPJHinqlt6iHxpA0eyfccKrR+FPOeBjlcH3LAPgbXEscY3OiO
         ZzahLtozFCMDsZFFkyF4s1hax2GggkCFaHUj1qarMY3v2t1/6V65PgcEnFO3A7wiHa6N
         Hh7NLBTsRqjhKDXleDB7CTuFh51IttfvTgZSHjPvIhARrbQhlNlVi3JjO7/zd/QtJn3Z
         qOlpD10IMlGYWhrPMy0qMLrXJDP/QjpEpOj65pFhantE7M92gSXMYRIgIJDfM9oITGhs
         cSHp4yBALWhMKwl80Yxqz6MmfE6PmzO/mjbv5NDsCpRVyONFOBdHp0xGblpeP1U8GyWm
         jmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ymj4Q6wWgOAvQbTy75axQ/yRvuTb9Er87LeIb8CpZ0=;
        b=POkdmyBa6lqnSxKL+b1NbySDNeO8s/PVbZfSHA5sYZSo718uhfCW8IVll04vg34PXJ
         6ypRYc/wORWWd6ttIPkCuU0a0H+pgLvTBQt8Nodxd9NccxIEXTzCcEs+hGhW8hZyy4I1
         fiV2+BtCPBlAZsJYzyLmfdZH5mP4kkNNVlkSwr0abOOY1iRpIRfumwjew8zWrCQmcjez
         7bzJfXEsQYS4BrHgNDx4mdEkZzMRmHMgyOK2XcaP9kahuSrKw/Hd++8WI86wEFpykLwh
         nLafkSrWFt1CscC7KSgFfXGFTCXI0yHyI5kK9LLPxG1SPdXTEa+AGSoI6+bYrRaUam60
         KELw==
X-Gm-Message-State: AOUpUlFWDiYusit1gUIvIDO4uldR3kEV0U4GNQV7EGxMaGkPJhGoOnYx
        xLgJtWGn33XKEuhQzv/akJLCdUCw
X-Google-Smtp-Source: AAOMgpcJC5Zhk8rhGbyuuXz6j00A7y4Wj/pFTNs4grHSoS8Cs5HhwW4jwtDonGkRFeQgP6YpgAQEGw==
X-Received: by 2002:a62:51:: with SMTP id 78-v6mr9364233pfa.135.1533394167103;
        Sat, 04 Aug 2018 07:49:27 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 22-v6sm14017101pfl.126.2018.08.04.07.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 07:49:26 -0700 (PDT)
Subject: Re: [PATCH 4.17 00/31] 4.17.13-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180804082632.304529527@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <15d3b835-fb8b-5348-45c2-c5f16e0c42e1@roeck-us.net>
Date:   Sat, 4 Aug 2018 07:49:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180804082632.304529527@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2018 02:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.17.13 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Aug  6 08:26:21 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 134 pass: 134 fail: 0
Qemu test results:
	total: 261 pass: 261 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
