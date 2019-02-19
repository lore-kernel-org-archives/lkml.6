Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CB3C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6F92087B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XhwxZm6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfBSXxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:53:53 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:42414 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfBSXxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:53:52 -0500
Received: by mail-pl1-f176.google.com with SMTP id s1so11201350plp.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RVTkpac01g3cNfe4Xc4xF+D8LtAtD2ekFLf0SwyqwAM=;
        b=XhwxZm6J8Hl/tfw1PuOFnkOWuv4pOqCleFp0ncPJuBuObZNAPTkXlKNTyQH/IzZdFf
         zdfwVujZs9TFDjhsi9sZirh7a8aTZmbbHc/TaSJ698au3Y9Fu+RJCM3EE4Rosu0/OXY0
         Tjs5xPnvdTGoxVUNQVhkbtyoAa8ZR0wmnHmQ95pIKkgPR6JWrqDDMUY1c90GDo2qUf2u
         flZFDW6HHHnXgknGRBqvwcvsal0Qi9DNvYIUHVaoB6Sm+p673VmPqDZ9PtC7tiivM/Qv
         zwYlYYLEPVVhKuDe3YIJiYJ0UlO/gjyboowcHxgqrXunZgzk6h0qS/cXCagGqrGYtgU7
         B/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RVTkpac01g3cNfe4Xc4xF+D8LtAtD2ekFLf0SwyqwAM=;
        b=lgeA/EN4mUt2jecq6IVPjXRod6CG8MbV4FL3mCJxfNv7JeltS+e6zTHUL+0Mfyw0zi
         28kgl2L0r1/CQ+IggF0aysNXlCY2mik6dSJjbcU6/Md6JdLGBdeiSdSv1ZGR3+2ulClS
         2UUQYvMaqPa36OxZYkSBoNowOXHakEVv/L0YkZDhneDv3tAwHGwYZo57dqempjvZcBHX
         S06QCnBfcoCGzQhD2GNKEUN31/fJdywrWfCStaxzOc+x066MoWEkbJI4dNHSflTG+fgY
         M3THkuA8usV7stL0D2JJ2nwWDoj6b/zgSxdT9pOGn01YZFMSc6HzIxDzAmS9UsEFie13
         9oBg==
X-Gm-Message-State: AHQUAuYDijHCLKP4ezN6OjjCwIXenJg1i30u2zocrX3LbNKUX8tebU/9
        NqwjbdooHpk+gRb5tgcBLD/eoQ==
X-Google-Smtp-Source: AHgI3IYRY6d0eUH61qZaCykgm5rbBAhJxTk+g2Av1/9Er8Pn4n0rpVkPCGpzzuToyQ6svK19WT7G7g==
X-Received: by 2002:a17:902:2a66:: with SMTP id i93mr33778640plb.128.1550620431769;
        Tue, 19 Feb 2019 15:53:51 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id y5sm29416041pge.49.2019.02.19.15.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 15:53:51 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gwFCv-0004Zb-Rb; Tue, 19 Feb 2019 16:53:49 -0700
Date:   Tue, 19 Feb 2019 16:53:49 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: xarray reserve/release?
Message-ID: <20190219235349.GA17351@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Matt,

Did you intend that xa_release doesn't work on allocating arrays:

	xa_init_flags(&xa, XA_FLAGS_ALLOC);
	xa_reserve(&xa, 0, GFP_KERNEL);
	WARN_ON(xa_empty(&xa));
	xa_release(&xa, 0);
	WARN_ON(!xa_empty(&xa));

Triggers the second WARN_ON. 

If FLAGS_ALLOC is removed this passes

This creates kind of a confusing / super unexpected situation where 

   xa_for_each (xa, id)
       xa_erase(xa, id);
   WARN_ON(!xa_empty(&xa))

Is not safe with XA_FLAGS_ALLOC??

Seems like at least deserves a documentation note.. Or maybe ALLOC
xa_empty should do something different?

Thanks,
Jason
