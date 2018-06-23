Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB6BC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFADF24C92
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFADF24C92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeFWQ7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 12:59:31 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64924 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751727AbeFWQ7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 12:59:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41ChVj2gGHz9ttRy;
        Sat, 23 Jun 2018 18:59:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id oIAHvpdXQBuG; Sat, 23 Jun 2018 18:59:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41ChVj26FFz9ttRr;
        Sat, 23 Jun 2018 18:59:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6927D8B7F8;
        Sat, 23 Jun 2018 18:59:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PMwD1uLZRYPD; Sat, 23 Jun 2018 18:59:29 +0200 (CEST)
Received: from [192.168.232.53] (unknown [192.168.232.53])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6B10C8B74B;
        Sat, 23 Jun 2018 18:59:28 +0200 (CEST)
Subject: =?UTF-8?Q?Re:_[PATCH]_powerpc/xmon:_avoid_warnings_about_variables_?=
 =?UTF-8?Q?that_might_be_clobbered_by_=e2=80=98longjmp=e2=80=99?=
To:     Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Yisheng Xie <xieyisheng1@huawei.com>,
        Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
References: <20180622192718.24242-1-malat@debian.org>
From:   christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <b41b244e-78b8-c85f-9122-427ad04cccf8@c-s.fr>
Date:   Sat, 23 Jun 2018 18:59:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622192718.24242-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 180623-2, 23/06/2018), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 22/06/2018 à 21:27, Mathieu Malaterre a écrit :
> Move initialization of variables after data definitions. This silence
> warnings treated as error with W=1:
> 
>    arch/powerpc/xmon/xmon.c:3389:14: error: variable ‘name’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Werror=clobbered]
>    arch/powerpc/xmon/xmon.c:3100:22: error: variable ‘tsk’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Werror=clobbered]

Is that an invalid warning ?

If so, please explain in the commit log.

Otherwise, I'd expect one to fix the warning, not just cheat on GCC.

Christophe


> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/powerpc/xmon/xmon.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 47166ad2a669..982848c784ff 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -3097,10 +3097,11 @@ static void show_pte(unsigned long addr)
>   static void show_tasks(void)
>   {
>   	unsigned long tskv;
> -	struct task_struct *tsk = NULL;
> +	struct task_struct *tsk;
>   
>   	printf("     task_struct     ->thread.ksp    PID   PPID S  P CMD\n");
>   
> +	tsk = NULL;
>   	if (scanhex(&tskv))
>   		tsk = (struct task_struct *)tskv;
>   
> @@ -3386,10 +3387,11 @@ static void xmon_print_symbol(unsigned long address, const char *mid,
>   			      const char *after)
>   {
>   	char *modname;
> -	const char *name = NULL;
> +	const char *name;
>   	unsigned long offset, size;
>   
>   	printf(REG, address);
> +	name = NULL;
>   	if (setjmp(bus_error_jmp) == 0) {
>   		catch_memory_errors = 1;
>   		sync();
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

