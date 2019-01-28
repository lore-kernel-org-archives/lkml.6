Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBD2C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE0F20880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548685840;
	bh=/r1Gx1w/EIesNC3KMMTr7sfzj/pcxRe6VkYRYzZCExo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1ZJ12OpNQ4IfdDtEL4tfeaa8qHJ2YKg+6Jj1YPcokOIFh0+R+G85ijhOy9UYIh4Jj
	 5h9FV3Of2sw14e0+flvwWXk69It5Ao9S/69S3tnUc0k2ZzgdWdSTxDiwEqoxGBCfAc
	 a6r/ouC8Vce3NoROVgQOJGH7+OaZV9+WUqmvSqFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfA1Oai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:30:38 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33428 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfA1Oah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:30:37 -0500
Received: by mail-yw1-f67.google.com with SMTP id p65so6798247ywe.0;
        Mon, 28 Jan 2019 06:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1ogb3hFMHB8WCDDPWWGm6OYJJs0L4GkVd3fDg6sKROY=;
        b=L1ydZxq2pUdx41QvZPNxpibVmlWNSwIjOand8ivfRjISmfa1LIaEOSgbFYxaCSfydA
         9JKxXq9itIXeevyyuBGJLlFvvNMbaCxOhfKS7sqFVcq9o2ImHgRNS2PQ7u2P7OE/8Ld1
         vnN1CBwoZeu0o42j/hO7OJiH4yjm2hm6aM07+9zdXFS+ZBMBhS9pEW5fDqUbGYEn+Lir
         D5NhFy92Kzkr0o4YoBq/SMH3e2HXhOOzRhaJ0INHmUPkPVYoNe1eXw+pLHT94+qlDtsR
         eNw8P/PcwD5FAWBJTBDnl4nJZaCanVN663vg1JgF1tds/39xysXE1CSWq+en5qvrzmRl
         zWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1ogb3hFMHB8WCDDPWWGm6OYJJs0L4GkVd3fDg6sKROY=;
        b=Bv2CupUZM9f0ZoQNlc2Off09rzs66nwiZMNVlXuyTBOieFILP7OhjkHdg0eGDPkXPW
         foLHCfTeKEuWs6vWEPiPjQ+dwDbAYnsE24y9kU5yBH3rrF8SGk1ZpEYWBVrh97xsDPxg
         0WvEcjipnTPoSNhFJTEcA2+5FaceGobrPnxwwPWCEBXHHek+UGQ6AcfRNv12VjjeJlJB
         xj6EAVOikZoa7yz8majgGuKSXFAqRUtD90doIBrZqFyAW0Z2Hug4IxxaJsdQvpr8evM1
         aDmgEyVucRdcQjmzLPl6BNpRAoxzcvvLwgvNfla2UEkc2H1y1zdsnDCS5Htt99wuhXsB
         MvVg==
X-Gm-Message-State: AJcUukcTOBU82o+O/KXc0eXKmaCaw/MSlahY+W4AbALgWndoc5BUDJV7
        q1VfqC5Oe5Gr0hXOm/IeMvs=
X-Google-Smtp-Source: ALg8bN6DK3Ik5hSEDaHjzXcOTqgU9q2sx269zz95BuzexpP1Tu0v8kRSQ/1aymUvjHG0L7unR5gFgQ==
X-Received: by 2002:a81:f00c:: with SMTP id p12mr21249044ywm.55.1548685836139;
        Mon, 28 Jan 2019 06:30:36 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:a62a])
        by smtp.gmail.com with ESMTPSA id k127sm13451223ywa.81.2019.01.28.06.30.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 06:30:35 -0800 (PST)
Date:   Mon, 28 Jan 2019 06:30:33 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190128143033.GN50184@devbig004.ftw2.facebook.com>
References: <20190123223144.GA10798@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123223144.GA10798@chrisdown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 05:31:44PM -0500, Chris Down wrote:
> memory.stat and other files already consider subtrees in their output,
> and we should too in order to not present an inconsistent interface.
> 
> The current situation is fairly confusing, because people interacting
> with cgroups expect hierarchical behaviour in the vein of memory.stat,
> cgroup.events, and other files. For example, this causes confusion when
> debugging reclaim events under low, as currently these always read "0"
> at non-leaf memcg nodes, which frequently causes people to misdiagnose
> breach behaviour. The same confusion applies to other counters in this
> file when debugging issues.
> 
> Aggregation is done at write time instead of at read-time since these
> counters aren't hot (unlike memory.stat which is per-page, so it does it
> at read time), and it makes sense to bundle this with the file
> notifications.
...
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Tejun Heo <tj@kernel.org>

Michal has a valid counterpoint that this is a change in userland
visible behavior but to me this patch seems to be more of a bug fix
than anything else in that it's addressing an obvious inconsistency in
the interface.

Thanks.

-- 
tejun
