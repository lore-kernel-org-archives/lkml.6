Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2260ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D47E206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D47E206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbeKIC6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:58:43 -0500
Received: from mout.gmx.net ([212.227.17.20]:36733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbeKIC6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:58:43 -0500
Received: from [66.187.233.206] ([66.187.233.206]) by web-mail.gmx.net
 (3c-app-mailcom-bs15.server.lan [172.19.170.183]) (via HTTP); Thu, 8 Nov
 2018 18:22:12 +0100
MIME-Version: 1.0
Message-ID: <trinity-73b7af5e-ab88-495b-932a-2ffd6dd81623-1541697732607@3c-app-mailcom-bs15>
From:   "Qian Cai" <cai@gmx.us>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, "Ard Biesheuvel" <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org
Subject: Re: BUG: sleeping function called from invalid context at
 mm/slab.h:421
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 8 Nov 2018 18:22:12 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <trinity-7128b38b-7a1d-4584-aa34-174a2906ec88-1541694235634@3c-app-mailcom-bs15>
References: <trinity-7128b38b-7a1d-4584-aa34-174a2906ec88-1541694235634@3c-app-mailcom-bs15>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:JSDxI+IpPwfSHnC3yq7Bt2wANp76gaE1yGsTsg1Lq/XpBNLTPQ6hLwkZPOZmZCY8zcK9x
 J4ReQaMe7ZBjOHkSb9heJzMySvEvVDyHZY9MA21z3uhIFQ/KlPpnvhBSIGbzPP010mCUGAim3xAJ
 Jnc2qciLVQ9vmyNJu/BQIr9d0VuvCpvL/xNLSDVzWyYQAmj3RBc3hH6A+mk/rRc5vX4Otp2muXcg
 8rAbnexOYispRRb9xjAsBFzZbxqo7LkCVHxZLG1vuFT5gGYnAWJtU70XBxtFPG7Av6pb6E7b2oU1
 FM=
X-UI-Out-Filterresults: notjunk:1;V01:K0:7CxU67IgCMw=:htSe5oB9k6dw0p2YXUdKIq
 Ik6AC/eMr4nZPhfpvxHFPQlci5xRtONVKM6BkcHWTqGAvDnyp7hIPkD6Cmcpss5b/P5hSNzg3
 KX1rsmMaJhYww4P0eJjDiYf91EJsWIDJXID6Q0jgMFMGLLmjo/gA1tXV2oP8ukjXtIIQQbiLZ
 NDnSI5zbpuAmg82v8fYiW6xHcAZ1NTDJAZtaTSZHa46ozXbHpk/7nuNtVdMWpxxSI+KdatxsM
 H0lD+xuQ47oum59pTo/M4Z3Bqi/lZZq7C8/JILcie7wVQsARj0KaI6D4pXoXrrOO96K7qcKcn
 kmTqPmRzc1QgCud2cToANVDqpsCzEMhgH1xRZb96BjV/HA6va+7wJvj79wO11jY5d+d7mTV6V
 fhxQ1BrftnjK1EL/QX2+VWmBvQnH+utIJeYzwYriMxxgXETAD7HoMbcdfjKZo/es0GEr+y2G6
 hr6wqAVpCMChEvLw1U3rRZ50saFtuSnJxgUEytX/oilr0xPysSp8DEMgeN9Hrj7xF8lrGKrRl
 UJlaIaQRDb6KOaoym+lbO0ujijlqT4ndE1LC465FzIxGrMmISoFHJcFaGdSl7whWA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like more of an EFI issue where it called efi_mem_reserve_persistent().

> Sent: Thursday, November 08, 2018 at 11:23 AM
> From: "Qian Cai" <cai@gmx.us>
> To: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Subject: BUG: sleeping function called from invalid context at mm/slab.h:421
>
> Just booting up the latest git master (b00d209) on an aarch64 server and saw this.
> 
> Nov  8 11:06:36 huawei-t2280-03 kernel: BUG: sleeping function called from invalid context at mm/slab.h:421
> Nov  8 11:06:36 huawei-t2280-03 kernel: in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/1
> Nov  8 11:06:36 huawei-t2280-03 kernel: no locks held by swapper/1/0.
> Nov  8 11:06:36 huawei-t2280-03 kernel: irq event stamp: 0
> Nov  8 11:06:36 huawei-t2280-03 kernel: hardirqs last  enabled at (0): [<0000000000000000>]           (null)
> Nov  8 11:06:36 huawei-t2280-03 kernel: hardirqs last disabled at (0): [<ffff2000080e24ec>] copy_process.isra.32.part.33+0x460/0x1534
> Nov  8 11:06:36 huawei-t2280-03 kernel: softirqs last  enabled at (0): [<ffff2000080e24ec>] copy_process.isra.32.part.33+0x460/0x1534
> Nov  8 11:06:36 huawei-t2280-03 kernel: softirqs last disabled at (0): [<0000000000000000>]           (null)
> Nov  8 11:06:36 huawei-t2280-03 kernel: CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.20.0-rc1+ #3
> Nov  8 11:06:36 huawei-t2280-03 kernel: Call trace:
> Nov  8 11:06:36 huawei-t2280-03 kernel: dump_backtrace+0x0/0x190
> Nov  8 11:06:36 huawei-t2280-03 kernel: show_stack+0x24/0x2c
> Nov  8 11:06:36 huawei-t2280-03 kernel: dump_stack+0xa4/0xe0
> Nov  8 11:06:36 huawei-t2280-03 kernel: ___might_sleep+0x208/0x234
> Nov  8 11:06:36 huawei-t2280-03 kernel: __might_sleep+0x58/0x8c
> Nov  8 11:06:36 huawei-t2280-03 kernel: kmem_cache_alloc_trace+0x29c/0x420
> Nov  8 11:06:36 huawei-t2280-03 kernel: efi_mem_reserve_persistent+0x50/0xe8
> Nov  8 11:06:36 huawei-t2280-03 kernel: its_cpu_init_lpis+0x298/0x2e0
> Nov  8 11:06:36 huawei-t2280-03 kernel: its_cpu_init+0x7c/0x1a8
> Nov  8 11:06:36 huawei-t2280-03 kernel: gic_starting_cpu+0x28/0x34
> Nov  8 11:06:36 huawei-t2280-03 kernel: cpuhp_invoke_callback+0x104/0xd04
> Nov  8 11:06:36 huawei-t2280-03 kernel: notify_cpu_starting+0x60/0xa0
> Nov  8 11:06:36 huawei-t2280-03 kernel: secondary_start_kernel+0xcc/0x178
> 
> Any idea?
