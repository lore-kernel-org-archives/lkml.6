Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425152AbeE1PYL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:24:11 -0400
Received: from smtprelay0216.hostedemail.com ([216.40.44.216]:35321 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1033256AbeE1PYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:24:07 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:69:355:379:541:599:800:960:973:988:989:1042:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2691:2828:2899:2911:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3870:3871:3872:4321:4425:5007:6119:7576:7688:7903:10004:10400:10450:10455:10471:10848:11026:11232:11473:11657:11658:11914:12043:12296:12438:12555:12740:12760:12895:13069:13095:13161:13229:13255:13311:13357:13439:14181:14659:14721:19904:19999:21080:21212:21433:21451:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: fan42_687801c45a46
X-Filterd-Recvd-Size: 2808
Message-ID: <41d4c55b6e9ad7f68bdcbae6c3f8064938d58e68.camel@perches.com>
Subject: Re: [PATCH 4.14 102/496] drm/exynos: g2d: Delete an error message
 for a failed memory allocation in two functions
From: Joe Perches <joe@perches.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Markus Elfring <elfring@users.sourceforge.net>,
        Inki Dae <inki.dae@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Date: Mon, 28 May 2018 08:24:03 -0700
In-Reply-To: <20180528100324.148603249@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
         <20180528100324.148603249@linuxfoundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-28 at 11:58 +0200, Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Markus Elfring <elfring@users.sourceforge.net>

I still wonder why any Markus Elfring patch should
be applied to a stable branch.

The only reason I could believe is it would make
forward porting of an actually useful fix easier.

Does this?


> [ Upstream commit 6f0a60298bbbea43ab5e3955913ab19c153076f3 ]
> 
> Omit an extra message for a memory allocation failure in these functions.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> Signed-off-by: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> --- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> @@ -286,7 +286,6 @@ static int g2d_init_cmdlist(struct g2d_d
>  
>  	node = kcalloc(G2D_CMDLIST_NUM, sizeof(*node), GFP_KERNEL);
>  	if (!node) {
> -		dev_err(dev, "failed to allocate memory\n");
>  		ret = -ENOMEM;
>  		goto err;
>  	}
> @@ -1358,10 +1357,9 @@ int exynos_g2d_exec_ioctl(struct drm_dev
>  		return -EFAULT;
>  
>  	runqueue_node = kmem_cache_alloc(g2d->runqueue_slab, GFP_KERNEL);
> -	if (!runqueue_node) {
> -		dev_err(dev, "failed to allocate memory\n");
> +	if (!runqueue_node)
>  		return -ENOMEM;
> -	}
> +
>  	run_cmdlist = &runqueue_node->run_cmdlist;
>  	event_list = &runqueue_node->event_list;
>  	INIT_LIST_HEAD(run_cmdlist);
> 
> 
