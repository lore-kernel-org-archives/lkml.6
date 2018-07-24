Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525E6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A9420874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAL4W3iT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A9420874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388568AbeGXRE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:04:57 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:33424 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388468AbeGXRE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:04:57 -0400
Received: by mail-pl0-f51.google.com with SMTP id 6-v6so1971048plb.0;
        Tue, 24 Jul 2018 08:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b50mVGdCFPUt3ivwI2aBzUYzrpWr0KHRicLJZROjCcM=;
        b=WAL4W3iTC/1O9WVkpi10Dk8x/K6LbQo0CL4t4Ygj8zjUtURf0AdrFXfDBZg+vuQ21i
         MSVMkT2C/zfAHup/3hKoBxWKMiH5NNUuBb4oj9ThS+nZPCBFgBUYgRpFp29dMEL6b801
         mLMAKoWO6cb+HGbCzmtU9IKWhhiiPofnDQxndEHxM8qwI0AxiQgk3m7FG2JcWzYmE6bf
         +Zgz89Yi5ik7DOgU2HhecHXrUJUDZdcPWtnFhjvE2ITtG+8JJ0u4uKG7uAIhP7I+L5sX
         3+cb4LqsPK559frpBkzWVGTC0qRVYCR4wo6V1qATxJR7MEcUnCVSBGVSSXTQJTZ3L+f3
         +fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=b50mVGdCFPUt3ivwI2aBzUYzrpWr0KHRicLJZROjCcM=;
        b=NEsZqvXzu28iVwpW2Spj4l9v8BU0iU4BBKnH3+U5FDBfB94/R5OrCj+kqGDmdtn8LZ
         rXqRnjBr6IZPG/xH19VIzcPI6WGuTSDHjKayB9D2IQxBThE1W8URZoFhW4yOfv0vOPnv
         v4zFTKJe2vdhRnHC1B+PJJPQxfsiCAfg4b8/hawlxMX4jePQZaIPK8SQEFeE99w7eea5
         BiHiaCPqzRj1GQ6A8qUmE5gRS0R3dK8ERrfyKPfI0sIh479MRmjaNQSdiNKR3Swpu8RO
         xusb7UWzxd9iOUXEn06i6p+WHIUvqI0Yfjm5Dbz4juthmCsBiqMCbT8iENNfJQvwDiqY
         PoAw==
X-Gm-Message-State: AOUpUlE9JnSbsA5qrTa3AzwHWTEDGs5o/9oKYHhxzqycHHqJcSL2aQTb
        hlQvNYD3vbdAvpbwyY9jBlDsZ4zN
X-Google-Smtp-Source: AAOMgpfZGgxlASeImP6AR4C+wWBx066cUJi/kU+IUJTwnJjmsTRiyj9D9AY02sr6j2xWWcpqHT9zIA==
X-Received: by 2002:a17:902:7894:: with SMTP id q20-v6mr17868208pll.3.1532447869474;
        Tue, 24 Jul 2018 08:57:49 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x65-v6sm6848577pfk.140.2018.07.24.08.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 08:57:48 -0700 (PDT)
Date:   Tue, 24 Jul 2018 08:57:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/28] 4.9.115-stable review
Message-ID: <20180724155748.GD917@roeck-us.net>
References: <20180723122425.241418073@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723122425.241418073@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 02:25:00PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.115 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jul 25 12:24:13 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 166 pass: 166 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
