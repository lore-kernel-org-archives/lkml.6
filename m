Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C81C4151A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 03:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A3520870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 03:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="YR1NipHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfBBDpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 22:45:50 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:35110 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfBBDpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 22:45:49 -0500
Received: by mail-pg1-f178.google.com with SMTP id s198so3861782pgs.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 19:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=qGYGMdLI1E9U8tsRC/gCfqX8vID7DS6aiO77Nz4B9m8=;
        b=YR1NipHv4vwAEtvfDfNLAEQUzl+JGObVgGyhxM6+Xxit4bYhzL9Zn+v2KuHlIPqtcq
         +8atmOsQZDkphNBhOwjl67ql9yP2TkmMN1IYLcfXJKEwkWD3UxnOao4yE7AO/WHzWRlv
         mSnBXfHQ/ZQVByabOE9CP8NdBcZ7MfT7cj4fqc010BGMzg2FgJ5RWXF/CxkPAfTSyogT
         T0aoBi0YUqOQrHsHJCUqG+8dCTyB/tV7Zn8XRKjr36E6f3tgJBK0k9ctlakFjvVcIIuI
         51jxIanb0Z9nDfpJWw2LzPRDxcTSaUCY6HtYhDESXB8hFlArcxdYNxMgB1H3RoOF0/by
         wuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=qGYGMdLI1E9U8tsRC/gCfqX8vID7DS6aiO77Nz4B9m8=;
        b=IBKI1IWHdVP84gOSW5P9A6rYRTqS44RTCMw88y1oMcCJycCdz1CCe7QqyhnQc2VYJ/
         SC1mTTvICxzfWFJSJJWpXSXIW6/F1SRUPQjv6+qUtO8ITykfHLwCkMlvxDzDck74+Pr9
         jprZMI+2tJj2+nUfFn3H8OF8RFCCDgCyVSrEkQlbFwapKHRpMoustLzTswg6vX0spyG3
         8uR8FgHdy9VFrpWWFTI3oUpfoW/N/uZHN0bNS2GyQ4wLYNheqM5pgWHznuWF1MfwXEWU
         cSSDKUwCbU2QMRm+TIHsuklnu9KNFQ8gxOjOrmaNi+hgcPq1BX7etOaCzUm30JFrpeS2
         a2hg==
X-Gm-Message-State: AHQUAubV8kZLX9qyTw0OfDLx3PXAwxixEkPX8/dMUiamoVnjOn0uvgoc
        ycAQm+Lzu+U2n8ov5uJhCHTZMg==
X-Google-Smtp-Source: AHgI3Ib9hiAixoW8iLR2I06rCFAy8WzFHqFPYuqC+ivKC+oglhsrHX0kcAo376IpTTPVTyc1D0FquQ==
X-Received: by 2002:a63:e302:: with SMTP id f2mr4945675pgh.320.1549079148571;
        Fri, 01 Feb 2019 19:45:48 -0800 (PST)
Received: from cakuba.hsd1.ca.comcast.net ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id m3sm15832716pgl.69.2019.02.01.19.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 19:45:48 -0800 (PST)
Date:   Fri, 1 Feb 2019 19:45:41 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "Francois H. Theron" <francois.theron@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        John Hurley <john.hurley@netronome.com>,
        Edwin Peer <edwin.peer@netronome.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
        oss-drivers@netronome.com (open list:NETRONOME ETHERNET DRIVERS),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
Subject: Re: [RFC net-next 11/13] nfp: Handle SWITCHDEV_PORT_ATTR_GET event
Message-ID: <20190201194541.49754fbf@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20190201220657.30170-12-f.fainelli@gmail.com>
References: <20190201220657.30170-1-f.fainelli@gmail.com>
        <20190201220657.30170-12-f.fainelli@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Feb 2019 14:06:55 -0800, Florian Fainelli wrote:
> Following patches will change the way we communicate getting or setting
> a port's attribute and use a blocking notifier to perform those tasks.
> 
> Prepare nfp to support receiving notifier events targeting
> SWITCHDEV_PORT_ATTR_GET and simply translate that into the existing
> switchdev_ops::switchdev_port_attr_get operation.
> 
> We register a single blocking switchdev notifier for the entire driver
> instance and we differentiate a "net" from a "repr" by comparing the
> network device's netdev_ops with the ones that this driver manages.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks Florian, the code looks good, only nit I have is - could you
move nfp_switchdev_blocking_event() to nfp_port.c and nfp_port.h?
We shouldn't touch nfp_net_common.c here.

In general calling a notifier to get the parent_id (which is the only
thing all these SR-IOV NIC drivers implement) seems a tad heavy.  It's
an immutable, read-only attribute of a port, perhaps we can break it
out?  Could we make it an NDO, perhaps?

That's just my knee jerk reaction, given that NIC drivers don't
implement any of the bridging side of switchdev I may not have a full
appreciation of the abstraction you are building here :)
