Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9103C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2C620846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oQenGgBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2C620846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731898AbeGZXbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 19:31:08 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39223 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730581AbeGZXbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 19:31:08 -0400
Received: by mail-wm0-f68.google.com with SMTP id h20-v6so3453560wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 15:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P9AV9njPHMHiiBj7gxGy3OSYdBdnw9v6TfiYXaYQISk=;
        b=oQenGgBueaCbwLRlqOlcPUA5td4A9fkVvQNkoL7Lodo+8/mx0FEIqxlEkvHYwWX+aM
         y+pCtx7dI2mROwVUDrXE/dPDaxzgYGk4Q3RLYDCAQNEahPh4v6gHXnphAonQd2IZdft8
         Wm9sTib4F2NW+IqsY/U59yfezXeI3A3Qrbyfd4qfAANdQsSYAB4B0gAd7dVzAFrFKBfQ
         hOOP3TlclFWJBqhhuCGC1hkM6+5LXOy3XxD65QPkUMZROHYVwpPCkkAWwGR/9YMoWV5H
         wg4K3iDqegprHBNUpx4uG0NGpkWGQBKQkd2jFWkq2J07vqJo0jYTtH2TTlnNWV44AhcR
         2TUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P9AV9njPHMHiiBj7gxGy3OSYdBdnw9v6TfiYXaYQISk=;
        b=JMOODBUfGexJ2+6WEzICN71fLuZ8pNxMoqFoKkqLAuGRc76ULjb3DaeOnhN3k3sAQq
         5bbwU6ZmOu4ZhwAQb1EHxXkvizjsEiIr96jW8hfIDmoVItyikHb8VmqHq26wpX0nb96+
         38qjfKgypTlc3PRl0LPqq3Xk1FvG8WTyDW9PpqEpHh0BH2F83RORRbgDGDFgp+yFisO6
         FYcL8ihEquCXFSBtH1iKsBtOW4Q5yfaWaoFgaWlCVQaRfb1T2xXlfvAuuylulrmFZywq
         raVHM0Ri8xldhVJP1SC+fsieOf7eg06jb/n62RQ0DjsDHe38s6T3TwJW/g3f5gDrpyyb
         m2NA==
X-Gm-Message-State: AOUpUlH1Aa4JlgA1XYh3PzcVtytRSa2U4QxbkuvIXKU7FWapWfEmQ5nZ
        iu+5ZbH8Y239L32EIFt4yhqHxA==
X-Google-Smtp-Source: AAOMgpctW5znNY5lLKNndeUj8HZtkWyvC6UwCNOd+4rh+1OHEKOnWf1bd94OlMO+R4T890Bjkgz+Fg==
X-Received: by 2002:a1c:4182:: with SMTP id o124-v6mr2553040wma.101.1532643138609;
        Thu, 26 Jul 2018 15:12:18 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id z8-v6sm4525767wrp.54.2018.07.26.15.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 15:12:17 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fioUY-0003Z5-An; Thu, 26 Jul 2018 16:12:14 -0600
Date:   Thu, 26 Jul 2018 16:12:14 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Qing Huang <qing.huang@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        dledford@redhat.com, leon@kernel.org, gerald.gibson@oracle.com,
        danielj@mellanox.com, sharon.s.liu@oracle.com
Subject: Re: [PATCH v2] IB/mlx5: avoid excessive warning msgs when creating
 VFs on 2nd port
Message-ID: <20180726221214.GA13670@ziepe.ca>
References: <20180723211508.7078-1-qing.huang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723211508.7078-1-qing.huang@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 02:15:08PM -0700, Qing Huang wrote:
> When a CX5 device is configured in dual-port RoCE mode, after creating
> many VFs against port 1, creating the same number of VFs against port 2
> will flood kernel/syslog with something like
> "mlx5_*:mlx5_ib_bind_slave_port:4266:(pid 5269): port 2 already
> affiliated."
> 
> So basically, when traversing mlx5_ib_dev_list, mlx5_ib_add_slave_port()
> repeatedly attempts to bind the new mpi structure to every device
> on the list until it finds an unbound device.
> 
> Change the log level from warn to dbg to avoid log flooding as the warning
> should be harmless.
> 
> Signed-off-by: Qing Huang <qing.huang@oracle.com>
> Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
> ---
>   v1 -> v2: change the log level instead

Applied to for-next

Thanks,
Jason
