Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B69EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158E5217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5RZ+gmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbfBLQPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:15:41 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35799 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbfBLQPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:15:40 -0500
Received: by mail-qt1-f196.google.com with SMTP id p48so3595850qtk.2;
        Tue, 12 Feb 2019 08:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aR39FVqSxVArerxHPSeWFsedeeOHnpYRLJllQyf+/QY=;
        b=c5RZ+gmDqZ4l9AMrOVwx570E/5MEazdt1YVtsJc27mB9Na+3lvcTLvUTIvP3PoQbFm
         WOIIk9FaGLTGF/NITEGnGXY1ccS6wjJa/FWp6fIh5hh/Ef4/4+T7tU74LiLNQuT0KqSN
         24ZOSERr+M/D7ulic/6Oh4VvWdJrJT0kifbgErLY8AZkWtGvUP+PcDnM9uhZaRfoIM8X
         K1w+541Tf6qyVlaxDz8znwkrRzcRdSOWjN5uyasW9M38qUz4WsQDEA/Aq/YcLWi8eFL2
         1BmQPGlayi8n30qtMzkLz6FZMHANoBLU1H78qj0KrZb4NDcI0nBdItuuGa5VprV+G1eR
         A/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aR39FVqSxVArerxHPSeWFsedeeOHnpYRLJllQyf+/QY=;
        b=TIil43EHeMpAyhqanuUjDryqhZEPuk2Wf9CI6u77kY9ty68oipVVIcofFcrnaxOZXx
         6Y7x86gbaC9YB6Pgsx6nOolxc2w5jCUkT4zGbHme9Btv0bVvvLNrMxKxPiO+pI6roZH9
         6setuCWOBHIU31tOFShXhEDOg9H7Lm7XLr2cq/rHhseGUr1gzEmFQnaK0yxAXhb0VYt4
         SwFmJ2ot93lEBdgavEiHxPa9h+aa0pQBmg9GnKZ9hrGluooMt1gEzgcbeh+k3QEdbPaz
         r0VDW3cBzrpkGbo9+rHpPnKGw/rJ+p3H4o5hAXHFVqIQnyXlu+V17zdbQ3Rlm8cBeThh
         RnIg==
X-Gm-Message-State: AHQUAuYyetF4qd/tfZ6TqtWwWxjcU7cJ3SI1QvtQTI/+1S2iQYY+nCBf
        wbtPrObonPlR7Wvdfv1Vhc0=
X-Google-Smtp-Source: AHgI3IYECDdYlDV8gNm3lz0xbtWP1zl6/BG7gml+DqF39a/855kUC8g0gV6G+kxPLCRLklsW3f8THg==
X-Received: by 2002:ac8:3f0f:: with SMTP id c15mr3473477qtk.142.1549988138924;
        Tue, 12 Feb 2019 08:15:38 -0800 (PST)
Received: from localhost.localdomain ([2001:1284:f019:3a5b:b662:7c1a:9012:e865])
        by smtp.gmail.com with ESMTPSA id e5sm10223796qtr.52.2019.02.12.08.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 08:15:37 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 77841180C61; Tue, 12 Feb 2019 14:15:35 -0200 (-02)
Date:   Tue, 12 Feb 2019 14:15:35 -0200
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org, davem@davemloft.net,
        Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH net] sctp: call gso_reset_checksum when computing
 checksum in sctp_gso_segment
Message-ID: <20190212161535.GH10665@localhost.localdomain>
References: <5b8187d1eabd52e4db7d3e4506d98c33571c1c83.1549968450.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b8187d1eabd52e4db7d3e4506d98c33571c1c83.1549968450.git.lucien.xin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 06:47:30PM +0800, Xin Long wrote:
> Jianlin reported a panic when running sctp gso over gre over vlan device:
> 
>   [   84.772930] RIP: 0010:do_csum+0x6d/0x170
>   [   84.790605] Call Trace:
>   [   84.791054]  csum_partial+0xd/0x20
>   [   84.791657]  gre_gso_segment+0x2c3/0x390
>   [   84.792364]  inet_gso_segment+0x161/0x3e0
>   [   84.793071]  skb_mac_gso_segment+0xb8/0x120
>   [   84.793846]  __skb_gso_segment+0x7e/0x180
>   [   84.794581]  validate_xmit_skb+0x141/0x2e0
>   [   84.795297]  __dev_queue_xmit+0x258/0x8f0
>   [   84.795949]  ? eth_header+0x26/0xc0
>   [   84.796581]  ip_finish_output2+0x196/0x430
>   [   84.797295]  ? skb_gso_validate_network_len+0x11/0x80
>   [   84.798183]  ? ip_finish_output+0x169/0x270
>   [   84.798875]  ip_output+0x6c/0xe0
>   [   84.799413]  ? ip_append_data.part.50+0xc0/0xc0
>   [   84.800145]  iptunnel_xmit+0x144/0x1c0
>   [   84.800814]  ip_tunnel_xmit+0x62d/0x930 [ip_tunnel]
>   [   84.801699]  gre_tap_xmit+0xac/0xf0 [ip_gre]
>   [   84.802395]  dev_hard_start_xmit+0xa5/0x210
>   [   84.803086]  sch_direct_xmit+0x14f/0x340
>   [   84.803733]  __dev_queue_xmit+0x799/0x8f0
>   [   84.804472]  ip_finish_output2+0x2e0/0x430
>   [   84.805255]  ? skb_gso_validate_network_len+0x11/0x80
>   [   84.806154]  ip_output+0x6c/0xe0
>   [   84.806721]  ? ip_append_data.part.50+0xc0/0xc0
>   [   84.807516]  sctp_packet_transmit+0x716/0xa10 [sctp]
>   [   84.808337]  sctp_outq_flush+0xd7/0x880 [sctp]
> 
> It was caused by SKB_GSO_CB(skb)->csum_start not set in sctp_gso_segment.
> sctp_gso_segment() calls skb_segment() with 'feature | NETIF_F_HW_CSUM',
> which causes SKB_GSO_CB(skb)->csum_start not to be set in skb_segment().
> 
> For TCP/UDP, when feature supports HW_CSUM, CHECKSUM_PARTIAL will be set
> and gso_reset_checksum will be called to set SKB_GSO_CB(skb)->csum_start.
> 
> So SCTP should do the same as TCP/UDP, to call gso_reset_checksum() when
> computing checksum in sctp_gso_segment.
> 
> Reported-by: Jianlin Shi <jishi@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

> ---
>  net/sctp/offload.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/sctp/offload.c b/net/sctp/offload.c
> index 123e9f2..edfcf16 100644
> --- a/net/sctp/offload.c
> +++ b/net/sctp/offload.c
> @@ -36,6 +36,7 @@ static __le32 sctp_gso_make_checksum(struct sk_buff *skb)
>  {
>  	skb->ip_summed = CHECKSUM_NONE;
>  	skb->csum_not_inet = 0;
> +	gso_reset_checksum(skb, ~0);
>  	return sctp_compute_cksum(skb, skb_transport_offset(skb));
>  }
>  
> -- 
> 2.1.0
> 
