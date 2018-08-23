Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CAAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E49421537
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="j3zuQkQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E49421537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbeHWOhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:37:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41062 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbeHWOhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:37:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id y17-v6so3819450ljy.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 04:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TiqdqkGM5XpZpHvGKXN3QNi+DQ7PdrpRq0kWc+NC2WI=;
        b=j3zuQkQ3TJ0lVX8KdKd//Vs5uXyvQmBu9B45bpb8CrJzmbD6KgO6h4WxevUbSzncNG
         cJvIYFCs4mclO840YDVdbbTVVR0XJxWQ97P3u85jYrWaayVmcpC23IjjtBVXpeJgAAY7
         dMyQ/h1y9bksNC74JSyQD984nbic577S4k0X5nWFG1+OX7ibt3ulzXeElZXLS+C/0Zxt
         4Srnjt8HiZUXOJYGvnvJZiAckGSz026NdIQl+f/Wz5ONBc8LzVkBwIuwt9lTgZdxWD1Q
         P3LhqdChHxanmznIXvuNH3QFJuJ5bkAb3H619H1+51slR1X+oIamT6yN9Ej896smkkjM
         2ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TiqdqkGM5XpZpHvGKXN3QNi+DQ7PdrpRq0kWc+NC2WI=;
        b=cx+hHjt3eXvgI7b71qJ8kZZlvhoroQ+FCupuCW6oQpc3K+opE6o8l7ViLo8+JPpakg
         6cjKAw9eidqBHUDw6HyrNb3zZjdNlj2yQ1Hukjb7KGj2MQJsxK+b46PrkjBkzdpfEH8d
         Y0JovEElBFNOfTfnYg3wfgizNCna7NdPfcmGIx8AJrUoAD2v/i2PJESzoBOPHySrKI7J
         51OOEbNtuU9R6ukfa1NbmEbsM/r6vXeGYhJDMc0OdJ2Yil0ey4FfIkS2ovEg0f4kUDD1
         4vUMn+LTPfT4TwfJvbvyF+kfPsoBBM9wyemovsZMGx12vpYcQi3WIO0UdG5Zm2GdZq9Z
         c1fw==
X-Gm-Message-State: AOUpUlEQ4eJTrG/Bs/UzgJv+zc+dRRZYgGcx+WCJpfF0u070MxPmE22v
        OaCqNRAMoGNC752Vj+R4cPkO1w==
X-Google-Smtp-Source: AA+uWPxPcmE0DgytKUlnb953uHlLNDiV/ZWCqTAd8jLuU7e4mwvv5JdTnvJLasQ6NyEOkOu5m2jrTg==
X-Received: by 2002:a2e:869a:: with SMTP id l26-v6mr23811878lji.48.1535022487431;
        Thu, 23 Aug 2018 04:08:07 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.81.66])
        by smtp.gmail.com with ESMTPSA id y65-v6sm781740lfa.97.2018.08.23.04.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 04:08:06 -0700 (PDT)
Subject: Re: [PATCH 4.9 124/130] PCI: OF: Fix I/O space page leak
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20180823074927.161454870@linuxfoundation.org>
 <20180823074934.995162393@linuxfoundation.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <bde26016-9381-0df1-ec4b-b6f6fc5b9f51@cogentembedded.com>
Date:   Thu, 23 Aug 2018 14:08:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180823074934.995162393@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23/2018 10:54 AM, Greg Kroah-Hartman wrote:

> 4.9-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> commit a5fb9fb023a1435f2b42bccd7f547560f3a21dc3 upstream.
> 
> When testing the R-Car PCIe driver on the Condor board, if the PCIe PHY
> driver was left disabled, the kernel crashed with this BUG:
> 
>   kernel BUG at lib/ioremap.c:72!
>   Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>   Modules linked in:
>   CPU: 0 PID: 39 Comm: kworker/0:1 Not tainted 4.17.0-dirty #1092
>   Hardware name: Renesas Condor board based on r8a77980 (DT)
>   Workqueue: events deferred_probe_work_func
>   pstate: 80000005 (Nzcv daif -PAN -UAO)
>   pc : ioremap_page_range+0x370/0x3c8
>   lr : ioremap_page_range+0x40/0x3c8
>   sp : ffff000008da39e0
>   x29: ffff000008da39e0 x28: 00e8000000000f07
>   x27: ffff7dfffee00000 x26: 0140000000000000
>   x25: ffff7dfffef00000 x24: 00000000000fe100
>   x23: ffff80007b906000 x22: ffff000008ab8000
>   x21: ffff000008bb1d58 x20: ffff7dfffef00000
>   x19: ffff800009c30fb8 x18: 0000000000000001
>   x17: 00000000000152d0 x16: 00000000014012d0
>   x15: 0000000000000000 x14: 0720072007200720
>   x13: 0720072007200720 x12: 0720072007200720
>   x11: 0720072007300730 x10: 00000000000000ae
>   x9 : 0000000000000000 x8 : ffff7dffff000000
>   x7 : 0000000000000000 x6 : 0000000000000100
>   x5 : 0000000000000000 x4 : 000000007b906000
>   x3 : ffff80007c61a880 x2 : ffff7dfffeefffff
>   x1 : 0000000040000000 x0 : 00e80000fe100f07
>   Process kworker/0:1 (pid: 39, stack limit = 0x        (ptrval))
>   Call trace:
>    ioremap_page_range+0x370/0x3c8
>    pci_remap_iospace+0x7c/0xac
>    pci_parse_request_of_pci_ranges+0x13c/0x190
>    rcar_pcie_probe+0x4c/0xb04
>    platform_drv_probe+0x50/0xbc
>    driver_probe_device+0x21c/0x308
>    __device_attach_driver+0x98/0xc8
>    bus_for_each_drv+0x54/0x94
>    __device_attach+0xc4/0x12c
>    device_initial_probe+0x10/0x18
>    bus_probe_device+0x90/0x98
>    deferred_probe_work_func+0xb0/0x150
>    process_one_work+0x12c/0x29c
>    worker_thread+0x200/0x3fc
>    kthread+0x108/0x134
>    ret_from_fork+0x10/0x18
>   Code: f9004ba2 54000080 aa0003fb 17ffff48 (d4210000)
> 
> It turned out that pci_remap_iospace() wasn't undone when the driver's
> probe failed, and since devm_phy_optional_get() returned -EPROBE_DEFER,
> the probe was retried, finally causing the BUG due to trying to remap
> already remapped pages.
> 
> Introduce the devm_pci_remap_iospace() managed API and replace the
> pci_remap_iospace() call with it to fix the bug.
> 
> Fixes: dbf9826d5797 ("PCI: generic: Convert to DT resource parsing API")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> [lorenzo.pieralisi@arm.com: split commit/updated the commit log]
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> [Backport just for the new api which other patches need - gregkh]
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  drivers/pci/pci.c   |   38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h |    2 ++
>  2 files changed, 40 insertions(+)

   Again, you missed a change to drivers/pci/host/pci-host-common.c (and 
also drivers/pci/host/pcie-rcar.c which wasn't using the generic code back
then)...

[...]

MBR, Sergei
