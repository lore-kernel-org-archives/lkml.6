Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3176ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3552085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="o/BOQv1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3552085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeJ0DDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:03:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38561 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbeJ0DDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:03:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id f8-v6so915194pgq.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 11:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kp9CJe8k5R3uYMUvCq6vQPX6v5+P0jqkisy0oS2h7Y8=;
        b=o/BOQv1ZMTXW99v99yWdQRf3evh70rCR4++x244RhrQRY0N9XCRwdA7j09dUJrUNJS
         4eigJDSTGjlOqsu17XdxNk3DigclY9I9gMikNUMVyFlXLA8YtKRmlbhJ7GiGIxufLryV
         xs9AmomnT4xsRw5bxvpfU/eXSCkGwWpfB1PL0v+Vir5lRumdicaHHVutGJyvRMqF0enF
         m4FqzbScNjERKbhqlBvV5K53pfPYhY2anezPlTgDyyUiyc9YTDbQ/cve50o378N/GfPz
         pr4kq3urmddIkSdkVI5yqHJV+a1Rb0Bo+wluxYGci+/AqAVQcqtqnUU8+BHkRrDpOv48
         fyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kp9CJe8k5R3uYMUvCq6vQPX6v5+P0jqkisy0oS2h7Y8=;
        b=Lq26nXXaVM6mega/1IF0pQGgd3QS82O3NM2Atd+z09M/aB+obn6RSwsBjb0zzficNY
         HSe3sjdo+/Ap/rjfPc/NV4Mh9nbSeM/RjsEizADwn2jP/lngU2CbgOqDek2jWSLgCvGn
         B3+aN37wIvHV/SHGKzhbfjxiiG6gxcEzCPF6+I+gk+vKtwgSk0dxhHnGQXSrKh5FEKLs
         DMu8iTU/FPaZUZeBtJ6BK7gMJ5QXcYY2OcZEejAU2QVg0mtmuTtDOeS5H6Q6iEmbmDmX
         Mxulk3CPuIBOTzw9A4qoUD6glO2YKfvE1JDMvjoS/x1bm/TXYjwmtMSUI9sHY4sjojPf
         ibSw==
X-Gm-Message-State: AGRZ1gL6mkNqVQGPVKk6Eq3E0klwQL8kV7FM+ptnHmLtBOto9tcsJGS3
        VdRTK270B6nJGBxxC80YrDKzfA==
X-Google-Smtp-Source: AJdET5fuQgmx1A+dFdwbB6mg+cqaa2WxQQUu2RR2qRcP1W3y9quioYmnFzPb9x6qLZcNl8ExkQBQyA==
X-Received: by 2002:a62:1497:: with SMTP id 145-v6mr5039500pfu.100.1540578296936;
        Fri, 26 Oct 2018 11:24:56 -0700 (PDT)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id o9-v6sm19023401pgn.30.2018.10.26.11.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 11:24:56 -0700 (PDT)
Date:   Fri, 26 Oct 2018 11:24:48 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz>
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.packham@alliedtelesis.co.nz,
        luuk.paulussen@alliedtelesis.co.nz
Subject: Re: [PATCH 1/1] ipmr: Make cache queue length configurable
Message-ID: <20181026112448.2092c254@xeon-e3>
In-Reply-To: <20181026020219.22401-2-brodie.greenfield@alliedtelesis.co.nz>
References: <20181026020219.22401-2-brodie.greenfield@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2018 15:02:19 +1300
Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz> wrote:

> We want to be able to keep more spaces available in our queue for
> processing incoming multicast traffic (adding (S,G) entries) - this lets
> us learn more groups faster, rather than dropping them at this stage.
> 
> Signed-off-by: Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz>
> ---
>  Documentation/networking/ip-sysctl.txt | 7 +++++++
>  include/net/netns/ipv4.h               | 1 +
>  include/uapi/linux/sysctl.h            | 1 +
>  kernel/sysctl_binary.c                 | 1 +
>  net/ipv4/af_inet.c                     | 2 ++
>  net/ipv4/ipmr.c                        | 4 +++-
>  net/ipv4/sysctl_net_ipv4.c             | 7 +++++++
>  7 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/ip-sysctl.txt b/Documentation/networking/ip-sysctl.txt
> index 960de8fe3f40..dfc70ef6c42b 100644
> --- a/Documentation/networking/ip-sysctl.txt
> +++ b/Documentation/networking/ip-sysctl.txt
> @@ -864,6 +864,13 @@ ip_local_reserved_ports - list of comma separated ranges
>  
>  	Default: Empty
>  
> +ip_mr_cache_queue_length - INTEGER
> +	Limit the number of multicast packets we can have in the queue to be
> +	resolved.
> +	Bear in mind that this causes an O(n) traversal of the same size when
> +	the queue is full. This should be considered if increasing.
> +	Default: 10
>

Thanks for updating documentation.  The second two sentences aren't clear.
Does it mean that setting queue length causes O(n) traversal or that each
multicast packet received causes O(n) traversal

>  ip_unprivileged_port_start - INTEGER
>  	This is a per-namespace sysctl.  It defines the first
>  	unprivileged port in the network namespace.  Privileged ports
> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
> index e47503b4e4d1..1ca5cabe2d3b 100644
> --- a/include/net/netns/ipv4.h
> +++ b/include/net/netns/ipv4.h
> @@ -184,6 +184,7 @@ struct netns_ipv4 {
>  	int sysctl_igmp_max_msf;
>  	int sysctl_igmp_llm_reports;
>  	int sysctl_igmp_qrv;
> +	int sysctl_ip_mr_cache_queue_length;

Maybe unsigned because negative value is not meaningful.

>  
>  	struct ping_group_range ping_group_range;
>  
> diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
> index d71013fffaf6..32e32d4904cd 100644
> --- a/include/uapi/linux/sysctl.h
> +++ b/include/uapi/linux/sysctl.h
> @@ -425,6 +425,7 @@ enum
>  	NET_TCP_ALLOWED_CONG_CONTROL=123,
>  	NET_TCP_MAX_SSTHRESH=124,
>  	NET_TCP_FRTO_RESPONSE=125,
> +	NET_IPV4_IP_MR_CACHE_QUEUE_LENGTH=126,
>  };

The numeric sysctl enum is considered deprecated, new sysctl's
need not be added here.

>  enum {
> diff --git a/kernel/sysctl_binary.c b/kernel/sysctl_binary.c
> index 07148b497451..8db94e8d97ed 100644
> --- a/kernel/sysctl_binary.c
> +++ b/kernel/sysctl_binary.c
> @@ -367,6 +367,7 @@ static const struct bin_table bin_net_ipv4_table[] = {
>  	{ CTL_INT,	NET_IPV4_LOCAL_PORT_RANGE,		"ip_local_port_range" },
>  	{ CTL_INT,	NET_IPV4_IGMP_MAX_MEMBERSHIPS,		"igmp_max_memberships" },
>  	{ CTL_INT,	NET_IPV4_IGMP_MAX_MSF,			"igmp_max_msf" },
> +	{ CTL_INT,	NET_IPV4_IP_MR_CACHE_QUEUE_LENGTH,	"ip_mr_cache_queue_length" },
>  	{ CTL_INT,	NET_IPV4_INET_PEER_THRESHOLD,		"inet_peer_threshold" },
>  	{ CTL_INT,	NET_IPV4_INET_PEER_MINTTL,		"inet_peer_minttl" },
>  	{ CTL_INT,	NET_IPV4_INET_PEER_MAXTTL,		"inet_peer_maxttl" },
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 1fbe2f815474..4b78d12aca36 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1818,6 +1818,8 @@ static __net_init int inet_init_net(struct net *net)
>  	net->ipv4.sysctl_igmp_llm_reports = 1;
>  	net->ipv4.sysctl_igmp_qrv = 2;
>  
> +	/* ipmr unresolved queue length max */
> +	net->ipv4.sysctl_ip_mr_cache_queue_length = 10;

Comment here is not necessary, is obvious.

>  	return 0;
>  }
>  
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index 5660adcf7a04..2864f80e2f2a 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -1128,6 +1128,7 @@ static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
>  	struct mfc_cache *c;
>  	bool found = false;
>  	int err;
> +	struct net *net = dev_net(dev);

The network layer coding style is to use reverse christmas tree
style declarations, move this up.

>  
>  	spin_lock_bh(&mfc_unres_lock);
>  	list_for_each_entry(c, &mrt->mfc_unres_queue, _c.list) {
> @@ -1140,7 +1141,8 @@ static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
>  
>  	if (!found) {
>  		/* Create a new entry if allowable */
> -		if (atomic_read(&mrt->cache_resolve_queue_len) >= 10 ||
> +		if (atomic_read(&mrt->cache_resolve_queue_len) >=
> +		    net->ipv4.sysctl_ip_mr_cache_queue_length ||
>  		    (c = ipmr_cache_alloc_unres()) == NULL) {
>  			spin_unlock_bh(&mfc_unres_lock);
>  
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index 891ed2f91467..b249932ee24e 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -772,6 +772,13 @@ static struct ctl_table ipv4_net_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec
>  	},
> +	{
> +		.procname	= "ip_mr_cache_queue_length",
> +		.data		= &init_net.ipv4.sysctl_ip_mr_cache_queue_length,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec
> +	},
>  #ifdef CONFIG_IP_MULTICAST
>  	{
>  		.procname	= "igmp_qrv",

This sysctl is not needed if CONFIG_IP_MULTICAST is not defined.
