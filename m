Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FEAC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E901720823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="GZBCzfI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbfBFNXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:23:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34532 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730773AbfBFNXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:23:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id z15so5496022wrn.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 05:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R3MAd8ERATstMVf6jvlrx6LGkVnckuqZbN5JPFSgo0g=;
        b=GZBCzfI/ez5EkqElnQvm26Kol78TP0TlacDUtKht9wCO1LNxJPZOWQyH2id1ErSxOW
         YOFakguaBHbsOVsql+id60OsEBCjegGRkS2zikVvNYaIb+phCNALsTc5iRRmGiokGmZL
         PT/hbQJMIz8Lo9abaf7QbgiQ6z2BpLI0+0qe1otpfAOQOelGNyoCLEVSxfkLSSsS9Zf+
         5Gu1uw+rXUgsLcoOjQAKJn+KpgHtZDrnFzzm6jaaRa8lDRugfVzoCMoVt68+DesJsS9t
         KphyfUHMkQVbBz7mSBwi+PfABVxQo7dW3ILVr+q5JZBoyNlNl+D40f8UjKlu1AbGVNkQ
         SZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R3MAd8ERATstMVf6jvlrx6LGkVnckuqZbN5JPFSgo0g=;
        b=eeNwkXWQfFojIAPjI9Lolw4192rKCFh/szi2i3rOLbaKfVUlOL28W74I68A7GvW5TS
         gAR9QoUtaA8gYb8DJoziuXwJWXmOuocY3tDosvO09De32vRdsqiHdyN7RwknxrJmASTR
         R56Lr3bMuqX5fV6d/m8bi2KVOLwZiyAeJdZuBPOR227KAIoQdYcRuaXuiq+4KozMlVwH
         sNeEngAh1OTwCI8UEpMyhT8e/dxjRAdy214ETc5Km1EqIfMDbLKj8XBm2R08uNRuxa1q
         lmTJ34zlqOS6IeOgdGEapJ69OcZUlfR396sSUfvt0S+lx/Bkgj/Ax13nHT52JDQ5X7x/
         /EaQ==
X-Gm-Message-State: AHQUAubnX2egaPVmOHlxjrJ7kT///UAo1cbs3ztjC/n/N8tMJ8Uhnlad
        RNsRAiRhDQW3T6TgvHMhm/N7YQ==
X-Google-Smtp-Source: AHgI3IYM1zKwtTgPLpbLdqYmprvA92RbadBepxocK6TVaG9gSCYaaHufSFo0LxE6vulEVM5ua91ULw==
X-Received: by 2002:adf:891a:: with SMTP id s26mr7886737wrs.44.1549459430017;
        Wed, 06 Feb 2019 05:23:50 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id x22sm6475472wmj.40.2019.02.06.05.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 05:23:49 -0800 (PST)
Date:   Wed, 6 Feb 2019 14:14:38 +0100
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
Subject: Re: [PATCH net-next v3 05/12] mlxsw: Implement
 ndo_get_port_parent_id()
Message-ID: <20190206131438.GF2189@nanopsycho>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
 <20190205235326.14600-6-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205235326.14600-6-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Feb 06, 2019 at 12:53:19AM CET, f.fainelli@gmail.com wrote:
>mlxsw implements SWITCHDEV_ATTR_ID_PORT_PARENT_ID and we want to get rid
>of switchdev_ops eventually, ease that migration by implementing a
>ndo_get_port_parent_id() function which returns what
>switchdev_port_attr_get() would do.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

[...]

>diff --git a/drivers/net/ethernet/mellanox/mlxsw/switchx2.c b/drivers/net/ethernet/mellanox/mlxsw/switchx2.c
>index 2d4f213e154d..3814ba8af517 100644
>--- a/drivers/net/ethernet/mellanox/mlxsw/switchx2.c
>+++ b/drivers/net/ethernet/mellanox/mlxsw/switchx2.c

Please remove net/switchdev.h inclusion from this file, you don't need
it any longer.

Otherwise, looks fine.
Acked-by: Jiri Pirko <jiri@mellanox.com>

[...]
