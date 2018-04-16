Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbeDPIDF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 04:03:05 -0400
Received: from nautica.notk.org ([91.121.71.147]:56011 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752915AbeDPIDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 04:03:03 -0400
Date: Mon, 16 Apr 2018 16:56:41 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Chengguang Xu <cgxu519@gmx.com>
Cc: ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [V9fs-developer] [PATCH 2/2] fs/9p: detecting invalid options as
 much as possible
Message-ID: <20180416075641.GA16402@nautica>
References: <1523864909-4337-1-git-send-email-cgxu519@gmx.com>
 <1523864909-4337-2-git-send-email-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1523864909-4337-2-git-send-email-cgxu519@gmx.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chengguang Xu wrote on Mon, Apr 16, 2018:
>  		default:
> +			p9_debug(P9_DEBUG_ERROR,
> +				"unrecognized mount option \"%s\" or missing value\n",
> +					p);
>  			continue;

The problem with that is that the same options are passed to the vfs,
net and transport init later on - none of which know the full subset of
valid options to tell what option has been recognized or not.

Unless we do some backward-incompatible breakage of passing all the
net/transport options in its own option (e.g. net=foo:bar:moo) there
unfortunately is no nice way of fixing this now.


(I don't mind the rest of the patches, although I'd say if we hit ENOMEM
there is likely trouble going on so I'm not so sure about hiding it if
there also is an EINVAL, but I don't really care)
-- 
Dominique Martinet | Asmadeus
