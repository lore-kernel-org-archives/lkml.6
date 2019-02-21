Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B85C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910A420836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UuMj1Xtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfBUVJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:09:05 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44617 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfBUVJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 16:09:05 -0500
Received: by mail-pf1-f196.google.com with SMTP id a3so4530336pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 13:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TTYmL1H0iu5pPbydjtrAiGnyCf3ukcpdoN96IF3qaBM=;
        b=UuMj1XtuApSGC7LeTk6i5UXPkP8xnfYrgS3RBS1fp/iuYxebshp5xAVkqZgV3QRA6d
         9DaqtlnhDMejwjC0BrFux15Fi4df+u0VgzlgcZVwYF47di2b2A8ZMGllg4RPNe+bw/kW
         d2/4utk1GuRzVzAEcdeWcl6LjfHR2x745oC/VCN2rTuaoQEoP8RP17vd49u8atUvHreu
         Ux07XttsTQ8xmsZwzo9ICofRkFEUPrNHyoAp8oIL7Wk4JYO89aJpXkK8k5UZuVd7WtF5
         8tTQbgTzEx5lMGeO4/EwOfG7bip75ru6w3l56iUJh39V87AanqKxXlvVYW68cWYRytSi
         7CKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TTYmL1H0iu5pPbydjtrAiGnyCf3ukcpdoN96IF3qaBM=;
        b=g7up+XLGT03nXSFky0tkhhRq9a7XosxpwlCMRNORX1zrqKqrZOTAPVea1KuEyMQWl0
         bZ+stDCzM7nrp9Och3AX+5vFHIn8+iyeDGT5SGstYYKGqGnY++nM7j93QPHMLBw6av6g
         0Ycu9JMwbbWRL2ytJwxKR/ZpGdUN0hZIlWRooYpXYrMeQtfgXUNd7RyyTUlpHBocJ2Xh
         fNt10T/mUXziOtD7TfT7A0DZc5B86hNNZ5Ct2CHxYd7doc+RYs95oYRsBrEYao+0dfK3
         ZI/35sruvXASr0wq5ivcq9ANlgsd96Ppd1ZY5K7qUPVDnCTNmkg3u30tC5erztZl9eUi
         NfdA==
X-Gm-Message-State: AHQUAuaWspiJUoNiZTGQ2z9aT2/WdtzLFyDrk8Ff82pHCfbuS6K5C5Qp
        sVl1on4peQX8+//uuzUTsee1rw==
X-Google-Smtp-Source: AHgI3IZakJBIHD8xwgkmhKXOXuh95/AGT9KONYpICEgEvmW5Th2cR5ldw93v84OVcuYg37UQcf6B6Q==
X-Received: by 2002:a62:4641:: with SMTP id t62mr498372pfa.141.1550783344302;
        Thu, 21 Feb 2019 13:09:04 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id y21sm27365230pfe.57.2019.02.21.13.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 13:09:03 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gwvaY-0006Wr-LX; Thu, 21 Feb 2019 14:09:02 -0700
Date:   Thu, 21 Feb 2019 14:09:02 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kaike Wan <kaike.wan@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] IB/hfi1: Add missing break in switch statement
Message-ID: <20190221210902.GA25062@ziepe.ca>
References: <20190221010233.GA29228@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190221010233.GA29228@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 07:02:33PM -0600, Gustavo A. R. Silva wrote:
> Fix the following warning by adding a missing break:
> 
> drivers/infiniband/hw/hfi1/tid_rdma.c: In function ‘hfi1_tid_rdma_wqe_interlock’:
> drivers/infiniband/hw/hfi1/tid_rdma.c:3251:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    switch (prev->wr.opcode) {
>    ^~~~~~
> drivers/infiniband/hw/hfi1/tid_rdma.c:3259:2: note: here
>   case IB_WR_RDMA_READ:
>   ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Fixes: c6c231175ccd ("IB/hfi1: Add interlock between TID RDMA WRITE and other requests")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Reviewed-by: Kaike Wan <Kaike.wan@intel.com>
> --
>  drivers/infiniband/hw/hfi1/tid_rdma.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-next, thanks

Jason
