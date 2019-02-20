Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A903C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EAB2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbfBTCB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:01:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726262AbfBTCB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:01:26 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1K1xrQZ117078
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 21:01:25 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qrrtf2r0e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 21:01:25 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 20 Feb 2019 02:01:23 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Feb 2019 02:01:19 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1K21INC12910816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 02:01:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0644DB2064;
        Wed, 20 Feb 2019 02:01:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADE94B205F;
        Wed, 20 Feb 2019 02:01:17 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.140.94])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Feb 2019 02:01:17 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5370916C63E4; Tue, 19 Feb 2019 18:01:17 -0800 (PST)
Date:   Tue, 19 Feb 2019 18:01:17 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Reply-To: paulmck@linux.ibm.com
References: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19022002-0072-0000-0000-000003FC6CBB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010629; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01163562; UDB=6.00607551; IPR=6.00944144;
 MB=3.00025662; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-20 02:01:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022002-0073-0000-0000-00004B3C6F9B
Message-Id: <20190220020117.GD11787@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 11:57:37PM +0100, Andrea Parri wrote:
> Remove this subtle (and, AFAICT, unused) ordering: we can add it back,
> if necessary, but let us not encourage people to rely on this thing.
> 
> For example, the following "exists" clause can be satisfied with this
> change:
> 
> C dep-rfi
> 
> { }
> 
> P0(int *x, int *y)
> {
> 	WRITE_ONCE(*x, 1);
> 	smp_store_release(y, 1);
> }
> 
> P1(int *x, int *y, int *z)
> {
> 	int r0;
> 	int r1;
> 	int r2;
> 
> 	r0 = READ_ONCE(*y);
> 	WRITE_ONCE(*z, r0);
> 	r1 = smp_load_acquire(z);
> 	r2 = READ_ONCE(*x);
> }
> 
> exists (1:r0=1 /\ 1:r2=0)

Any objections?  If I don't hear any in a couple days, I will apply this.

							Thanx, Paul

> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Cc: Daniel Lustig <dlustig@nvidia.com>
> ---
>  tools/memory-model/Documentation/explanation.txt | 28 ------------------------
>  tools/memory-model/linux-kernel.cat              |  2 +-
>  2 files changed, 1 insertion(+), 29 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index 68caa9a976d0c..965e11744d090 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -1019,34 +1019,6 @@ section for more details).  The kernel includes a workaround for this
>  problem when the loads come from READ_ONCE(), and therefore the LKMM
>  includes address dependencies to loads in the ppo relation.
>  
> -On the other hand, dependencies can indirectly affect the ordering of
> -two loads.  This happens when there is a dependency from a load to a
> -store and a second, po-later load reads from that store:
> -
> -	R ->dep W ->rfi R',
> -
> -where the dep link can be either an address or a data dependency.  In
> -this situation we know it is possible for the CPU to execute R' before
> -W, because it can forward the value that W will store to R'.  But it
> -cannot execute R' before R, because it cannot forward the value before
> -it knows what that value is, or that W and R' do access the same
> -location.  However, if there is merely a control dependency between R
> -and W then the CPU can speculatively forward W to R' before executing
> -R; if the speculation turns out to be wrong then the CPU merely has to
> -restart or abandon R'.
> -
> -(In theory, a CPU might forward a store to a load when it runs across
> -an address dependency like this:
> -
> -	r1 = READ_ONCE(ptr);
> -	WRITE_ONCE(*r1, 17);
> -	r2 = READ_ONCE(*r1);
> -
> -because it could tell that the store and the second load access the
> -same location even before it knows what the location's address is.
> -However, none of the architectures supported by the Linux kernel do
> -this.)
> -
>  Two memory accesses of the same location must always be executed in
>  program order if the second access is a store.  Thus, if we have
>  
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index 8dcb37835b613..6b9e3bb4e397f 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -62,7 +62,7 @@ let dep = addr | data
>  let rwdep = (dep | ctrl) ; [W]
>  let overwrite = co | fr
>  let to-w = rwdep | (overwrite & int)
> -let to-r = addr | (dep ; rfi)
> +let to-r = addr ; [R]
>  let fence = strong-fence | wmb | po-rel | rmb | acq-po
>  let ppo = to-r | to-w | fence | (po-unlock-rf-lock-po & int)
>  
> -- 
> 2.7.4
> 

