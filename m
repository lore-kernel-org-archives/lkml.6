Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752810AbeDLBud (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 21:50:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7167 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751960AbeDLBub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 21:50:31 -0400
Message-ID: <5ACEBB47.3060300@huawei.com>
Date: Thu, 12 Apr 2018 09:49:59 +0800
From: Xishi Qiu <qiuxishi@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "Ard Biesheuvel" <ard.biesheuvel@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>
CC: yeyunfeng <yeyunfeng@huawei.com>, Wenan Mao <maowenan@huawei.com>,
        "Linux MM" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [RFC] should BIOS change the efi type when we set CONFIG_X86_RESERVE_LOW
 ?
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.25.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I find CONFIG_X86_RESERVE_LOW=64 in my system, so trim_low_memory_range()
will reserve low 64kb memory. But efi_free_boot_services() will free it to
buddy system again later because BIOS set the type to EFI_BOOT_SERVICES_CODE.

Here is the log:
...
efi: mem03: type=3, attr=0xf, range=[0x000000000000e000-0x0000000000010000) (0MB
...
