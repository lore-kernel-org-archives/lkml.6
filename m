Return-Path: <jb@essential.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523264738; cv=none;
        d=google.com; s=arc-20160816;
        b=f6s2QwDQzlxmt8I0R6Swt7SCoEcOpuiwGGvhdxj8SRtH62Vr605lDl2CBJwIfJh9hc
         3cFAZCPeM6K3Z5ksrWySoQzSw4AuyujBBS7OfiNXnV/Xadbyca87o180DlMDE+Q3Tw1g
         cbNstyRO6rJObkaZNGy6K9Qr+eLLF0COUC1wvD2IrsUXDDFZN/0avYVG+69JgxxJBVKM
         hjNgAuM0Z63UyCZDNJWlaKpgu4bdwZgBV/Q2Vd09exlZqvpjokXrOB1LuwtdBPsDPRgD
         WjK3yvjVOH2WrLY6b5Ive1jZrR2oMIUIwMKI83HBea4bi3rqMVM4+NAThpUaGA5oiBcF
         MXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:reply-to:message-id:subject
         :cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=Qh9ikWapoKoK7MzRZsKzdOhUQWfTGzdxcc18V9kX1G0=;
        b=YZ7T5neKLSOizlYyjRkTroAL98yHc/UbFZ3WZcbuMYxNcBVC5H64egudPquV5Q2wR2
         cKkVTApcEXDpC+0fZvW8Lt5rxowU65QT0THeHAzXw/dM8tt4MROvxbsO9k3h9koWN2ph
         5E61rDN8urejnBYIN9w0GtYb5yCdgeerpULFkC7GTj+/z65HOhxozxbGqMexlxH6U3Zm
         IDpf4vOHjtU+3p2QT933j/idoksheH7YEVqXeBX009HfZdXZGPrf0/4LNbL54eqWFSxb
         YJSvW0NDTCj0lr/pS4zH/bC39Qk2QpdvwyCWy9alYRWNIHkfwwF0P/wEkyG57TLvEMkH
         k5WQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@essential-com.20150623.gappssmtp.com header.s=20150623 header.b=dxor5aA2;
       spf=pass (google.com: domain of jb@essential.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jb@essential.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@essential-com.20150623.gappssmtp.com header.s=20150623 header.b=dxor5aA2;
       spf=pass (google.com: domain of jb@essential.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jb@essential.com
X-Google-Smtp-Source: AIpwx4+dFvnT3wHxLLqVDcBJf3gTzxUAOxeIHy5hsjn0X9KPhQExqM3iUqjM+UWpOaWutxKCzPqvmQ==
Date: Mon, 9 Apr 2018 18:05:34 +0900
From: Jean-Baptiste Theou <jb@essential.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, will.deacon@arm.com, dan.rue@linaro.org
Subject: Linux 4.9.93
Message-Id: <20180409180534.1768583293d0abe207168c5a@essential.com>
Reply-To: 20180408150840.GA16019@kroah.com
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597258846269332204?=
X-GMAIL-MSGID: =?utf-8?q?1597258846269332204?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

After this patchset, a kernel built with CFI fails. Disabling UNMAP_KERNEL_AT_EL0 fix the issue obviously.

Wondering if there is one of the test suite used on the review patchset that covers the CFI usecase.

Best regards,

[    0.249191] CPU features: detected feature: GIC system register CPU interface
[    0.256391] CPU features: detected feature: Privileged Access Never
[    0.262719] CPU features: detected feature: User Access Override
[    0.268791] CPU features: detected feature: 32-bit EL0 Support
[    0.274683] CPU features: detected feature: Kernel page table isolation (KPTI)
[    0.282166] CFI failure:
[    0.282169] CFI failure:
[    0.282172] CFI failure:
[    0.282173] CFI failure:
[    0.282175] CFI failure:
[    0.282176] CFI failure:
[    0.282177] CFI failure:
[    0.282178] CFI failure:
[    0.282188] ------------[ cut here ]------------
[    0.282189] ------------[ cut here ]------------
[    0.282190] ------------[ cut here ]------------
[    0.282191] ------------[ cut here ]------------
[    0.282193] ------------[ cut here ]------------
[    0.282196] kernel BUG at kernel/cfi.c:32!
[    0.282198] ------------[ cut here ]------------
[    0.282201] kernel BUG at kernel/cfi.c:32!
[    0.282202] ------------[ cut here ]------------
[    0.282204] kernel BUG at kernel/cfi.c:32!
[    0.282207] kernel BUG at kernel/cfi.c:32!
[    0.282209] kernel BUG at kernel/cfi.c:32!
[    0.282211] kernel BUG at kernel/cfi.c:32!
[    0.282214] kernel BUG at kernel/cfi.c:32!
[    0.282215] ------------[ cut here ]------------
[    0.282216] kernel BUG at kernel/cfi.c:32!
[    0.282218] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[    0.282224] Modules linked in:
[    0.282230] CPU: 2 PID: 25 Comm: migration/2 Not tainted 4.9.93-perf+ #39
[    0.282232] Hardware name: <REMOVED>
[    0.282235] task: fffffffbb3b36580 task.stack: fffffffbb30cc000
[    0.282250] PC is at __cfi_check_fail+0x14/0x1c
[    0.282253] LR is at __cfi_check_fail+0x14/0x1c
[    0.282255] pc : [<ffffff93b3f03d90>] lr : [<ffffff93b3f03d90>] pstate: 60c00085
[    0.282256] sp : fffffffbb30cfc30
[    0.282259] x29: fffffffbb30cfc30 x28: ffffff93b6415000 
[    0.282261] x27: 00000013b65c1000 x26: ffffff93b5ce6000 
[    0.282264] x25: ffffff93b5ce6000 x24: ffffff93b6419000 
[    0.282266] x23: ffffff93b65c1000 x22: ffffff93b65c4000 
[    0.282268] x21: 9d12f8172cb2f296 x20: 000000008180e3e0 
[    0.282271] x19: 0000000000000000 x18: 000000000000002c 
[    0.282274] x17: 00000000000fd054 x16: 0000000000000000 
[    0.282276] x15: ffffff93b65ec000 x14: 000000000000000c 
[    0.282279] x13: 0000000000000004 x12: 0000000000000000 
[    0.282281] x11: 0000000000000000 x10: 0000000001440144 
[    0.282283] x9 : 260822e8751d5000 x8 : 260822e8751d5000 
[    0.282286] x7 : 0000000000000000 x6 : fffffffbbac75b60 
[    0.282288] x5 : 0000000000000000 x4 : 0000000000000000 
[    0.282290] x3 : 000000003a657275 x2 : 0000000000000000 
[    0.282292] x1 : 0000000000000000 x0 : 000000000000000c 
[    0.282294] 
[    0.282294] PC: 0xffffff93b3f03d50:
[    0.282308] 3d50  b9001ac8 f94002c8 370ffec8 17ffffbe d4210000 14000000 aa1603e0 f90007e8
[    0.282315] 3d70  94536017 f94007e8 17ffffe2 a9bf7bfd 910003fd d000d100 913ee400 94533cc7
[    0.282322] 3d90  d4210000 14000000 b0013788 2a1f03e0 f901c51f d65f03c0 f940406b 2a0203e8
[    0.282329] 3db0  2a0103e9 aa0003ea b400008b f9000145 f94000cb b40001ab a9bf7bfd 910003fd
[    0.282330] 
[    0.282330] LR: 0xffffff93b3f03d50:
[    0.282336] 3d50  b9001ac8 f94002c8 370ffec8 17ffffbe d4210000 14000000 aa1603e0 f90007e8
[    0.282343] 3d70  94536017 f94007e8 17ffffe2 a9bf7bfd 910003fd d000d100 913ee400 94533cc7
[    0.282350] 3d90  d4210000 14000000 b0013788 2a1f03e0 f901c51f d65f03c0 f940406b 2a0203e8
[    0.282357] 3db0  2a0103e9 aa0003ea b400008b f9000145 f94000cb b40001ab a9bf7bfd 910003fd
[    0.282358] 
[    0.282358] SP: 0xfffffffbb30cfbf0:
[    0.282365] fbf0  b3f03d90 ffffff93 b30cfc30 fffffffb b3f03d90 ffffff93 60c00085 00000000
[    0.282372] fc10  b6415000 ffffff93 b642fa00 ffffff93 ffffffff ffffffff b3f03d90 ffffff93
[    0.282378] fc30  b30cfc70 fffffffb b3d458c0 ffffff93 00000080 00000000 00000001 00000000
[    0.282385] fc50  b65c4000 ffffff93 b64420f0 ffffff93 8180e3e0 00000000 00000002 00000000
[    0.282387] Process migration/2 (pid: 25, stack limit = 0xfffffffbb30cc000)
[    0.282389] Call trace:
[    0.282391] Exception stack(0xfffffffbb30cfb00 to 0xfffffffbb30cfc30)
[    0.282395] fb00: 000000000000000c 0000000000000000 0000000000000000 000000003a657275
[    0.282397] fb20: 0000000000000000 0000000000000000 fffffffbbac75b60 0000000000000000
[    0.282400] fb40: 260822e8751d5000 260822e8751d5000 0000000001440144 0000000000000000
[    0.282403] fb60: 0000000000000000 0000000000000004 000000000000000c ffffff93b65ec000
[    0.282405] fb80: 0000000000000000 00000000000fd054 000000000000002c 0000000000000000
[    0.282408] fba0: 000000008180e3e0 9d12f8172cb2f296 ffffff93b65c4000 ffffff93b65c1000
[    0.282411] fbc0: ffffff93b6419000 ffffff93b5ce6000 ffffff93b5ce6000 00000013b65c1000
[    0.282413] fbe0: ffffff93b6415000 fffffffbb30cfc30 ffffff93b3f03d90 fffffffbb30cfc30
[    0.282416] fc00: ffffff93b3f03d90 0000000060c00085 ffffff93b6415000 ffffff93b642fa00
[    0.282418] fc20: ffffffffffffffff ffffff93b3f03d90
[    0.282421] [<ffffff93b3f03d90>] __cfi_check_fail+0x14/0x1c
[    0.282430] [<ffffff93b3d458c0>] name_to_dev_t+0x0/0x47c
[    0.282436] [<ffffff93b3d51b80>] kpti_install_ng_mappings+0x178/0x2e0
[    0.282443] [<ffffff93b3eae950>] multi_cpu_stop+0x114/0x170
[    0.282445] [<ffffff93b3eaf08c>] cpu_stopper_thread+0x128/0x2e8
[    0.282452] [<ffffff93b3db5504>] smpboot_thread_fn+0x230/0x558
[    0.282455] [<ffffff93b3dae848>] kthread+0x21c/0x238
[    0.282459] [<ffffff93b3c838f0>] ret_from_fork+0x10/0x20
[    0.282464] Code: 910003fd d000d100 913ee400 94533cc7 (d4210000) 
