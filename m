Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753424AbeCFLFp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 06:05:45 -0500
Received: from ozlabs.org ([103.22.144.67]:59491 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750817AbeCFLFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 06:05:44 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com
Subject: Re: [PATCH v3] powerpc/kernel/sysfs: Export ldbar spr to sysfs
In-Reply-To: <1510232445-10869-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1510232445-10869-1-git-send-email-anju@linux.vnet.ibm.com>
Date: Tue, 06 Mar 2018 22:05:39 +1100
Message-ID: <878tb5foqk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index 4437c70..caefb64 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -757,6 +759,9 @@ static int register_cpu_online(unsigned int cpu)
>  			device_create_file(s, &pmc_attrs[i]);
>  
>  #ifdef CONFIG_PPC64
> +	if (cpu_has_feature(CPU_FTR_ARCH_300))
> +		device_create_file(s, &dev_attr_ldbar);

Is this register readable in supervisor state?

cheers
