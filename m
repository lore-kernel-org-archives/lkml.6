Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBB5C4161C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913612151B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ntq35KZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 913612151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbeIRVxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:53:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44046 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbeIRVxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:53:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so1245581pff.11;
        Tue, 18 Sep 2018 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dJ8aAo+zU8Fs1IWYyw9eWDJcpqR/ljWIAnYE7UwytAU=;
        b=Ntq35KZScfFLcJdaNxbWFYhRLYJwccLuKgbwM3ANyOulSJBGNBkzJtSoax9xF0gKx6
         lPBu/Uo2Q2W0JMVpvEKmACv15OJf8Qbjukm5ZYIF3TQuJnNYbvQEaiqNCogA2kvQj+sp
         2caniu2BVOrRhSLaqpCZQXjsxNMwMttb1SqZo5XLfs7yzY5mruwlOD+8HGKaFIPqwZ6y
         6RJ/cFb3St3V1i3GNBzvsSyWcRLMPrwNenIa2Vm4gScEv8Jia1FKsVKt2Hk85DFvKTMt
         NmwN9rprKYOva8YSGIgsUabKLMHh4jUYkp7T6VHZB8lFOAtuuF0XvqwbvzTTBNS5Y9SH
         qOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dJ8aAo+zU8Fs1IWYyw9eWDJcpqR/ljWIAnYE7UwytAU=;
        b=VxA3Ft7cUgm+bJGHN5ve8sX/bPnL467nSFj15B+6LhtHozxtJl6eKXkYLELhlZMIK2
         VLPJX10AF+Z7IsXsRx3iiD5gKtAbfyH0w+c6j2hb11gFtHwQGhDVFNnq0fcZebSH60kp
         DjumxuCj6I4wdPAK2vbyhDoVbaTCScNfLXK5hjBhBDkgkdQERTsMSSUqs9DUEXnjtzSN
         VRCM2k+1oL2QIu5eetic40UWSPo3hXCfzK7VUM8Ce69a2tKcytbHfEInIluH6N7Gm2N0
         x/Zgz1xqAcwCfcS64lD1QeY8k+AwkdtkSDMPXWMa6V3shCD9PEfX+Ohf6Dk+t2ttPLd+
         FvuA==
X-Gm-Message-State: APzg51AiEW7HJH1CXL1dsCXv8M3n41vDU+ipwbRvI2t1ZlE395UTNsmi
        xRVPC/qxTL+Uzj2Wdssu5M0=
X-Google-Smtp-Source: ANB0VdbH+Hu6TviX3AGoZJYfxUrw/QF9TCb6ibqqII24hkttbuIxQWrN9e+5yS5oplJVSPvBbN3rgA==
X-Received: by 2002:a62:a6cc:: with SMTP id r73-v6mr31652274pfl.60.1537287599402;
        Tue, 18 Sep 2018 09:19:59 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id y128-v6sm25958681pfb.56.2018.09.18.09.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 09:19:58 -0700 (PDT)
Date:   Tue, 18 Sep 2018 09:19:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/56] 4.4.157-stable review
Message-ID: <20180918161957.GA28152@roeck-us.net>
References: <20180917213827.913122591@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917213827.913122591@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 12:41:33AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.157 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep 19 21:38:11 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 285 pass: 285 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
