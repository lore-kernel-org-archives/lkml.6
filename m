Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48E2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE2F2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="bdLp6877"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfBUKHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:07:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37965 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbfBUKHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:07:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so29248025wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 02:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3fnUapPakhBTDfxghT8hz4o/XbxDp1gFkmPTygqh+eE=;
        b=bdLp6877M5Wx1NbL95XdsnI469RxX5whcecOAc3odlecRRam5iEkUD7siOaPX8jOAi
         xznB4mPC/5oHSDNzPG9eP+CKmKw4Q/mJ/2damoaPF9OHATNRS2qKQGojEzyLISEpcsBY
         mcgEiomdefIdXK6CzKyBZvI5zh6EmW+tU6zaL8o+r8GDBXtHIDVtmOGcw6w2Lg9F5/aA
         vshVfdRSlApvLEY+xpCVbY/4jVPRKbbva/18lQym6Ghgb5QuG7umqbTLShedMtrWidXG
         Ju5xV9jwUYa1lNJubg+cWvlhuSpA/48vWv50ug3d6SPMXy/OIColRW+2O5hPO38tA8wS
         yU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3fnUapPakhBTDfxghT8hz4o/XbxDp1gFkmPTygqh+eE=;
        b=RRzXODgSQkrBVf4GDzKlrKQSeaCmN/TCbOpA/zMsBY9xyzMmzFRzumONy1HC1SGt+D
         ya1eEA/kUvIVjwMGXDSLx1llz4hVJRD6tJ+KMyv01GdS8OBuN/r/HHnWrOg+Gtml70GV
         a6KDl0DEdrbMZELVOW/u3BLqJTaU/M3HlGrMoMyuo+rYaZBA05RZPxntEPEwySQ4h/Ry
         GlmplsqhtMB9sjzMusQ6zvwEE6dAtQpI0msRNaLBVVF+fQocNrMzp3g9ZkYhnMbKuR4W
         zJlO6l6plzPCHOhS0UoWJd4M/pX17a/dvZCzdZ3/i7g2UpIh2g/vqML3TM2K5SyIL89N
         Te0w==
X-Gm-Message-State: AHQUAuZvX0xgA1OtBkDO7AqCX/LsEWyRQ4jk7yNnFuEc9Niyd0MU9A4F
        9fc9MeAwrLzHv503QzbzsPplpw==
X-Google-Smtp-Source: AHgI3IbCnAViD6GXH+3PON/zSHYGelFLn5PCjbYHwBzs3I7UhoBf5DLF0J0vy9nl/PXdW8MxOG+SCw==
X-Received: by 2002:adf:fc49:: with SMTP id e9mr29649656wrs.2.1550743640808;
        Thu, 21 Feb 2019 02:07:20 -0800 (PST)
Received: from localhost (ip-89-102-139-73.net.upcbroadband.cz. [89.102.139.73])
        by smtp.gmail.com with ESMTPSA id y1sm23515115wrh.65.2019.02.21.02.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 02:07:20 -0800 (PST)
Date:   Thu, 21 Feb 2019 10:57:41 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next v3 7/8] net: Remove
 SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
Message-ID: <20190221095741.GJ2312@nanopsycho>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
 <20190221005826.26317-8-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221005826.26317-8-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Feb 21, 2019 at 01:58:25AM CET, f.fainelli@gmail.com wrote:
>Now that we have converted the bridge code and the drivers to check for
>bridge port(s) flags at the time we try to set them, there is no need
>for a get() -> set() sequence anymore and
>SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT therefore becomes unused.
>
>Reviewed-by: Ido Schimmel <idosch@mellanox.com>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
