Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA24C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C11621A38
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C11621A38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbeHIJ5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:57:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:33297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727371AbeHIJ5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:57:30 -0400
Received: from homer.simpson.net ([185.221.149.218]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Le69A-1gHCNz3EJ2-00pxcS; Thu, 09
 Aug 2018 09:33:31 +0200
Message-ID: <1533800010.5087.71.camel@gmx.de>
Subject: Re: [PATCH] x86, kdump: Fix efi=noruntime NULL pointer dereference
From:   Mike Galbraith <efault@gmx.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org
Date:   Thu, 09 Aug 2018 09:33:30 +0200
In-Reply-To: <20180809042153.GA4377@dhcp-128-65.nay.redhat.com>
References: <1533737025.4936.3.camel@gmx.de>
         <20180809042153.GA4377@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FSmBjftEw302nboHY0idqCmA4IVMNl6D4ZILbrG5Zxstm0yMX/X
 +N9ltjDtNfN8BXJaZPV3j9FiRCe84O0i1uw0JlqNM3khlBDtb7RL0TdoHgRQZ42vcf9s0gw
 Q9O3cxUnn9R1ZghSvyoMymiJM5ptJ3kFg7pvpMzmw3Ne5NV2PlLATEZVl/xeWgJ2f3pXA/T
 Z7xePfd1rYVn5wHsbasPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KZN4Er//DNY=:8aWCq/tEtvK9vRuihPTi4B
 VXKZVVejccB4/ml/6/wVTRQzFYd3PztURWWY43KTe2c7fd8UlcF1rXDTGpgmcD20YuLmpoSHU
 SxIGOQ0oz9Sa0VzZ6tl4Z8VjEfRJmSAGZvq4XxXxVcMldauPKquVEhz39p+4jrOCG1J322GJI
 vLymc6vXBr6+/t7vry34NtxJ7HhL5pK6H0nUzxYAdqVR/GzvwybkWiVM/Dh87tp09dxMwS2Mp
 axR8t7yteu8M2675aO+1dZbuwu5PP/4FnD+zmCMShafop0D+8ryOp/k4ARgWZ0yaEQjMPow3x
 rZiuMIYTF8GnB0M/AerVlK1rDkVj/gfJV/vdIG//Ju8+6Uq9qR+WyzxqcEBr3ZGFzXtXdA/+I
 6C+HmELjMeyuHtaRrxgroDsHQv9qgUEirfXLaWjoZ0hwYrH/fPUIpayFnzMJUHgS9KJyBSGoq
 LptAisphiIvEnKPrhYTzLy0R54JcwPsnknT8IP1NgfDehgM/0lzB3dbsbf3AqMKrBpwD8aq+2
 XY23LB15DFOKNTQTmToBi7RgJ//UH0bp5jGwXVovTm5vAMK3HTJhp+hxllahStjcPJPkJbuu6
 gP61UngKMeax6snKH6XqxKfOv7Hw3w2TteCN/wDhRO1KdqdA1lzRtxU3ubH0Vc73dsEs2Vf3x
 yeOCtitSdsLZmGZUYoIyBwSiyYddoF+wYS2a/9OvD33qOXJqhEXCM6czcN4K0wfEmALdnJiuw
 g/Kq3xGTORLYu4mxOg8q7OQYpuRtfzYZEw/G8OIoU7p8xEX2WaVGzshSKGWz7PgGnpmo2oMvT
 E1ChKdT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-09 at 12:21 +0800, Dave Young wrote:
> Hi Mike,
> 
> Thanks for the patch!
> On 08/08/18 at 04:03pm, Mike Galbraith wrote:
> > When booting with efi=noruntime, we call efi_runtime_map_copy() while
> > loading the kdump kernel, and trip over a NULL efi.memmap.map.  Avoid
> > that and a useless allocation when the only mapping we can use (1:1)
> > is not available.
> 
> At first glance, efi_get_runtime_map_size should return 0 in case
> noruntime.

What efi does internally at unmap time is to leave everything except
efi.mmap.map untouched, setting it to NULL and turning off EFI_MEMMAP,
rendering efi.mmap.map accessors useless/unsafe without first checking
EFI_MEMMAP.

	-Mike
