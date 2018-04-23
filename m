Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753867AbeDWBGH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 21:06:07 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:42432 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753783AbeDWBGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 21:06:06 -0400
Date: Sun, 22 Apr 2018 21:06:04 -0400 (EDT)
Message-Id: <20180422.210604.1788466884650842473.davem@davemloft.net>
To: amsalam20@gmail.com
Cc: dlebrun@google.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net] ipv6: sr: fix NULL pointer dereference in
 seg6_do_srh_encap()- v4 pkts
From: David Miller <davem@davemloft.net>
In-Reply-To: <1524232685-1203-1-git-send-email-amsalam20@gmail.com>
References: <1524232685-1203-1-git-send-email-amsalam20@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahmed Abdelsalam <amsalam20@gmail.com>
Date: Fri, 20 Apr 2018 15:58:05 +0200

> In case of seg6 in encap mode, seg6_do_srh_encap() calls set_tun_src()
> in order to set the src addr of outer IPv6 header.
> 
> The net_device is required for set_tun_src(). However calling ip6_dst_idev()
> on dst_entry in case of IPv4 traffic results on the following bug.
> 
> Using just dst->dev should fix this BUG.
 ...
> Fixes: 8936ef7604c11 ipv6: sr: fix NULL pointer dereference when setting encap source address

Please format your Fixes: tag properly next time.  The commit header
text should be enclosed by (" ").  I fixed it up for you this time.

> Signed-off-by: Ahmed Abdelsalam <amsalam20@gmail.com>

Applied and queued up for -stable.
