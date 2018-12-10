Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37605C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C9E2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C9E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeLJT43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:56:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727515AbeLJT43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:56:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C9F37307EA92;
        Mon, 10 Dec 2018 19:56:27 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-223.bos.redhat.com [10.18.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9F0E5D965;
        Mon, 10 Dec 2018 19:56:25 +0000 (UTC)
Subject: Re: [PATCH v4 1/5] cgroup: subtree_control bypass mode for bypassable
 controllers
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@01.org
Cc:     kbuild-all@01.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>,
        Shakeel Butt <shakeelb@google.com>
References: <20181129111811.GP3073@unbuntlaptop>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <181c8ea6-7b5a-1ee4-7049-84aad192697c@redhat.com>
Date:   Mon, 10 Dec 2018 14:56:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181129111811.GP3073@unbuntlaptop>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 10 Dec 2018 19:56:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/2018 06:18 AM, Dan Carpenter wrote:
> Hi Waiman,
>
> Thank you for the patch! Perhaps something to improve:
>
> url:    https://github.com/0day-ci/linux/commits/Waiman-Long/cgroup-Introducing-bypass-mode/20181123-030552
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
>
> smatch warnings:
> kernel/cgroup/cgroup.c:4893 css_create() error: we previously assumed 'parent' could be null (see line 4864)
>
> # https://github.com/0day-ci/linux/commit/8b68fd4330e043645667a5d3306398f8f88f9ff2
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 8b68fd4330e043645667a5d3306398f8f88f9ff2
> vim +/parent +4893 kernel/cgroup/cgroup.c
>
> a31f2d3ff kernel/cgroup.c        Tejun Heo        2012-11-19  4840  
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4841  /**
> 6cd0f5bba kernel/cgroup.c        Tejun Heo        2016-03-03  4842   * css_create - create a cgroup_subsys_state
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4843   * @cgrp: the cgroup new css will be associated with
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4844   * @ss: the subsys of new css
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4845   *
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4846   * Create a new css associated with @cgrp - @ss pair.  On success, the new
> 6cd0f5bba kernel/cgroup.c        Tejun Heo        2016-03-03  4847   * css is online and installed in @cgrp.  This function doesn't create the
> 6cd0f5bba kernel/cgroup.c        Tejun Heo        2016-03-03  4848   * interface files.  Returns 0 on success, -errno on failure.
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4849   */
> 6cd0f5bba kernel/cgroup.c        Tejun Heo        2016-03-03  4850  static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
> 6cd0f5bba kernel/cgroup.c        Tejun Heo        2016-03-03  4851  					      struct cgroup_subsys *ss)
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4852  {
> d51f39b05 kernel/cgroup.c        Tejun Heo        2014-05-16  4853  	struct cgroup *parent = cgroup_parent(cgrp);
> 8b68fd433 kernel/cgroup/cgroup.c Waiman Long      2018-11-20  4854  	struct cgroup_subsys_state *parent_css = NULL;
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4855  	struct cgroup_subsys_state *css;
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4856  	int err;
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4857  
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4858  	lockdep_assert_held(&cgroup_mutex);
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4859  
> 8b68fd433 kernel/cgroup/cgroup.c Waiman Long      2018-11-20  4860  	/*
> 8b68fd433 kernel/cgroup/cgroup.c Waiman Long      2018-11-20  4861  	 * As cgroup may be in bypass mode, need to skip over ancestor
> 8b68fd433 kernel/cgroup/cgroup.c Waiman Long      2018-11-20  4862  	 * cgroups with NULL CSS.
> 8b68fd433 kernel/cgroup/cgroup.c Waiman Long      2018-11-20  4863  	 */
> 8b68fd433 kernel/cgroup/cgroup.c Waiman Long      2018-11-20 @4864  	for (; parent && !parent_css; parent = cgroup_parent(parent))
>                                                                                ^^^^^^^^^^^^^^^^^^^^^
> 8b68fd433 kernel/cgroup/cgroup.c Waiman Long      2018-11-20  4865  		parent_css = cgroup_css(parent, ss);
>
> When we exit this loop it means either parent is NULL or parent_css
> is non-NULL.

Sorry for the bug. I should have a temp variable to go up
cgroup_parent() iteration chain and leave parent alone. Thanks for
spotting that.

> 8b68fd433 kernel/cgroup/cgroup.c Waiman Long      2018-11-20  4866  
> 1fed1b2e3 kernel/cgroup.c        Tejun Heo        2014-05-16  4867  	css = ss->css_alloc(parent_css);
> e7e15b87f kernel/cgroup.c        Tejun Heo        2016-06-21  4868  	if (!css)
> e7e15b87f kernel/cgroup.c        Tejun Heo        2016-06-21  4869  		css = ERR_PTR(-ENOMEM);
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4870  	if (IS_ERR(css))
> 6cd0f5bba kernel/cgroup.c        Tejun Heo        2016-03-03  4871  		return css;
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4872  
> 8b68fd433 kernel/cgroup/cgroup.c Waiman Long      2018-11-20  4873  	init_and_link_css(css, ss, cgrp, parent_css);
> a2bed8209 kernel/cgroup.c        Tejun Heo        2014-05-04  4874  
> 2aad2a86f kernel/cgroup.c        Tejun Heo        2014-09-24  4875  	err = percpu_ref_init(&css->refcnt, css_release, 0, GFP_KERNEL);
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4876  	if (err)
> 3eb59ec64 kernel/cgroup.c        Li Zefan         2014-03-18  4877  		goto err_free_css;
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4878  
> cf780b7dc kernel/cgroup.c        Vladimir Davydov 2015-08-03  4879  	err = cgroup_idr_alloc(&ss->css_idr, NULL, 2, 0, GFP_KERNEL);
> 15a4c835e kernel/cgroup.c        Tejun Heo        2014-05-04  4880  	if (err < 0)
> b00c52dae kernel/cgroup.c        Wenwei Tao       2016-05-13  4881  		goto err_free_css;
> 15a4c835e kernel/cgroup.c        Tejun Heo        2014-05-04  4882  	css->id = err;
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4883  
> 15a4c835e kernel/cgroup.c        Tejun Heo        2014-05-04  4884  	/* @css is ready to be brought online now, make it visible */
> 1fed1b2e3 kernel/cgroup.c        Tejun Heo        2014-05-16  4885  	list_add_tail_rcu(&css->sibling, &parent_css->children);
> 15a4c835e kernel/cgroup.c        Tejun Heo        2014-05-04  4886  	cgroup_idr_replace(&ss->css_idr, css, css->id);
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4887  
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4888  	err = online_css(css);
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4889  	if (err)
> 1fed1b2e3 kernel/cgroup.c        Tejun Heo        2014-05-16  4890  		goto err_list_del;
> 944196278 kernel/cgroup.c        Tejun Heo        2014-03-19  4891  
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4892  	if (ss->broken_hierarchy && !ss->warned_broken_hierarchy &&
> d51f39b05 kernel/cgroup.c        Tejun Heo        2014-05-16 @4893  	    cgroup_parent(parent)) {
>                                                                                           ^^^^^^
> We dereference parent inside the function, but I don't know for sure
> if this is reachable when "parent" is NULL.
>
> ed3d261b5 kernel/cgroup.c        Joe Perches      2014-04-25  4894  		pr_warn("%s (%d) created nested cgroup for controller \"%s\" which has incomplete hierarchy support. Nested cgroups may change behavior in the future.\n",
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4895  			current->comm, current->pid, ss->name);
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4896  		if (!strcmp(ss->name, "memory"))
> ed3d261b5 kernel/cgroup.c        Joe Perches      2014-04-25  4897  			pr_warn("\"memory\" requires setting use_hierarchy to 1 on the root\n");
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4898  		ss->warned_broken_hierarchy = true;
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4899  	}
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4900  
> 6cd0f5bba kernel/cgroup.c        Tejun Heo        2016-03-03  4901  	return css;
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4902  
> 1fed1b2e3 kernel/cgroup.c        Tejun Heo        2014-05-16  4903  err_list_del:
> 1fed1b2e3 kernel/cgroup.c        Tejun Heo        2014-05-16  4904  	list_del_rcu(&css->sibling);
> 3eb59ec64 kernel/cgroup.c        Li Zefan         2014-03-18  4905  err_free_css:
> 8f53470ba kernel/cgroup/cgroup.c Tejun Heo        2018-04-26  4906  	list_del_rcu(&css->rstat_css_node);
> 8f36aaec9 kernel/cgroup/cgroup.c Tejun Heo        2018-03-14  4907  	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
> 8f36aaec9 kernel/cgroup/cgroup.c Tejun Heo        2018-03-14  4908  	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
> 6cd0f5bba kernel/cgroup.c        Tejun Heo        2016-03-03  4909  	return ERR_PTR(err);
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4910  }
> c81c925ad kernel/cgroup.c        Tejun Heo        2013-12-06  4911  
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Cheers,
Longman

