Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeFDL1c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751473AbeFDL1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:27:30 -0400
Date: Mon, 4 Jun 2018 13:27:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/29] 4.9.106-stable review
Message-ID: <20180604112706.GA16847@kroah.com>
References: <20180604065802.157744637@linuxfoundation.org>
 <a4a96a37-0958-ca4e-ea32-826a29db1476@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4a96a37-0958-ca4e-ea32-826a29db1476@roeck-us.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 03:15:23AM -0700, Guenter Roeck wrote:
> On 06/03/2018 11:57 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.106 release.
> > There are 29 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Jun  6 06:57:52 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Are you testing us ?
> 
> Building x86_64:tools/perf ... failed
> --------------
> Error log:
> make[4]: execvp: ./check-headers.sh: Permission denied
> make[4]: *** [sub-make] Error 127

Heh, no, I wasn't, but thanks for checking.

> Something went wrong with the patch creating the file. In the original
> commit it is created as 755, in the backport it is created as 644.

Ugh, quilt does not keep the permissions of files :(

I thought I had figured that out in the past, let me try to go remember
what I did before...

There's also a .sh file in the objtool directory that is not the proper
permissions as well...

greg k-h
