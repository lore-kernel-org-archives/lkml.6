Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A357C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C21C20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="g4KQmDO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C21C20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbeK3Kqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:46:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39858 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbeK3Kqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:46:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so1638598pgl.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F8AKlnU/YZniF3fFN7P17RcXIo/RtheGQptMA/Tw4qM=;
        b=g4KQmDO2taEhP3z1uw9xGDr3uw2k/4jsahHZrhC1ddWqgtWdzis0b8Lc/CufXOtLAU
         ZFCjKa0o7APghCQ6w+AJzYrM73C2/YIVW4bFniSOHpm5cZSKLF59igyoB1gX6KEy3IjE
         Fx6Z/Chxd6D7A+Y2YoEkRRf6U/I5eZaP9Pykx+le63rjxF1Oug4H4auTQshBFAOKIf+2
         5nsKmzb/+7iOt1InodR8c3yOo62t4EV15v5XrI1QlE5EZyjyrLWPUpE9HBDH8GAED11I
         oq6NAFdcIt0AJ9ZrGkkapK+gPQrx8d84ytfEXPC34rIRKu01CES1YeHlQ/XpmnJG7doY
         ab7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F8AKlnU/YZniF3fFN7P17RcXIo/RtheGQptMA/Tw4qM=;
        b=JNpsWNyw+KWUjmcqFruMam5FlbGyz9anWVL3JBwYfnWUADQvmqGlAx1Du/D//wvT7O
         62m0rHQ21H+pLUUZW7ps+uZdg7e3unqtyanK42dFn5Ca/V2N9nFgJeUyVpuMT/VfGqlI
         ql6lqgjg7ekIZrST+xJKBP8aAC5Ml/pOf1iOxi8jwSiTpTjHtdmOtqMoKa2EiRpNrA8A
         MG/LLSvHESaLpZoPnHn5EDYNwgZ4ppvUp3+NPar4aExCSXFT5ppBrAEEA4PwWz8NRcHf
         srkj2VeJB9elOx0cJ2O1ULeJVc3YoDvMXpbkqgdQqWCQ6Z70g0J9MmgJqUtG3zNSoxRv
         hytg==
X-Gm-Message-State: AA+aEWZdVwTs7Pes0uiDtUzM3vnt73Wu4ql7r9XSGj7ttKO3QSLbfdYD
        SGpX2LSA5JMT8cROQO85D/y4Dg==
X-Google-Smtp-Source: AFSGD/W5DqHuIobPRSyqJaW6gUsJDrC+EvH5k7wMP4U5l8ZdF2LcKQgWjzwPe2FYRVARnwy/NLzcTA==
X-Received: by 2002:a63:5346:: with SMTP id t6mr3038301pgl.40.1543534768147;
        Thu, 29 Nov 2018 15:39:28 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id o8sm11081363pfa.42.2018.11.29.15.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:39:27 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gSVu2-0002xa-Nd; Thu, 29 Nov 2018 16:39:26 -0700
Date:   Thu, 29 Nov 2018 16:39:26 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Christian Benvenuti <benve@cisco.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/usnic: fix spelling mistake "miniumum" -> "minimum"
Message-ID: <20181129233926.GB11172@ziepe.ca>
References: <20181129104213.17593-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129104213.17593-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:42:13AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a usnic_err error message, fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_ib_qp_grp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next

Thanks,
Jason
