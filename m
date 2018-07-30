Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290A9FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA1F20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="R8JqAUrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA1F20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeG3RDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:03:48 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33118 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbeG3RDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:03:48 -0400
Received: by mail-qt0-f195.google.com with SMTP id c15-v6so12495252qtp.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 08:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bAQF7G4YSF50LkEIXaJPuasuOF/yCfd4ZGRA+h6Ym/4=;
        b=R8JqAUrhIbmTFWTuYNCGMeXv2jvp+chwIXdu3dNce8B0Z7YCDSOE6mx8X8SqbjfZ7I
         4UCuDSUQztdzKXEoj2jmJ8ZcakSCTd2wLsNy9GuhFDjTbUSIhuAz+xEFKeRvPRVG86OB
         MCQLcgJJRh85xSXAAey8O4F5oQc0jeKj4w6pH1oFf4nsISPs8ATcDsswtl0kYEuhGzuu
         jZKcS34VuuMulycq/344wqPb/iSfG15cVKvVGEmo9ev+lW6nc+Ag1Hr1fo71b+d4zCY5
         MQg1/z455wQRImjIbwYtevHSQDGDwhYDGZ4VRVIsePxX+RIHCXg+8YYxVOf+PMhx/Le+
         IBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bAQF7G4YSF50LkEIXaJPuasuOF/yCfd4ZGRA+h6Ym/4=;
        b=VLP41hpINvZ+tcQmVLwweMQCAO2S8WvP/3i0mojH0nnNiPDi6etWD79TWYfGc+7Z82
         10mg7gxMMz0yRKnMfeqqyDQBFTDX7eDK0vxS+7SdQbxfYhhHAog+KNIy4A4WWM3r/6Dx
         iXz9MR2WY+BZgbgOlNp0IL5b6huksoWB+blcDDiwVz7VqmcqRhWn6zm7yzP2+8kOZtiW
         qfk5UkbsrSk2A2/ki+AogbKfxfa1WEe7V5G0h8LrGNliYD8ncZrfDp1BwRXGnw59EymO
         hbC5tiU5QdK5+vNbP2cJGp2MrGXXtsRmf7/HKzUEDOXE1c27vOf9LWTiLpTQnwVio/he
         72Mg==
X-Gm-Message-State: AOUpUlEp48hoPDi+d00eJEMDx+GjWlpfw8ui8svIRX4w7ek4F49CIN4+
        P892lSkT8E86P0lfm+khoz33RA==
X-Google-Smtp-Source: AAOMgpcd84GZKy04aieu4Znc481Fdfdz3U9UnTuoBVaqbJMXvz3hqBA/1ET9R5Ss8vQrdLWb0BFuPQ==
X-Received: by 2002:ac8:2b23:: with SMTP id 32-v6mr17794585qtu.119.1532964498599;
        Mon, 30 Jul 2018 08:28:18 -0700 (PDT)
Received: from localhost (pool-96-246-38-36.nycmny.fios.verizon.net. [96.246.38.36])
        by smtp.gmail.com with ESMTPSA id q15-v6sm9366120qte.55.2018.07.30.08.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 08:28:17 -0700 (PDT)
Date:   Mon, 30 Jul 2018 11:31:13 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: Remove memcg_cgroup::id from IDR on
 mem_cgroup_css_alloc() failure
Message-ID: <20180730153113.GB4567@cmpxchg.org>
References: <6dbc33bb-f3d5-1a46-b454-13c6f5865fcd@virtuozzo.com>
 <20180413113855.GI17484@dhcp22.suse.cz>
 <8a81c801-35c8-767d-54b0-df9f1ca0abc0@virtuozzo.com>
 <20180413115454.GL17484@dhcp22.suse.cz>
 <abfd4903-c455-fac2-7ed6-73707cda64d1@virtuozzo.com>
 <20180413121433.GM17484@dhcp22.suse.cz>
 <20180413125101.GO17484@dhcp22.suse.cz>
 <20180726162512.6056b5d7c1d2a5fbff6ce214@linux-foundation.org>
 <20180727193134.GA10996@cmpxchg.org>
 <20180729192621.py4znecoinw5mqcp@esperanza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180729192621.py4znecoinw5mqcp@esperanza>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 10:26:21PM +0300, Vladimir Davydov wrote:
> On Fri, Jul 27, 2018 at 03:31:34PM -0400, Johannes Weiner wrote:
> > That said, the lifetime of the root reference on the ID is the online
> > state, we put that in css_offline. Is there a reason we need to have
> > the ID ready and the memcg in the IDR before onlining it?
> 
> I fail to see any reason for this in the code.

Me neither, thanks for double checking.

The patch also survives stress testing cgroup creation and destruction
with the script from 73f576c04b94 ("mm: memcontrol: fix cgroup
creation failure after many small jobs").

> > Can we do something like this and not mess with the alloc/free
> > sequence at all?
> 
> I guess so, and this definitely looks better to me.

Cool, then I think we should merge Kirill's patch as the fix and mine
as a follow-up cleanup.

---

From b4106ea1f163479da805eceada60c942bd66e524 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Mon, 30 Jul 2018 11:03:55 -0400
Subject: [PATCH] mm: memcontrol: simplify memcg idr allocation and error
 unwinding

The memcg ID is allocated early in the multi-step memcg creation
process, which needs 2-step ID allocation and IDR publishing, as well
as two separate IDR cleanup/unwind sites on error.

Defer the IDR allocation until the last second during onlining to
eliminate all this complexity. There is no requirement to have the ID
and IDR entry earlier than that. And the root reference to the ID is
put in the offline path, so this matches nicely.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 12205159b462..12339ae779ca 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4151,12 +4151,6 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
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
@@ -4183,10 +4177,8 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
 #endif
-	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
 	return memcg;
 fail:
-	mem_cgroup_id_remove(memcg);
 	__mem_cgroup_free(memcg);
 	return NULL;
 }
@@ -4245,7 +4237,6 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 
 	return &memcg->css;
 fail:
-	mem_cgroup_id_remove(memcg);
 	mem_cgroup_free(memcg);
 	return ERR_PTR(-ENOMEM);
 }
@@ -4253,10 +4244,17 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
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
 
-- 
2.18.0

