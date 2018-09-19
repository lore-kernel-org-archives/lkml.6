Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02F5C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A94D20858
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bW7SfUwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A94D20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbeISVwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:52:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45811 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbeISVwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:52:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so2923295pfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=emUEFn0OcajAlFY/h/sddojpuUAUq45BqeIFhvEdgpw=;
        b=bW7SfUwZYX3WdkJY+AUGos1TWKZoPFQoGDcS45xzGlc/2amy6IkhzUWMJojAIyG0FJ
         eywgOq7EQcv7j9RqnqnW5VS4fkoFRX2LlyVlGhnheEw1ZwVB2g9Tig181qQQd72AKwsQ
         k61JFXqNsqtbLUfcva6GHx9akvJSYIqs3XMkHpQmtyfukwohNpGPwLCNLlkK2kvdLyXa
         nps+9bp8d9aOhhR+WrPz8FV/3wLTl7iCDm5bCBnFMZOsTeEnYgMHed27igTGfA0rtfNe
         vzYcqxogIUvrTH9MFW+QmNI9K3XXDzUK6WAdI4WGLmJoZms0e/bP5fDLlVEtyoVdqWVL
         3Wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=emUEFn0OcajAlFY/h/sddojpuUAUq45BqeIFhvEdgpw=;
        b=McgXfNSm18Zrus7Sd4Kfdm8RWvRwLjd4ecMtOixPISq8Xrzhyq4R+E1gasFj7nWrym
         97Wj6GHlz3k2SCzuAavCz6AtFcgK5hkxS38oOvrwXwDU68wCZtcMJ7zfv+SNJhWYNsgU
         e1ZC7SfImlor6VM0hituUPxmGqdjFy5DE9LcOQbY+lZ5dME4lXLFbbjcNFSioTHOGbTG
         306L/eZTz0X/p0Cq9vl1PhGR71s98KoR8+PIx0KmKvTIyaqSHg07bxuUEd52Mw3yUGhj
         qRKy0Rklt4S/LMv6WUJwEcLYd87vTCcXngbnkliCiCJ9Cz19FlGIKCFIBay1P0UWNlaP
         YJ4Q==
X-Gm-Message-State: APzg51BZQ/pEEI7fyDgpNuN9hddYCFrzWMywuSS2lucf86fl1dEOpXAh
        IJ3NQBn9W4BMZcSWEhocE7uflQ==
X-Google-Smtp-Source: ANB0VdYptNUgqzWWrUrGvz4PbUWdCDwYj4yJvyuaC+VZwMGeziJeX3UX+aqCH5MDrdmG9fDmjYYnlQ==
X-Received: by 2002:a63:6385:: with SMTP id x127-v6mr33447667pgb.413.1537373622917;
        Wed, 19 Sep 2018 09:13:42 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id p19-v6sm34260287pgk.28.2018.09.19.09.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 09:13:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g2f6j-0002Zp-3q; Wed, 19 Sep 2018 10:13:41 -0600
Date:   Wed, 19 Sep 2018 10:13:41 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     =?utf-8?B?SMOla29u?= Bugge <Haakon.Bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>, faisal.latif@intel.com,
        shiraz.saleem@intel.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/i40iw: Fix incorrect iterator type
Message-ID: <20180919161341.GB9867@ziepe.ca>
References: <20180917140707.1253738-1-Haakon.Bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180917140707.1253738-1-Haakon.Bugge@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 04:07:07PM +0200, Håkon Bugge wrote:
> Commit f27b4746f378 ("i40iw: add connection management code") uses an
> incorrect rcu iterator, whilst holding the rtnl_lock. Since the
> critical region invokes i40iw_manage_qhash(), which is a sleeping
> function, the rcu locking and traversal cannot be used.
> 
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw_cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
