Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E83C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0EE20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="fWYnH7o/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0EE20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389301AbeG0UwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:52:03 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:44803 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389078AbeG0UwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:52:02 -0400
Received: by mail-yb0-f193.google.com with SMTP id l16-v6so2431538ybk.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 12:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H6r+ivETp18KyvaR5ps5MBhP9aK6uRFs/KhKJoV12pY=;
        b=fWYnH7o/d3+mtS2nn0NijOsZEuTTm1ymFa+LWKzR5ri8zMUTHp7WlR/WzFP515F9iu
         /yYt7RCZ/zIwYF4mIpeK/pii0O6wAD4jk4K4Q1AM+epv/s8n9XumWHln60rbdeXHRb+u
         ykZY3NfDyH7/IlHR33yxRPdpvK6rD4mj68aVf6mMLIuukM7l8/vDTgehVo5a1E3HbNIJ
         AnK1IJPykrKVDLGmD3U3rIat5W74sFo7zrT/RuXEHxCeBqn69XR0MP4HdB15MTGusiKW
         K/DOuSG1VzRJmAJ2DWzr4g/qQPpyIiVVzByh2SklLfNudRUN08lgfRKDiJ+VQgIvUUPz
         VoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H6r+ivETp18KyvaR5ps5MBhP9aK6uRFs/KhKJoV12pY=;
        b=CARhXiouUJ2ZmMB5b+yOLfpeM8zqoc9HeXiMY4Fd1T/LWpfEMlO/7bHyxWHU6CRuVQ
         A1C98euCRFB7vH/jWg9mBxRbFNCsRK8+uYJ/O/53ig83gK7AJF4AFqRns+NPeao/BDr3
         H5XpyBy//Uj1F2UlY+1KBn80B66OPYrRTSuUZzm6teiulMffSKBohz2qvZ8NiplkrQqm
         sHt7Sj/wzYd6cruN6oef5OI0U2LKbZlGs0de80/tSgqbc0ccpLdarFaAP48htsMKNw1t
         dPaUwzXhLP53JwSOg3+6EXjEjT2SCZ33ydKOHyQn43pJJzRABja201N6/x+Xo5wWNqWX
         A3uA==
X-Gm-Message-State: AOUpUlExJ/JJmYyLVN3ixM+lLNN8tvRKUoEdY3q6fN0yBrZCjQR7UkRD
        M0uH8eJ7vfl32OlBjNO6mjfQMw==
X-Google-Smtp-Source: AAOMgpe3nwhvvJSuF10P1mtabv+ZvOTtnRL+UzlMI0YnIe/wx73Dxf6y4Wl0AiJqQDySqNoss6iN7A==
X-Received: by 2002:a25:3886:: with SMTP id f128-v6mr4195710yba.236.1532719723926;
        Fri, 27 Jul 2018 12:28:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:b944])
        by smtp.gmail.com with ESMTPSA id j8-v6sm3025582ywj.6.2018.07.27.12.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 12:28:42 -0700 (PDT)
Date:   Fri, 27 Jul 2018 15:31:34 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: Remove memcg_cgroup::id from IDR on
 mem_cgroup_css_alloc() failure
Message-ID: <20180727193134.GA10996@cmpxchg.org>
References: <06931a83-91d2-3dcf-31cf-0b98d82e957f@virtuozzo.com>
 <20180413112036.GH17484@dhcp22.suse.cz>
 <6dbc33bb-f3d5-1a46-b454-13c6f5865fcd@virtuozzo.com>
 <20180413113855.GI17484@dhcp22.suse.cz>
 <8a81c801-35c8-767d-54b0-df9f1ca0abc0@virtuozzo.com>
 <20180413115454.GL17484@dhcp22.suse.cz>
 <abfd4903-c455-fac2-7ed6-73707cda64d1@virtuozzo.com>
 <20180413121433.GM17484@dhcp22.suse.cz>
 <20180413125101.GO17484@dhcp22.suse.cz>
 <20180726162512.6056b5d7c1d2a5fbff6ce214@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726162512.6056b5d7c1d2a5fbff6ce214@linux-foundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 04:25:12PM -0700, Andrew Morton wrote:
> On Fri, 13 Apr 2018 14:51:01 +0200 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > On Fri 13-04-18 14:14:33, Michal Hocko wrote:
> > [...]
> > > Well, this is probably a matter of taste. I will not argue. I will not
> > > object if Johannes is OK with your patch. But the whole thing confused
> > > hell out of me so I would rather un-clutter it...
> > 
> > In other words, this
> > 
> 
> This discussion has rather petered out.  afaict we're waiting for
> hannes to offer an opinion?
> 
> 
> From: Kirill Tkhai <ktkhai@virtuozzo.com>
> Subject: memcg: remove memcg_cgroup::id from IDR on mem_cgroup_css_alloc() failure
> 
> In case of memcg_online_kmem() failure, memcg_cgroup::id remains hashed in
> mem_cgroup_idr even after memcg memory is freed.  This leads to leak of ID
> in mem_cgroup_idr.
> 
> This patch adds removal into mem_cgroup_css_alloc(), which fixes the
> problem.  For better readability, it adds a generic helper which is used
> in mem_cgroup_alloc() and mem_cgroup_id_put_many() as well.
> 
> Link: http://lkml.kernel.org/r/152354470916.22460.14397070748001974638.stgit@localhost.localdomain
> Fixes 73f576c04b94 ("mm: memcontrol: fix cgroup creation failure after many small jobs")
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

I also do wonder if we can do it cleaner, but since it's a fix I don't
want that discussion to hold things up:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

That said, the lifetime of the root reference on the ID is the online
state, we put that in css_offline. Is there a reason we need to have
the ID ready and the memcg in the IDR before onlining it? Can we do
something like this and not mess with the alloc/free sequence at all?

Michal, Vladimir, am I missing something?

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c59519d600ea..865e6d41d3d1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4144,12 +4144,6 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	if (!memcg)
 		return NULL;
 
-	memcg->id.id = idr_alloc(&mem_cgroup_idr, NULL,
-				 1, MEM_CGROUP_ID_MAX,
-				 GFP_KERNEL);
-	if (memcg->id.id < 0)
-		goto fail;
-
 	memcg->stat_cpu = alloc_percpu(struct mem_cgroup_stat_cpu);
 	if (!memcg->stat_cpu)
 		goto fail;
@@ -4176,11 +4170,8 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
 #endif
-	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
 	return memcg;
 fail:
-	if (memcg->id.id > 0)
-		idr_remove(&mem_cgroup_idr, memcg->id.id);
 	__mem_cgroup_free(memcg);
 	return NULL;
 }
@@ -4246,10 +4237,17 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+	int i;
+
+	i = idr_alloc(&mem_cgroup_idr, memcg, 1, MEM_CGROUP_ID_MAX, GFP_KERNEL);
+	if (i < 0)
+		return i;
 
 	/* Online state pins memcg ID, memcg ID pins CSS */
+	memcg->id.id = i;
 	atomic_set(&memcg->id.ref, 1);
 	css_get(css);
+
 	return 0;
 }
 
