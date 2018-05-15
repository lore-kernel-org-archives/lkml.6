Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeEOIKv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:10:51 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:23956 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752421AbeEOIJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:09:35 -0400
X-IronPort-AV: E=Sophos;i="5.49,403,1520899200";
   d="scan'208";a="54652593"
Date: Tue, 15 May 2018 09:09:29 +0100
From: Wei Liu <wei.liu2@citrix.com>
To: Weiwei Jia <harrynjit@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        Weiwei Jia <harryxiyou@gmail.com>, <jianchen.shan@gmail.com>,
        <kvm@vger.kernel.org>, <dingxn@gmail.com>,
        Wei Liu <wei.liu2@citrix.com>
Subject: Re: [Xen-devel] [RFC][PATCH] KVM: APPLES can improve the performance
 of applications and virtualized systems by up to 49%
Message-ID: <20180515080929.rkqmmumjoxtlqctd@citrix.com>
References: <CA+scX6kYH8Y9_f1PLcMHG-MD9bhXgd4gGpkJanjzvwwj9L=aOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+scX6kYH8Y9_f1PLcMHG-MD9bhXgd4gGpkJanjzvwwj9L=aOQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2018 at 04:27:04PM +0800, Weiwei Jia wrote:
> Dear all,
> 
> Recently, we made a few improvements on effectively utilizing Pause
> Loop Exiting (PLE) support for higher throughput on virtualized
> systems. Basically, it solves two problems: 1) how to adjust
> PLE_Window; 2) how to select virtual CPUs to schedule on VM_EXITs
> caused by PLE. Our tests with standard benchmarks show that the
> approach can improve performance by up to 49%. The approach shows
> promising performance and is easy to implement. We think that it would
> be wonderful if Linux/KVM and XEN can consider the approach.
> 
> We already have a prototype implementation based on KVM (Linux Kernel
> 3.19.8). Our patch for Linux Kernel 3.19.8 and the paper describing
> our idea are available in Github repository [1][2][3]. We are pleased
> to revise our patch in order to merge it into Linux/KVM and XEN. We
> hope that you can test and adopt our approach/techniques. We are
> pleased to get some comments/suggestions on the approach and on how
> the idea can be adopted/tested by Linux/KVM and XEN. Thank you.
> 
> [1] APPLES paper: https://github.com/sysmen/apples/tree/master/paper
> [2] APPLES patch:
> https://github.com/sysmen/apples/blob/master/patches/3.19.8-APPLES.patch
> [3] APPLES patch README:
> https://github.com/sysmen/apples/blob/master/patches/README.txt
> 

Is PV spinlock involved in your test? There is no mention of it in your
paper.

Wei.

> Best Regards,
> Sysmen Research Group
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel
