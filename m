Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C95BC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFB62133D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="F3qPcDBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfAWO4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:56:09 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:36332 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfAWO4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:56:08 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43l7dd4Mcjz9tyTN;
        Wed, 23 Jan 2019 15:56:05 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=F3qPcDBg; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id KCT9hiWv9axF; Wed, 23 Jan 2019 15:56:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43l7dd396Dz9tyTL;
        Wed, 23 Jan 2019 15:56:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1548255365; bh=sSpBcnR1qxezOo1ri8qRsSrq7fLG0SxqCxAbgIGwrBs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=F3qPcDBgEgn4kltWSxnGy+D5nem5aJmbvstdrm+IFkantZ2X4qhOh1w+Tjsl9Phnp
         dqQ3yp4o3Hqd4bYtkq6vBCB1xdlZ9zLtR+VExiQ9dxiZ/A/mYYYCbGUddKr+4aACjC
         VaaiCO6C9PKG98Gte4OahF0oeZkm1fYvHxq3GTIA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E2FC08B820;
        Wed, 23 Jan 2019 15:56:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vMi-tTw7U0b6; Wed, 23 Jan 2019 15:56:06 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5BCCB8B81E;
        Wed, 23 Jan 2019 15:56:06 +0100 (CET)
Subject: Re: [PATCH] tools/testing/selftests/powerpc: Add Anton's null_syscall
 benchmark to the selftests
To:     Rui Teng <rui.teng@linux.vnet.ibm.com>,
        Anton Blanchard <anton@au1.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
        Shuah Khan <shuah@kernel.org>, Cyril Bur <cyrilbur@gmail.com>
References: <20160927141016.6027-1-rui.teng@linux.vnet.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <2b98b303-d0d4-9f1d-9c47-fde0afb1306c@c-s.fr>
Date:   Wed, 23 Jan 2019 15:56:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20160927141016.6027-1-rui.teng@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 27/09/2016 à 16:10, Rui Teng a écrit :
> From: Anton Blanchard <anton@au.ibm.com>
> 
> Pull in a version of Anton's null_syscall benchmark:
> http://ozlabs.org/~anton/junkcode/null_syscall.c
> Into tools/testing/selftests/powerpc/benchmarks.
> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Anton Blanchard <anton@au.ibm.com>
> Signed-off-by: Rui Teng <rui.teng@linux.vnet.ibm.com>
> ---
>   .../testing/selftests/powerpc/benchmarks/Makefile  |   2 +-
>   .../selftests/powerpc/benchmarks/null_syscall.c    | 157 +++++++++++++++++++++
>   2 files changed, 158 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/powerpc/benchmarks/null_syscall.c
> 

[...]

> +
> +static void do_null_syscall(unsigned long nr)
> +{
> +	unsigned long i;
> +
> +	for (i = 0; i < nr; i++)
> +		getppid();
> +}
> +

Looks like getppid() performs a rcu_read_lock(). Is that what we want ?

Shouldn't we use getpid() instead for a lighter syscall ?

Christophe
