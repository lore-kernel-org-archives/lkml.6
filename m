Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F7DC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD2620833
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vauUpKM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD2620833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeIZC5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:57:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40575 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeIZC5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:57:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id s5-v6so4254928pfj.7;
        Tue, 25 Sep 2018 13:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s5ZpOPYUYRXGk7WeH1Oa9+q3GNoawx03f9YmOMHRtCw=;
        b=vauUpKM16G/QIcTY/7ptTldBfDF58Xmn6BugpZJrxFEu0w9Qa2HE0xJw6vJ95beGFx
         TWz8Zk64RPZZa6pV43i0WRFyOGjdgUsbfcpDUKJdrNAJJrikYGcYZUU3oOCk1DV4J3wc
         iZXIPbF1XEWLsdmCGfK3sAW6ubudQH1+UHCIArGqEHUyIig2NYy0WKJ5hSieM0Hfr83X
         xFwkJZVHqpy2z3+UinEvg4lXTa0FiR7Lj6p6Zyd17C/BlWpvJdsxw3ny9R9O7Dlc7JbI
         MGO3i+eeNCALqhAecomtwC3pfKSxzxXyopkcBj5fKvBLstnzkUaSQhnZ5tC/4thsUHKU
         +oLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=s5ZpOPYUYRXGk7WeH1Oa9+q3GNoawx03f9YmOMHRtCw=;
        b=VPkqJn2jJDmzu5GBAi5z5yVuS380EILLmcgvIUpW322eLbLIuDfyRf7sh5ehwj+oFA
         sU/J6jLAtn3dKWIjOSXjH36dwHAw8hTJIXiGkrC2Ie8jEHFFY1ewo+zNv4O2/ISqLdEK
         pWa1N8YRfSBr11uAUjj151o1k4v5BM3lUh0D1uBTL9GGXy4nGq8fa9Ww7rmwRPEji3SL
         dq27uuSQ8oFkO+x1MNNijSp9OOFwTJ7Uh6eY04oUa2pwhHbq8qDGcH8g1Zbg88JNwBIV
         7VutYtn5WMRsGOqpJL5NGvBgtZAoWXPEmrqXuAoFuxG5kkLSbse+3vSkXkBO1P0K+wx/
         prgQ==
X-Gm-Message-State: ABuFfoi9QWtvtvBixvHIg1kfA+cA4y/jfGmLn5Ml3NfHs5qLiqohYu8Y
        HZoenVMH1GCXFynAxrKheQM=
X-Google-Smtp-Source: ACcGV623uJf/WKYgtXF1HyWovtifoz7sDVpS3ujAfkz6gLiiPUyZYJGaazz33jV0/4Str9bre1ithw==
X-Received: by 2002:a63:380d:: with SMTP id f13-v6mr2631212pga.124.1537908499859;
        Tue, 25 Sep 2018 13:48:19 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h69-v6sm7146730pfh.13.2018.09.25.13.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 13:48:19 -0700 (PDT)
Date:   Tue, 25 Sep 2018 13:48:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.18 000/235] 4.18.10-stable review
Message-ID: <20180925204818.GD13170@roeck-us.net>
References: <20180924113103.999624566@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 01:49:46PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.10 release.
> There are 235 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep 26 11:30:01 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 137 pass: 137 fail: 0
Qemu test results:
	total: 318 pass: 317 fail: 1
Failed tests: 
	powerpc:g3beige:ppc_book3s_defconfig:nosmp:ide:rootfs

The failed test is the result of a crash in devicetree unittest code. 
It affects all branches. Nothing to worry about; fix is being worked on.

Details are available at https://kerneltests.org/builders/.

Guenter
