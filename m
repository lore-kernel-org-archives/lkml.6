Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006CFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC12F206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=greyhouse-net.20150623.gappssmtp.com header.i=@greyhouse-net.20150623.gappssmtp.com header.b="x8E+jmVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfBVUrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:47:37 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36907 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfBVUrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:47:37 -0500
Received: by mail-yw1-f66.google.com with SMTP id k14so1344716ywe.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 12:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=greyhouse-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Js5KI1qYfTJYOoACiFTP+1nDNEEBuacZO1NjrrQSw24=;
        b=x8E+jmVPaNNUmaH6RHp7pct13ff+mO//3mA581Vb6VT5/u/TI+YQB+2fufyHtBt2bP
         /U4Nw3R8g2WYu98spvBZyl1Va9B05HHBNqJiH3yfzPt0Rf99Dwd966OfJ0JOltwQRhhZ
         +shFRAi0zrs/qsdYjOtesW5K9rbnqeW75JheuHfqjW6WQ5rR5aOr9m48LpmX+QUJzyQQ
         0gRM9ttH23Tn14R8yKCuh6vp6fpxBulfyOhMQhE4TP6i3zAkn9nCUB2EmNWULvU56dM6
         nFuQISUI41B+ScALCvlB/jec24KuE976KQueXsxChSGMHps5idVX80U06NIZdpexoOV5
         4d9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Js5KI1qYfTJYOoACiFTP+1nDNEEBuacZO1NjrrQSw24=;
        b=jQxeYKed/oFcEagZXtJgdqloUIkqOgJXXPSpjDqSY5uISa1BegblocAh1OhAjLnVyJ
         3OVr7/kfxOmWQa1yvcgNjVp9EjW+D4dfGvX8OfLuSkHm+qAEqkAUN3MwAc97IrRlDNbf
         prKkmRAhmAwCwH5a94M4yiqow763LHjIGPYUH3pTzcKTHcAbA8MlUUbBrbGRS+Ze56LB
         GetDz8LhmQkwA5p2mQYTpi1QtOpSi/4vmyN4/vJVicaqzPmJQRDaZQr4IYpdBJgo4sHF
         1uNXa9msHRxkbDEmyRkvsRZdOdH8+eArzWKKUAube4emXsrP+3bfQm2yNzAvN1hCuLL8
         IhHg==
X-Gm-Message-State: AHQUAuZvBxu+bw/IzAlKDSZdJ7BpNzJyJh++BW703s8WO8rODJLlS+h4
        cBzDr027O+jojHCY67QaXbXx0A==
X-Google-Smtp-Source: AHgI3IZ+rYLcT2I6d31nKARaGSzMPSfcKtVUlikiU9bIJB0KHRru9nOdseE6az4eSRlY6AMYNyWXzg==
X-Received: by 2002:a81:4f0c:: with SMTP id d12mr4922559ywb.414.1550868455795;
        Fri, 22 Feb 2019 12:47:35 -0800 (PST)
Received: from C02RW35GFVH8.dhcp.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 82sm801042ywq.97.2019.02.22.12.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 12:47:35 -0800 (PST)
Date:   Fri, 22 Feb 2019 15:47:30 -0500
From:   Andy Gospodarek <andy@greyhouse.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Davide Caratti <dcaratti@redhat.com>,
        Debabrata Banerjee <dbanerje@akamai.com>,
        Sun Lianwen <sunlw.fnst@cn.fujitsu.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: Remove switchdev.h inclusion from
 team/bond/vlan
Message-ID: <20190222204730.GA73924@C02RW35GFVH8.dhcp.broadcom.net>
References: <20190222203134.19508-1-f.fainelli@gmail.com>
 <20190222203134.19508-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222203134.19508-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 12:31:34PM -0800, Florian Fainelli wrote:
> This is no longer necessary after eca59f691566 ("net: Remove support for bridge bypass ndos from stacked devices")
> 
> Suggested-by: Ido Schimmel <idosch@mellanox.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Andy Gospodarek <andy@greyhouse.net>

> ---
>  drivers/net/bonding/bond_main.c | 1 -
>  drivers/net/team/team.c         | 1 -
>  net/8021q/vlan_dev.c            | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 485462d3087f..a044a8032a0f 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -77,7 +77,6 @@
>  #include <net/pkt_sched.h>
>  #include <linux/rculist.h>
>  #include <net/flow_dissector.h>
> -#include <net/switchdev.h>
>  #include <net/bonding.h>
>  #include <net/bond_3ad.h>
>  #include <net/bond_alb.h>
> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
> index 958f1cf67282..3ff23a993668 100644
> --- a/drivers/net/team/team.c
> +++ b/drivers/net/team/team.c
> @@ -28,7 +28,6 @@
>  #include <net/genetlink.h>
>  #include <net/netlink.h>
>  #include <net/sch_generic.h>
> -#include <net/switchdev.h>
>  #include <generated/utsrelease.h>
>  #include <linux/if_team.h>
>  
> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> index b2d9c8f27cd7..15293c2a5dd8 100644
> --- a/net/8021q/vlan_dev.c
> +++ b/net/8021q/vlan_dev.c
> @@ -31,7 +31,6 @@
>  #include <linux/ethtool.h>
>  #include <linux/phy.h>
>  #include <net/arp.h>
> -#include <net/switchdev.h>
>  
>  #include "vlan.h"
>  #include "vlanproc.h"
> -- 
> 2.17.1
> 
