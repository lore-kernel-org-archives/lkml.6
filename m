Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752856AbeDWGJN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 02:09:13 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:38436 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbeDWGJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 02:09:09 -0400
X-Google-Smtp-Source: AIpwx4870NtiYFldiSBHwiluxI7FQkZb+uibfVtzKBriHtmTxLQNqPuwoaldzIitR4fIineA9ps/ZQ==
Date: Mon, 23 Apr 2018 08:09:23 +0200
From: Ahmed Abdelsalam <amsalam20@gmail.com>
To: David Miller <davem@davemloft.net>
Cc: dlebrun@google.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net] ipv6: sr: fix NULL pointer dereference in
 seg6_do_srh_encap()- v4 pkts
Message-Id: <20180423080923.9dc889c97a24df7337ca4958@gmail.com>
In-Reply-To: <20180422.210604.1788466884650842473.davem@davemloft.net>
References: <1524232685-1203-1-git-send-email-amsalam20@gmail.com>
        <20180422.210604.1788466884650842473.davem@davemloft.net>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.21; x86_64-apple-darwin10.8.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Apr 2018 21:06:04 -0400 (EDT)
David Miller <davem@davemloft.net> wrote:

> From: Ahmed Abdelsalam <amsalam20@gmail.com>
> Date: Fri, 20 Apr 2018 15:58:05 +0200
> 
> > In case of seg6 in encap mode, seg6_do_srh_encap() calls set_tun_src()
> > in order to set the src addr of outer IPv6 header.
> > 
> > The net_device is required for set_tun_src(). However calling ip6_dst_idev()
> > on dst_entry in case of IPv4 traffic results on the following bug.
> > 
> > Using just dst->dev should fix this BUG.
>  ...
> > Fixes: 8936ef7604c11 ipv6: sr: fix NULL pointer dereference when setting encap source address
> 
> Please format your Fixes: tag properly next time.  The commit header
> text should be enclosed by (" ").  I fixed it up for you this time.
> 

Ok! 
Thanks David for your time. 

> > Signed-off-by: Ahmed Abdelsalam <amsalam20@gmail.com>
> 
> Applied and queued up for -stable.


-- 
Ahmed Abdelsalam <amsalam20@gmail.com>
