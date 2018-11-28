Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5796BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167712081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rnimLh55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167712081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbeK2D7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:59:13 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53438 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbeK2D7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:59:12 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wASGpf3X040017;
        Wed, 28 Nov 2018 16:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=cCwH1ANq6v21ntWMcjVa+jDJ+YT4fzjShf+rUxh5u44=;
 b=rnimLh55mkOXfK+OaD7t08NMQelBoTU+5xfaC9LHUvxribnGrheflx+WL9WH1+A11Nnn
 ERS3+cXH0iMX6s9afW/+QSxc2b6i8b3+VAsnMG1nPwOUpvNjVbhFx0uxUPvkbH6Izgai
 jOG0qbIKDiSdJ69D+7+eEtWlT77XrX40onjgchkDxkbSMEQTlKEKtbFf/vomFyKiI0Xo
 DZJSjbFodZsSFnf/cTwXqhEN1LPhH/NePWd8wt8xVDRly61MQRxj6AG1t2t7uLN0vmOn
 mgTbl/mLz1FUy8uURM3hir6R7ode7GiUFNnRMNNBLDv2C96YxOm6CzPBm4gnAUVq8npC 4Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2nxxkqke62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 16:56:17 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wASGuBxf017704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 16:56:12 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wASGu8Gf025097;
        Wed, 28 Nov 2018 16:56:08 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Nov 2018 08:56:08 -0800
Date:   Wed, 28 Nov 2018 08:56:18 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, tj@kernel.org, vbabka@suse.cz,
        peterz@infradead.org, dhaval.giani@oracle.com
Subject: Re: [RFC PATCH v4 01/13] ktask: add documentation
Message-ID: <20181128165618.7ttzgzh2axl62ajd@ca-dmjordan1.us.oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-2-daniel.m.jordan@oracle.com>
 <20181127195008.GA20692@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127195008.GA20692@amd>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811280147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 08:50:08PM +0100, Pavel Machek wrote:
> Hi!

Hi, Pavel.

> > +============================================
> > +ktask: parallelize CPU-intensive kernel work
> > +============================================
> > +
> > +:Date: November, 2018
> > +:Author: Daniel Jordan <daniel.m.jordan@oracle.com>
> 
> 
> > +For example, consider the task of clearing a gigantic page.  This used to be
> > +done in a single thread with a for loop that calls a page clearing function for
> > +each constituent base page.  To parallelize with ktask, the client first moves
> > +the for loop to the thread function, adapting it to operate on the range passed
> > +to the function.  In this simple case, the thread function's start and end
> > +arguments are just addresses delimiting the portion of the gigantic page to
> > +clear.  Then, where the for loop used to be, the client calls into ktask with
> > +the start address of the gigantic page, the total size of the gigantic page,
> > +and the thread function.  Internally, ktask will divide the address range into
> > +an appropriate number of chunks and start an appropriate number of threads to
> > +complete these chunks.
> 
> Great, so my little task is bound to CPUs 1-4 and uses gigantic
> pages. Kernel clears them for me.
> 
> a) Do all the CPUs work for me, or just CPUs I was assigned to?

In ktask's current form, all the CPUs.  This is an existing limitation of
workqueues, which ktask is built on: unbound workqueue workers don't honor the
cpumask of the queueing task (...absent a wq user applying a cpumask wq attr
beforehand, which nobody in-tree does...).

But good point, the helper threads should only run on the CPUs the task is
bound to.  I'm working on cgroup-aware workqueues but hadn't considered a
task's cpumask outside of cgroup/cpuset, so I'll try adding support for this
too.

> b) Will my time my_little_task show the system time including the
> worker threads?

No, system time of kworkers isn't accounted to the user tasks they're working
on behalf of.  This time is already visible to userland in kworkers, and it
would be confusing to account it to a userland task instead.

Thanks for the questions.

Daniel
