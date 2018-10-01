Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50163C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7A1208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7A1208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeJBCfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:35:54 -0400
Received: from mail.windriver.com ([147.11.1.11]:54379 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeJBCfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:35:54 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w91JtxFO013023
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 1 Oct 2018 12:55:59 -0700 (PDT)
Received: from [172.25.59.211] (172.25.59.211) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Mon, 1 Oct 2018
 12:55:58 -0700
Subject: Re: [PATCH] kdb: print real address of pointers instead of hashed
 addresses
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Daniel Thompson <daniel.thompson@linaro.org>
CC:     Michael Ellerman <mpe@ellerman.id.au>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <kgdb-bugreport@lists.sourceforge.net>, <stable@vger.kernel.org>
References: <e5f8f6e3e5a5595be08127eefae8025ebbb691cc.1538068025.git.christophe.leroy@c-s.fr>
From:   Jason Wessel <jason.wessel@windriver.com>
Message-ID: <ed907623-d636-0d18-95b0-33249c3d88cf@windriver.com>
Date:   Mon, 1 Oct 2018 14:55:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e5f8f6e3e5a5595be08127eefae8025ebbb691cc.1538068025.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/2018 12:17 PM, Christophe Leroy wrote:
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p"),
> all pointers printed with %p are printed with hashed addresses
> instead of real addresses in order to avoid leaking addresses in
> dmesg and syslog. But this applies to kdb too, with is unfortunate:
> 
>      Entering kdb (current=0x(ptrval), pid 329) due to Keyboard Entry
>      kdb> ps
>      15 sleeping system daemon (state M) processes suppressed,
>      use 'ps A' to see all.
>      Task Addr       Pid   Parent [*] cpu State Thread     Command
>      0x(ptrval)      329      328  1    0   R  0x(ptrval) *sh
> 
>      0x(ptrval)        1        0  0    0   S  0x(ptrval)  init
>      0x(ptrval)        3        2  0    0   D  0x(ptrval)  rcu_gp
>      0x(ptrval)        4        2  0    0   D  0x(ptrval)  rcu_par_gp
>      0x(ptrval)        5        2  0    0   D  0x(ptrval)  kworker/0:0
>      0x(ptrval)        6        2  0    0   D  0x(ptrval)  kworker/0:0H
>      0x(ptrval)        7        2  0    0   D  0x(ptrval)  kworker/u2:0
>      0x(ptrval)        8        2  0    0   D  0x(ptrval)  mm_percpu_wq
>      0x(ptrval)       10        2  0    0   D  0x(ptrval)  rcu_preempt
> 
> The whole purpose of kdb is to debug, and for debugging real addresses
> need to be known. In addition, data displayed by kdb doesn't go into
> dmesg.
> 

I completely agree.  This is added to the merge queue.

Cheers,
Jason.
