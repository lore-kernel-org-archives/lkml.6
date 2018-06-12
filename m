Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2B095C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FE820693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOuJGpy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FE820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754321AbeFLIdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:33:22 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38336 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754288AbeFLIdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:33:19 -0400
Received: by mail-lf0-f65.google.com with SMTP id i83-v6so34678960lfh.5;
        Tue, 12 Jun 2018 01:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2CUoKXg/Jtc5sIdU2xR4mhcen0nTu7a2lUGvIEAuSVw=;
        b=EOuJGpy8lYROQorMGNi92tF5uE0GVcl+EICrGulTwEvZFQoZQDG5b7q4aNubDCN7Gq
         J3cHkLo+4OnA8cxGvy3I+d/6J2dHliSmpid1NYfMqnv/fmjLnCxNl4cMIjzhfxfb2WS9
         qz9nNDbWPaRtmtittPfWdJO0915lN0q+Fek5/Z2HzsgfNtQ2DqpfgfI6wpv2GC6oCR7g
         JCR7/gZy13y+qYEjgK0gArY9MwZjk+bDhxtdM12cA7kxtWdyqScwg4IKhEDN5PO+jTzl
         wuU6EI/tA0dpAhtG4a03h9bK0bFYV9+OLKFH0eZzVZQqSVyfH5Bl+jatkpHq6erNgQNI
         OOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2CUoKXg/Jtc5sIdU2xR4mhcen0nTu7a2lUGvIEAuSVw=;
        b=qVXxJQpS58z37HUmmZrxUlCg6YVxG+nAKS4q2bXtJcrNJZUOWFi3UQZMatku9D8gLT
         BlDoOmk+UXctkFA88TKkRSs3xAQ66Ktu1XfzqdxaQhPm15iNiWhpkWjCFizHmyavBajZ
         cW/25VL3F8Iy+E5tjtXJZDpTzvhi9w+lJEUyIZROhzXCBkq/DeGNjb4FEjB+YL1AsiO7
         y8jYgNnER1qV2xYdJUG0Td+atOKemJ/nttWEXPeAoiEoulHLAxpVs1YPNNRJ4c4Bjqw8
         XVBWgU3/fLsDNpBcrvvn0Qqul4Q+yEgQDIpqjKd8owI7+5klf5jkrn0kO7QBj5tBkYJG
         zh3g==
X-Gm-Message-State: APt69E3JxSoF/ja9u9fEbiOJ0xNDcddZ9sPAHzH0mRJbFZarWieIR4v+
        7uZa7SicYpMMrqK4RDW2l+o=
X-Google-Smtp-Source: ADUXVKLFTNFQb8bgavJ65M4P6AMaNqVFbYIDRpXiaTtNG8xCXlmmZeCFMPpd3DWRmgxnX2u8LQ2MOQ==
X-Received: by 2002:a2e:529c:: with SMTP id n28-v6mr1779627lje.62.1528792397884;
        Tue, 12 Jun 2018 01:33:17 -0700 (PDT)
Received: from esperanza (81.5.110.211.dhcp.mipt-telecom.ru. [81.5.110.211])
        by smtp.gmail.com with ESMTPSA id r64-v6sm79341lff.90.2018.06.12.01.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 01:33:16 -0700 (PDT)
Date:   Tue, 12 Jun 2018 11:33:14 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] mm: fix race between kmem_cache destroy, create and
 deactivate
Message-ID: <20180612083314.ftl4hmn4xwnehjdx@esperanza>
References: <20180611192951.195727-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611192951.195727-1-shakeelb@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 12:29:51PM -0700, Shakeel Butt wrote:
> The memcg kmem cache creation and deactivation (SLUB only) is
> asynchronous. If a root kmem cache is destroyed whose memcg cache is in
> the process of creation or deactivation, the kernel may crash.
> 
> Example of one such crash:
> 	general protection fault: 0000 [#1] SMP PTI
> 	CPU: 1 PID: 1721 Comm: kworker/14:1 Not tainted 4.17.0-smp
> 	...
> 	Workqueue: memcg_kmem_cache kmemcg_deactivate_workfn
> 	RIP: 0010:has_cpu_slab
> 	...
> 	Call Trace:
> 	? on_each_cpu_cond
> 	__kmem_cache_shrink
> 	kmemcg_cache_deact_after_rcu
> 	kmemcg_deactivate_workfn
> 	process_one_work
> 	worker_thread
> 	kthread
> 	ret_from_fork+0x35/0x40
> 
> To fix this race, on root kmem cache destruction, mark the cache as
> dying and flush the workqueue used for memcg kmem cache creation and
> deactivation. SLUB's memcg kmem cache deactivation also includes RCU
> callback and thus make sure all previous registered RCU callbacks
> have completed as well.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>

Thanks.
