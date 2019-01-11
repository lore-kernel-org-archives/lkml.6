Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230ABC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBD420872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732976AbfAKOAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:00:14 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:45651 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbfAKOAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:00:14 -0500
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id AA27FE0003;
        Fri, 11 Jan 2019 14:00:09 +0000 (UTC)
Subject: Re: [PATCH 1/3] riscv: Introduce huge page support for 32/64bit
 kernel
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Alexandre Ghiti <aghiti@upmem.com>
Cc:     aou@eecs.berkeley.edu, catalin.marinas@arm.com, palmer@sifive.com,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, atish.patra@wdc.com,
        linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com
References: <20181210062146.24951-1-aghiti@upmem.com>
 <20181210062146.24951-2-aghiti@upmem.com>
 <alpine.DEB.2.21.9999.1901102215390.22105@viisi.sifive.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <8a96dec9-ac00-5b3c-e532-2c8ef0e3a537@ghiti.fr>
Date:   Fri, 11 Jan 2019 14:58:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.9999.1901102215390.22105@viisi.sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2019 07:18 AM, Paul Walmsley wrote:
> Hello Alexandre,
>
> On Mon, 10 Dec 2018, Alexandre Ghiti wrote:
>
>> This patch implements both 4MB huge page support for 32bit kernel
>> and 2MB/1GB huge pages support for 64bit kernel.
>>
>> Signed-off-by: Alexandre Ghiti <aghiti@upmem.com>
> This patch introduces a few minor checkpatch and strict checkpatch
> warnings, when tested against both v4.20 and v5.0-rc1 checkpatch versions.
> Could you fix those?  The other two patches in the series look OK from
> that point of view.

Yes, I had noted those warnings:

- the SPDX warning is weird, in all *.c files, the script seems to 
accept only
   "// SPDX-License-Identifier: GPL-2.0" and not "/* 
SPDX-License-Identifier: GPL-2.0 */".
   But on *.h files, this the contrary, maybe I missed something, I am going
   to take a look at the script spdxcheck.py.
   Note that kernel/ftrace.c and kernel/perf_event.c raise the same 
strange warning.

- I'll change the "printk(KERN_ERR" into a pr_err.

- I'll ignore the last warning regarding the new file.

Thanks for your feedback Paul,

Alex

>
>
> - Paul
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

