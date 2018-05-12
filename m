Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750846AbeELHLP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 03:11:15 -0400
Received: from mout.gmx.net ([212.227.17.22]:58025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750722AbeELHLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 03:11:14 -0400
Message-ID: <1526109060.20556.1.camel@gmx.de>
Subject: Re: [patch] swiotlb: fix ignored DMA_ATTR_NO_WARN request
From: Mike Galbraith <efault@gmx.de>
To: nouveau <nouveau@lists.freedesktop.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ben Skeggs <bskeggs@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Roger He <Hongbo.He@amd.com>, Christoph Hellwig <hch@lst.de>
Date: Sat, 12 May 2018 09:11:00 +0200
In-Reply-To: <1526051730.23162.3.camel@gmx.de>
References: <1525943427.8013.11.camel@gmx.de>
         <1525948096.29445.4.camel@gmx.de> <1526022830.6288.3.camel@gmx.de>
         <1526051730.23162.3.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0f1kBm5bcTJJsbovNrgsyH+WhydOxYMH6v45X9HAyFE8VnDjeQP
 6vXAge27xvkzbhAVVQV3i805sB0u20FDEBiQiKarV4mooxcu/vwyTgXbkD96xURcG+xXswi
 8cp/Vg21N5v0RpYBcDIKylfmxo6ypPuHLqFTL6F1kjUtavJQIZz8fIrFWNqQItfqWTcPZxt
 1xBjBQaLb6UeEQlK4GZTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8UBrpE7Zjts=:bT57bJNd+3rBa20vq/QUkX
 W1cHEEi2aMly78N7wR7La8Crj2pGCYkRImbP+siwAavFNbZbLTEbqRYp4+JHOEdCleoul0sSu
 u4e0mGTtFt7rb/nAWfKrqo5J9XmWc3nOMcwJoq45+TZUmP0IWPbQxwCQQMkcgArndncPFoI4X
 67Pt4E86u976kRaBQxvpJorcubzdLVu0SwbNu3p3GrfxhKJCpmv37oqBXl4WOYhikydaorpQ7
 /czs8NhGukKdMXRB92TpwfTwi25LGeQCTTPGgfSUZAn8YqGXrAjLLbSUnRwD9JbTu5+skd+3f
 RDm8MAsnDFx+MkkjSDkpdT8YK9H7i5vFBa/iw3MAWeAf4zQCSbCVfUql2V9tmArxxsz79OEoQ
 aWe6ceV1u0NZxHIepmHgSOkM5H6h7EXPu76zhBnJ+dAxHMnhDu2svknmBM2yX1UJNpDtndQre
 lqY3LCepQhe34JAtD80FGbfFiHmZMXDg92w/JVwoHVe1xx8yxnDVekl2o/AKyXNxMenGyWf4U
 usn7IKcSreYaKILdcHN0Xnxc6rUXPMZGds3+Bmy/58qw/9yqmM1Uolh1iubh371vQhKcsN67I
 hnBEBRLWYCQ2IjFkxVL/97ehsJou1sybkg2eHaL64SgCOSTd+D6zek2kxpBCZrg0m3pkP4Jmq
 21Xi+2fviluM3MU/qIt0U+ZTDsElo0p2h7DzAtuPwROc/NVtl7OqUHImCKxw5XuC79Mud7YPT
 xx0cFY937n58xpMHXMuxH/Ancdwm5jl65X6tQIOg6tSS5n29D+nwrYo+ygCp38upYpCkeTtti
 TjrZEab
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To conclude to this snail like thread (/me=walking wounded), with the
v4.16.8 hunk below, traces showing that swiotlb_alloc_coherent() was
being asked to not bother warning started showing up after the box had
been flogged for a while.

Whatever finally happens with swiotlb (seems to be in flux), other
folks meeting annoying gripeage can find bandaids in the interim.

The End

v4.16.8 !DMA_DIRECT_OPS
Xorg-3105  [001] ....  2156.711471: swiotlb_alloc_coherent+0xa7/0x1e0: yup
Xorg-3105  [001] ....  2156.711497: <stack trace>
 => ttm_dma_populate+0x23c/0x310 [ttm]
 => ttm_tt_bind+0x31/0x60 [ttm]
 => ttm_bo_handle_move_mem+0x527/0x580 [ttm]
 => ttm_bo_validate+0xfb/0x110 [ttm]
 => ttm_bo_init_reserved+0x289/0x450 [ttm]
 => ttm_bo_init+0x77/0xd0 [ttm]
 => nouveau_bo_new+0x3fc/0x5e0 [nouveau]
 => nouveau_gem_new+0x66/0x110 [nouveau]
 => nouveau_gem_ioctl_new+0x48/0xc0 [nouveau]
 => drm_ioctl_kernel+0x66/0xb0 [drm]
 => drm_ioctl+0x2a4/0x360 [drm]
 => nouveau_drm_ioctl+0x50/0xb0 [nouveau]
 => do_vfs_ioctl+0x92/0x5e0
 => SyS_ioctl+0x3b/0x70
 => do_syscall_64+0x74/0x1a0
 => entry_SYSCALL_64_after_hwframe+0x3d/0xa2

--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -28,10 +28,8 @@ void *x86_swiotlb_alloc_coherent(struct
 	 * swiotlb_alloc_coherent() will print a warning when the DMA
 	 * memory allocation ultimately failed.
 	 */
-	flags |= __GFP_NOWARN;
-
-	vaddr = dma_generic_alloc_coherent(hwdev, size, dma_handle, flags,
-					   attrs);
+	vaddr = dma_generic_alloc_coherent(hwdev, size, dma_handle,
+					   flags | __GFP_NOWARN, attrs);
 	if (vaddr)
 		return vaddr;
 
