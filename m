Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeEJXcv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 19:32:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:55962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751695AbeEJXct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 19:32:49 -0400
Date: Thu, 10 May 2018 23:32:47 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, ast@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH] coredump: rename umh_pipe_setup() to
 coredump_pipe_setup()
Message-ID: <20180510233247.GG27853@wotan.suse.de>
References: <20180507233002.5571-1-mcgrof@kernel.org>
 <20180510231907.xbok4h6rjopwdq6e@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510231907.xbok4h6rjopwdq6e@ast-mbp>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 04:19:09PM -0700, Alexei Starovoitov wrote:
> On Mon, May 07, 2018 at 04:30:02PM -0700, Luis R. Rodriguez wrote:
> > This makes it clearer this code is part of the coredump code, and
> > is not an exported generic helper from kernel/umh.c.
> > 
> > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> > ---
> >  fs/coredump.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/coredump.c b/fs/coredump.c
> > index 1e2c87acac9b..566504781683 100644
> > --- a/fs/coredump.c
> > +++ b/fs/coredump.c
> > @@ -508,7 +508,7 @@ static void wait_for_dump_helpers(struct file *file)
> >  }
> >  
> >  /*
> > - * umh_pipe_setup
> > + * coredump_pipe_setup
> >   * helper function to customize the process used
> >   * to collect the core in userspace.  Specifically
> >   * it sets up a pipe and installs it as fd 0 (stdin)
> > @@ -518,7 +518,7 @@ static void wait_for_dump_helpers(struct file *file)
> >   * is a special value that we use to trap recursive
> >   * core dumps
> >   */
> > -static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
> > +static int coredump_pipe_setup(struct subprocess_info *info, struct cred *new)
> 
> I think this renaming makes sense.
> How do we want to proceed?
> I can take it as part of my series and get the whole thing through net-next
> or folks want to apply this separately?

I think net-next makes sense if Al Viro is OK with that. This way it could go
in regardless of the state of your series, but it also lines up with your work.

  Luis
