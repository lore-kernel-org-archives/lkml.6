Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F01C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEDD206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfBKJu3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:50:29 -0500
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:33637 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKJu2 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:5:1>);
        Mon, 11 Feb 2019 04:50:28 -0500
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Mon, 11 Feb 2019 02:50:27 -0700
Message-Id: <5C6145600200007800215864@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Mon, 11 Feb 2019 02:50:24 -0700
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Gustavo A.R.Silva" <gustavo@embeddedor.com>
Cc:     "Paul Durrant" <paul.durrant@citrix.com>,
        "Wei Liu" <wei.liu2@citrix.com>, <davem@davemloft.net>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH net-next] xen-netback: mark expected
 switch fall-through
References: <20190208195838.GA11878@embeddedor>
In-Reply-To: <20190208195838.GA11878@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 08.02.19 at 20:58, <gustavo@embeddedor.com> wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/net/xen-netback/xenbus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/xen-netback/xenbus.c 
> b/drivers/net/xen-netback/xenbus.c
> index 2625740bdc4a..330ddb64930f 100644
> --- a/drivers/net/xen-netback/xenbus.c
> +++ b/drivers/net/xen-netback/xenbus.c
> @@ -655,7 +655,7 @@ static void frontend_changed(struct xenbus_device *dev,
>  		set_backend_state(be, XenbusStateClosed);
>  		if (xenbus_dev_is_online(dev))
>  			break;
> -		/* fall through if not online */
> +		/* fall through - if not online */
>  	case XenbusStateUnknown:

Considering the fall-through was already annotated, I don't think
title and description really justify the change. Is the compiler after
a particular wording here?

Jan


