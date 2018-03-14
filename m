Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELvyrSTt04Bh8LfzXXPDBnRmjo/5MwtYXbIV/rckUBY7ULJxqx/DexSm1bcWWIUmkh+IWzOF
ARC-Seal: i=1; a=rsa-sha256; t=1520987981; cv=none;
        d=google.com; s=arc-20160816;
        b=bpbijBUvbGonuZ5qUd76+B2DeGvDKvu9BNhx4I9qdnWgb3gEuUTyEqVvLbRteHkKK0
         q4yT8CQahM3+hN74odRYBo60XnADMMAoTzvfEMYa6qtTvGmSORxJkky0AUnkCNFSU2xb
         x7ydoOyP7S6Xivl/gJDpJG4QDHQjesnwP74iuezP3qV74foMBh7S/9HHAwkqaO5QTIN1
         9RmE2AHe0hBUcpiP7oPgENumEhioBoQTsBdaDudCHUhWfAgWG7IWZBpL4LgUZjM2ysZW
         5g6ScNXKwKKUoATZEsHkEV/Cs/51o/jaxwOkpxUJDcExAaoOnOvslMYeQ+QELwy9srsg
         L9gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=pkgSpmqVaIVgvO++fYheloibAk7YUZgy0apPn+Vh2Zw=;
        b=TUAO2450c1dBVqkzZtvB7n90JSS3xrCFwaaVvumvaO51NHjnusemC2m0Fzcs0md9Rr
         yilfImn5lDu/q5OCyKGncX+Rby0UDcTqgw/T8FbVxp4vZbzVrqLrdOwOYbFJ8Ha5vyrD
         4y/ASz6NPt4xnNj9i84TsNzLaDLWgLoOD75ezoqRST8c1wUf0+0w4ttkO/TgFS0clAeG
         XYs2y7EXjRgcB+KO8Kco4VDDPoDbL99kbCzBcBiq9r2+3ZVXqxCReVgGvpl1Fz2CXWI9
         AS+/ZEELqebMdDIyMB7w1GsXh/FuFcaOHrwwXv7chKfPNRjhNKHhgsGa5Hxwgzy55r63
         y/IQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=FpyzkYDK;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=FpyzkYDK;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
MIME-Version: 1.0
In-Reply-To: <20180313234333.j3i43yxeawx5d67x@sasha-lappy>
References: <20180131210300.22963-1-pasha.tatashin@oracle.com>
 <20180131210300.22963-2-pasha.tatashin@oracle.com> <20180313234333.j3i43yxeawx5d67x@sasha-lappy>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 13 Mar 2018 20:38:57 -0400
X-Gmail-Original-Message-ID: <CAGM2reaPK=ZcLBOnmBiC2-u86DZC6ukOhL1xxZofB2OTW3ozoA@mail.gmail.com>
Message-ID: <CAGM2reaPK=ZcLBOnmBiC2-u86DZC6ukOhL1xxZofB2OTW3ozoA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: uninitialized struct page poisoning sanity checking
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
        "daniel.m.jordan@oracle.com" <daniel.m.jordan@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8831 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803140003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591143417186287050?=
X-GMAIL-MSGID: =?utf-8?q?1594871493176191391?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Sasha,

It seems the patch is doing the right thing, and it catches bugs. Here
we access uninitialized struct page. The question is why this happens?

register_mem_sect_under_node(struct memory_block *mem_blk, int nid)
   page_nid = get_nid_for_pfn(pfn);

node id is stored in page flags, and since struct page is poisoned,
and the pattern is recognized, the panic is triggered.

Do you have config file? Also, instructions how to reproduce it?

Thank you,
Pasha


On Tue, Mar 13, 2018 at 7:43 PM, Sasha Levin
<Alexander.Levin@microsoft.com> wrote:
> On Wed, Jan 31, 2018 at 04:02:59PM -0500, Pavel Tatashin wrote:
>>During boot we poison struct page memory in order to ensure that no one is
>>accessing this memory until the struct pages are initialized in
>>__init_single_page().
>>
>>This patch adds more scrutiny to this checking, by making sure that flags
>>do not equal to poison pattern when the are accessed. The pattern is all
>>ones.
>>
>>Since, node id is also stored in struct page, and may be accessed quiet
>>early we add the enforcement into page_to_nid() function as well.
>>
>>Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
>>---
>
> Hey Pasha,
>
> This patch is causing the following on boot:
>
> [    1.253732] BUG: unable to handle kernel paging request at fffffffffffffffe
> [    1.254000] PGD 2284e19067 P4D 2284e19067 PUD 2284e1b067 PMD 0
> [    1.254000] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
> [    1.254000] Modules linked in:
> [    1.254000] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc5-next-20180313 #10
> [    1.254000] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090007  06/02/2017
> [    1.254000] RIP: 0010:__dump_page (??:?)
> [    1.254000] RSP: 0000:ffff881c63c17810 EFLAGS: 00010246
> [    1.254000] RAX: dffffc0000000000 RBX: ffffea0084000000 RCX: 1ffff1038c782f2b
> [    1.254000] RDX: 1fffffffffffffff RSI: ffffffff9e160640 RDI: ffffea0084000000
> [    1.254000] RBP: ffff881c63c17c00 R08: ffff8840107e8880 R09: ffffed0802167a4d
> [    1.254000] R10: 0000000000000001 R11: ffffed0802167a4c R12: 1ffff1038c782f07
> [    1.254000] R13: ffffea0084000020 R14: fffffffffffffffe R15: ffff881c63c17bd8
> [    1.254000] FS:  0000000000000000(0000) GS:ffff881c6ac00000(0000) knlGS:0000000000000000
> [    1.254000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.254000] CR2: fffffffffffffffe CR3: 0000002284e16000 CR4: 00000000003406e0
> [    1.254000] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    1.254000] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    1.254000] Call Trace:
> [    1.254000] dump_page (/mm/debug.c:80)
> [    1.254000] get_nid_for_pfn (/./include/linux/mm.h:900 /drivers/base/node.c:396)
> [    1.254000] register_mem_sect_under_node (/drivers/base/node.c:438)
> [    1.254000] link_mem_sections (/drivers/base/node.c:517)
> [    1.254000] topology_init (/./include/linux/nodemask.h:271 /arch/x86/kernel/topology.c:164)
> [    1.254000] do_one_initcall (/init/main.c:835)
> [    1.254000] kernel_init_freeable (/init/main.c:901 /init/main.c:909 /init/main.c:927 /init/main.c:1076)
> [    1.254000] kernel_init (/init/main.c:1004)
> [    1.254000] ret_from_fork (/arch/x86/entry/entry_64.S:417)
> [ 1.254000] Code: ff a8 01 4c 0f 44 f3 4d 85 f6 0f 84 31 0e 00 00 4c 89 f2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 2d 11 00 00 <49> 83 3e ff 0f 84 a9 06 00 00 4d 8d b7 c0 fd ff ff 48 b8 00 00
> All code
> ========
>    0:   ff a8 01 4c 0f 44       ljmp   *0x440f4c01(%rax)
>    6:   f3 4d 85 f6             repz test %r14,%r14
>    a:   0f 84 31 0e 00 00       je     0xe41
>   10:   4c 89 f2                mov    %r14,%rdx
>   13:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
>   1a:   fc ff df
>   1d:   48 c1 ea 03             shr    $0x3,%rdx
>   21:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)
>   25:   0f 85 2d 11 00 00       jne    0x1158
>   2b:*  49 83 3e ff             cmpq   $0xffffffffffffffff,(%r14)               <-- trapping instruction
>   2f:   0f 84 a9 06 00 00       je     0x6de
>   35:   4d 8d b7 c0 fd ff ff    lea    -0x240(%r15),%r14
>   3c:   48                      rex.W
>   3d:   b8                      .byte 0xb8
>         ...
>
> Code starting with the faulting instruction
> ===========================================
>    0:   49 83 3e ff             cmpq   $0xffffffffffffffff,(%r14)
>    4:   0f 84 a9 06 00 00       je     0x6b3
>    a:   4d 8d b7 c0 fd ff ff    lea    -0x240(%r15),%r14
>   11:   48                      rex.W
>   12:   b8                      .byte 0xb8
>         ...
> [    1.254000] RIP: __dump_page+0x1c8/0x13c0 RSP: ffff881c63c17810 (/./include/asm-generic/sections.h:42)
> [    1.254000] CR2: fffffffffffffffe
> [    1.254000] ---[ end trace e643dfbc44b562ca ]---
>
> --
>
> Thanks,
> Sasha
