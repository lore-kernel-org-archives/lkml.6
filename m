Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeDJCcS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 22:32:18 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:37981 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751568AbeDJCcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 22:32:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=zoucao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0T-wddO-_1523327524;
Message-ID: <5ACC2223.3090907@linux.alibaba.com>
Date: Tue, 10 Apr 2018 10:32:03 +0800
From: zoucao-ipc <zoucao@linux.alibaba.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To: tglx@linutronix.de
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] free e820 reserved memory in bootargs memmap
References: <20180408064134.77385-1-zoucao@linux.alibaba.com>
In-Reply-To: <20180408064134.77385-1-zoucao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found commit characters errors, please ignore this path, V2 will be 
sent soon

On 2018/4/8 下午2:41, zoucao@linux.alibaba.com wrote:
> add a new chareater "-" in bootargs memmap, you can use this chareater to free
> e820 reserved memory, for example:
>
> reserved iomem:
> 	cat /proc/iomem:
> 	......
> 	00100000-6aefefff : System RAM
> 	  01000000-0165537a : Kernel code
> 	  0165537b-01a8873f : Kernel data
> 	  01c31000-01f4efff : Kernel bss
> 	  28000000-320fffff : Crash kernel
> 	6aeff000-6effffff : reserved       --> it is e820 reserved memory
> 	6f000000-78240fff : System RAM
> 	......
>
>
> add bootargs memmap=0x4101000-0x6aeff000, to free memory region: 6aeff000-6effffff
> then 6aeff000-6effffff will be merged into 00100000-78240fff.
>
> new iomem:
> 	cat /proc/iomem:
> 	......
> 	00100000-78240fff : System RAM
> 	  01000000-0165537a : Kernel code
> 	  0165537b-01a8873f : Kernel data
> 	  01c31000-01f4efff : Kernel bss
> 	......
