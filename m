Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00014C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999A12089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Jfx2RJfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999A12089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbeJAXfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:35:11 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:37160 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeJAXfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:35:11 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id DE04524E138C;
        Mon,  1 Oct 2018 09:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1538412988; bh=t7x5u0SJtl6zUAKDTwCmb8bGK/+M6y2tS5xS77hgpSE=;
        h=From:To:CC:Subject:Date:References:From;
        b=Jfx2RJfjOgCyvLjYhOXRYu1sQeZxn2/caqZjfc29BnjjkYuBECDXK3ZneO8hAIjAE
         bJ2Dkj/LfuXAntc9JPCCqKOCYfh3mdz5vrwBlHtin8iNLTfklygv2ky4+g2foeQITp
         7U+ACt6GowHhm9i2FNl4hViWV3V2TohTA9L8YBRGVJLrKFLZBwauotkjitM1T1ibAp
         Hg6omm20FOLWsADSWHe7TrSLygKwVKkeH381vNaBXxslSJ9AWSGsxbysBeeeYa4QJC
         t4GH5SZ5JBpq25X/MmIrev1KvV+LjlUHyaFXkZW4QmwRgbjTTdyH5jRD7oAssKAy3l
         oznFxkKOIpd+A==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id C707C3369;
        Mon,  1 Oct 2018 09:56:28 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon, 1
 Oct 2018 09:56:28 -0700
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>
Subject: Re: [PATCH v2] ARC: prevent showing irrelevant exception info in
 signal message
Thread-Topic: [PATCH v2] ARC: prevent showing irrelevant exception info in
 signal message
Thread-Index: AQHULlbodZrzxyhmnkO08j5Ph8lw5w==
Date:   Mon, 1 Oct 2018 16:56:28 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B099BAB@us01wembx1.internal.synopsys.com>
References: <20180807135945.2948-1-Eugeniy.Paltsev@synopsys.com>
 <1538412641.5186.9.camel@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2018 09:50 AM, Eugeniy Paltsev wrote:=0A=
> Hi Vineet,=0A=
>=0A=
> any chance you could look at this?=0A=
> Otherwise we will both forget what it is all about :)=0A=
=0A=
I was busy with non Linux stuff for quite some time - hopefully that should=
 be=0A=
wrapped up and I can get back to tending you ;-)=0A=
=0A=
-Vineet=0A=
=0A=
>=0A=
> On Tue, 2018-08-07 at 16:59 +0300, Eugeniy Paltsev wrote:=0A=
>> We process signals in the end of syscall/exception handler.=0A=
>> It the signal is fatal we print register's content using=0A=
>> show_regs function. show_regs() also prints information about=0A=
>> last exception happened.=0A=
>>=0A=
>> In case of multicore system we can catch the situation when we=0A=
>> will print wrong information about exception. See the example:=0A=
>> ______________________________=0A=
>> CPU-0: started to handle page fault=0A=
>> CPU-1: sent signal to process, which is executed on CPU-0=0A=
>> CPU-0: ended page fault handle. Started to process signal before=0A=
>>        returnig to userspace. Process signal, which is send from=0A=
>>        CPU-0. As th signal is fatal we call show_regs().=0A=
>>        show_regs() will show information about last exception=0A=
>>        which is *page fault* (instead of "trap" which is used for=0A=
>>        signals and happened on CPU-0)=0A=
>>=0A=
>> So we will get message like this:=0A=
>>    # ./waitpid02=0A=
>>   potentially unexpected fatal signal 8.=0A=
>>   Path: /home/waitpid02=0A=
>>   CPU: 0 PID: 100 Comm: waitpid02 Not tainted 4.10.0-rc4 #2=0A=
>>   task: 9f11c200 task.stack: 9f3ae000=0A=
>>=0A=
>>   [ECR   ]: 0x00050200 =3D> Invalid Write @ 0x00000000 by insn @ 0x00012=
3ec=0A=
>>   [EFA   ]: 0x00000000=0A=
>>   [BLINK ]: 0x123ea=0A=
>>   [ERET  ]: 0x123ec=0A=
>>     @off 0x123ec in [/home/waitpid02]=0A=
>>     VMA: 0x00010000 to 0x00016000=0A=
>>   [STAT32]: 0x80080882 : IE U=0A=
>>   BTA: 0x000123ea  SP: 0x5ffd3db0  FP: 0x00000000=0A=
>>   LPS: 0x20031684 LPE: 0x2003169a LPC: 0x00000006=0A=
>>   [-----other-info-----]=0A=
>>=0A=
>> This message is confusing because it show information about page fault=
=0A=
>> ( [ECR   ]: 0x00050200 =3D> Invalid Write ) which is absolutely irreleva=
nt=0A=
>> to signal.=0A=
>>=0A=
>> This situation was reproduced with waitpid02 LTP test.=0A=
>> _____________________________=0A=
>>=0A=
>> So remove printing information about exceptions from show_regs()=0A=
>> to avoid confusing messages. Print information about exceptions=0A=
>> only in required places instead of show_regs()=0A=
>>=0A=
>> Now we don't print information about exceptions if signal is simply=0A=
>> send by another userspace app. So in case of waitpid02 we will print=0A=
>> next message:=0A=
>> _____________________________=0A=
>>    # ./waitpid02=0A=
>>   potentially unexpected fatal signal 8.=0A=
>>   Path: /root/waitpid02=0A=
>>   CPU: 2 PID: 105 Comm: waitpid02 Not tainted 4.18.0-rc8-00002-gde0f6d6a=
eb53-dirty #17=0A=
>>   [ECR   ]: 0x00050100=0A=
>>   [EFA   ]: 0x00000000=0A=
>>   [BLINK ]: 0x20001486=0A=
>>   [-----other-info-----]=0A=
>> _____________________________=0A=
>>=0A=
>> This patch fix=0A=
>> STAR 9001146055: waitpid02: Invalid Write @ 0x00000000 by insn @ 0x00012=
3ec=0A=
>>=0A=
>> NOTE:=0A=
>> To be more clear I give examples of different faults (signal-based,=0A=
>> userspace/kernelspace exception-based) with different values of=0A=
>> "/proc/sys/kernel/print-fatal-signals" option.=0A=
>>=0A=
>> 0) NULL pointer access from user space, print-fatal-signals =3D=3D 1:=0A=
>> ------------>8---------------=0A=
>>  # ./arc_hell=0A=
>> Exception: arc_hell[103]: at 0x2003a35c [off 0x2e35c in /lib/libuClibc-1=
.0.18.so, VMA: 2000c000:20072000]=0A=
>>   ECR: 0x00050100 =3D> Invalid Read @ 0x00000000 by insn @ 0x2003a35c=0A=
>> potentially unexpected fatal signal 11.=0A=
>> Path: /root/arc_hell=0A=
>> CPU: 1 PID: 103 Comm: arc_hell Not tainted 4.18.0-rc8-00002-gde0f6d6aeb5=
3-dirty #17=0A=
>> [ECR   ]: 0x00050100=0A=
>> [EFA   ]: 0x00000000=0A=
>> [BLINK ]: 0x20039ef8=0A=
>> [ERET  ]: 0x2003a35c=0A=
>> [STAT32]: 0x80080882 : IE U=0A=
>> BTA: 0x2003a358  SP: 0x5fa27dc4  FP: 0x5fa27de8=0A=
>> LPS: 0x2003a628 LPE: 0x2003a62c LPC: 0x00000000=0A=
>> r00: 0x00000000 r01: 0x200740b0 r02: 0x00000001=0A=
>> r03: 0x00000007 r04: 0x80808080 r05: 0x2f2f2f2f=0A=
>> r06: 0x7c7a2f43 r07: 0x00000000 r08: 0x1a131100=0A=
>> r09: 0x2008b1e0 r10: 0x20003a5c r11: 0x20004038=0A=
>> r12: 0x20039ef8 r13: 0x200740b0 r14: 0x00000000=0A=
>> r15: 0x200740b0 r16: 0x00000000 r17: 0x0007d468=0A=
>> r18: 0x0009313a r19: 0x00000000 r20: 0x0009c22c=0A=
>> r21: 0x0009c23c r22: 0x0009ab64 r23: 0x00000000=0A=
>> r24: 0x0009dfc5 r25: 0x20004b70=0A=
>>=0A=
>> Segmentation fault=0A=
>> ------------>8---------------=0A=
>>=0A=
>> 1) NULL pointer access from user space, print-fatal-signals =3D=3D 0:=0A=
>> ------------>8---------------=0A=
>>  # ./arc_hell=0A=
>> Exception: arc_hell[107]: at 0x2003a35c [off 0x2e35c in /lib/libuClibc-1=
.0.18.so, VMA: 2000c000:20072000]=0A=
>>   ECR: 0x00050100 =3D> Invalid Read @ 0x00000000 by insn @ 0x2003a35c=0A=
>> Segmentation fault=0A=
>> ------------>8---------------=0A=
>>=0A=
>> 2) Process killed by signal (waitpid02 test), print-fatal-signals =3D=3D=
 1:=0A=
>> ------------>8---------------=0A=
>>  # ./waitpid02=0A=
>> potentially unexpected fatal signal 8.=0A=
>> Path: /root/waitpid02=0A=
>> CPU: 2 PID: 105 Comm: waitpid02 Not tainted 4.18.0-rc8-00002-gde0f6d6aeb=
53-dirty #17=0A=
>> [ECR   ]: 0x00050100=0A=
>> [EFA   ]: 0x00000000=0A=
>> [BLINK ]: 0x20001486=0A=
>> [ERET  ]: 0x2000146c=0A=
>> [STAT32]: 0x80080082 : IE U=0A=
>> BTA: 0x20000fc4  SP: 0x5fa21d64  FP: 0x00000000=0A=
>> LPS: 0x200524a0 LPE: 0x200524b6 LPC: 0x00000006=0A=
>> r00: 0x2000c0dc r01: 0x00000018 r02: 0x0001159a=0A=
>> r03: 0x00000001 r04: 0x00000000 r05: 0x00000045=0A=
>> r06: 0x0000004e r07: 0x01010101 r08: 0x000000dc=0A=
>> r09: 0x200a31e0 r10: 0x20003a5c r11: 0x20004038=0A=
>> r12: 0x20001486 r13: 0x20004174 r14: 0x07ca2bc0=0A=
>> r15: 0x20004078 r16: 0x00000000 r17: 0x20004038=0A=
>> r18: 0x00000001 r19: 0x00000000 r20: 0x0001159a=0A=
>> r21: 0x00000001 r22: 0x00000000 r23: 0x00000004=0A=
>> r24: 0x2000d1fc r25: 0x20004cd0=0A=
>> ------------>8---------------=0A=
>>=0A=
>> 3) Process killed by signal (waitpid02 test), print-fatal-signals =3D=3D=
 0:=0A=
>> ------------>8---------------=0A=
>>  # ./waitpid02=0A=
>> ------------>8---------------=0A=
>>=0A=
>> 4) NULL pointer access from kernel space, regardless print-fatal-signals=
=0A=
>> value:=0A=
>> ------------>8---------------=0A=
>> Oops=0A=
>> Exception: at stmmac_dvr_probe+0x40/0x7e0:=0A=
>>   ECR: 0x00050200 =3D> Invalid Write @ 0x00000000 by insn @ 0x90575254=
=0A=
>> Path: (null)=0A=
>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.0-rc8-00002-gde0f6d6aeb53=
-dirty #11=0A=
>> [EFA   ]: 0x00000000=0A=
>> [BLINK ]: stmmac_dvr_probe+0x2a/0x7e0=0A=
>> [ERET  ]: stmmac_dvr_probe+0x40/0x7e0=0A=
>> [STAT32]: 0x80080402 : IE K=0A=
>> BTA: 0x9057523e  SP: 0xbf02be40  FP: 0x00000000=0A=
>> LPS: 0x9073dbcc LPE: 0x9073dbe0 LPC: 0x00000000=0A=
>> r00: 0xbf1f0000 r01: 0x00000000 r02: 0x00000008=0A=
>> r03: 0x00000000 r04: 0x00000064 r05: 0x00000000=0A=
>> r06: 0x00000003 r07: 0x00000004 r08: 0x01010101=0A=
>> r09: 0x00000031 r10: 0xbf1f0006 r11: 0x00000000=0A=
>> r12: 0x9057523e=0A=
>>=0A=
>> Stack Trace:=0A=
>>   stmmac_dvr_probe+0x40/0x7e0=0A=
>>   dwmac_generic_probe+0x50/0xbc=0A=
>>   platform_drv_probe+0x26/0x5c=0A=
>>   really_probe+0x3b0/0x464=0A=
>>   __driver_attach+0xd4/0xd8=0A=
>>   bus_for_each_dev+0x3a/0x70=0A=
>>   bus_add_driver+0x12a/0x18c=0A=
>>   driver_register+0x56/0xe8=0A=
>>   do_one_initcall+0x2e/0x118=0A=
>>   kernel_init_freeable+0x102/0x194=0A=
>> ------------>8---------------=0A=
>>=0A=
>> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
>> ---=0A=
>>=0A=
>> NOTE:=0A=
>>   This patch has prerequisites:=0A=
>>   https://www.mail-archive.com/linux-snps-arc@lists.infradead.org/msg039=
38.html=0A=
>>   https://www.mail-archive.com/linux-snps-arc@lists.infradead.org/msg039=
37.html=0A=
>>=0A=
>> Changes v1->v2:=0A=
>>  * Change format of message about exception.=0A=
>>=0A=
>>  arch/arc/include/asm/bug.h     |  1 +=0A=
>>  arch/arc/kernel/traps.c        |  1 +=0A=
>>  arch/arc/kernel/troubleshoot.c | 51 +++++++++++++++++++++++++++++++++--=
-------=0A=
>>  arch/arc/mm/fault.c            |  2 ++=0A=
>>  4 files changed, 44 insertions(+), 11 deletions(-)=0A=
>>=0A=
>> diff --git a/arch/arc/include/asm/bug.h b/arch/arc/include/asm/bug.h=0A=
>> index 21ec82466d62..b68f7f82f2d8 100644=0A=
>> --- a/arch/arc/include/asm/bug.h=0A=
>> +++ b/arch/arc/include/asm/bug.h=0A=
>> @@ -16,6 +16,7 @@=0A=
>>  struct task_struct;=0A=
>>  =0A=
>>  void show_regs(struct pt_regs *regs);=0A=
>> +void show_exception_mesg(struct pt_regs *regs);=0A=
>>  void show_stacktrace(struct task_struct *tsk, struct pt_regs *regs);=0A=
>>  void show_kernel_fault_diag(const char *str, struct pt_regs *regs,=0A=
>>  			    unsigned long address);=0A=
>> diff --git a/arch/arc/kernel/traps.c b/arch/arc/kernel/traps.c=0A=
>> index b123558bf0bb..5d83b2fe5f12 100644=0A=
>> --- a/arch/arc/kernel/traps.c=0A=
>> +++ b/arch/arc/kernel/traps.c=0A=
>> @@ -50,6 +50,7 @@ unhandled_exception(const char *str, struct pt_regs *r=
egs, siginfo_t *info)=0A=
>>  		tsk->thread.fault_address =3D (__force unsigned int)info->si_addr;=0A=
>>  =0A=
>>  		force_sig_info(info->si_signo, info, tsk);=0A=
>> +		show_exception_mesg(regs);=0A=
>>  =0A=
>>  	} else {=0A=
>>  		/* If not due to copy_(to|from)_user, we are doomed */=0A=
>> diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troublesho=
ot.c=0A=
>> index e8d9fb452346..fdfba1942a06 100644=0A=
>> --- a/arch/arc/kernel/troubleshoot.c=0A=
>> +++ b/arch/arc/kernel/troubleshoot.c=0A=
>> @@ -101,13 +101,13 @@ static void show_faulting_vma(unsigned long addres=
s, char *buf)=0A=
>>  			if (IS_ERR(nm))=0A=
>>  				nm =3D "?";=0A=
>>  		}=0A=
>> -		pr_info("    @off 0x%lx in [%s]\n"=0A=
>> -			"    VMA: 0x%08lx to 0x%08lx\n",=0A=
>> +=0A=
>> +		pr_cont("[off 0x%lx in %s, VMA: %08lx:%08lx] ",=0A=
>>  			vma->vm_start < TASK_UNMAPPED_BASE ?=0A=
>>  				address : address - vma->vm_start,=0A=
>>  			nm, vma->vm_start, vma->vm_end);=0A=
>>  	} else=0A=
>> -		pr_info("    @No matching VMA found\n");=0A=
>> +		pr_cont("[No matching VMA found] ");=0A=
>>  =0A=
>>  	up_read(&active_mm->mmap_sem);=0A=
>>  }=0A=
>> @@ -117,7 +117,7 @@ static void show_ecr_verbose(struct pt_regs *regs)=
=0A=
>>  	unsigned int vec, cause_code;=0A=
>>  	unsigned long address;=0A=
>>  =0A=
>> -	pr_info("\n[ECR   ]: 0x%08lx =3D> ", regs->event);=0A=
>> +	pr_cont("\n  ECR: 0x%08lx =3D> ", regs->event);=0A=
>>  =0A=
>>  	/* For Data fault, this is data address not instruction addr */=0A=
>>  	address =3D current->thread.fault_address;=0A=
>> @@ -165,10 +165,42 @@ static void show_ecr_verbose(struct pt_regs *regs)=
=0A=
>>  	}=0A=
>>  }=0A=
>>  =0A=
>> +static inline void show_exception_mesg_u(struct pt_regs *regs)=0A=
>> +{=0A=
>> +	struct task_struct *tsk =3D current;=0A=
>> +	char *buf;=0A=
>> +=0A=
>> +	pr_info("Exception: %s[%d]: at %pS ",=0A=
>> +		tsk->comm, task_pid_nr(tsk), (void *)regs->ret);=0A=
>> +=0A=
>> +	buf =3D (char *)__get_free_page(GFP_NOWAIT);=0A=
>> +	if (buf) {=0A=
>> +		show_faulting_vma(regs->ret, buf);=0A=
>> +		free_page((unsigned long)buf);=0A=
>> +	}=0A=
>> +=0A=
>> +	show_ecr_verbose(regs);=0A=
>> +}=0A=
>> +=0A=
>> +static inline void show_exception_mesg_k(struct pt_regs *regs)=0A=
>> +{=0A=
>> +	pr_info("Exception: at %pS:", (void *)regs->ret);=0A=
>> +=0A=
>> +	show_ecr_verbose(regs);=0A=
>> +}=0A=
>> +=0A=
>>  /**********************************************************************=
**=0A=
>>   *  API called by rest of kernel=0A=
>>   **********************************************************************=
*/=0A=
>>  =0A=
>> +void show_exception_mesg(struct pt_regs *regs)=0A=
>> +{=0A=
>> +	if (user_mode(regs))=0A=
>> +		show_exception_mesg_u(regs);=0A=
>> +	else=0A=
>> +		show_exception_mesg_k(regs);=0A=
>> +}=0A=
>> +=0A=
>>  void show_regs(struct pt_regs *regs)=0A=
>>  {=0A=
>>  	struct task_struct *tsk =3D current;=0A=
>> @@ -182,15 +214,10 @@ void show_regs(struct pt_regs *regs)=0A=
>>  	print_task_path_n_nm(tsk, buf);=0A=
>>  	show_regs_print_info(KERN_INFO);=0A=
>>  =0A=
>> -	show_ecr_verbose(regs);=0A=
>> -=0A=
>> -	pr_info("[EFA   ]: 0x%08lx\n[BLINK ]: %pS\n[ERET  ]: %pS\n",=0A=
>> -		current->thread.fault_address,=0A=
>> +	pr_info("[ECR   ]: 0x%08lx\n[EFA   ]: 0x%08lx\n[BLINK ]: %pS\n[ERET  ]=
: %pS\n",=0A=
>> +		regs->event, current->thread.fault_address,=0A=
>>  		(void *)regs->blink, (void *)regs->ret);=0A=
>>  =0A=
>> -	if (user_mode(regs))=0A=
>> -		show_faulting_vma(regs->ret, buf); /* faulting code, not data */=0A=
>> -=0A=
>>  	pr_info("[STAT32]: 0x%08lx", regs->status32);=0A=
>>  =0A=
>>  #define STS_BIT(r, bit)	r->status32 & STATUS_##bit##_MASK ? #bit" " : "=
"=0A=
>> @@ -233,6 +260,8 @@ void show_kernel_fault_diag(const char *str, struct =
pt_regs *regs,=0A=
>>  	/* Show fault description */=0A=
>>  	pr_info("\n%s\n", str);=0A=
>>  =0A=
>> +	show_exception_mesg(regs);=0A=
>> +=0A=
>>  	/* Caller and Callee regs */=0A=
>>  	show_regs(regs);=0A=
>>  =0A=
>> diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c=0A=
>> index b884bbd6f354..d9c6958a1702 100644=0A=
>> --- a/arch/arc/mm/fault.c=0A=
>> +++ b/arch/arc/mm/fault.c=0A=
>> @@ -202,6 +202,7 @@ void do_page_fault(unsigned long address, struct pt_=
regs *regs)=0A=
>>  		/* info.si_code has been set above */=0A=
>>  		info.si_addr =3D (void __user *)address;=0A=
>>  		force_sig_info(SIGSEGV, &info, tsk);=0A=
>> +		show_exception_mesg(regs);=0A=
>>  		return;=0A=
>>  	}=0A=
>>  =0A=
>> @@ -241,4 +242,5 @@ void do_page_fault(unsigned long address, struct pt_=
regs *regs)=0A=
>>  	info.si_code =3D BUS_ADRERR;=0A=
>>  	info.si_addr =3D (void __user *)address;=0A=
>>  	force_sig_info(SIGBUS, &info, tsk);=0A=
>> +	show_exception_mesg(regs);=0A=
>>  }=0A=
=0A=
