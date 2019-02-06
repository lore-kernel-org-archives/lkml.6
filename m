Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99BCC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69C52175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="NM7AywVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfBFNI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:08:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45102 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfBFNI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:08:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id q15so7424051wro.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 05:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P1pOlZW/Id97sp4fAA+2r0hhEC/TTJ/UW1DX4h/o9vI=;
        b=NM7AywVY9VILtjTRV+wZ2glv9suyd8bMBHvMpU3wbOuGOuHq11V17x8MK3F3th7nMa
         kc7plOaf1EPCWaKUlLhsJouiWGFZqpw5mzpyCJW8IwH1kqkYETS8Dq4rqeLeHrzb8ix9
         QCiIhqXrfhmmF5YaML4XcIK7TY3qDkfNjslpyzNoLo3Dqxg7tyd2G03Yk7tOXRk9vdHE
         EjcPgALv1c+NEU6DA6u3K1th+9kBnEGECABsKpWkGKkbNelI3NN8jT8206CutE8yM3+J
         6XQLLa+Q81yeE62lK6PRfgHgufr1wXOsBtrql6eKwGulanOowtiDZ5ctpQpfUWgr3dMW
         5EsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P1pOlZW/Id97sp4fAA+2r0hhEC/TTJ/UW1DX4h/o9vI=;
        b=SXeVuZYf8SRr6M65sq2kcoYMaJwir720XfEBsPqD+0MXaVodgAl3CsBW/gngKO0HXC
         VsFs+q5PZyxNdzqjlbgOBh7vOS013x+1m1PTLaBuwS57aRpTj5cxKchuTe3FLBvayu/V
         k8DgkIWsvzKm6HzAYyLf09+SA5/rXFsbgDE0V+7pBk8TqskV3NwFe7KDKNVkNhgsi62S
         fs8xtUHA4ftTrf28NUV1/OTM0Wma57DP/Qy8Q7mqDIn+9anCOF+fWuWDyDRDVprKmRy6
         YnvlyS6/QEz96Lq1q1tZmFCRbowlYx6A0yZnLBGVlh4vjwhYFIarnmug5p3lMS//OOpX
         qIag==
X-Gm-Message-State: AHQUAub2un2lOhJqVS/Id4LxhDSAsO7JMKMkhAHoLm3fneC+oplchxnc
        cT/YsSccOO2r5KXj/OiUm5/0yA==
X-Google-Smtp-Source: AHgI3Ib3/nnzT6S8FH7jrpgXBr97s3NRqV1YTUtTkm3Qo2BHAMOtkSh7KMiCvrf8+KV9bqmPals0xQ==
X-Received: by 2002:adf:f401:: with SMTP id g1mr8100652wro.103.1549458536006;
        Wed, 06 Feb 2019 05:08:56 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id q12sm18603496wrx.31.2019.02.06.05.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 05:08:55 -0800 (PST)
Date:   Wed, 6 Feb 2019 13:59:44 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MELLANOX MLX5 core VPI driver" 
        <linux-rdma@vger.kernel.org>,
        "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>
Subject: Re: [PATCH net-next v3 02/12] bnxt: Implement
 ndo_get_port_parent_id()
Message-ID: <20190206125944.GC2189@nanopsycho>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
 <20190205235326.14600-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205235326.14600-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Feb 06, 2019 at 12:53:16AM CET, f.fainelli@gmail.com wrote:
>BNXT only supports SWITCHDEV_ATTR_ID_PORT_PARENT_ID, which makes it a
>great candidate to be converted to use the ndo_get_port_parent_id() NDO
>instead of implementing switchdev_port_attr_get(). The conversion is
>straight forward here since the PF and VF code use the same getter.
>
>Since bnxt makes uses of switchdev_port_same_parent_id() convert it to
>use netdev_port_same_parent_id().
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

[...]

>diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
>index c683b5e96b1d..170d2fbbb91b 100644
>--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
>+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
>@@ -12,6 +12,7 @@
> #include <linux/if_vlan.h>
> #include <net/flow_dissector.h>
> #include <net/pkt_cls.h>
>+#include <net/switchdev.h>

You don't need this. Looks like a leftover.

Otherwise, looks fine.
Acked-by: Jiri Pirko <jiri@mellanox.com>


> #include <net/tc_act/tc_gact.h>
> #include <net/tc_act/tc_skbedit.h>
> #include <net/tc_act/tc_mirred.h>

[...]
