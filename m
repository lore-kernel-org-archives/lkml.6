Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBDEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2B02133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbfAKDkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 22:40:39 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:6470 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726531AbfAKDki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 22:40:38 -0500
X-IronPort-AV: E=Sophos;i="5.56,463,1539619200"; 
   d="scan'208";a="51761711"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Jan 2019 11:40:37 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id F15044BAD909;
        Fri, 11 Jan 2019 11:40:36 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 11 Jan 2019 11:40:35 +0800
Subject: Re: [PATCH] x86/boot: drop memset from copy.S
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
References: <20190107074056.12532-1-caoj.fnst@cn.fujitsu.com>
 <4bb8f61a-f93c-4b30-9990-ecf5a8ddc998@cn.fujitsu.com>
Message-ID: <1b9db13b-ebe9-70f7-bc79-b608d8906a4b@cn.fujitsu.com>
Date:   Fri, 11 Jan 2019 11:40:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <4bb8f61a-f93c-4b30-9990-ecf5a8ddc998@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: F15044BAD909.A7C5A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/19 4:46 PM, Cao jin wrote:
> One more question: in compressed/, for mem*(), it seems we both use the
> macros of boot/string.h, and the functions of compressed/string.c. Is
> that what we want?
> 
> compressed/ is compiled with -O2, so it cannot be told by objdump -d,
> but still can be confirmed by nm <*.o>, for example:
> 
> $nm arch/x86/boot/compressed/eboot.o
>                  U memcpy
>                  U memset
> 
> $nm arch/x86/boot/compressed/pgtable_64.o
>                  # No entry of mem*()
> 
> both of eboot.c and pgtable_64.c #include "../string.h", and use some of
>  mem*(), it is counter-intuitive to me. Very appreciate it someone can
> leave a hint.
> 

Well, I think HPA's previous answer is also suitable for this question,
with -O2, sometimes __builtin_mem*() is optimized as inline code, while
sometimes just emit a call to corresponding self-defined mem*() functions.

-- 
Sincerely,
Cao jin


