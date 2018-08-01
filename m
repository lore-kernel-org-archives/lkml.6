Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59561C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5D520844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oVRG7jLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C5D520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403905AbeHATA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:00:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35821 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403758AbeHATA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:00:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so3075818pfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q1zv/G/41asY9MvLT0w75/ROUp0bMJxAI3F1GaeJsV8=;
        b=oVRG7jLMc4xC5+KigNElOVlTHOuPOOjisoq8ThrroXGm5k5vEA4B62a2kort6fiojR
         d5AqrYD84dUOI6tuGmtYMKvs2Kf8OoLfj+1qUWHWsxoQ27O2xll/Txwc7igvEhcfWU1O
         E5Lktl0e7jtB4wMzpkG5F6tkSJn4CC81GQezoMELJ5roxc1gy8Yy4tI12zkCQF7Fc2dG
         DW6v+Dxkta1WBwrsmLeF8aNTtCBcCVmfHmWIBTFc0eQggh6pld9mPNEF2zWWCK7y5fNc
         NOqG8X7t452Dz4XCl5jGPSjCsYpDbW9k+eZ0jCFFLnWwYfPVdSbk9d7c6PTA/FTOCq4C
         qiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q1zv/G/41asY9MvLT0w75/ROUp0bMJxAI3F1GaeJsV8=;
        b=hgFtqwPJrH3JrCGY2ykeb1neTAmIUNAOCYJwvRYrd9nAs9xvn64tUCfjUCjjvs75tp
         t6B4NDgrUslMbzp+0d8jwh2doUZCdJo3QnprEHygWdvPygw14l374GePpqT0NQ3HeQMe
         hYQAGWk9epmZGzjiDAyos2ATqCzPbI66SkDZ5RywR6W5OkcpE5fIe8eD0Q+/u4glBsjv
         m0ATHzIN99/9C8Wr5D7UCwqQhxXCKyxd3G5iRtgCLh8NkG6ve4aoJ9+cOvHxbkloPPih
         Fe6xpF0xcoEWmebMHOZsaAipXTUdpjg93ffG3xD2+AIQIqTh8svERS3qCz2fQBW5NMVI
         BzSw==
X-Gm-Message-State: AOUpUlEvMKpz5lhnAEwP0zKGbrPLcfgo8YYEDfgrTgko1561yErLPqxz
        J0GW6SHk7SfEKWbA0CEYTdAwFA==
X-Google-Smtp-Source: AAOMgpd8z2u0kqOz7E1HaAgUn5mOk7S7sBdhrx8CodSJAfKsUHSUedwwsGJeQZ8A5pMhmvw3jDny1Q==
X-Received: by 2002:a63:7b1b:: with SMTP id w27-v6mr24550437pgc.199.1533143629289;
        Wed, 01 Aug 2018 10:13:49 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id u17-v6sm41504730pfa.176.2018.08.01.10.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 10:13:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fkuh0-0004du-TD; Wed, 01 Aug 2018 11:13:46 -0600
Date:   Wed, 1 Aug 2018 11:13:46 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Parav Pandit <parav@mellanox.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: linux-next: manual merge of the net-next tree with the rdma tree
Message-ID: <20180801171346.GC10824@ziepe.ca>
References: <20180727123301.3ac97ddc@canb.auug.org.au>
 <20180727024832.GA30023@mellanox.com>
 <20180727132847.2be8563b@canb.auug.org.au>
 <VI1PR0502MB3008702AFA64F44DE57DC9F5D12A0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <20180727150903.0f2816ba@canb.auug.org.au>
 <VI1PR0502MB3008076016496152D4898D8ED12E0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <20180801153345.22692adb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801153345.22692adb@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 03:33:45PM +1000, Stephen Rothwell wrote:
> Hi Parav,
> 
> On Tue, 31 Jul 2018 21:12:00 +0000 Parav Pandit <parav@mellanox.com> wrote:
> >
> > You might want to consider this compatibility patch in Linux-rdma
> > tree to avoid a merge conflict of smc.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=for-next&id=7aaa1807e698f73094b78f0ef25b1a37a4409a55
> 
> Ok, since commit that is now in the rdma tree, my resolution of the
> original conflicts comes down to dropping all the changes to
> net/smc/smc_core.c net/smc/smc_ib.c that come from the rdma tree and
> adding
> 
> #include <rdma/ib_cache.h>
> 
> to net/smc/smc_ib.c.

Oh, that means I put the compat inline in the wrong header? Sigh.

Jason
