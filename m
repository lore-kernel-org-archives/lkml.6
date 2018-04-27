Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757620AbeD0R7L (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 13:59:11 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:55604 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbeD0R7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 13:59:09 -0400
Date: Fri, 27 Apr 2018 13:59:07 -0400 (EDT)
Message-Id: <20180427.135907.1528151032821602074.davem@davemloft.net>
To: amsalam20@gmail.com
Cc: dav.lebrun@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next] ipv6: sr: Extract the right key values for
 "seg6_make_flowlabel"
From: David Miller <davem@davemloft.net>
In-Reply-To: <1524751871-1353-1-git-send-email-amsalam20@gmail.com>
References: <1524751871-1353-1-git-send-email-amsalam20@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahmed Abdelsalam <amsalam20@gmail.com>
Date: Thu, 26 Apr 2018 16:11:11 +0200

> @@ -119,6 +119,9 @@ int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
>  	int hdrlen, tot_len, err;
>  	__be32 flowlabel;
>  
> +	inner_hdr = ipv6_hdr(skb);

You have to make this assignment after, not before, the skb_cow_header()
call.  Otherwise this point can be pointing to freed up memory.
