Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E223C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F41B2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZFDFEQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfAGSDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:03:25 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:45000 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfAGSDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:03:24 -0500
Received: by mail-pl1-f182.google.com with SMTP id e11so490196plt.11;
        Mon, 07 Jan 2019 10:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4l3/EEEPrjDxklMgQd7+F5n1Ykrv7354eEA2Q45rKZY=;
        b=iZFDFEQTXet3rI6R9G2HM8AUTWbFC3XFTd2cFDOrm1/HNoOisP0yBuELNNnh7yPMev
         HfoxtdWJJu7e2ODuIzUJRIXAee2Lk6GvAZ6dUyLryl4Yg4suttPmoOXd8guIYCcj5YoL
         jB3C3dx3QSsD7q9DY8jPnhOvwpaMDPLhbE/weXswIhVIjIo/OXP184ZqcsUfjO7BDZoP
         CchP+cQ+E15041Me5Ho5Fuqhr7Bl9o+3dG7B9v6lHmfSm+2l47DUbjwQ1zUC2EljEuoB
         /7xAEt5wC0Z6Ax8nsGJuIazfSZrlrUKETrluBhgR38eiwqe+/ZBCvoz2JizJ+zfLgC8o
         N2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4l3/EEEPrjDxklMgQd7+F5n1Ykrv7354eEA2Q45rKZY=;
        b=gjCr2nSGP6V8Ceqeo/Fwq56Mcvuxa/Bn/AKkn7A4wgyCzX9kGM37rBEXeIy8OcajCL
         Mip7xfiCmdese3ZE3CRmHib3ed1PNgnNz9Lp+pT2foAKHpGTO4/G9lhw+Zdb5srHQkK7
         pAXuzTryqcLC9Lxhw7L3ky5DgB/sQ3HYSehRpQjUGAIxZvtmyA+0Y9OVEOTeF+MQKcWI
         hO2PTg1VpP+PqFiyXZAklI2xFhaPT19RwAYIpJAjuJ7W2lAYav1/WWB7ijLAsH29MbKk
         R4lg8bK6lQoEW/JhvWcITYtMYxq5AG1JrGzioPaf94DtQcVGHN62QwSHg8qGiOjEMQtd
         rnRA==
X-Gm-Message-State: AJcUukfIRPHxl2Xv7J8LAxqkQEumM/6c94/cGkJEJhVNRFPxOmJjIWqd
        Lu89+D9NBTy1JzlhS9nZrps=
X-Google-Smtp-Source: ALg8bN4d8exK/ejJW9EBduWEwjEAERTSpf9+GmVNzff6ChIAluyCoApBMJKaGG/Nt9axK7Cl1PXE5A==
X-Received: by 2002:a17:902:6946:: with SMTP id k6mr63400653plt.101.1546884203720;
        Mon, 07 Jan 2019 10:03:23 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l70sm75545933pgd.20.2019.01.07.10.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 10:03:22 -0800 (PST)
Date:   Mon, 7 Jan 2019 10:03:21 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/170] 4.19.14-stable review
Message-ID: <20190107180321.GA11134@roeck-us.net>
References: <20190107104452.953560660@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 01:30:27PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.14 release.
> There are 170 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan  9 10:43:54 UTC 2019.
> Anything received after that time might be too late.
> 

[ partial results; qemu tests incomplete ]

Build results:
	total: 155 pass: 148 fail: 7
Failed builds: 
	arm:allmodconfig 
	mips:allmodconfig 
	parisc:allmodconfig 
	powerpc:ppc64e_defconfig 
	powerpc:cell_defconfig 
	powerpc:maple_defconfig 
	xtensa:allmodconfig 
Qemu test results:
	total: 332 pass: 331 fail: 1
Failed tests: 
	mipsel64:fuloong2e_defconfig:fulong2e:rootfs

Depending on the architecture, different variants of the same error.

ERROR: "__bad_cmpxchg" [drivers/spi/spi-bcm2835.ko] undefined!
ERROR: "__cmpxchg_small" [drivers/spi/spi-bcm2835.ko] undefined!
ERROR: "__cmpxchg_called_with_bad_pointer" [drivers/spi/spi-bcm2835.ko] undefined!

v4.4 and v4.20 are also affected by this problem. The impact differs
from release to release; for example, sparc64 is affected in v4.4.y,
but not in v4.19.y / v4.20.y. I suspect that the problem is also seen
in v4.9.y and v4.14.y, but the compilation doesn't get there
due to the other problems in those releases.

Also, for powerpc builds:

arch/powerpc/kernel/signal_64.c: In function ‘sys_rt_sigreturn’:
arch/powerpc/kernel/signal_64.c:761:21: error: ‘msr’ undeclared

and for mips64:

Building mipsel64:fuloong2e_defconfig:fulong2e:rootfs ... failed
------------
Error log:
In file included from ./arch/mips/include/asm/mmzone.h:10:0,
                 from ./arch/mips/include/asm/r4kcache.h:23,
		 from arch/mips/mm/c-r4k.c:33:
./arch/mips/include/asm/mach-loongson64/mmzone.h:48:0: error: "NODE_DATA" redefined [-Werror]

Guenter
