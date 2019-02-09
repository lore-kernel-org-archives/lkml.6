Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E8EC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDE42080D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="O1r9/wVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfBIR6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:58:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33484 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfBIR6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:58:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id h22so9930477wmb.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 09:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YK/DOflSKRENwvRyyzLBwCPcZPmwpZNjPfSTaEYky+Q=;
        b=O1r9/wVFuIuKadK4e5/ZDBZvY55+IH1hkqGwEoWSVEPS2erarS8lrNd4xqySsKfrxL
         UnjPZMQ61E4Ujcl03JwvjZVtgoTNi36NP5S2v06W1x6xrr2kbYCAJ5Hn0zVXyZtEQ2ig
         Ie8lk2OAsfSIbBiOTEDttibTAWUn7f5sQ3QHdyfY0fGr6Y+CwDoKADjQKQnjxNCQ2luq
         irQP5ZbHi+0zENsuhSXIPziwzYIt8mazEYgdpy8FIYcJCcwC0wq1sXgkmFoTImHO1URL
         Lvl2kx22W8SZ3d85hTZBWhBU5ggNDNcpc8wJdixsaozZpbYlFrFxIUz7vtUDI89FNoVg
         EwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YK/DOflSKRENwvRyyzLBwCPcZPmwpZNjPfSTaEYky+Q=;
        b=sRGvTQ1TkNlb131hfb29rVHcW1/lB70RM1bPWqn4p5kVrpE8c789oNLEbYhzNgIT+2
         y/gxlkG6UGSTfMN/URSouDAg901CC4ZfH37RKOb2O+UI6SCgLiHw5Gm8NQBHEk5RJzyE
         33NnYH+Q/TT5co0wgrxBu+Lmb5cqJ6z2rhmzerIRXrqvPo+At3fpH9wsimcu1N1SD3mT
         q5rodAUrSCrWJhsPem88b8kawdR2zGL9K02wd6i5MDHw/gQMHAO+VShpbXM3N0/aqgME
         9VdV82zcrhEwI8+LPnQEdXgSqXgPsT1SV08dFB5gjejS+5CxtWYisMAFYSxAAWY3KQ1y
         IXQw==
X-Gm-Message-State: AHQUAuavn6xXFVxGQnYUmfm5+JzodwdqmFDHWs4Te3v42CFSokjw0BNC
        Wb0th0FX0fcz1X85PZPKfuIRhQ==
X-Google-Smtp-Source: AHgI3IYtxVXYfwS1NovZQhoOwjGhP+A8m9DiyexLYqlssmRWSZvjk2jmQ+NJ7jtQ8VwpSOxKpI64lw==
X-Received: by 2002:adf:ff09:: with SMTP id k9mr20315094wrr.97.1549735121477;
        Sat, 09 Feb 2019 09:58:41 -0800 (PST)
Received: from localhost (ip-94-113-219-55.net.upcbroadband.cz. [94.113.219.55])
        by smtp.gmail.com with ESMTPSA id p6sm4141078wrx.50.2019.02.09.09.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 09:58:41 -0800 (PST)
Date:   Sat, 9 Feb 2019 18:49:29 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next 07/16] net: Remove
 SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
Message-ID: <20190209174929.GN2353@nanopsycho>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
 <20190209003248.31088-8-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209003248.31088-8-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Feb 09, 2019 at 01:32:39AM CET, f.fainelli@gmail.com wrote:
>Now that we have converted the bridge code and the drivers to check for
>bridge port(s) flags at the time we try to set them, there is no need
>for a get() -> set() sequence anymore and
>SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT therefore becomes unused.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
