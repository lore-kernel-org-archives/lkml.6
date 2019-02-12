Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D59C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7BB2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="aDaN0H0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfBLJFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:05:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36190 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfBLJFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:05:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id o17so1781790wrw.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 01:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Acmz1DviFJQ7y9528+Zehb0HBpcITQ/3JJciu95MD3Y=;
        b=aDaN0H0t9RKDfQGKA37UksAwxyXAKFdKc6enBvr+/O5s2q6OQlziaqHLbqTOrjTyYf
         kbW9i2znK0dJ/l8CFhDBLKwr+26zw9KMu65nR69kpa+XzP9j3CU/Bj+YsS121TNsKI1q
         Yy4nSeAV5ETVuE8kD3HFJtQLGQ6Y1dVDo4ci4FY9BcpzotJzoeOtQe+URxgGkYdbOSGD
         bW8nsFczFjQ7p5ZqkTCR4545Oar7vdXogUad0Duoo9A57SyRqqu9Zz5nLn2ZOQgMbd+J
         mV2aHxMVRiGt44ZdUjrhiMcY6kna36LQVY5sAkeasSQBX3ABJ8GgdaRU36UuyZlL73ap
         f+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Acmz1DviFJQ7y9528+Zehb0HBpcITQ/3JJciu95MD3Y=;
        b=BLaZv5bmUWCimhvz3p7iJ+iC68LxILi5JLUdPG6fetziHI65RbgJEfJqhyxkb1Ejf+
         icgQ8MjgmrravYrTXEPsnDLZP/E+HVwZdV2cAgYN0GBxgL8EVLYwj0tTU1KLjjd7Hq+C
         j+1FTqgVtLyUJhUZRPCXMGlh8M1LDp6w4wUMCGO5cJfZ/ApZLtZ9Hlm7YPYTibxgvNJp
         2rjVE9yeCtfztKXK1P/dzlW0N+u6Ms9TPMMjrH0NX8N+BC/cd05wK6emS7BQO9o8jmkj
         NfxYxVhlV9KdIojOs/eqMI/4gdB2zba1KZ/o69MAFBFawO/GLIyvvP18qzTOf3/oPdQ3
         auZQ==
X-Gm-Message-State: AHQUAubdCXgHhHCxxHHxy6Zyb78RottMD/pf/D91sagkdnvcFXanlfwa
        4NO0ug2u5+kUwnacGmEtKBeDYw==
X-Google-Smtp-Source: AHgI3IYftwhaxq37Lj6dNefQdZIAVdWJZUT5c6/38/fuhq5A+lcg0aiHZ+zUhULbvu1OiCji4r4vNA==
X-Received: by 2002:a5d:6542:: with SMTP id z2mr1983683wrv.237.1549962341592;
        Tue, 12 Feb 2019 01:05:41 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id a62sm1901923wmf.47.2019.02.12.01.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 01:05:41 -0800 (PST)
Date:   Tue, 12 Feb 2019 09:56:16 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next 2/3] rocker: Remove getting PORT_BRIDGE_FLAGS
Message-ID: <20190212085616.GD2881@nanopsycho>
References: <20190211211749.19847-1-f.fainelli@gmail.com>
 <20190211211749.19847-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211211749.19847-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Feb 11, 2019 at 10:17:48PM CET, f.fainelli@gmail.com wrote:
>There is no code that attempts to get the
>SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS attribute, remove support for that.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
