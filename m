Return-Path: <niveditas98@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517618337; cv=none;
        d=google.com; s=arc-20160816;
        b=ZiPbVi8xKVpmB7SChsJU70CKxZZA2NbD9YHho8eJuYIcYhuyIsdPeRwkSLAhigY9Jw
         Jk5t7ZfjBnbdRmJ5bj8qqSnxrI5yrM7UmLWPk7sC0udsQyFbxV5jC8vrdpqI7EzdUPsH
         75OlGpffRr2rQ60MTosIAksIUwQ7lwXZdwzOMar9rwaLlZQEuSxAjn1X85yVX1AWdfJ5
         dainw6ikc5tSwsnCptKF1BP8zxEZqDCXHgtcZt/HI5apRboGmYWAdIgr6sBc8uD5XwS/
         a8GiKHrebgLLbEDd/v34t94wA7/4vAH98MjUXqWDwh44kZUtFet9TKb99hor8McUUWPn
         Zu1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=dPZ+G9ofmSnfLrS0kTNjWbHSBdzfQ2EIC7v4uIegrbo=;
        b=lozfcLNlw19zOZUWa8wH/4p8dEQ7Cn5bMqzk9iL+v2TurMxE2tZCqL/6wAlHcXAHoF
         /hzmZPSE/a7QhqsR9rUT2qDzTi7Zjk9ZCmFhm5Mz8D2AwDwhi9dVJ1TF6ILS/OQ1rYdF
         exNwPuYkg2pOXN95Vgiq0pTq0cB8EkvJz4LW/wYYC33Zfb5eJHoDRdbs+8NmnvLNBydY
         QPPbb0cWDeIn3agnRtjicbJqo7PevuGgEkKUSmFbyoa5BJofNAmwNTYR1VKYee+FoYme
         WhLdBWmxBw8tLpeqEjqgcfAxh1dlUBUFhLBk3pfiV7ZE1RkNhYFU6+8rejnvKu+JHFrn
         c6pg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of niveditas98@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=niveditas98@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of niveditas98@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=niveditas98@gmail.com
X-Google-Smtp-Source: AH8x226qQZxr1a54I4G6e3a/fxmoP8GYEVnTM1YR2U/1TMDdqa7SsvSTr30NuFUb9q/hOLlpKuhhNQ==
Date: Fri, 2 Feb 2018 19:38:51 -0500
From: Arvind Sankar <nivedita@alum.mit.edu>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] tools: libsubcmd: Drop the less hack that was inherited
 from Git.
Message-ID: <20180203003850.GA62570@rani.riverdale>
References: <20180124003831.GA34667@rani.riverdale>
 <20180124205411.lpzcpqnuw3nlyg4n@treble>
 <20180125081652.GA23548@kernel.org>
 <20180125132425.GA27283@rani.riverdale>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180125132425.GA27283@rani.riverdale>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590432180841544172?=
X-GMAIL-MSGID: =?utf-8?q?1591338165323639888?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi, it looks like Sergey has put in a patch to fix the aliasing, looking
at the linux-next tree.

Are we still looking to remove this hack altogether?

Thanks

On Thu, Jan 25, 2018 at 08:24:26AM -0500, Arvind Sankar wrote:
> Thanks.
> 
> This was found because gcc 8 appears to be enabling -Wrestrict in -Wall,
> so there is a build failure with mainline gcc.
> 
> On Thu, Jan 25, 2018 at 05:16:52AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Jan 24, 2018 at 02:54:11PM -0600, Josh Poimboeuf escreveu:
> > > On Tue, Jan 23, 2018 at 07:38:37PM -0500, Arvind Sankar wrote:
> > > > We inherited this hack with the original code from the Git project. The
> > > > select call is invalid as the two fd_set pointers should not be aliased.
> > > > 
> > > > We could fix it, but the Git project removed this hack in 2012 in commit
> > > > e8320f3 (pager: drop "wait for output to run less" hack). The bug it
> > > > worked around was apparently fixed in less back in June 2007.
> > > > 
> > > > So remove the hack from here as well.
> > > > 
> > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > 
> > > Looks good to me.
> > > 
> > >   Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > 
> > > Libsubcmd is used by perf and objtool, so adding the perf maintainers to
> > > CC.  Arnaldo, do you want to pick this one up?
> > 
> > Sure, I'll put it in my perf/core branch.
> > 
> > - Arnaldo
> >  
> > > > ---
> > > >  tools/lib/subcmd/pager.c       | 17 -----------------
> > > >  tools/lib/subcmd/run-command.c |  2 --
> > > >  tools/lib/subcmd/run-command.h |  1 -
> > > >  3 files changed, 20 deletions(-)
> > > > 
> > > > diff --git a/tools/lib/subcmd/pager.c b/tools/lib/subcmd/pager.c
> > > > index 5ba754d17952..94d61d9b511f 100644
> > > > --- a/tools/lib/subcmd/pager.c
> > > > +++ b/tools/lib/subcmd/pager.c
> > > > @@ -1,5 +1,4 @@
> > > >  // SPDX-License-Identifier: GPL-2.0
> > > > -#include <sys/select.h>
> > > >  #include <stdlib.h>
> > > >  #include <stdio.h>
> > > >  #include <string.h>
> > > > @@ -23,21 +22,6 @@ void pager_init(const char *pager_env)
> > > >  	subcmd_config.pager_env = pager_env;
> > > >  }
> > > >  
> > > > -static void pager_preexec(void)
> > > > -{
> > > > -	/*
> > > > -	 * Work around bug in "less" by not starting it until we
> > > > -	 * have real input
> > > > -	 */
> > > > -	fd_set in;
> > > > -
> > > > -	FD_ZERO(&in);
> > > > -	FD_SET(0, &in);
> > > > -	select(1, &in, NULL, &in, NULL);
> > > > -
> > > > -	setenv("LESS", "FRSX", 0);
> > > > -}
> > > > -
> > > >  static const char *pager_argv[] = { "sh", "-c", NULL, NULL };
> > > >  static struct child_process pager_process;
> > > >  
> > > > @@ -84,7 +68,6 @@ void setup_pager(void)
> > > >  	pager_argv[2] = pager;
> > > >  	pager_process.argv = pager_argv;
> > > >  	pager_process.in = -1;
> > > > -	pager_process.preexec_cb = pager_preexec;
> > > >  
> > > >  	if (start_command(&pager_process))
> > > >  		return;
> > > > diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
> > > > index 5cdac2162532..9e9dca717ed7 100644
> > > > --- a/tools/lib/subcmd/run-command.c
> > > > +++ b/tools/lib/subcmd/run-command.c
> > > > @@ -120,8 +120,6 @@ int start_command(struct child_process *cmd)
> > > >  					unsetenv(*cmd->env);
> > > >  			}
> > > >  		}
> > > > -		if (cmd->preexec_cb)
> > > > -			cmd->preexec_cb();
> > > >  		if (cmd->exec_cmd) {
> > > >  			execv_cmd(cmd->argv);
> > > >  		} else {
> > > > diff --git a/tools/lib/subcmd/run-command.h b/tools/lib/subcmd/run-command.h
> > > > index 17d969c6add3..6256268802b5 100644
> > > > --- a/tools/lib/subcmd/run-command.h
> > > > +++ b/tools/lib/subcmd/run-command.h
> > > > @@ -46,7 +46,6 @@ struct child_process {
> > > >  	unsigned no_stderr:1;
> > > >  	unsigned exec_cmd:1; /* if this is to be external sub-command */
> > > >  	unsigned stdout_to_stderr:1;
> > > > -	void (*preexec_cb)(void);
> > > >  };
> > > >  
> > > >  int start_command(struct child_process *);
> > > > -- 
> > > > 2.13.6
> > > > 
> > > 
> > > -- 
> > > Josh
