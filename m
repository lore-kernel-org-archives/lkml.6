Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E8FC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7022081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SbsZxntr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7022081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbeKCBQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:16:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43776 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeKCBQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:16:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id g59-v6so1212748plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=toZ6GdabPKpTESOWXZ385LSkM52vFCYnsUVWju8J4s4=;
        b=SbsZxntrdWE2mWGUWeIpye7JnqUzKXrPt0C5+eCoLcdclGSkG/+pZqHiIWv3Y2wQiq
         Yt/zmzL2u4GRWykWyl8tBSQr2OoFbU2pOihqVG+W/csZeloC65zSI6MD/n7GfN0xUkG6
         cc+2kkhQeHfJSBWdIBZEXbNkPkcJN3RYzi6xpPQiYA+nA0Tr0b26YBEEMkYJMlxERuAm
         2dTZHRdrQpL0osNiZcIgT3wNBCg7LVDLKnr8lKREEkwesWLTwKDPEjURyJTEnyBepdtw
         5NzDF57dFCZD1hNScvw274/G3Xndm/38NU+RSvTRcSijq2KhjRa0VcpeHovJyBuBMqNp
         buEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=toZ6GdabPKpTESOWXZ385LSkM52vFCYnsUVWju8J4s4=;
        b=oguwUoNpbDuMGMe93ySFbUdRUOX35EZFG9rzWd9Q6dm3aXdnwyyKvXo+DUK8Z12NVv
         jfsEsbfb4FRMQ/XdVoH0C5K3xgc0QsPD0GbqI3q1vRQmfngedZxp3cdQ/naFgX2MxPG/
         K4vDca10MVROVZEKoHUWRFS48/6w7Vhtuyei6JVG6QmtMLY0cDfcR5/iQVLX6DJeq1aA
         XUaxqGK45cbk2WL8yfnoIb6xDWFv3svzq5SyzyqdL4FXKGbfFc2nxUgBSQJ82/Zrbd8g
         VhEI5exUYrc/Hk4yDG4nlJ3A7LG/u76T/lbwonsTduwKFVUnCZGlJOBzngwmNF4hFwK4
         7Eqg==
X-Gm-Message-State: AGRZ1gKdJWqzXiP7V6Ea0GdwguieExnFXntT1zlQ6nGCN+exJiJ7HRhm
        +yGFo048Pnw178e2pWIMLxMhzIOhBYU=
X-Google-Smtp-Source: AJdET5cwpiDM9qEQSc13UaEs4yOG6aNiBAmM0zECVdOZk17h1nMgaq2mxgy+S6RKjX4+Ji5DNvcaJw==
X-Received: by 2002:a17:902:187:: with SMTP id b7-v6mr12344982plb.150.1541174940925;
        Fri, 02 Nov 2018 09:09:00 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id y18-v6sm4667638pfa.136.2018.11.02.09.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 09:08:59 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gIc0I-00055w-MW; Fri, 02 Nov 2018 10:08:58 -0600
Date:   Fri, 2 Nov 2018 10:08:58 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Tariq Toukan <tariqt@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Moshe Shemesh <moshe@mellanox.com>,
        Kamal Heib <kamalh@mellanox.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5e: fix high stack usage
Message-ID: <20181102160858.GA17096@ziepe.ca>
References: <20181102153316.1492515-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181102153316.1492515-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 04:33:03PM +0100, Arnd Bergmann wrote:
> A patch that looks harmless causes the stack usage of the mlx5e_grp_sw_update_stats()
> function to drastically increase with x86 gcc-4.9 and higher (tested up to 8.1):
> 
> drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: In function ‘mlx5e_grp_sw_update_stats’:
> drivers/net/ethernet/mellanox/mlx5/core/en_stats.c:216:1: warning: the frame size of 1276 bytes is larger than 500 bytes [-Wframe-larger-than=]

Why is the stack size so big here? The mlx5e_sw_stats is < 500 bytes
and all the other on-stack stuff looks pretty small?

> By splitting out the loop body into a non-inlined function, the stack size goes
> back down to under 500 bytes.

Does this actually reduce the stack consumed or does this just suppress
the warning?

Jason
