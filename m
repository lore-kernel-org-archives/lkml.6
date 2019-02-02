Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7489C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25DF2085A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="vIKlbGZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfBBQBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 11:01:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39195 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbfBBQBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 11:01:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id y8so9112393wmi.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 08:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=97g4P7ElyV4vGOSQXSTGIwWc8CwGSr5dI2uy0oN/ke0=;
        b=vIKlbGZCRB6RUUrqRDjFL0wm0q7rN5iLgMgWvhTpqBx9Tj2izGRMA9drFIhg/8IGLO
         Xw6K6cUIEIaPciX7N66JvOD/fhYkztm51qxE9lvmFUKjeSx9PsBWcfEoFlXbUQ2oUUvT
         3cVh4syVB5lhCbiIS1zLEULZVYKImwYKg3w//EgjZtrSn5PGo/Ssmszs2G49d64OTCGv
         h02NZgp1nSVpDac8sOkiKxJK34OzZ7RspUDqEfZjV6t+fWpcZngYcLsNJmZvazTjRjIX
         Xc1ZbQUYT6td1cROl2qabIEMow1SqYaDjknNzA9OAOetP/SfewafjItfedNXrTPhS9Rf
         044Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=97g4P7ElyV4vGOSQXSTGIwWc8CwGSr5dI2uy0oN/ke0=;
        b=H0slA/xVNwZDvgUSwDayPRCm2BSdF9TwK+IEyNYhuYVJMqeiA88rYttudOqZWQQXpx
         lRVNN2pMTpD66wephfb/BErFQsonB0DuGmj2uBl2Wjs3fvlg0gHJFNewaVlaXJ8ek4NY
         28hB7n2jTBhwe6kp0Xgz50cK3GJ0B4YkD6NV9u7uZpsVczUZVSLbBh7MI+umy/zAMb6U
         zKU1XoSDYKNLG5vZqi/pS/zReYTxJbSXdvWsqvZ2vvQ0uUZyrqfWK4AShDS3s4NkYTzZ
         YpjTGd/M813y+etHSmQBPJbFzRxuI9T8RXQs/7xfS4vPjywW8pWg9zhKWitDybK5Ezid
         /Q/g==
X-Gm-Message-State: AHQUAuacFr4Co7wnjOB8eR0/lnN+GRNftA1vMTi3mUEDYWuMR3wPxm3s
        OOTvM0hOqt38NgnlfPV+nznH3g==
X-Google-Smtp-Source: AHgI3IbJONdLa76vHYHKhfEpYPpbri9rvbvZR3RbqWVkpQFnBKWc5Dn0xaPxp7WM57TChcLKrezRZg==
X-Received: by 2002:a1c:2902:: with SMTP id p2mr6645449wmp.19.1549123295584;
        Sat, 02 Feb 2019 08:01:35 -0800 (PST)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id m13sm5992195wmd.6.2019.02.02.08.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Feb 2019 08:01:35 -0800 (PST)
Date:   Sat, 2 Feb 2019 16:52:31 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "Francois H. Theron" <francois.theron@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        John Hurley <john.hurley@netronome.com>,
        Edwin Peer <edwin.peer@netronome.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MELLANOX MLX5 core VPI driver" 
        <linux-rdma@vger.kernel.org>,
        "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>
Subject: Re: [RFC net-next 00/13] Get rid of switchdev_ops
Message-ID: <20190202155231.GD2778@nanopsycho>
References: <20190201220657.30170-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201220657.30170-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Feb 01, 2019 at 11:06:44PM CET, f.fainelli@gmail.com wrote:
>Hi all,
>
>This patch series converts SWITCHDEV_PORT_ATTR_{GET,SET} to use a
>blocking notifier, similar to how SWITCHDEV_PORT_OBJ_{ADD,DEL} has been
>changed recently by Petr.
>
>This was suggested by Ido to help with a particular use case I have
>where I want to be able to veto a switchdev bridge attribute from a
>driver (multicast_snooping).
>
>Please review since I may not have gotten the driver abstraction right,
>especially for mlx5e and nfp since these are *hum* *hum* large drivers.

Looks fine. Thanks!
