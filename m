Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32595C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DF921773
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="Q4u/FhuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfBIR5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:57:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33916 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfBIR5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:57:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so9928917wmd.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 09:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=orYXw2upRWYiuxg/I8zslqSX9VkqHKkYi2F0NpJ36dc=;
        b=Q4u/FhuRucvfl/QM45MqMmQHO8a0WjcmZ4AiRhAvzUuBN+E0pzrnUhG95Klf18yrrH
         zFe14EQex9LNz5Zck1sB1y7sLmfm1rr2E/g4lspkBH75BJv3ZytjLy/0JTdmxvR5+WU6
         PhSEjdnBhcN2vLaGOyCLJbme9bdz6wyGAaJn3+m6xLqqLbjO/2zh3oD5v1Q8d5t8TK+O
         cnJz44sLjD7qXxMZ9OvEl1WL95k6orGOKgTYE5Yo2JGuhg8ohJ75abKtnPft4MSqfD3a
         ojRVZtH0+aADLJz5EL3eG7nBHlc4B1ianL0pZ0wFwOC9nOFWxHMQMbi6Hnae+U0fM31w
         pW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=orYXw2upRWYiuxg/I8zslqSX9VkqHKkYi2F0NpJ36dc=;
        b=WAnPjuCUe7G+XhjgVnWbSV61BjMMrZytV3yigAdbP0eayOOIeYQHRqfekhN1ucz007
         7Xd11kweho5vLoksoMmasjzR92CKfFXlS6WK+/2onKaYR2s3xIGUKcNPB7SggsW52fPZ
         kL/qR64l17dQYYy2iupvjFyVjNdUX3m98bHPYHyQ72evqnE92ROSegxUBcvzfYPfYwDV
         5a5M//mePSwrBxzeEs06gsGh5OMXW8S0OVLEYexkrjdezUK0BFgN44+j9Ymd2XCqtQpo
         H2SB4Id6Db3MXdzOD16Bu3Alb8PMztzXF82KqExFYMJJcwzCcjfuKTl2YA/Q9tUVlSX4
         0dcg==
X-Gm-Message-State: AHQUAuYJaNIotPVwDuM46ESZ3nm4XUwOamAJLPP+HZwIUMD/ZD01A2bj
        /nOjTjtHH3Oq7yYAlu4Tv5utDA==
X-Google-Smtp-Source: AHgI3Iabvgq5iPJDuEN6/MxvxOHoYvK3TiJcURiFCSngEKvKxPy3SXtT5/XgfU4Jt++s7bEmQYTPdQ==
X-Received: by 2002:adf:ee89:: with SMTP id b9mr1346867wro.116.1549735070411;
        Sat, 09 Feb 2019 09:57:50 -0800 (PST)
Received: from localhost (ip-94-113-219-55.net.upcbroadband.cz. [94.113.219.55])
        by smtp.gmail.com with ESMTPSA id p17sm2130153wrv.59.2019.02.09.09.57.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 09:57:50 -0800 (PST)
Date:   Sat, 9 Feb 2019 18:48:38 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next 05/16] rocker: Check bridge flags during prepare
 phase
Message-ID: <20190209174838.GL2353@nanopsycho>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
 <20190209003248.31088-6-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209003248.31088-6-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Feb 09, 2019 at 01:32:37AM CET, f.fainelli@gmail.com wrote:
>In preparation for getting rid of switchdev_port_attr_get(), have rocker
>check for the bridge flags being set through switchdev_port_attr_set()
>with the SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS attribute identifier.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
