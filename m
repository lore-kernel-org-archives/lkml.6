Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753546AbeCQRVV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 13:21:21 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:35086 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752772AbeCQRVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 13:21:11 -0400
Date: Sat, 17 Mar 2018 17:44:07 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, luto@kernel.org, mingo@kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de
Subject: Re: [PATCH v2 02/36] kernel: use kernel_wait4() instead of
 sys_wait4()
Message-ID: <20180317164407.GB1619@light.dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
 <20180315190529.20943-3-linux@dominikbrodowski.net>
 <20180316165831.GV4449@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316165831.GV4449@wotan.suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 04:58:31PM +0000, Luis R. Rodriguez wrote:
> On Thu, Mar 15, 2018 at 08:04:55PM +0100, Dominik Brodowski wrote:
> > diff --git a/kernel/umh.c b/kernel/umh.c
> > index 18e5fa4b0e71..f4b557cadf08 100644
> > --- a/kernel/umh.c
> > +++ b/kernel/umh.c
> > @@ -135,7 +135,7 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
> >  		 *
> >  		 * Thus the __user pointer cast is valid here.
> >  		 */
> > -		sys_wait4(pid, (int __user *)&ret, 0, NULL);
> > +		kernel_wait4(pid, (int __user *)&ret, 0, NULL);
> >  
> >  		/*
> >  		 * If ret is 0, either call_usermodehelper_exec_async failed and
> 
> There is also a reference to sys_wait4() usage on umh.c:
> 
>         /* If SIGCLD is ignored sys_wait4 won't populate the status. */         
>         kernel_sigaction(SIGCHLD, SIG_DFL);     
> 
> Does that remain true for kernel_wait4()? If so that comment should be updated
> as well.

Thanks, have updated the comment.

	Dominik
