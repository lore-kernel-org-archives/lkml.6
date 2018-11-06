Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5E7C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841FB2081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eCLGfUhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841FB2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbeKFLvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 06:51:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39454 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbeKFLvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 06:51:05 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA62OcTJ164427;
        Tue, 6 Nov 2018 02:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Pq0q7fgYlsXP5RgqD/ux4NPF+hjznz6JNMGk9EFGCHA=;
 b=eCLGfUhXJy3NNnUbYoOxqAFyWK2mN9QnHvnhr+D1F1U+wJ9G1vXXEnMact9AsNqywx8u
 Kd+5b9uTClXwtzPSom6FFqoPnZUwHVnRMOd4FYr3IAgdGELVP38LgPpxpyNif8IRmahR
 uEUex8/4lMqM1ljrcs0KiDzMEaygASemmV4YknYgWQ3392w5+LJHh8VgrAjGV0p1IA4C
 9BtyGvTsSKLADaiJzb1toboOm5F7kie/9T5Qcd6qOpih0BOVkwXMs2WRdv0xsvJUQ6FZ
 Tja1dogiLip3sGDBZyTfwe7xdG93G1nXbYLLExTvLYX9KaJvxkCfXnO/COGrr6jMgu7m RQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2nh3mpjjq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Nov 2018 02:27:42 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA62Rgvh013083
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Nov 2018 02:27:42 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA62ReFd031986;
        Tue, 6 Nov 2018 02:27:41 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 18:27:40 -0800
Date:   Mon, 5 Nov 2018 18:27:47 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        steven.sistare@oracle.com, tim.c.chen@intel.com, tj@kernel.org,
        vbabka@suse.cz
Subject: Re: [RFC PATCH v4 01/13] ktask: add documentation
Message-ID: <20181106022747.dmtq24pvulcnv3lc@ca-dmjordan1.us.oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-2-daniel.m.jordan@oracle.com>
 <7693f8a2-e180-520a-0d07-cc3090d2139f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7693f8a2-e180-520a-0d07-cc3090d2139f@infradead.org>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811060017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 01:19:50PM -0800, Randy Dunlap wrote:
> On 11/5/18 8:55 AM, Daniel Jordan wrote:
> 
> Hi,
> 
> > +Resource Limits
> > +===============
> > +
> > +ktask has resource limits on the number of work items it sends to workqueue.
> 
>                                                                   to a workqueue.
> or:                                                               to workqueues.

Ok, I'll do "to workqueues" since ktask uses two internally (NUMA-aware and
non-NUMA-aware).

> 
> > +In ktask, a workqueue item is a thread that runs chunks of the task until the
> > +task is finished.
> > +
> > +These limits support the different ways ktask uses workqueues:
> > + - ktask_run to run threads on the calling thread's node.
> > + - ktask_run_numa to run threads on the node(s) specified.
> > + - ktask_run_numa with nid=NUMA_NO_NODE to run threads on any node in the
> > +   system.
> > +
> > +To support these different ways of queueing work while maintaining an efficient
> > +concurrency level, we need both system-wide and per-node limits on the number
> 
> I would prefer to refer to ktask as ktask instead of "we", so
> s/we need/ktask needs/

Good idea, I'll change it.

> > +of threads.  Without per-node limits, a node might become oversubscribed
> > +despite ktask staying within the system-wide limit, and without a system-wide
> > +limit, we can't properly account for work that can run on any node.
> 
> s/we/ktask/

Ok.

> > +
> > +The system-wide limit is based on the total number of CPUs, and the per-node
> > +limit on the CPU count for each node.  A per-node work item counts against the
> > +system-wide limit.  Workqueue's max_active can't accommodate both types of
> > +limit, no matter how many workqueues are used, so ktask implements its own.
> > +
> > +If a per-node limit is reached, the work item is allowed to run anywhere on the
> > +machine to avoid overwhelming the node.  If the global limit is also reached,
> > +ktask won't queue additional work items until we fall below the limit again.
> 
> s/we fall/ktask falls/
> or s/we fall/it falls/

'ktask.'  Will change.

> > +
> > +These limits apply only to workqueue items--that is, helper threads beyond the
> > +one starting the task.  That way, one thread per task is always allowed to run.
> 
> 
> thanks.

Appreciate the feedback!
