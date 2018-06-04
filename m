Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbeFDQQx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:16:53 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:50254 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbeFDQQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:16:51 -0400
Date: Mon, 4 Jun 2018 09:16:49 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/29] 4.9.106-stable review
Message-ID: <20180604161649.GA16269@roeck-us.net>
References: <20180604065802.157744637@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604065802.157744637@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 08:57:56AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.106 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jun  6 06:57:52 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.9.105-30-ge0f8632 (4.9.106-rc1-00030-ge0f8632):

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 139 pass: 137 fail: 2
Failed tests: 
	mips64:malta_defconfig:nosmp
	mips64:malta_defconfig:smp

Qemu tests fail with:

This architecture does not have kernel memory protection.
random: fast init done
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000a

---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000a

While tracking this down, I found commit 4e4636cf981b ("objtool: Enclose
contents of unreachable() macro in a block"), which says "... Guenter Roeck
reported a boot failure in mips64 ...". Go figure. Applying commit
4e4636cf981b on top of v4.9.106-rc1 indeed fixes the problem.

Guenter
