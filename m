Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753297AbeCaOEl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 10:04:41 -0400
Received: from ozlabs.org ([103.22.144.67]:36439 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753198AbeCaOEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 10:04:16 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: bf8a1abc3ddbd6e9a8312ea7d96e5dd89c140f18
In-Reply-To: <20180329190543.25118-1-bauerman@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        =?utf-8?q?Michal_Such=C3=A1n?= =?utf-8?q?ek?= <msuchanek@suse.de>,
        Dave Young <dyoung@redhat.com>
Subject: Re: powerpc: kexec_file: Fix error code when trying to load kdump kernel
Message-Id: <40D0bL6Ncvz9s3v@ozlabs.org>
Date: Sun,  1 Apr 2018 01:04:14 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-29 at 19:05:43 UTC, Thiago Jung Bauermann wrote:
> kexec_file_load() on powerpc doesn't support kdump kernels yet, so it
> returns -ENOTSUPP in that case.
> 
> I've recently learned that this errno is internal to the kernel and isn't
> supposed to be exposed to userspace. Therefore, change to -EOPNOTSUPP which
> is defined in an uapi header.
> 
> This does indeed make kexec-tools happier. Before the patch, on ppc64le:
> 
>   # ~bauermann/src/kexec-tools/build/sbin/kexec -s -p /boot/vmlinuz
>   kexec_file_load failed: Unknown error 524
> 
> After the patch:
> 
>   # ~bauermann/src/kexec-tools/build/sbin/kexec -s -p /boot/vmlinuz
>   kexec_file_load failed: Operation not supported
> 
> Fixes: a0458284f062 ("powerpc: Add support code for kexec_file_load()")
> Reported-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Reviewed-by: Simon Horman <horms@verge.net.au>
> Reviewed-by: Dave Young <dyoung@redhat.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bf8a1abc3ddbd6e9a8312ea7d96e5d

cheers
