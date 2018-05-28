Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934390AbeE1Vrc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 17:47:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:33653 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933771AbeE1Vra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 17:47:30 -0400
Date: Mon, 28 May 2018 14:30:39 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4.16 000/272] 4.16.13-stable review
Message-ID: <20180528213039.yy2madue67njkmw5@linux-n805>
References: <20180528100240.256525891@linuxfoundation.org>
 <CA+G9fYsS50-auAAe79hSGAQ8b1jzkfdcUvuHq0WpAJk17JQkEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+G9fYsS50-auAAe79hSGAQ8b1jzkfdcUvuHq0WpAJk17JQkEA@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2018, Naresh Kamboju wrote:

>On 28 May 2018 at 15:30, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>On all devices,
>  ltp-syscalls-tests:
>    * cve-2017-5669
>
>  ltp-cve-tests:
>    * cve-2017-5669
>
>Test log:
>------------
>cve-2017-5669.c:62: INFO: Attempting to attach shared memory to null page
>cve-2017-5669.c:74: INFO: Mapped shared memory to (nil)
>cve-2017-5669.c:78: FAIL: We have mapped a VM address within the first 64Kb
>cve-2017-5669.c:84: INFO: Touching shared memory to see if anything
>strange happens
>Summary:
>passed   0
>failed   1
>skipped  0
>warnings 0
>
>
>The root cause is,
>"Revert "ipc/shm: Fix shmat mmap nil-page protection"",
>which explicitly rolls back the original change and mentions that
>the LTP test case needs to be updated accordingly.

This is expected in that the ltp testcase was made based on wrong assumptions.
Furthermore, the reversion is being done because without it we breaks userspace;
X11 most noticeably -- that alone indicates that the cve testcase is bogus.

>
>This regression initially detected on 4.17.0-rc5-next-20180516
>Need more investigation on this issue.

The correct way of proceeding is to update the ltp testcase to deal with the
remap option only, which I mentioned and they are Cc'ed.

Thanks,
Davidlohr
