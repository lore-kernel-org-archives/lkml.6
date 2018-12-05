Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BA5C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E765720989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g+ECFszL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E765720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeLETAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:00:22 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42175 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeLETAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:00:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so9429860pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 11:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=wsnQOTkUnx8CL9Z5KKvss9h3kVd/jnVBhTMb767fQbw=;
        b=g+ECFszLYuOCu8VNcBp+VwxRMqjonff3N+NbRSSMk3wjlEoR5TBOPQFBGc36r2aijQ
         /Bn6bmCly/YFqDNvTjVwbnworLIyAQHECYHW4EmbRXB3i54Atrs1abfMaUTDfrSw41mS
         gY2lcExOQlPfzlXcVoEhmqdIj5Ea/7YQKZ4EP/m4RRAppkUwdYU2eg41cRZa1awnGBTD
         71y58jGSikbss7rggBoGJsyxt6RYVXqBVmdU4QpFPWBtrj4Wg3l+zgjpRzj7VgiQ/kyF
         OIKVDnlPT4nVKEut6UKsAUBOeOFhqHWn555guhYMpH8MokD8Kwidagti6CXLyNzdg9va
         1FFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=wsnQOTkUnx8CL9Z5KKvss9h3kVd/jnVBhTMb767fQbw=;
        b=WoSjJpsHqg7pJv5nxvSRfZAnT8hTBFlkAh1/v/sHHWoIXQDrfUp7+IZ3Yd9Q+x5QnL
         7Ua+hlpDNmINvYo3K8YIhNP9ib0rFzJ05gHyo7ps31JfGwF04Xl5bSVlNtsrNxciP2XK
         kR1Lz0WVZijnz7CooNzJswPdyJlRzovDBDv7PO2dMeq7xCDr2BGoinL2nYYX3E/cbV/t
         UolraAfDCYdjX1Ju59lIyv5z6/5V1gvUHCQwE1g2CyEJpSaZFGDiXTLuYyvOwYmD1erC
         a26m1+Bwy/6/UTDKuM2zH2wkHLEXJVmKPJ3XqrHEDQAnzlUgelFM2jx8ZWKhtaxLLWtA
         YtiA==
X-Gm-Message-State: AA+aEWYoV7Er67zl1enITtiiIWKOttg3ZvX+bXLytwcmgl3FYValPTdt
        3DuZVILmf/jcPTRQTNk1w/lBGQ==
X-Google-Smtp-Source: AFSGD/V1hBd4x0dcDx572+XW/Nkd2IBflIu1wpoVt7yFaKZjgb4pinad0KYlG6co7XVnUlzG/aF3bQ==
X-Received: by 2002:a62:ca9c:: with SMTP id y28mr25359270pfk.236.1544036421224;
        Wed, 05 Dec 2018 11:00:21 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id g28sm38393114pfd.100.2018.12.05.11.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 11:00:20 -0800 (PST)
Date:   Wed, 5 Dec 2018 11:00:19 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Pingfan Liu <kernelfans@gmail.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node
 offline
In-Reply-To: <CAFgQCTttgfuPJZHqGDSF5hLpLWDm2+_+UiyK+ScKgxs6qD-KCQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1812051058440.240991@chino.kir.corp.google.com>
References: <1543892757-4323-1-git-send-email-kernelfans@gmail.com> <alpine.DEB.2.21.1812031946140.97328@chino.kir.corp.google.com> <CAFgQCTsikqQERh2MgsrupdVzp0TyF4dDQPjJkN9g3DTq4DB9hw@mail.gmail.com>
 <CAFgQCTttgfuPJZHqGDSF5hLpLWDm2+_+UiyK+ScKgxs6qD-KCQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018, Pingfan Liu wrote:

> > > And rather than using first_online_node, would next_online_node() work?
> > >
> > What is the gain? Is it for memory pressure on node0?
> >
> Maybe I got your point now.  Do you try to give a cheap assumption on
> nearest neigh of this node?
> 

It's likely better than first_online_node, but probably going to be the 
same based on the node ids that you have reported since the nodemask will 
simply wrap around back to the first node.
