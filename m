Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753043AbeDXSZF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:25:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33733 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbeDXSZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:25:00 -0400
X-Google-Smtp-Source: AIpwx4/6j2b4wM1NtZYa803vd0A0vFmEigOF1AKXMtyoaGqWsogCJA2VPZUeD3c5py1fm3LZDhqqVg==
Date: Tue, 24 Apr 2018 20:24:57 +0200
From: Ahmed Abdelsalam <amsalam20@gmail.com>
To: Ahmed Abdelsalam <amsalam20@gmail.com>
Cc: davem@davemloft.net, dav.lebrun@gmail.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next v2] ipv6: sr: Compute flowlabel for outer IPv6 header
 of seg6 encap mode
Message-Id: <20180424202457.19cbc7ee781fe52aaeb56357@gmail.com>
In-Reply-To: <1524592795-1467-1-git-send-email-amsalam20@gmail.com>
References: <1524592795-1467-1-git-send-email-amsalam20@gmail.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.21; x86_64-apple-darwin10.8.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018 19:59:55 +0200
Ahmed Abdelsalam <amsalam20@gmail.com> wrote:

> This patch has been tested for IPv6, IPv4, and L2 traffic.
> 
> Signed-off-by: Ahmed Abdelsalam <amsalam20@gmail.com>
> ---
>  include/net/netns/ipv6.h   |  1 +
>  net/ipv6/seg6_iptunnel.c   | 24 ++++++++++++++++++++++--
>  net/ipv6/sysctl_net_ipv6.c |  8 ++++++++
>  3 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
> index 97b3a54..c978a31 100644
> --- a/include/net/netns/ipv6.h
> +++ b/include/net/netns/ipv6.h
> @@ -43,6 +43,7 @@ struct netns_sysctl_ipv6 {
>  	int max_hbh_opts_cnt;
>  	int max_dst_opts_len;
>  	int max_hbh_opts_len;
> +	int seg6_flowlabel;
>  };
>  
>  struct netns_ipv6 {
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 5fe1394..3d9cd86 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -91,6 +91,24 @@ static void set_tun_src(struct net *net, struct net_device *dev,
>  	rcu_read_unlock();
>  }
>  
> +/* Compute flowlabel for outer IPv6 header */
> +__be32 seg6_make_flowlabel(struct net *net, struct sk_buff *skb,
> +			   struct ipv6hdr *inner_hdr)

David, please take v3 of the patch. 
I re-defined seg6_make_flowlabel () as static to fix the kbuild test robot.

-- 
Ahmed Abdelsalam <amsalam20@gmail.com>
