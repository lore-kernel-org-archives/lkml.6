Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0669C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3AD820878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3AD820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbeLFSFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:05:06 -0500
Received: from mout.gmx.net ([212.227.15.15]:44903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbeLFSFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:05:06 -0500
Received: from dhcp-41-57.bos.redhat.com ([66.187.233.206]) by mail.gmx.com
 (mrgmx001 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0MLvGW-1gYHwI0GWS-007n1o; Thu, 06 Dec 2018 19:05:02 +0100
Message-ID: <1544119499.12945.48.camel@gmx.us>
Subject: Re: [RESEND PATCH] efi: let kmemleak ignore false positives
From:   Qian Cai <cai@gmx.us>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 06 Dec 2018 13:04:59 -0500
In-Reply-To: <CAKv+Gu97MU5kU878gF=KBLxQ5GjZatAbJ-LVdKv-QMgdPh3kZQ@mail.gmail.com>
References: <1543517152-23969-1-git-send-email-cai@gmx.us>
         <20181206161633.36292-1-cai@gmx.us>
         <20181206175958.GS54495@arrakis.emea.arm.com>
         <CAKv+Gu97MU5kU878gF=KBLxQ5GjZatAbJ-LVdKv-QMgdPh3kZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7VKPPBiG3CdBXBSn1uAA4wiJnNVhLlXhWNMll1RJziBSbNu5sa3
 SkDrNjIV3/8BRg2GbN/n3KbzZiKfE6GPRZvMNT/uq3p2F8iZ0ZAStdDx8s1h8QGbAz0LA4q
 uMa6VXIBo8TqZGAENJkQFBbTf0uYFJQ9Xu0OW2vt+MzAobbRxo+/P7VXJ3svHDQ1S8sZcj3
 ZAdywapQE+OURxdgV23nw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Air/+UXhmig=:WZyPYsTAYO0NyUZ0qpPo26
 7iwtge4Qajfoyi/yJ2X0iqx0zA/BEyMR9x/hAR0Jmuia8k4wPTb/PFYFg1sucr6mcrSXSySD8
 L2OfIQmpgvYhCrWZ6hfIN78dayw0OgDibTwhj+qNWzEU8UtidZE/0TeqUbw77f//+yqxekD22
 G2JpSsqu/wv8e6PzfVX24DYUNiQ1KPhgEsRV7IbjsRSy47KlhfPc66eFujMEsfA08ma+d3qIC
 T0k3shucWAIw0Y00POOftEDdRjO5EEUJbSxxPtHbxdMOWPkQftyFaPpZGUngo5D7GFlXpRYbc
 DmSLe+ih3Tg3J5xQIeU4sOWNTRtOX5QIr3r1dGzU1lmVR15ZuOse5gxNqWaWnzDsNdhseMCi9
 V1/mCd1Rw2Sux1ssrwKDQNc/8GLh2k6UCjJM59F2ORhGmUAaI6E7nXI8TSJr7A1BtQm9/FQOb
 OokbAjVVvloVpDZjcnJEt8/+KjJp0QA6IXYsf8eH2NXXxeQvPvV1bYwIddY+7S1XeZQMIagfU
 7xdjarHCExJVqa42rBB2bdI5OOgxsYMDvMYkVFT0c/YaBULxUSFGgCZ+Yi9ch539txH65u7vO
 kc7J9S+Q8zUWEEq3jjHOz3qmqsP7Sx73l2iGrG8dEgatOIMjKoKM0O2pQ9UXoHEwQeEMt230M
 BSTEqt6fy5oaaptPJ/dA4Kg9z4hcBntgIwNjRiCbcgrsf/DN3D3y4aHt+IKiL6SLy8tJUzYcf
 gf6vIwcdzpgZm/tNAkA1FuYdaBcj79y9ZkwKUpN6rvDVX68/iN7jvIkanI+km/padO3sCjp+9
 SoZrNohoq6XKf7x6GmYXllillQfZ92IT5HrZ1HrgEvPVgOWsb7Atf3KvfkyNMw0hC3Z4esvVK
 TrbqJmJZGw8I2HqG0nAw1ZoDnUT75mQRo+4qjji71oOdoJ5NGiZCwQj9ZCBkja
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-06 at 19:01 +0100, Ard Biesheuvel wrote:
> On Thu, 6 Dec 2018 at 19:00, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > 
> > On Thu, Dec 06, 2018 at 11:16:33AM -0500, Qian Cai wrote:
> > > unreferenced object 0xffff8096c1acf580 (size 128):
> > >   comm "swapper/63", pid 0, jiffies 4294937418 (age 1201.230s)
> > >   hex dump (first 32 bytes):
> > >     80 87 b5 c1 96 00 00 00 00 00 cc c2 16 00 00 00  ................
> > >     00 00 01 00 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b  ........kkkkkkkk
> > >   backtrace:
> > >     [<000000001d2549ba>] kmem_cache_alloc_trace+0x430/0x500
> > >     [<0000000093a6dfab>] efi_mem_reserve_persistent+0x50/0xf8
> > >     [<000000000a730828>] its_cpu_init_lpis+0x394/0x4b8
> > >     [<00000000edf04e07>] its_cpu_init+0x104/0x150
> > >     [<000000004d0342c5>] gic_starting_cpu+0x34/0x40
> > >     [<000000005d9da772>] cpuhp_invoke_callback+0x228/0x1d68
> > >     [<0000000061eace9b>] notify_cpu_starting+0xc0/0x118
> > >     [<0000000048bc2dc5>] secondary_start_kernel+0x23c/0x3b0
> > >     [<0000000015137d6a>] 0xffffffffffffffff
> > > 
> > > efi_mem_reserve_persistent+0x50/0xf8:
> > > kmalloc at include/linux/slab.h:546
> > > (inlined by) efi_mem_reserve_persistent at drivers/firmware/efi/efi.c:979
> > > 
> > > This line,
> > > 
> > > rsv = kmalloc(sizeof(*rsv), GFP_ATOMIC);
> > > 
> > > Kmemleak has a known limitation that can only track pointers in the kernel
> > > virtual space. Hence, it will report false positives due to "rsv" will
> > > only
> > > reference to other physical addresses,
> > > 
> > > rsv->next = efi_memreserve_root->next;
> > > efi_memreserve_root->next = __pa(rsv);
> > > 
> > > Signed-off-by: Qian Cai <cai@gmx.us>
> > 
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>\
> 
> I don't see the patch and I wasn't cc'ed

That is strange. Please see,

https://lore.kernel.org/lkml/1543517152-23969-1-git-send-email-cai@gmx.us/
