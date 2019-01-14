Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFE0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99BBE2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LbusiBAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfANVE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:04:56 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:39605 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfANVE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:04:56 -0500
Received: by mail-pg1-f175.google.com with SMTP id w6so184482pgl.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 13:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5md306cRDCf+yVfQT3X44HFwI5LlQ5koziB7a+AgZL4=;
        b=LbusiBAJxasPV06nsSx9rOca0GTDE/b3Rs5CeXUmhQZUE/NFkthm+ms42HEWDKl60A
         mohxu5wWzsY2AISvIFTQZ9NBYMf6TccCQVl+O44HvURmNVs42/N3UNOcFGDHLe0r11p1
         MZFvff480lAwO96XQabyZIPHh2obdZXJSrZSfvLwxNc/eRjNAZTeVpUInXKV9e1ynOgI
         qQyJOmKoxqs3E3xoaClWWttwMP5chlSgdQWSuzi5iEhlF4KBTpgcsobH76blV0NFEKEc
         J3LaepVtz0deopv1CTvH+LTN3NFdgO8C8iopWDY0n8OMsi/hSR7TDBcqhwIzBCO7kY09
         iIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5md306cRDCf+yVfQT3X44HFwI5LlQ5koziB7a+AgZL4=;
        b=I2xHAA1FLxVxQGseW4TDvZwQnTzQ7lIPHBoWI6b1K1ds2K6IyIdmk+mPaw2UN06iAR
         x7jDGHPjb7Q/f6ec980Fx/py02/sH8CNKVkXsUQZVjsMthZGXNuOfprIpmi1b99WivUS
         KjDe539I6XLeqQ5Dz/BzmtmadGA76/2+6/J3X157LdQNgSoYkkFEQj/vMe9hnMsJVuQY
         UmjKV+AEdKRkgvPqpcBwgTotaIQTPM5PLsxHBWFebJftEA1QVj9YLzIpTdEcIEmUREcl
         kQb65u+s0040EIfHkc2WMsVK8i902/4YD9yaWdT7oBqNayPHVb7EAQ/CVmqKPsTZ9kd9
         tN4w==
X-Gm-Message-State: AJcUukeoj8ryO2qtztPWYB3Gzd8WXea09+nB/nC9b0V8EEQd4vx70549
        CvSHYpx793eOuh5vXQCeeAeztQ==
X-Google-Smtp-Source: ALg8bN7FzDnQqG6JCuK4gyWvA/EoxZWzSq/IKHcogr/k3hwpj8cYJoSNaHuqQZgCB0qa0kO7mxS0Mw==
X-Received: by 2002:a63:f30d:: with SMTP id l13mr394699pgh.399.1547499895690;
        Mon, 14 Jan 2019 13:04:55 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id x28sm4318687pge.66.2019.01.14.13.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 13:04:54 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gj9Pi-0003Uu-6h; Mon, 14 Jan 2019 14:04:54 -0700
Date:   Mon, 14 Jan 2019 14:04:54 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [V2] infiniband: fix a missing check of nla_put
Message-ID: <20190114210454.GA13422@ziepe.ca>
References: <20190105161808.3496-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190105161808.3496-1-pakki001@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2019 at 10:18:07AM -0600, Aditya Pakki wrote:
> nla_put() may fail. The fix adds a check for its return value, and
> returns -EMSGSIZE if it fails, post canceling netlink msg.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/infiniband/core/addr.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Leon?

Jason
