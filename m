Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81733C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0E12170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tbnUTo2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0E12170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeI1ESs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:18:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39602 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeI1ESs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:18:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so2824803pff.6;
        Thu, 27 Sep 2018 14:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=woCOGF1WAteMc6XeSYh/WKxOlaMmubUoV3H9Lr/yZlU=;
        b=tbnUTo2+hAkYIR/GLXLeOfwfoPVsfEXoy+kdlsZGO/ZSc8UoHH0bP1VjqMNsDzNgGs
         InTLuVzGLfuyH/1dNXDGBeQUKNgFh3jTzLpVHMtfK6XpdARDh3+PcE2JoNd3bI3ta1wv
         YjiqXoFkrDmaHNflHzWoiZ98ItbcxefDm8s45ZZ19RdgNznDEDr4qDdB71VDzmqjsTly
         HfpBAgN3rrqFCdQin1u2cmQKa+wGiXACD6E7tlN6t3psE+H8asZO1wUjGx+75Gi0qJ5m
         gKe/8kiIbMLVtNQP3GQHP9izFOponxEatAZ8RQe35MBVGbW2wra4m91503m0NaYwFdKY
         YslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=woCOGF1WAteMc6XeSYh/WKxOlaMmubUoV3H9Lr/yZlU=;
        b=dUa2WgmEV14tO3rOZ/HbGVLEHCYMOQVsrqCQ1qd8C2Yf/sjXyRUWlfYHs1UXnxgFm6
         ZVUMCLYHyo+4MKwW4j0TnH3NvlmL+J33IsYedUUWmDM5MHa5NjjIqA5S0NKGPpb9m9Jh
         NkSxxyONDdPFSCjeP8YIMIZOe2sqrelwfaLEAYBDs8SVF2/vtEunNZgnc5+vWBNQQKRY
         E5zIJVYDMyDKipARft/ZRlXn8B7OI0TBXoxRkfhoKvjyaupjvDlM2pJK5IuZ4uJbRBYy
         hAhHMPwFUcT41KwdUWSIq8fUKzDGpDv7H5SmdyxfIXbpRKNzF979MYn28VStwxLuFQdB
         +eug==
X-Gm-Message-State: ABuFfoiCwJabjGyHtG5o5uC3PdIpkGAKPf4ZtY70me0VpDUxgOqjo0oE
        Ztp1icyjGZnu/M2KEckV44s=
X-Google-Smtp-Source: ACcGV62HJTeHtVpjSa5a7Oy+L+GxW7v55brhtHGposmGyc0rVC1dXiriK5hc7uCZcBlr/sZbVY/MIg==
X-Received: by 2002:a62:5950:: with SMTP id n77-v6mr9041400pfb.0.1538085504487;
        Thu, 27 Sep 2018 14:58:24 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u79-v6sm6399057pfd.117.2018.09.27.14.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 14:58:23 -0700 (PDT)
Date:   Thu, 27 Sep 2018 14:58:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/44] 4.9.130-stable review
Message-ID: <20180927215823.GC9198@roeck-us.net>
References: <20180927090117.997362691@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927090117.997362691@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:03:49AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.130 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Sep 29 09:00:54 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 308 pass: 306 fail: 2
Failed tests: 
	powerpc:g3beige:ppc_book3s_defconfig:nosmp:ide:rootfs
	i386:pc:EPYC:defconfig:smp:efi32:scsi[MEGASAS]:rootfs

powerpc:g3beige is the known problem. Patch should be available upstream
in the near future.

The i386 failure is spurious.

Details are available at https://kerneltests.org/builders/.

Guenter
