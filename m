Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66A7ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B5D214C1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="kPpsAKSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B5D214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeIWTFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 15:05:38 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39469 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeIWTFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 15:05:37 -0400
Received: by mail-lf1-f65.google.com with SMTP id w21-v6so516294lff.6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 06:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x2IViEJkkf+X9rnatrmvnx2QFgIT3F5HrvrhwaJBwNE=;
        b=kPpsAKSFpCRbWnfu7lxvcR8dbXkXD2aWe8TSDEa/QmciKgsISdbSEOVd3Cl/QKzjzN
         6ktp3PWG4bxp2RA5sPl6KIt+JqrBtcGiHSYw7FEKKXxuN8GN4AuixdzxnwSvrH2h4JMB
         kKJo5fUicgJs0r5XxoyluFRO92WCU0zv/2c1DA74nPMb7z2JFt+OoNd2yxWjBgfgD/Uv
         PTR7Uq6GsdMOvYktlZDYB5bK/0AOIbTcbAr4fduPNdrqCxOYJNQ8V17Um/owJma2PTn5
         rwhgCIBX11nLrrxrXvb/ExgAad2H3FX/1yehLsZogb8xh5TFVE26NTcoPJ064DZWEKf0
         XkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x2IViEJkkf+X9rnatrmvnx2QFgIT3F5HrvrhwaJBwNE=;
        b=ahcYiuvIDWjXqPEaa3vgPWKuee8eHVUCDCvjYUze92hXjuoDhDOTE+U17I0H5IdBfe
         CBtx6RI5dj6up0og8/y4EoA9LBT3xCkflr92t+16oyqq0op4HCBsaydS1v9axcSYyNoz
         3XHO6m9BAvvQ8ctePsCMtUBxfKEdJGObIFL4qvPniliCWOTqNRXvOsyqGzvYYYewe4DQ
         1IF7L903Oj4oRUYYSszq1Qss64KaOgo61GuQ+JJ3UOIeUvDXtk47wA8dq7AU7TGCE6JD
         kySIsvhcaA8+q311ZqwFR7vssYFGyp7Xpiw9oMr61866VXKOL+MnJdF9HyCg6fSeYd1E
         s7Ew==
X-Gm-Message-State: APzg51AZdFSLBikENVHpgRcjA5HktZo2acqblpXuugHVEHqM1AC56l/d
        191n1GhXwXwuzKYjfE6nwghITQ==
X-Google-Smtp-Source: ANB0VdZevKJwUK1JE6h6MNBx01wgHGNaJyRBvGxbXHIqUHLZlrbY1Y+Ds7P2twSIUBcdkNOP7PKrQA==
X-Received: by 2002:a19:940c:: with SMTP id w12-v6mr3811321lfd.0.1537708089930;
        Sun, 23 Sep 2018 06:08:09 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id p9-v6sm6050130ljh.0.2018.09.23.06.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 06:08:08 -0700 (PDT)
Date:   Sun, 23 Sep 2018 05:30:13 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     arm@kernel.org, tsahee@annapurnalabs.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update the Annapurna Labs maintainer email
Message-ID: <20180923123013.b6eosbnrnuwiuenw@localhost>
References: <20180919065802.18846-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919065802.18846-1-antoine.tenart@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 08:58:02AM +0200, Antoine Tenart wrote:
> Free Electrons became Bootlin. Update my email accordingly.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.


-Olof
