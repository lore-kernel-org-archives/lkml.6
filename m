Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1779982-1523430028-2-12305653550126774650
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523430027; b=K+G60rbWM10reOvGuLT4PcBuJd4E+p0LtXhBfFmb8Cu3YclZVK
    gojL6NDTRUs7QF9UrbfjAQLoDBMDH/4vmfXvB3zVGTpL0vRgJMzsgqWeFB8SC417
    uaAcJklwqWB6XDjR8OVypkq+4g6pjbkh5pq8atpyBNSBSg+zM3MbWEVA9rFT3sGH
    VxBYX/a8LeJElDLSAWr/3CHmdI79GzvlCqzjAvd2aqSPZD/A0WjTzJ0aOCQane2I
    tTKoLPs3g0v4GT/r+pmGxY6faAsUGBf6Q3zU9qpQCmr35jI+Vz4TXce3uD1gXugf
    IPUNuKZapTWfmCA+zRfANlP4KdFejU3CPKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523430027; bh=
    3y2iVUIvBEMNCw8psB0BnENo0owZjnjZ25ENiXYr1mM=; b=urONqvsykVGFTsuh
    8E2I7umxwQsnZJ1CNfHdKqTXi2IEU51wIqBlKQJmhhYTaCdPF9Q5N4d0ikcMtREq
    ooSFZxniiXXshim/c5Z6W48rAuqHSQfitOQUX1yvCY2yomytwn1WZLZfTqwXDzBe
    Rgo34gb6ykCAhhFiUSgG6ZsgG01B9ikPH3mXXAdsjS07iYuthGLc2Hp6Vr+Ls3am
    16fR77PlSMs8CLQc07z9QgZPkwjvrdkCbtEV+jHaGGjsJPsCbzM3tknsyVOMGjvK
    5NtiY7kFe8kA6C6CoAU93nccxnqebbgsaAGxpP3kHtBBm5mTYMp2QDcqnlHSggWu
    d09ACw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG99BmHGVpRbkLW8tH9pvb36uMUA6DouJvS6+VK8C819GVtW2nLYJYYOfdmpw6eSCjSEFfTPb89AuDg9WmPcemqiOOpfWbwRgyHNKaNlh8exHvkkRFnq
    xg8KchrJiLsY+JOoubjYepjYY7p96CUMprYb3qv/DoKVJYbkItO/at7XWjnN/+k/Gs5yjRHJXR+8O+dXOPczCGUpBEyLrd+2jt1cK3ae9lS12mkgUCEmuTZ4
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=57SyGIRnAAAA:8 a=1XWaLZrsAAAA:8 a=NufY4J3AAAAA:8 a=pGLkceISAAAA:8
    a=KKAkSRfTAAAA:8 a=zPZknKe_xf31IkCjsZUA:9 a=AjGcO6oz07-iQ99wixmX:22
    a=YzT4AsKTxtEdF6UtD8mD:22 a=TPcZfFuj8SYsoCJAFAiX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbeDKHAY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 03:00:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:46217 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751983AbeDKHAX (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 11 Apr 2018 03:00:23 -0400
From: Vlastimil Babka <vbabka@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH] mm, slab: reschedule cache_reap() on the same CPU
Date: Wed, 11 Apr 2018 09:00:07 +0200
Message-Id: <20180411070007.32225-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180410081531.18053-1-vbabka@suse.cz>
References: <20180410081531.18053-1-vbabka@suse.cz>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

cache_reap() is initially scheduled in start_cpu_timer() via
schedule_delayed_work_on(). But then the next iterations are scheduled via
schedule_delayed_work(), i.e. using WORK_CPU_UNBOUND.

Thus since commit ef557180447f ("workqueue: schedule WORK_CPU_UNBOUND work on
wq_unbound_cpumask CPUs") there is no guarantee the future iterations will run
on the originally intended cpu, although it's still preferred. I was able to
demonstrate this with /sys/module/workqueue/parameters/debug_force_rr_cpu.
IIUC, it may also happen due to migrating timers in nohz context. As a result,
some cpu's would be calling cache_reap() more frequently and others never.

This patch uses schedule_delayed_work_on() with the current cpu when scheduling
the next iteration.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Fixes: ef557180447f ("workqueue: schedule WORK_CPU_UNBOUND work on wq_unbound_cpumask CPUs")
CC: <stable@vger.kernel.org>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
---
 mm/slab.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slab.c b/mm/slab.c
index 9095c3945425..a76006aae857 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -4074,7 +4074,8 @@ static void cache_reap(struct work_struct *w)
 	next_reap_node();
 out:
 	/* Set up the next iteration */
-	schedule_delayed_work(work, round_jiffies_relative(REAPTIMEOUT_AC));
+	schedule_delayed_work_on(smp_processor_id(), work,
+				round_jiffies_relative(REAPTIMEOUT_AC));
 }
 
 void get_slabinfo(struct kmem_cache *cachep, struct slabinfo *sinfo)
-- 
2.16.3
