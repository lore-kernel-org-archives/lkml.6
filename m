Return-Path: <marc.zyngier@arm.com>
X-Google-Smtp-Source: AIpwx4/dwT2vy3+om4t3HCMzDT9hxjnFrtk/RN43AhIaUDBDCRddfgDxHqvNc6Z+u3nTbIwsk9wg
ARC-Seal: i=1; a=rsa-sha256; t=1523267067; cv=none;
        d=google.com; s=arc-20160816;
        b=Hc1C93JuNY4HeYkVnroX6/0no/TvRqkVIu7GgelzRR//udTmVqfr2+P8OC0In3jhBn
         MNK9wc2Ijn0TOlwtJLBRJTYvtU0NwONFVtpx+yYqRjealThMdOMI6GjKnWE5P72srG+u
         wwQacYAGSBXmL578JBZ0LvJQSh0ksfLPSBG/5SuPPglkV0ToRXCu/H3iXzXEr8H01Eb4
         TrCLWkyG7XXzsuG/IhXllIPrQz7oXBVPjyg1+r6ajvvEr94ewgTUl5dpkc5cWZgvqCD2
         2Xr6/x64fK7YUa6F6Kwz1XAPEcqw5oeajNoYEsKTzKpTA9pRsEM7tIOsG7hwDDU7PhLu
         uzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=rWhiMHiXlGFMRi9hm7ptaq6xBDRG3M+Ggsk4UweLOR4=;
        b=ZFZZL8qoxGqmZ9CL/05aTNO8eOKjuIiusus/0NZIX1KnJdt+Szs/zNjCyowJoB32+d
         RP/IcmkoVN1ePH1376HfUsQM74dw8iVUySvc9eAJkr3qFm+znaFK+X4txZGLakCayrnn
         xQbggwKQWf0fXMDhIVrmiHQKdpcZkDBvKuUumDLUqA6I77KrLdRBIUgiYPs+rODT7+2i
         vxe/YBDhMQxM+9j+O7ZRP5qdoe9He5kfis5jxUZeEfBh7Us/ROhveGmZQ76hwbpm7V9/
         RJPXIRSTaQXxzAMY8dVNfowCRP4agRcRpqMU3fXycKuJHiN3PqSNaeUWSwfewWsBlvHm
         hikA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Subject: Re: Linux 4.9.93
To: Greg KH <gregkh@linuxfoundation.org>,
 Jean-Baptiste Theou <jb@essential.com>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, will.deacon@arm.com, dan.rue@linaro.org,
 mark.brown@linaro.org, ard.biesheuvel@linaro.org,
 Greg Hackmann <ghackmann@google.com>
References: <20180409180534.1768583293d0abe207168c5a@essential.com>
 <20180409093028.GA3398@kroah.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <d68777f7-0211-d1cb-691d-6f9d06410b21@arm.com>
Date: Mon, 9 Apr 2018 10:44:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180409093028.GA3398@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597258846269332204?=
X-GMAIL-MSGID: =?utf-8?q?1597261288159346117?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 09/04/18 10:30, Greg KH wrote:
> On Mon, Apr 09, 2018 at 06:05:34PM +0900, Jean-Baptiste Theou wrote:
>> Hi,
>>
>> After this patchset, a kernel built with CFI fails. Disabling
>> UNMAP_KERNEL_AT_EL0 fix the issue obviously.
> 
> Is this a "clean" 4.9.93 tree or a "4.9.93 merged into
> android-common-4.9?
> 
>> Wondering if there is one of the test suite used on the review patchset that covers the CFI usecase.
>>
>> Best regards,
>>
>> [    0.249191] CPU features: detected feature: GIC system register CPU interface
>> [    0.256391] CPU features: detected feature: Privileged Access Never
>> [    0.262719] CPU features: detected feature: User Access Override
>> [    0.268791] CPU features: detected feature: 32-bit EL0 Support
>> [    0.274683] CPU features: detected feature: Kernel page table isolation (KPTI)
>> [    0.282166] CFI failure:
>> [    0.282169] CFI failure:
>> [    0.282172] CFI failure:
>> [    0.282173] CFI failure:
>> [    0.282175] CFI failure:
>> [    0.282176] CFI failure:
>> [    0.282177] CFI failure:
>> [    0.282178] CFI failure:
>> [    0.282188] ------------[ cut here ]------------
>> [    0.282189] ------------[ cut here ]------------
>> [    0.282190] ------------[ cut here ]------------
>> [    0.282191] ------------[ cut here ]------------
>> [    0.282193] ------------[ cut here ]------------
>> [    0.282196] kernel BUG at kernel/cfi.c:32!
>> [    0.282198] ------------[ cut here ]------------
>> [    0.282201] kernel BUG at kernel/cfi.c:32!
>> [    0.282202] ------------[ cut here ]------------
>> [    0.282204] kernel BUG at kernel/cfi.c:32!
>> [    0.282207] kernel BUG at kernel/cfi.c:32!
>> [    0.282209] kernel BUG at kernel/cfi.c:32!
>> [    0.282211] kernel BUG at kernel/cfi.c:32!
>> [    0.282214] kernel BUG at kernel/cfi.c:32!
>> [    0.282215] ------------[ cut here ]------------
>> [    0.282216] kernel BUG at kernel/cfi.c:32!
>> [    0.282218] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>> [    0.282224] Modules linked in:
>> [    0.282230] CPU: 2 PID: 25 Comm: migration/2 Not tainted 4.9.93-perf+ #39
>> [    0.282232] Hardware name: <REMOVED>
>> [    0.282235] task: fffffffbb3b36580 task.stack: fffffffbb30cc000
>> [    0.282250] PC is at __cfi_check_fail+0x14/0x1c
>> [    0.282253] LR is at __cfi_check_fail+0x14/0x1c
>> [    0.282255] pc : [<ffffff93b3f03d90>] lr : [<ffffff93b3f03d90>] pstate: 60c00085
>> [    0.282256] sp : fffffffbb30cfc30
>> [    0.282259] x29: fffffffbb30cfc30 x28: ffffff93b6415000 
>> [    0.282261] x27: 00000013b65c1000 x26: ffffff93b5ce6000 
>> [    0.282264] x25: ffffff93b5ce6000 x24: ffffff93b6419000 
>> [    0.282266] x23: ffffff93b65c1000 x22: ffffff93b65c4000 
>> [    0.282268] x21: 9d12f8172cb2f296 x20: 000000008180e3e0 
>> [    0.282271] x19: 0000000000000000 x18: 000000000000002c 
>> [    0.282274] x17: 00000000000fd054 x16: 0000000000000000 
>> [    0.282276] x15: ffffff93b65ec000 x14: 000000000000000c 
>> [    0.282279] x13: 0000000000000004 x12: 0000000000000000 
>> [    0.282281] x11: 0000000000000000 x10: 0000000001440144 
>> [    0.282283] x9 : 260822e8751d5000 x8 : 260822e8751d5000 
>> [    0.282286] x7 : 0000000000000000 x6 : fffffffbbac75b60 
>> [    0.282288] x5 : 0000000000000000 x4 : 0000000000000000 
>> [    0.282290] x3 : 000000003a657275 x2 : 0000000000000000 
>> [    0.282292] x1 : 0000000000000000 x0 : 000000000000000c 
>> [    0.282294] 
>> [    0.282294] PC: 0xffffff93b3f03d50:
>> [    0.282308] 3d50  b9001ac8 f94002c8 370ffec8 17ffffbe d4210000 14000000 aa1603e0 f90007e8
>> [    0.282315] 3d70  94536017 f94007e8 17ffffe2 a9bf7bfd 910003fd d000d100 913ee400 94533cc7
>> [    0.282322] 3d90  d4210000 14000000 b0013788 2a1f03e0 f901c51f d65f03c0 f940406b 2a0203e8
>> [    0.282329] 3db0  2a0103e9 aa0003ea b400008b f9000145 f94000cb b40001ab a9bf7bfd 910003fd
>> [    0.282330] 
>> [    0.282330] LR: 0xffffff93b3f03d50:
>> [    0.282336] 3d50  b9001ac8 f94002c8 370ffec8 17ffffbe d4210000 14000000 aa1603e0 f90007e8
>> [    0.282343] 3d70  94536017 f94007e8 17ffffe2 a9bf7bfd 910003fd d000d100 913ee400 94533cc7
>> [    0.282350] 3d90  d4210000 14000000 b0013788 2a1f03e0 f901c51f d65f03c0 f940406b 2a0203e8
>> [    0.282357] 3db0  2a0103e9 aa0003ea b400008b f9000145 f94000cb b40001ab a9bf7bfd 910003fd
>> [    0.282358] 
>> [    0.282358] SP: 0xfffffffbb30cfbf0:
>> [    0.282365] fbf0  b3f03d90 ffffff93 b30cfc30 fffffffb b3f03d90 ffffff93 60c00085 00000000
>> [    0.282372] fc10  b6415000 ffffff93 b642fa00 ffffff93 ffffffff ffffffff b3f03d90 ffffff93
>> [    0.282378] fc30  b30cfc70 fffffffb b3d458c0 ffffff93 00000080 00000000 00000001 00000000
>> [    0.282385] fc50  b65c4000 ffffff93 b64420f0 ffffff93 8180e3e0 00000000 00000002 00000000
>> [    0.282387] Process migration/2 (pid: 25, stack limit = 0xfffffffbb30cc000)
>> [    0.282389] Call trace:
>> [    0.282391] Exception stack(0xfffffffbb30cfb00 to 0xfffffffbb30cfc30)
>> [    0.282395] fb00: 000000000000000c 0000000000000000 0000000000000000 000000003a657275
>> [    0.282397] fb20: 0000000000000000 0000000000000000 fffffffbbac75b60 0000000000000000
>> [    0.282400] fb40: 260822e8751d5000 260822e8751d5000 0000000001440144 0000000000000000
>> [    0.282403] fb60: 0000000000000000 0000000000000004 000000000000000c ffffff93b65ec000
>> [    0.282405] fb80: 0000000000000000 00000000000fd054 000000000000002c 0000000000000000
>> [    0.282408] fba0: 000000008180e3e0 9d12f8172cb2f296 ffffff93b65c4000 ffffff93b65c1000
>> [    0.282411] fbc0: ffffff93b6419000 ffffff93b5ce6000 ffffff93b5ce6000 00000013b65c1000
>> [    0.282413] fbe0: ffffff93b6415000 fffffffbb30cfc30 ffffff93b3f03d90 fffffffbb30cfc30
>> [    0.282416] fc00: ffffff93b3f03d90 0000000060c00085 ffffff93b6415000 ffffff93b642fa00
>> [    0.282418] fc20: ffffffffffffffff ffffff93b3f03d90
>> [    0.282421] [<ffffff93b3f03d90>] __cfi_check_fail+0x14/0x1c

Where is this coming from? Out of tree patches?

>> [    0.282430] [<ffffff93b3d458c0>] name_to_dev_t+0x0/0x47c
>> [    0.282436] [<ffffff93b3d51b80>] kpti_install_ng_mappings+0x178/0x2e0
>> [    0.282443] [<ffffff93b3eae950>] multi_cpu_stop+0x114/0x170
>> [    0.282445] [<ffffff93b3eaf08c>] cpu_stopper_thread+0x128/0x2e8
>> [    0.282452] [<ffffff93b3db5504>] smpboot_thread_fn+0x230/0x558
>> [    0.282455] [<ffffff93b3dae848>] kthread+0x21c/0x238
>> [    0.282459] [<ffffff93b3c838f0>] ret_from_fork+0x10/0x20
>> [    0.282464] Code: 910003fd d000d100 913ee400 94533cc7 (d4210000) 
> 
> Oh fun :(
> 
> Dragging in a bunch more people to the cc: and to: lines to have them
> look at this...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
