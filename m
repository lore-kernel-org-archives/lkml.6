Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B98C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F210320844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="fUdiZvIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbfBFNVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:21:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35691 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730205AbfBFNVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:21:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so2709916wmt.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 05:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oVihDgGO8uPGgBvemmcV9N9LOXygeTfE8hKfRmgbCNI=;
        b=fUdiZvIM+AdctwXpSn4r2AI3rsnnC5SNUE04bsqrNandgOCUM1ce+pFhsUKn+Osipn
         +9/PLKxh79WX+fh4bmwLsAvhoA+k84aMP31QPDE5fHvojFjgsy48+bPRtWo98OQx5woy
         xkYXOBZr/KmTWrIGqN23XtXCKDJ40ctzrbsKut76o/O/J7T7WcsrlHFNPYE4nTf1L/v2
         QH/H17Kxwp60h6LYg1Hvdqh4xSh/BeMj3N8GnzXlXYGgigOEKrnL2QlWtN/5Yq4uRzwg
         XIQcPganwOzz/IqP9hVvYlzqEs+T8jrJK56d78PpV6lYB4JH12u9jGQhI+5YrY4SLQth
         pQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oVihDgGO8uPGgBvemmcV9N9LOXygeTfE8hKfRmgbCNI=;
        b=I3Cz8uwuhJCpX9UtvyfvBURDyy49Zo1LY4jG1dgHyn+mtSx9Ctv1NFMnSclHo8qG84
         9UtPO+6QGtPynayTeOg+m/uXxobuIlHdBGUrWDM9bNHBkmBb7MA+lIX21Di9qU9+DVHj
         ibORu/Lu6/4LFzb2mIQN8dSvOLU7cC7t8dg6KoLOESQD0eATr+iDvjEtgOwn27ZIvwid
         Zl++mbvyKXr0JbN7SlLzm1RZQPwCurTTtEflIWo49MgHz/x0VnuoN/UTgCvT3Kh9C/ou
         wodSL9zZ2Qj/NgAzNtcSt231du7X+fj6A07j4gzmwTKWPmZRNa07gP7Eju3h0Ixw3Sox
         TQPQ==
X-Gm-Message-State: AHQUAubJojwk7LKC4dQcC+YxOzk3EObMQ6c/vjOAR6wNRssqNPQMraYA
        TDLoF+0cY6lKpwGTMLZgdVZ6bw==
X-Google-Smtp-Source: AHgI3IZH13lo8xK9pURpjj9trJUb9Ht9gb92xEEt2B4jrzmU2HahoekgyHqhAPQyt2BNc9CUxZb/Ww==
X-Received: by 2002:a05:600c:2143:: with SMTP id v3mr2005686wml.120.1549459271431;
        Wed, 06 Feb 2019 05:21:11 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id i184sm15382806wmd.26.2019.02.06.05.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 05:21:11 -0800 (PST)
Date:   Wed, 6 Feb 2019 14:12:00 +0100
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
Subject: Re: [PATCH net-next v3 04/12] net/mlx5e: Implement
 ndo_get_port_parent_id()
Message-ID: <20190206131200.GE2189@nanopsycho>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
 <20190205235326.14600-5-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205235326.14600-5-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Feb 06, 2019 at 12:53:18AM CET, f.fainelli@gmail.com wrote:
>mlx5e only supports SWITCHDEV_ATTR_ID_PORT_PARENT_ID, which makes it a
>great candidate to be converted to use the ndo_get_port_parent_id() NDO
>instead of implementing switchdev_port_attr_get().
>
>Since mlx5e makes use of switchdev_port_parent_id() convert it to use
>netdev_port_same_parent_id().
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
