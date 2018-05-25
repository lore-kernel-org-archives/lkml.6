Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967115AbeEYQTc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 12:19:32 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46074 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966854AbeEYQTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 12:19:30 -0400
X-Google-Smtp-Source: AB8JxZo38npo9EGvwV6r8YZ3Z/GSHYh+XV4dIciikjtPrLvKgUay1fFl8WhVW5WpbEodhP+nGNJhRQ==
Date: Fri, 25 May 2018 09:19:26 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: YueHaibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] bpfilter: fix a build err
Message-ID: <20180525161925.crdamzqjgs5wg77e@ast-mbp>
References: <20180525101757.13756-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525101757.13756-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 06:17:57PM +0800, YueHaibing wrote:
> gcc-7.3.0 report following err:
> 
>   HOSTCC  net/bpfilter/main.o
> In file included from net/bpfilter/main.c:9:0:
> ./include/uapi/linux/bpf.h:12:10: fatal error: linux/bpf_common.h: No such file or directory
>  #include <linux/bpf_common.h>
> 
> remove it by adding a include path.
> Fixes: d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/bpfilter/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
> index 2af752c..3f3cb87 100644
> --- a/net/bpfilter/Makefile
> +++ b/net/bpfilter/Makefile
> @@ -5,7 +5,7 @@
>  
>  hostprogs-y := bpfilter_umh
>  bpfilter_umh-objs := main.o
> -HOSTCFLAGS += -I. -Itools/include/
> +HOSTCFLAGS += -I. -Itools/include/ -Itools/include/uapi

Strangely I don't see this error with gcc 7.3
I've tried this patch and it doesn't hurt,
but before it gets applied could you please try
the top two patches from this tree:
https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/?h=ipt_bpf
in your environment?
These two patches add the actual meat of bpfilter and I'd like
to make sure the build setup is good for everyone before
we proceed too far.
