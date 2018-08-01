Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2FEC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622C520841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622C520841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387491AbeHAIZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 04:25:26 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:45679 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387444AbeHAIZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 04:25:25 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41gNxD1tl7z9tvqG;
        Wed,  1 Aug 2018 08:41:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id O-ZKHwjXjArW; Wed,  1 Aug 2018 08:41:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41gNxD11zyz9tvq9;
        Wed,  1 Aug 2018 08:41:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 53D8D8B82B;
        Wed,  1 Aug 2018 08:41:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id puN93dSAn-Wv; Wed,  1 Aug 2018 08:41:16 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CDD4C8B756;
        Wed,  1 Aug 2018 08:41:15 +0200 (CEST)
Subject: Re: [PATCH v3 9/9] powerpc/traps: Add line prefix in
 show_instructions()
To:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     Alastair D'Silva <alastair@d-silva.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Cyril Bur <cyrilbur@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Joe Perches <joe@perches.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
References: <20180731145020.14009-1-muriloo@linux.ibm.com>
 <20180731145020.14009-10-muriloo@linux.ibm.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <c7e0fe17-8c4e-4ccc-dadf-9b320ca5a1d2@c-s.fr>
Date:   Wed, 1 Aug 2018 08:41:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731145020.14009-10-muriloo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 31/07/2018 à 16:50, Murilo Opsfelder Araujo a écrit :
> Remove "Instruction dump:" line by adding a prefix to display current->comm
> and current->pid, along with the instructions dump.
> 
> The prefix can serve as a glue that links the instructions dump to its
> originator, allowing messages to be interleaved in the logs.
> 
> Before this patch, a page fault looked like:
> 
>    pandafault[10524]: segfault (11) at 100007d0 nip 1000061c lr 7fffbd295100 code 2 in pandafault[10000000+10000]
>    Instruction dump:
>    4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
>    392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040
> 
> After this patch, it looks like:
> 
>    pandafault[10850]: segfault (11) at 100007d0 nip 1000061c lr 7fff9f3e5100 code 2 in pandafault[10000000+10000]
>    pandafault[10850]: code: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
>    pandafault[10850]: code: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040
> 
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

Does the script scripts/decode_stacktrace.sh also works with this format 
change ?

> ---
>   arch/powerpc/kernel/process.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index e78799a8855a..d12143e7d8f9 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1265,16 +1265,19 @@ static int instructions_to_print = 16;
>   void show_instructions(struct pt_regs *regs)
>   {
>   	int i;
> +	const char *prefix = KERN_INFO "%s[%d]: code: ";
>   	unsigned long pc = regs->nip - (instructions_to_print * 3 / 4 *
>   			sizeof(int));
>   
> -	printk("Instruction dump:");
> +	printk(prefix, current->comm, current->pid);
>   
>   	for (i = 0; i < instructions_to_print; i++) {
>   		int instr;
>   
> -		if (!(i % 8))
> +		if (!(i % 8) && (i > 0)) {
>   			pr_cont("\n");
> +			printk(prefix, current->comm, current->pid);
> +		}
>   
>   #if !defined(CONFIG_BOOKE)
>   		/* If executing with the IMMU off, adjust pc rather
> 
