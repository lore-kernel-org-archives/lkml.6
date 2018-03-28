Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753929AbeC1PTp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:19:45 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:39779 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753529AbeC1PTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:19:43 -0400
Date: Wed, 28 Mar 2018 11:19:25 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vlad Yasevich <vyasevich@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Al Viro <viro@ZenIV.linux.org.uk>, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net-next] sctp: fix unused lable warning
Message-ID: <20180328151925.GA21759@neilslaptop.think-freely.org>
References: <20180328141512.3083992-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328141512.3083992-1-arnd@arndb.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Spam-Score: -2.9 (--)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 04:14:56PM +0200, Arnd Bergmann wrote:
> The proc file cleanup left a label possibly unused:
> 
> net/sctp/protocol.c: In function 'sctp_defaults_init':
> net/sctp/protocol.c:1304:1: error: label 'err_init_proc' defined but not used [-Werror=unused-label]
> 
> This adds an #ifdef around it to match the respective 'goto'.
> 
> Fixes: d47d08c8ca05 ("sctp: use proc_remove_subtree()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/sctp/protocol.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> index c1c64b78c39d..d685f8456762 100644
> --- a/net/sctp/protocol.c
> +++ b/net/sctp/protocol.c
> @@ -1301,8 +1301,10 @@ static int __net_init sctp_defaults_init(struct net *net)
>  
>  	return 0;
>  
> +#ifdef CONFIG_PROC_FS
>  err_init_proc:
>  	cleanup_sctp_mibs(net);
> +#endif
>  err_init_mibs:
>  	sctp_sysctl_net_unregister(net);
>  err_sysctl_register:
> -- 
> 2.9.0
> 
> 
Acked-by: Neil Horman <nhorman@tuxdriver.com>
