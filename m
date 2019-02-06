Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4C3C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A1B20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="xNYgmvk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbfBFNdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:33:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46821 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbfBFNdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:33:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so7512565wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 05:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eaxPR3z7jjeKy2WDq+VlhPAOH1MBT5YGsXvlTm/Dows=;
        b=xNYgmvk23k9PV8Na3qHZyo8sgIkvb5TJHmbqS46lLy2pdbF3iQJlEYWrXbaCvhpblU
         ExHfodXYpnsVAQlr+mJ+h8vc1UBadTrHqycNhPc1e3kQqWoKeICr2CNOTvyP27zdB2Qq
         1jbL3hkMt5TpMifNUsQzeSGC6tBUfbV1QWG3sr4jJYFEE++D8rEXsU7yLXfnIkp5ru48
         Jh2sAc4mbyK+t9PfIS427V+02zwvyF67uFjvWVmLEZzPy686YJ7Yx+inBisPntom8BDX
         kISWe3xp5aRs0qx3NrXDPiAvaAQC7juzWvnwuxwlQHxvzSVZxzczINlqfu+XaKUEewot
         VtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eaxPR3z7jjeKy2WDq+VlhPAOH1MBT5YGsXvlTm/Dows=;
        b=VeURLur6q0gAgVOX6yAqfROMnGXFm/wF/1ME2Cxyf0ciu4l6YcKzsgdhVCW2IX3lpE
         QPphvr7UiKX23EUFqVaXIZ8CCFa82ovzCOBnPoBWx/xu0fIGBDnZ7gbamNT7iIt+LMuu
         yMGp5Br6aOdInnEbmuXDUQVRqvEPqKZmfci+rUz3xp9EVMADWkNcExMgXPLu8T4/PxSO
         CJP9qgYZ9AR0DFX6Z8THCiP/nBIJldA69sAJC7YNqhJDQxmT8HwdePOgMoR+K99lzAUO
         dEtYYqF1rDYEXyYmmXs9824K6dxONXB/h4xA5uBhciIPftCEL+WrQR611i9HAopZ0ts2
         mkqw==
X-Gm-Message-State: AHQUAub1TNav+Lhg18dSEubTNPcyTIUM4yt2aP4iNaxK7JHcD+SVjTYT
        IyWdip9JCCkyk3M1Ofv6Fahkkg==
X-Google-Smtp-Source: AHgI3IaIzcqRkqgXxXRqkfAWVIeR9lafOBE/Z7qK/opZ6b3tmt1Py0K76TvxSH1xut3QEz6WWHWliw==
X-Received: by 2002:a5d:6187:: with SMTP id j7mr8033295wru.300.1549460011325;
        Wed, 06 Feb 2019 05:33:31 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id q6sm10042804wmq.4.2019.02.06.05.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 05:33:31 -0800 (PST)
Date:   Wed, 6 Feb 2019 14:24:20 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MELLANOX MLX5 core VPI driver" 
        <linux-rdma@vger.kernel.org>,
        "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>
Subject: Re: [PATCH net-next v3 09/12] netdevsim: Implement
 ndo_get_port_parent_id()
Message-ID: <20190206132420.GJ2189@nanopsycho>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
 <20190205235326.14600-10-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205235326.14600-10-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Feb 06, 2019 at 12:53:23AM CET, f.fainelli@gmail.com wrote:
>netdevsim only supports SWITCHDEV_ATTR_ID_PORT_PARENT_ID, which makes it a
>great candidate to be converted to use the ndo_get_port_parent_id() NDO
>instead of implementing switchdev_port_attr_get().
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
