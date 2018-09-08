Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33BAC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D09206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLNZlesF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D09206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeIICCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 22:02:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38306 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbeIICCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 22:02:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so8618674pfh.5;
        Sat, 08 Sep 2018 14:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QpOz7V/LxNUNnSqePtZIQzd+JQOZPYL2N8lwfDEfedA=;
        b=sLNZlesF9Hixn3bk56Bsx8hZW82aqN+sBkoUpZbSvirF/fts1GbLWICiOn6sXP5akV
         tkoefPkkAcHNGc6dq8fxNr4KrNJch4JMzyvBqz9LXGw+p5Ix3pF2srMNRwWcR4XJz34f
         A869KS91gTLYlsbRxONLQo7kzY+Wy5X+HdRRNe1ugeC5v2E8LZtC3lLfR/89LeFtjqFK
         E3TsFbyFMZ35AEfA1bBo3Mvva8sZ5q39rfn/VelVQQTxOqX9SUFB7oSIQi9Y6aJnx/ES
         4fmv0kCLguOFNEmCH50V4Uuv1f8EKA1QTiCGbhe2gFkRUHT5hBi5Vks5A5feiwOk+nUX
         La1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QpOz7V/LxNUNnSqePtZIQzd+JQOZPYL2N8lwfDEfedA=;
        b=uU/VmQ4Bi6orBE4LO9MvxOncroYf+VmMCcJUP4+UjMCnl/25O0/E4yFxQoF+DI52aS
         anO/aXAOdmfE2bhA9nj7zHggxPg0prE/dTAX4rsjN6V7hza6yLSUiEtfhKoIgeCJMz+Y
         AftNWI0UB1Q+TI12A6lQ9MZtkpEx1SkH81LNLFepg2LDQ6uoYABXUnqorOkNUkRcv11y
         SazsdzJXYKwQVwCs3RiMrTfTLEQOoWeBGrbpJSOshEfPy2dK7JTfZprOzd4HfWke5rtc
         PKPOPJgmIHyvKJETp6SC95N2GUjPkZPf6ZxsWQgLsHVZSifuoVKnAcfS61uzqzfDJ0+W
         86sQ==
X-Gm-Message-State: APzg51AE0usO6U4bXI7CuVF1QYdkL21KLWmaAQFb9ga6bBIvi3xg9uXv
        QyOcC9kqC7YyjRSTfABqA9I6oHYH
X-Google-Smtp-Source: ANB0VdYFnCHd6CqVssXPp2p8MLSh6RJ6HuGcxLoGUhRXMbL692zWQ1frzZ0yGX/mr0ZOA4sG4hkG9A==
X-Received: by 2002:a63:e056:: with SMTP id n22-v6mr14728572pgj.205.1536441295329;
        Sat, 08 Sep 2018 14:14:55 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t86-v6sm16112765pfe.109.2018.09.08.14.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 14:14:54 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/63] 4.9.126-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180907211012.965501324@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e1fa8fda-e277-3c83-5e35-826df83f3cd5@roeck-us.net>
Date:   Sat, 8 Sep 2018 14:14:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907211012.965501324@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 02:09 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.126 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Sep  9 21:09:58 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 151 pass: 149 fail: 2
Failed builds:
	powerpc:defconfig
	powerpc:allmodconfig
Qemu test results:
	total: 301 pass: 285 fail: 16
Failed tests:
	powerpc:mac99:ppc64_book3s_defconfig:nosmp:initrd
	powerpc:mac99:ppc64_book3s_defconfig:smp:cpu4:initrd
	powerpc:mac99:ppc64_book3s_defconfig:smp:cpu4:ide:rootfs
	powerpc:mac99:ppc64_book3s_defconfig:smp:cpu4:mmc:rootfs
	powerpc:mac99:ppc64_book3s_defconfig:smp:cpu4:scsi[DC395]:rootfs
	powerpc:pseries:pseries_defconfig:initrd
	powerpc:pseries:pseries_defconfig:scsi:rootfs
	powerpc:pseries:pseries_defconfig:mmc:rootfs
	powerpc:pseries:pseries_defconfig:nvme:rootfs
	powerpc:pseries:pseries_defconfig:little:initrd
	powerpc:pseries:pseries_defconfig:little:scsi:rootfs
	powerpc:pseries:pseries_defconfig:little:scsi[MEGASAS]:rootfs
	powerpc:pseries:pseries_defconfig:little:scsi[FUSION]:rootfs
	powerpc:pseries:pseries_defconfig:little:mmc:rootfs
	powerpc:pseries:pseries_defconfig:little:nvme:rootfs
	powerpc:powernv:powernv_defconfig:initrd

Details are available at https://kerneltests.org/builders/.

Guenter
