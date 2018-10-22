Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C3FC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1939420665
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6fI3m1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1939420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbeJWHDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 03:03:45 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:41387 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbeJWHDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 03:03:45 -0400
Received: by mail-ed1-f44.google.com with SMTP id x31-v6so39508138edd.8;
        Mon, 22 Oct 2018 15:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6KFMjOFlkzlc7F5cXnoYnTs8uQnldeE1GEZkggi0/KQ=;
        b=U6fI3m1gP/7tYLDJPTJ57sHzAXt4FrkhlDol6gRepLhYWIB5l7+MquOfy+FShaWq6Y
         qQjhbnVHXP0Kop/h89V10Ve7098pmHXxme24E84bzQEgEChTfZlER3aYKD6UIJxeu18u
         4CAdsKimJlQeHDLNmV45D11ApMRpsi3dpIHwK35+yBrU7Fu6mVoDvVST5igCBCTZqKRS
         6IDYt+uLrDvsW8G764TM2B8YfVjALX+NKb4+52KDqYFiNkEujdL1ulThnSXn0jMjw1tT
         Xk2MFfMRyc7bdrkmkQ3WH0BfN2loH+QoDfMtRKcrot9k6xRzdLyYxVQwirWMSOLZsr5y
         4piA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6KFMjOFlkzlc7F5cXnoYnTs8uQnldeE1GEZkggi0/KQ=;
        b=N+4iMWeNpok2oslCy4NaqxvdYyjeREOJrLwN6SSAZEpSfD8La0QDuEuIVd3vDq3Csb
         dM0AGTaT9lBtp1DgMMpGhmeP1M5YaEnW9dO74hTnl8MqIGCDgzrvdE7MIRH/c0QCVUbt
         krjwS+N2rOoUHnOB+3ocirv4wt8F2A7qNMMRa073MEm9YLEVdAasrs5ohCLDihFjO6Q8
         VcLyjsjLX3/vfi9MigtsX4YJMoZcLcdK3LIl3c1+JGXcwoDxojpJBUQXKgF073ZjBmTD
         aqFufw5lrkAkFUUF2tfOutsGHIOZC1Cps0Kt0oKRocxOOq4w3AoVdpOLpbGRKQAnWt0d
         cH8g==
X-Gm-Message-State: ABuFfojFKQbNZH3q44FZ503vxn+4CHRbh5gmcb+dvNBFaMYHN7AkNs3S
        eBzizYOPpkSykqE6/rKFq7k0vqa8
X-Google-Smtp-Source: ACcGV63vtlhgm7JdNaqLtyOHGlPoGcSoyKDMaRCC4GxPbCJlOHaH/q0Noab9+heOaOfuZasiTZUxNQ==
X-Received: by 2002:a50:eb97:: with SMTP id y23-v6mr14088639edr.38.1540248194829;
        Mon, 22 Oct 2018 15:43:14 -0700 (PDT)
Received: from localhost (195-70-108-137.stat.salzburg-online.at. [195.70.108.137])
        by smtp.gmail.com with ESMTPSA id m11sm11924518edv.90.2018.10.22.15.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 15:43:14 -0700 (PDT)
Date:   Mon, 22 Oct 2018 15:43:11 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] ptp: ptp_dte: simplify getting .driver_data
Message-ID: <20181022224311.xpzs6piq5khgg3t5@localhost>
References: <20181021200039.1933-1-wsa+renesas@sang-engineering.com>
 <20181021200039.1933-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181021200039.1933-2-wsa+renesas@sang-engineering.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 10:00:39PM +0200, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.

Acked-by: Richard Cochran <richardcochran@gmail.com>
