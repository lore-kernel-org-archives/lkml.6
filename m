Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A35C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C55218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="2NuewkfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfBKMhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:37:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39749 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfBKMhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:37:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id f16so17075852wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cOqkPY4No9PKZY0Nx+arBN/7lEVUHvE+C28keRtBSlY=;
        b=2NuewkfBWmEDC7XNcDFroAB9X6vTq6zEeRB5lcAuBrBcc6reQdKNO9rb9ee7aidc9R
         4mpdaSX4+r8CzmISnGhsCdOPdycyj/p86fVrOSX6b6u3tjJ7JEdK7Qbf5eKFlY6knrjB
         OjJEUCG7wUwkbqe05wisZFbXsTJWsCbpeodFsiHHClP8oPiT4wDfKhJsXGqvBT6FexGG
         Y2WM17+vvl9eV5jnh1BgOXgJfxP5PmetiJTg9RwNkWMG7QxdHYu5W074CER1dUhpBjUl
         ZuE4gzeAaHVBgYh2C6bkdwx6vQ2QOSo7FiMwXveoE+D3Q1ACCq4Wukteq63Aqr9AiZvr
         sEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cOqkPY4No9PKZY0Nx+arBN/7lEVUHvE+C28keRtBSlY=;
        b=DCjowpK1lukEtAX+JMJ+1wHZoGHUQFHxxpBJ8cYTezvRMF92F/YKOPhetIi44FXj4T
         o8a/5VG/EMThgRPeLUQhFObLicHlTR2n5gTF00zDhrvnUzX8DYwJsH5ZEzFYgdBVHxQy
         RseFQUXnTZ0Sy16yAmfSOap34gWwiE8ASAErHznWtmkkAr7+dxMX5KIjW5dTe3iYgcbW
         R0G7LsOxhllnk+lKRs5gVXPVtYR5S8j4X7RqX6ntLND0RXHyC7y/F5Jl1flLYH3LttpW
         HCdFEnJ6Z7I53gDVfaZ3tIvycX/XCuXMAl5Wjk5HTCWvThArwQz0gEmVUdbkmgmcBPuj
         MFew==
X-Gm-Message-State: AHQUAuYwti82shIj9x/dhWpQvZSZzg5GhymTuPoWZT3vA72ufbz/y0aj
        6Gn5wLTB7PvNOn7kCaFhWoDwgw==
X-Google-Smtp-Source: AHgI3IZ/FvjxZwcCAxOoszCNWFXKBm/pkLlemKcxC+uc+eaqVJFuYTVamAhqouYARQyvB90Pm5m07Q==
X-Received: by 2002:a1c:2804:: with SMTP id o4mr9704823wmo.150.1549888663505;
        Mon, 11 Feb 2019 04:37:43 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id u17sm5257435wrg.71.2019.02.11.04.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 04:37:43 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:28:20 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next v3 4/9] mlxsw: spectrum_switchdev: Handle
 SWITCHDEV_PORT_ATTR_GET/SET
Message-ID: <20190211122820.GG2251@nanopsycho>
References: <20190210234007.16173-1-f.fainelli@gmail.com>
 <20190210234007.16173-5-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190210234007.16173-5-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Feb 11, 2019 at 12:40:02AM CET, f.fainelli@gmail.com wrote:
>Following patches will change the way we communicate getting or setting
>a port's attribute and use a blocking notifier to perform those tasks.
>
>Prepare mlxsw to support receiving notifier events targeting
>SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
>mlxsw_sp_port_attr_{set,get} calls.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
