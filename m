Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751375AbeEJXTP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 19:19:15 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42172 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeEJXTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 19:19:12 -0400
X-Google-Smtp-Source: AB8JxZrn+LoHoUBpaJpy20WSOEYJv8GSCEy/I67amOGCf945uU6YAikPAMHHBUdjheJyZnjYmAzPTQ==
Date: Thu, 10 May 2018 16:19:09 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: viro@zeniv.linux.org.uk, ast@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org
Subject: Re: [PATCH] coredump: rename umh_pipe_setup() to
 coredump_pipe_setup()
Message-ID: <20180510231907.xbok4h6rjopwdq6e@ast-mbp>
References: <20180507233002.5571-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507233002.5571-1-mcgrof@kernel.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 04:30:02PM -0700, Luis R. Rodriguez wrote:
> This makes it clearer this code is part of the coredump code, and
> is not an exported generic helper from kernel/umh.c.
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  fs/coredump.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 1e2c87acac9b..566504781683 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -508,7 +508,7 @@ static void wait_for_dump_helpers(struct file *file)
>  }
>  
>  /*
> - * umh_pipe_setup
> + * coredump_pipe_setup
>   * helper function to customize the process used
>   * to collect the core in userspace.  Specifically
>   * it sets up a pipe and installs it as fd 0 (stdin)
> @@ -518,7 +518,7 @@ static void wait_for_dump_helpers(struct file *file)
>   * is a special value that we use to trap recursive
>   * core dumps
>   */
> -static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
> +static int coredump_pipe_setup(struct subprocess_info *info, struct cred *new)

I think this renaming makes sense.
How do we want to proceed?
I can take it as part of my series and get the whole thing through net-next
or folks want to apply this separately?
