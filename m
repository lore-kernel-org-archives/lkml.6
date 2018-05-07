Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeEGPNO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 11:13:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39886 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752548AbeEGPMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 11:12:50 -0400
Subject: Re: [PATCH 1/1] x86/xen: Reset VCPU0 info pointer after shared_info
 remap
To: "van der Linden, Frank" <fllinden@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "jgross@suse.com" <jgross@suse.com>
References: <C508E5F5-024E-4F71-A91E-7BB0BE046F5D@amazon.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <965354d1-e2e7-1764-a14e-bb4258b9ed13@oracle.com>
Date: Mon, 7 May 2018 11:15:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <C508E5F5-024E-4F71-A91E-7BB0BE046F5D@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8886 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805070154
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2018 04:11 PM, van der Linden, Frank wrote:
> This patch fixes crashes during boot for HVM guests on older (pre HVM
> vector callback) Xen versions. Without this, current kernels will always
> fail to boot on those Xen versions.
>
> Sample stack trace:
>
>    BUG: unable to handle kernel paging request at ffffffffff200000
>    IP: __xen_evtchn_do_upcall+0x1e/0x80
>    PGD 1e0e067 P4D 1e0e067 PUD 1e10067 PMD 235c067 PTE 0
>     Oops: 0002 [#1] SMP PTI
>    Modules linked in:
>    CPU: 0 PID: 512 Comm: kworker/u2:0 Not tainted 4.14.33-52.13.amzn1.x86_64 #1
>    Hardware name: Xen HVM domU, BIOS 3.4.3.amazon 11/11/2016
>    task: ffff88002531d700 task.stack: ffffc90000480000
>    RIP: 0010:__xen_evtchn_do_upcall+0x1e/0x80
>    RSP: 0000:ffff880025403ef0 EFLAGS: 00010046
>    RAX: ffffffff813cc760 RBX: ffffffffff200000 RCX: ffffc90000483ef0
>    RDX: ffff880020540a00 RSI: ffff880023c78000 RDI: 000000000000001c
>    RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
>    R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>    R13: ffff880025403f5c R14: 0000000000000000 R15: 0000000000000000
>    FS:  0000000000000000(0000) GS:ffff880025400000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: ffffffffff200000 CR3: 0000000001e0a000 CR4: 00000000000006f0
>     Call Trace:
>    <IRQ>
>    do_hvm_evtchn_intr+0xa/0x10
>    __handle_irq_event_percpu+0x43/0x1a0
>    handle_irq_event_percpu+0x20/0x50
>    handle_irq_event+0x39/0x60
>    handle_fasteoi_irq+0x80/0x140
>    handle_irq+0xaf/0x120
>    do_IRQ+0x41/0xd0
>    common_interrupt+0x7d/0x7d
>    </IRQ>
>
> During boot, the HYPERVISOR_shared_info page gets remapped to make it work
> with KASLR. This means that any pointer derived from it needs to be
> adjusted.
>
> The only value that this applies to is the vcpu_info pointer for VCPU 0.
> For PV and HVM with the callback vector feature, this gets done via the
> smp_ops prepare_boot_cpu callback. Older Xen versions do not support the
> HVM callback vector, so there is no Xen-specific smp_ops set up in that
> scenario. So, the vcpu_info pointer for VCPU 0 never gets set to the proper
> value, and the first reference of it will be bad. Fix this by resetting it
> immediately after the remap.
>
> Signed-off-by: Frank van der Linden <fllinden@amazon.com>
> Reviewed-by: Eduardo Valentin <eduval@amazon.com>
> Reviewed-by: Alakesh Haloi <alakeshh@amazon.com>
> Reviewed-by: Vallish Vaidyeshwara <vallish@amazon.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: xen-devel@lists.xenproject.org
> ---
>  arch/x86/xen/enlighten_hvm.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
> index 6b424da1ce75..c78b3e8fb2e5 100644
> --- a/arch/x86/xen/enlighten_hvm.c
> +++ b/arch/x86/xen/enlighten_hvm.c
> @@ -71,6 +71,19 @@ static void __init xen_hvm_init_mem_mapping(void)
>  {
>  	early_memunmap(HYPERVISOR_shared_info, PAGE_SIZE);
>  	HYPERVISOR_shared_info = __va(PFN_PHYS(shared_info_pfn));
> +
> +	/*
> +	 * The virtual address of the shared_info page has changed, so
> +	 * the vcpu_info pointer for VCPU 0 is now stale.

Is it "has changed" or "has changed if kaslr is on"?

> +	 *
> +	 * The prepare_boot_cpu callback will re-initialize it via
> +	 * xen_vcpu_setup, but we can't rely on that to be called for
> +	 * old Xen versions (xen_have_vector_callback == 0).
> +	 *
> +	 * It is, in any case, bad to have a stale vcpu_info pointer
> +	 * so reset it now.
> +	 */
> +	xen_vcpu_info_reset(0);


Why not xen_vcpu_setup(0)?

-boris
