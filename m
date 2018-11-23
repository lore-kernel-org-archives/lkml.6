Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A83CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF0C20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DyoAWKBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF0C20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbeKXH2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:28:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43782 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeKXH2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 02:28:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so11067422plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 12:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P/1ObpOuJk26EeolUgHvdRlrxbo9EIVZ+JjnXSnPfDc=;
        b=DyoAWKBvo9yaKZANYmvs4jq3oK/4BIj0d5KloSAe3m+EDWZJYh1lHRnixKwFrBvfrW
         tMGP8ybXrQh72Pgx7WPDsywTSIV5LXFC9QifoZuxCtvbgrhelow8g1pHRd9Eughm0K8s
         NHoS6vOqGRlTgGOk1SaQaQ3BFXKFMuvEVCj8qMdHnQNDk6uRlf7gFb+3FiTqJxdpv6mC
         ZQqpSwzolm9r5TWpH1hpEaLnwyvFhtBSSpUo0B18XjTSJmFNnYsbwt8rZTuntsCMxDmD
         KbzMHCyfHXXcBXxUodcnCuGTp0yVbVoAah+YHdbTIVaNjCMmojZQxILJelAZY3vn49wT
         oWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P/1ObpOuJk26EeolUgHvdRlrxbo9EIVZ+JjnXSnPfDc=;
        b=q9vvZW3lhr2gj9YQY13IzJcWkBNFWpVKcscvafK0CVRg8/x0uwhVZfW/W/QBF4twVz
         OBRZuW8XM6Az8JKlXOQNNIIfoor2dg2TbKzHdh/QyDsS1d4cyyGe8Ca8Cb+EdSSOxOZz
         KC7ax48oRs3F4kzDr7J00DhIA2pIMBzJwxFvacjoN9x2NGuZpedOJS+sXr1BAkFRZIxK
         e04n/Ux+OXtGpZATZj1372Fa411mvsfMd1XVUm6rvCLX0uUuZSLDPCCEmK2JXUnFXOQy
         JspsDk3ooDxPLMzmfD4vx9ABquLwYfFLnAzXS2pi41O8fD6CLYiqBH7HNEqPdWTBHGxW
         fMuA==
X-Gm-Message-State: AA+aEWa+qjfqjTrlEDdzqA//GMSSfecs7KGaMWOJHGJsfXLfRIQRhiMM
        Ynz0OhmnH6AO8DkVsfJAKfBVGw==
X-Google-Smtp-Source: AFSGD/WGub7cIpYTET9oZ+Mdl2DdL3KTWDbubX51rpnvY6jvvoqgUaMvNohyzW3FDp3mZ7kxSxo+mw==
X-Received: by 2002:a17:902:27e6:: with SMTP id i35mr13808015plg.222.1543005778197;
        Fri, 23 Nov 2018 12:42:58 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id u78sm81833390pfi.2.2018.11.23.12.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 12:42:57 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gQIHw-0004Rr-LQ; Fri, 23 Nov 2018 13:42:56 -0700
Date:   Fri, 23 Nov 2018 13:42:56 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        lijun_nudt@163.com, oulijun@huawei.com, charles.chenxin@huawei.com,
        liuyixian@huawei.com, zhangxiping3@huawei.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, xavier_huwei@163.com
Subject: Re: [PATCH rdma-next 0/3] RDMA/hns: Updates for reset process of
 roce device in hip08
Message-ID: <20181123204256.GK3395@ziepe.ca>
References: <1542986065-44265-1-git-send-email-xavier.huwei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542986065-44265-1-git-send-email-xavier.huwei@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 11:14:22PM +0800, Wei Hu (Xavier) wrote:
> Hi, Doug and Janson
> 
> This series mainly include updates for reset process of roce device
> in hip08.
> One patch adds support for reset and loading or unloading driver occur
> simultaneously to ensure work normally, one stops sending mailbox&cmq&
> doorbell when reset occured or reset is occuring, the last one modifies
> the name of hns RoCE device's name in order to ensure that the name is
> consistent before and after reset.
> 
> This series relies on the the new interfaces in hns NIC driver those
> had been accepted by David, the related commit as below:
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git 
> commit cb7ea80c6dfda472a068d40f4f9755d034b2dfde

Then you can't send patches to RDMA until the next cycle. Please
reasend after v4.21-rc1 is out.

We can only coordinate with Dave's tree if you are able to setup a
shared branch like Mellanox does.

Also, I don't even see cb7ea80c6dfda472a068d40f4f9755d034b2dfde in
that tree???

Jason
