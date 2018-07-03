Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79ECC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A038D21A18
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A038D21A18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934073AbeGCQii (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:38:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932747AbeGCQif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:38:35 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63GXvbT115079
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 12:38:35 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0a9jqeje-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 12:38:34 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 3 Jul 2018 12:38:33 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 12:38:31 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63GcUTa10354946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 16:38:30 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45231B2065;
        Tue,  3 Jul 2018 12:38:14 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 274AAB205F;
        Tue,  3 Jul 2018 12:38:14 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 12:38:14 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2EF1B16CA395; Tue,  3 Jul 2018 09:40:44 -0700 (PDT)
Date:   Tue, 3 Jul 2018 09:40:44 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: WARN_ON_ONCE() in process_one_work()?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180620192901.GA9956@linux.vnet.ibm.com>
 <20180702210540.GL533219@devbig577.frc2.facebook.com>
 <20180703040518.GV3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703040518.GV3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070316-0040-0000-0000-000004497261
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009301; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01056018; UDB=6.00541678; IPR=6.00833941;
 MB=3.00021978; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-03 16:38:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070316-0041-0000-0000-0000084F8F49
Message-Id: <20180703164044.GA400@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 09:05:18PM -0700, Paul E. McKenney wrote:
> On Mon, Jul 02, 2018 at 02:05:40PM -0700, Tejun Heo wrote:
> > Hello, Paul.
> > 
> > Sorry about the late reply.
> > 
> > On Wed, Jun 20, 2018 at 12:29:01PM -0700, Paul E. McKenney wrote:
> > > I have hit this WARN_ON_ONCE() in process_one_work:
> > > 
> > > 	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
> > > 		     raw_smp_processor_id() != pool->cpu);
> > > 
> > > This looks like it is my rcu_gp workqueue (see splat below), and it
> > > appears to be intermittent.  This happens on rcutorture scenario SRCU-N,
> > > which does random CPU-hotplug operations (in case that helps).
> > > 
> > > Is this related to the recent addition of WQ_MEM_RECLAIM?  Either way,
> > > what should I do to further debug this?
> > 
> > Hmm... I checked the code paths but couldn't spot anything suspicious.
> > Can you please apply the following patch and see whether it triggers
> > before hitting the warn and if so report what it says?
> 
> I will apply this, but be advised that I have not seen that WARN_ON_ONCE()
> trigger since.  :-/

But I get a build error:

kernel/workqueue.o: In function `worker_attach_to_pool':
workqueue.c:(.text+0x63c): undefined reference to `cpuhp_target_state'
workqueue.c:(.text+0x647): undefined reference to `cpuhp_current_state'
/home/paulmck/public_git/linux-rcu/Makefile:1015: recipe for target 'vmlinux' failed

My guess is that the worker_attach_to_pool() code needs to change so
as to invoke cpuhp_current_state() and cpuhp_target_state() only in
CONFIG_HOTPLUG_CPU=y kernels, but I figured I should defer to you.

							Thanx, Paul

