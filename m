Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A0FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E05B2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="Pg6qh0gL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfBLJFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:05:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38806 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfBLJFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:05:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so1762363wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 01:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9JE1KUAaeIF0Eqil7KjRb60SMtOMHOgTxiw3v8XiNgE=;
        b=Pg6qh0gLb+h0h2pEYTpLbPLqyaPQ7seYet07ukPSuUkxnF/BRrOiDgTK1oyyGgN6/9
         2hrBCT97S8f8rDsK2vo9z7SKsZnp/km6t0cAUGnwKvQjJTobBeVVAFJsRCkHrW1XbjqY
         DHR+3CWsz7+XdTOHE9hI0aVAKNFMfgTFxzSr/t9fuSsjQGyBsYiMOpmRRz2mkcgvNxA4
         4ZKatl5MZlYnh2PE8zRro7ZpNmMvKZUnymJAhg1Sx4Shcxf7tBtaHDJLm3ml/TYrPym5
         VZjtsbHvTKT0gzAcLTJUjy4IVViexDIRf0AndnIKk+JJwK4g9ujzLwqUQPkx/d/S/2ga
         oZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9JE1KUAaeIF0Eqil7KjRb60SMtOMHOgTxiw3v8XiNgE=;
        b=pte4eOt0JdDE1REGpb9UTLIg6PFa3kQdSXkqsR77vQIcI4G/04lwSsCQYRoZtHoJ0O
         0FXzVQt2Ut9HLUwdKpe6KCkJgwdpkK8IxFxAujVLhHaCOSo4tsKF5bR7Wu/l44zMl/mv
         mQPUpZO/Va4J1AXIsgLHsg+fcjuJpMiKg9Ajprzq2bgu5lIpFbv2px1EpP51qwQpeRxZ
         HsKnGk2bwKRu6UhwI/3flf9azIWalQ5LulIGdDMkt+vtMy6EcAraCtXtFmOqTfqcXMD1
         KbdOFViXyCATrVTB+m8bdNoHEXMRJ7KpNI3skxy9wNQZ/U2qlrlcXLDGP9lhoKhFvnus
         pOUQ==
X-Gm-Message-State: AHQUAuaPb94ubyU3rQrQrK7SYxwcjNib36j7iL8oT0KhuBZQRAqcCmee
        8dSZgp7z6C8rwdlW0yUiphWChQ==
X-Google-Smtp-Source: AHgI3IayiScQSC8EiD9u2VRjQLIzXRuoa8gCs/URUpHow4h9I2Ah9a5oJCkg/PRUa4pypMSzBP0EVg==
X-Received: by 2002:adf:9167:: with SMTP id j94mr2067590wrj.106.1549962314208;
        Tue, 12 Feb 2019 01:05:14 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id m4sm2556469wmi.3.2019.02.12.01.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 01:05:13 -0800 (PST)
Date:   Tue, 12 Feb 2019 09:55:49 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next 0/3] Remove getting
 SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
Message-ID: <20190212085549.GB2881@nanopsycho>
References: <20190211211749.19847-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211211749.19847-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Feb 11, 2019 at 10:17:46PM CET, f.fainelli@gmail.com wrote:
>Hi all,
>
>AFAICT there is no code that attempts to get the value of the attribute
>SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS while it is used with
>switchdev_port_attr_set().
>
>This is effectively no doing anything and it can slow down future work
>that tries to make modifications in these areas so remove that.
>
>David, there should be no dependency with previous patch series, but
>again, feedback from Ido and Jiri would be welcome in case this was
>added for a reason.

It was originally used by:
switchdev_port_bridge_getlink()
removed by:
commit 29ab586c3d83f81c435e269cace9a1619afb5bbd
Author: Arkadi Sharshevsky <arkadis@mellanox.com>
Date:   Sun Aug 6 16:15:51 2017 +0300

    net: switchdev: Remove bridge bypass support from switchdev

So these are just leftovers. Let's flush them.
