Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337BBC282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0706D2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfAXCuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 21:50:11 -0500
Received: from mail5.windriver.com ([192.103.53.11]:39304 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfAXCuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 21:50:11 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x0O2mWIB027103
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 23 Jan 2019 18:48:42 -0800
Received: from [128.224.155.90] (128.224.155.90) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 23 Jan
 2019 18:48:21 -0800
Subject: Re: [PATCH] tipc: remove dead code in struct tipc_topsrv
To:     Zhaolong Zhang <zhangzl2013@126.com>, <jon.maloy@ericsson.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <tipc-discussion@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1548295601-23063-1-git-send-email-zhangzl2013@126.com>
From:   Ying Xue <ying.xue@windriver.com>
Message-ID: <b419877d-49cb-15c6-7546-7b23a30631e3@windriver.com>
Date:   Thu, 24 Jan 2019 10:40:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1548295601-23063-1-git-send-email-zhangzl2013@126.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.155.90]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/19 10:06 AM, Zhaolong Zhang wrote:
> max_rcvbuf_size is no longer used since commit "414574a0af36".
> 
> Signed-off-by: Zhaolong Zhang <zhangzl2013@126.com>

Acked-by: Ying Xue <ying.xue@windriver.com>

> ---
>  net/tipc/topsrv.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
> index efb16f6..4b1c083 100644
> --- a/net/tipc/topsrv.c
> +++ b/net/tipc/topsrv.c
> @@ -60,7 +60,6 @@
>   * @awork: accept work item
>   * @rcv_wq: receive workqueue
>   * @send_wq: send workqueue
> - * @max_rcvbuf_size: maximum permitted receive message length
>   * @listener: topsrv listener socket
>   * @name: server name
>   */
> @@ -72,7 +71,6 @@ struct tipc_topsrv {
>  	struct work_struct awork;
>  	struct workqueue_struct *rcv_wq;
>  	struct workqueue_struct *send_wq;
> -	int max_rcvbuf_size;
>  	struct socket *listener;
>  	char name[TIPC_SERVER_NAME_LEN];
>  };
> @@ -648,7 +646,6 @@ int tipc_topsrv_start(struct net *net)
>  		return -ENOMEM;
>  
>  	srv->net = net;
> -	srv->max_rcvbuf_size = sizeof(struct tipc_subscr);
>  	INIT_WORK(&srv->awork, tipc_topsrv_accept);
>  
>  	strscpy(srv->name, name, sizeof(srv->name));
> 
