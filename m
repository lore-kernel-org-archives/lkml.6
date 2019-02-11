Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE211C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDC3214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="yPKhQIva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfBKMaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:30:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55227 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfBKMaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:30:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so17489904wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2vy/txD1OCIhjROwrdgRGMQFbSUcIxpXB03F3im1d8g=;
        b=yPKhQIvaje/L2j0CrlyRwhQXLZmwPPRwHwQKVNuWxYZ5tN8mMS3h1u/0VqNlTC1RxS
         JPLJnV8oqPrdbGjq/zheDoFQ7IQeEjINO8tPW0de3q4G4QtlKKCsuYH1aWOf2qmjAG0i
         uzSJQopcJFEf00Hn51H2uagVCR9GYiM85ftORR+4UXiwGL6bLHjMDUge/5Z5KTUdPFCY
         7CH1OfR0b1Fm3A1NqeXLw074Plhk8tc8UP0GUOdFp/F1mtUA9cKHEcxmXGemIeGrUFT0
         r8rlJZOddXW4iCTrWR/iVhU41r3YuGuWp0N+njFPG3/p2gjQkvSOoaPuC1eEIZXni9un
         Pspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2vy/txD1OCIhjROwrdgRGMQFbSUcIxpXB03F3im1d8g=;
        b=raXd+AYTE2NG0BIhIc2omCwkkgIJf4DHNYWf0+oLOBfIKnym+uozb7WtHtNVIJ829Z
         esU7Znk4uR8US3eqOuWtUxVgOE6ETXm5Yd25/xi0L3OWG5qAc3XuusIr+6SE17rMRVxM
         x/qPLuftyRZwIjsK1i3jtOiHb+bsZCoTlusta1pwMGkbqGXmgrZ15Nz7pPRqGmM819pM
         SKqPuIVALi4UjQz59cYxJQ2VphZEOi/Z5JY8MlhtEZUXGnrY0M+3KIECgUYeC2cikufb
         KuRKZ/7NhlOB/ztJj3jZisaSeAisohOlDb1uaAXcIssQCAcqKapNwzo0qX/MdUyUSFJ4
         FIsA==
X-Gm-Message-State: AHQUAuaISVne4KBkBYBmrvvW+2C+LPG3d2bcqyoqD15wd+IzoptrZs9P
        4fmxe2wAQhx59kX6vC0DOQh17w==
X-Google-Smtp-Source: AHgI3IbSZaPSyNJG4glfK7Y1zhTfm36XeOWnyI4F4LVWMZ5yH/enutwQBp1XxpwgHr/ofT/zs7T4Tw==
X-Received: by 2002:a1c:9cce:: with SMTP id f197mr9048271wme.135.1549888205797;
        Mon, 11 Feb 2019 04:30:05 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id l12sm6634282wrt.87.2019.02.11.04.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 04:30:05 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:20:42 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next v3 3/9] rocker: Handle
 SWITCHDEV_PORT_ATTR_GET/SET
Message-ID: <20190211122042.GF2251@nanopsycho>
References: <20190210234007.16173-1-f.fainelli@gmail.com>
 <20190210234007.16173-4-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190210234007.16173-4-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Feb 11, 2019 at 12:40:01AM CET, f.fainelli@gmail.com wrote:
>Following patches will change the way we communicate getting or setting
>a port's attribute and use a blocking notifier to perform those tasks.
>
>Prepare rocker to support receiving notifier events targeting
>SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
>rocker_port_attr_{set,get} calls.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
