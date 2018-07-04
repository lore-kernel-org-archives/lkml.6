Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8006C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609F820840
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609F820840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752888AbeGDOgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:36:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752136AbeGDOgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:36:54 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D1CC81E07;
        Wed,  4 Jul 2018 14:36:54 +0000 (UTC)
Received: from xps (ovpn-118-10.phx2.redhat.com [10.3.118.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B82AE2010CED;
        Wed,  4 Jul 2018 14:36:52 +0000 (UTC)
Date:   Wed, 4 Jul 2018 10:36:49 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Rodrigo Freire <rfreire@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: be more informative in OOM task list
Message-ID: <20180704143649.GE31826@xps>
References: <7de14c6cac4a486c04149f37948e3a76028f3fa5.1530461087.git.rfreire@redhat.com>
 <alpine.DEB.2.21.1807031832540.110853@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807031832540.110853@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 04 Jul 2018 14:36:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 06:34:48PM -0700, David Rientjes wrote:
> On Sun, 1 Jul 2018, Rodrigo Freire wrote:
> 
> > The default page memory unit of OOM task dump events might not be
> > intuitive for the non-initiated when debugging OOM events. Add
> > a small printk prior to the task dump informing that the memory
> > units are actually memory _pages_.
> > 
> > Signed-off-by: Rodrigo Freire <rfreire@redhat.com>
> > ---
> >  mm/oom_kill.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 84081e7..b4d9557 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -392,6 +392,7 @@ static void dump_tasks(struct mem_cgroup *memcg, const nodemask_t *nodemask)
> >  	struct task_struct *p;
> >  	struct task_struct *task;
> >  
> > +	pr_info("Tasks state (memory values in pages):\n");
> >  	pr_info("[ pid ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
> >  	rcu_read_lock();
> >  	for_each_process(p) {
> 
> As the author of dump_tasks(), and having seen these values misinterpreted 
> on more than one occassion, I think this is a valuable addition.
> 
> Could you also expand out the "pid" field to allow for seven digits 
> instead of five?  I think everything else is aligned.
> 
> Feel free to add
> 
> Acked-by: David Rientjes <rientjes@google.com>
> 
> to a v2.
>

Same here, for a v2:
 
Acked-by: Rafael Aquini <aquini@redhat.com>
