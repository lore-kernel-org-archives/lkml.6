Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B038C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9888121773
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="tWyLY2aJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfBISZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:25:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34029 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfBISZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:25:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so9978507wmd.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 10:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Njt9000zVySvKe0CQ7+n87lAlABhUWjfWy92spGM6HQ=;
        b=tWyLY2aJXii0uPjw1eL81bkq+6ZfCAtoLwXKbg3ajCLKwQaTiJpfQE7DKlnYpL7eoc
         J5adx6w+eQ61DgIyIaDTLeOU2Ag7dhffJrozSBgNjSB/dhBai6qtbbQ3warNM/h+AQPj
         nXDu6M11hcy1FasRtgwO4ROmNEpW4UlwNcz4gPPBAtthKjFBFmhYpYcoy9lONW8rW7Jn
         hru2XMjwPJ7Pmy+dJ8GlgHNx2ZCs0icGjJc+ZdcD5tR+FkhPQqqT2sOZFWlQQqxKKyzx
         eiQMC0LD4EGjbbScyrLkhCbBB/5rhYBf3Z1xN1Eu06IC4pgfIkxDzNL6/AoeNmoZmh26
         q7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Njt9000zVySvKe0CQ7+n87lAlABhUWjfWy92spGM6HQ=;
        b=DqY58xo0CEmTLa3NjVKnhtvsJcQ89PGpE/z7awUlR8/Nrd3fi9I87gTqXK8WbS9rLy
         5n4lcX3wKL/UDNU7IslFVOp7uCRHQ3VB7idw8X0sJJcTzypDlrq9wwu1sOTH27XM/eLW
         Rycl/LX9gNJz/0FWm+w2LpKEK6NEGHyd6qJYPHaAGjypSuq2Be4RuipiHP+CAJz9v5Rw
         l0uuM+4Nd0XAvRedlDI7Xw8BL1SWMZ7Dgl2AMH4D55mLaDXEk4ASIx4mjJSere+leWad
         fwYr0t2NDWPHUCaZS3j3BwaaLatJdt9hNJww/EscOSMqw+zo57gRviF/ZGYj1gObTaQw
         E3VA==
X-Gm-Message-State: AHQUAuYUwEaGf46EIr75tzqmwSwJZT0+lyLFflIo2UPYoMgXujvx6Ehk
        v1Bo4Z4eVES9lVeFaf29h/GVuA==
X-Google-Smtp-Source: AHgI3IaW4twuAYe8Aq9hme5xOeD59Pbuugnr4cbYnnf5ZgpuTrJgEx4m6qG9B3hR4jgcMTPHDUg48A==
X-Received: by 2002:a1c:7011:: with SMTP id l17mr3709975wmc.8.1549736700884;
        Sat, 09 Feb 2019 10:25:00 -0800 (PST)
Received: from localhost (ip-94-113-219-55.net.upcbroadband.cz. [94.113.219.55])
        by smtp.gmail.com with ESMTPSA id a4sm3432994wmm.22.2019.02.09.10.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 10:25:00 -0800 (PST)
Date:   Sat, 9 Feb 2019 19:15:48 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next 08/16] net: Get rid of switchdev_port_attr_get()
Message-ID: <20190209181548.GO2353@nanopsycho>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
 <20190209003248.31088-9-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209003248.31088-9-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Feb 09, 2019 at 01:32:40AM CET, f.fainelli@gmail.com wrote:
>With the bridge no longer calling switchdev_port_attr_get() to obtain
>the supported bridge port flags from a driver but instead trying to set
>the bridge port flags directly and relying on driver to reject
>unsupported configurations, we can effectively get rid of
>switchdev_port_attr_get() entirely since this was the only place where
>it was called.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
