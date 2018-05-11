Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeEKGpz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 02:45:55 -0400
Received: from ozlabs.org ([203.11.71.1]:41979 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751352AbeEKGpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 02:45:54 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH  11/17] powerpc/nohash32: set GUARDED attribute in the PMD directly
In-Reply-To: <4e87c5bd5ffe886ca202a58e5c93358bd6a34dce.1525435203.git.christophe.leroy@c-s.fr>
References: <cover.1525435203.git.christophe.leroy@c-s.fr> <4e87c5bd5ffe886ca202a58e5c93358bd6a34dce.1525435203.git.christophe.leroy@c-s.fr>
Date: Fri, 11 May 2018 16:45:52 +1000
Message-ID: <87vabur8pr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
> index 59be5dfcb3e9..b8c347077e02 100644
> --- a/arch/powerpc/mm/ioremap.c
> +++ b/arch/powerpc/mm/ioremap.c
> @@ -132,9 +132,14 @@ void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
>  	if (slab_is_available()) {
>  		struct vm_struct *area;
>  
> -		area = __get_vm_area_caller(size, VM_IOREMAP,
> -					    ioremap_bot, IOREMAP_END,
> -					    caller);
> +		if (flags & _PAGE_GUARDED)

On 64-bit configs:

  arch/powerpc/mm/ioremap.c:135:15: error: '_PAGE_GUARDED' undeclared (first use in this function)

cheers
