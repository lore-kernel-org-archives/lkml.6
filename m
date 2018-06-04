Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeFDQ7p (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751582AbeFDQ6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:58:50 -0400
Date: Mon, 4 Jun 2018 18:58:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/29] 4.9.106-stable review
Message-ID: <20180604165825.GB2004@kroah.com>
References: <20180604065802.157744637@linuxfoundation.org>
 <20180604161649.GA16269@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604161649.GA16269@roeck-us.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 09:16:49AM -0700, Guenter Roeck wrote:
> On Mon, Jun 04, 2018 at 08:57:56AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.106 release.
> > There are 29 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Jun  6 06:57:52 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> For v4.9.105-30-ge0f8632 (4.9.106-rc1-00030-ge0f8632):
> 
> Build results:
> 	total: 148 pass: 148 fail: 0
> Qemu test results:
> 	total: 139 pass: 137 fail: 2
> Failed tests: 
> 	mips64:malta_defconfig:nosmp
> 	mips64:malta_defconfig:smp
> 
> Qemu tests fail with:
> 
> This architecture does not have kernel memory protection.
> random: fast init done
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000a
> 
> ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000a
> 
> While tracking this down, I found commit 4e4636cf981b ("objtool: Enclose
> contents of unreachable() macro in a block"), which says "... Guenter Roeck
> reported a boot failure in mips64 ...". Go figure. Applying commit
> 4e4636cf981b on top of v4.9.106-rc1 indeed fixes the problem.

Thanks, I'll go queue that up now.

greg k-h
