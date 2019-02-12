Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BF8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120652073D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="s/a1RA3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfBLJFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:05:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35433 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfBLJFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:05:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so2123239wmt.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 01:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ogAqsVbYzz8+/eNLrfkEalfDGmknI6uqJ27faayKdkU=;
        b=s/a1RA3N7yzNW14RJe77Jmoy/uuDtCXZfJ4y/X0YH4OiZt2ud8EGH2pRjZC2MpT6Ol
         n1aHZplNMb6eIiVS16Fr9gyihFgndAgSURoWVxIWcxfwJj9UJOUbmwv/UGnXyBX4uvJl
         JfQOLYDq24rLaQycjynXIYwqLqPmoTLYCerhiJzsULr2hU2TljQBd8gTJg/Xz3W83k9y
         geeTjaM/0be/e17sw5N6o/fI97BkZGR7K7254yCyjR99Lcug4sd6hDLnqLBweiKrnBZT
         46evoBziGP52lBC9KNeCdjut+4BVteVcqjs0o5UX8ctoEnMmANaqFh/vLnGrKJkbAl/o
         oczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ogAqsVbYzz8+/eNLrfkEalfDGmknI6uqJ27faayKdkU=;
        b=gSUW8bsLZoJuELZxOD8IcCRoxhjSzhuVvIoCGO2Z2oL2bNB7ayzxH3mm7+oF/9G0tQ
         Yt/6vNJK+f9HUNoPMWs+pNcd0kYue37/+6De7bSgxcwa2bHjNvKQRoBolgkwKaXHKWrg
         x2HksHVlamQ2E+XKI9uFKA05VgPaS4tVaVus9XbxCIkh0uRbB7ZDcG0TykCUuZFJMXpE
         cNFRICCTYe5kW++DgGFgzjDMJ3PqOjgE951HRcen9LWJ61xvlngGn8rJz7Y/K3OS37Jv
         onMvoGXiZscpQiHtTAh/yx+GFBFLF7ua+jsay6OghU6Kl+CPT4pq5NvSVyINcRJ7wW5c
         M6kw==
X-Gm-Message-State: AHQUAuawA+mYBtvrMWLROj8f3nIJYkCIqEHTFqvwsMaeSopjnvRjZjTP
        zKAGpQezMOdPMB5ZIDNgJzAyUw==
X-Google-Smtp-Source: AHgI3IbjvXMdfJlb0SXAZ81uOKmXkKPBWl9QWs9b+1AnjqIBCUS8RURK7vFPl28EyJ+z2LB0Huor0g==
X-Received: by 2002:a1c:4009:: with SMTP id n9mr1976601wma.132.1549962323589;
        Tue, 12 Feb 2019 01:05:23 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id o9sm1543494wmh.3.2019.02.12.01.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 01:05:23 -0800 (PST)
Date:   Tue, 12 Feb 2019 09:55:58 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next 1/3] mlxsw: spectrum_switchdev: Remove getting
 PORT_BRIDGE_FLAGS
Message-ID: <20190212085558.GC2881@nanopsycho>
References: <20190211211749.19847-1-f.fainelli@gmail.com>
 <20190211211749.19847-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211211749.19847-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Feb 11, 2019 at 10:17:47PM CET, f.fainelli@gmail.com wrote:
>There is no code that will query the SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
>attribute remove support for that.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
